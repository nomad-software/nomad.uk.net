---
author: Gary Willoughby
title: Hidden treasure in the D standard library
description: I've been using D for a number of years and I am constantly surprised by the hidden treasure I find in the standard library. This article highlights a few of these hidden treasures which I hope you'll enjoy learning about and will be useful for your future D projects.
---

![](/articles/images/hidden-treasure-in-the-d-standard-library-banner.jpg)

# Hidden treasure in the D standard library

<time>Posted on 28th August 2014 by [Gary Willoughby](/pages/about.html)</time>

I’ve been using [D](https://dlang.org/) for a number of years and I am constantly surprised by the hidden treasure I find in the standard library. I guess the reason for my surprise is that i’ve never exhaustively read the entire library documentation, I only skim it for what’s needed at any given time. I’ve promised myself I _will_ read it thoroughly one day but until then i’ll enjoy these little discoveries. This article highlights a few of these hidden treasures which I hope you’ll enjoy learning about and will be useful for your future D projects.

## std.functional

This module implements functions that manipulate other functions. I guess this is where D implements library functions to accommodate some aspects of functional programming. It’s a bit thin on the ground in there but what is there seems to be very useful.

### memoize

[Memoization](https://en.wikipedia.org/wiki/Memoization) is an optimization technique used primarily to speed up computer programs by caching the results of expensive function calls and returning the cached result when the same inputs occur again. This template, available in the standard library does just that.

The following is a simple program to display numbers of the [Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_number) sequence by using a recursive function. This is not the most optimised way of calculating this sequence but for the purposes of a memoization demonstration it will do.

<script src="https://gist.github.com/nomad-software/472a5366fd91f0067acbd0f056ca9c0b.js"></script>

If I run this on my computer it finishes in about 13 seconds, which is not great. That’s because it’s recalculating values every time it’s run. Using the `memoize` template we can cache the values instead of recalculating them again. This caching assumes that for any given valid arguments the function will return the exact same result. Here is the memoized version.

<script src="https://gist.github.com/nomad-software/c0ae4bfb1d979c57d30b96d62ec7b328.js"></script>

Internally in `fib` the recursive calls are now being made to the memoized version `mfib`. When the memoized version is called, it first checks its cache and if a value exists for that particular combination of arguments the cached value is returned avoiding any recalculation. This can save an enormous amount of computation time but with the overhead of maintaining a simple cache. If I run this new program using the memoized function, the execution time is dramatically shortened to only a fraction of a second.

The memoization cache is implemented as a simple associative array keyed on the types and values of the passed arguments. The cache element size can be limited by passing a second argument to the `memoize` template. [View documentation](https://dlang.org/phobos/std_functional.html#.memoize).

## std.parallelism

This module implements high-level primitives for [SMP parallelism](https://en.wikipedia.org/wiki/Symmetric_multiprocessing). These include parallel foreach, parallel reduce, parallel eager map, pipelining and future/promise parallelism. This module is recommended when the same operation is to be executed in parallel on different data, or when a function is to be executed in a background thread and its result returned to a well-defined main thread.

### parallel

This is actually a convenience function that forwards to `taskPool.parallel` (which resides in the same module), the purpose of which is to create a [parallel](https://en.wikipedia.org/wiki/Parallel_computing) foreach loop. Parallelizing a foreach loop means that potentially each iteration can be run asynchronously across different [threads](https://en.wikipedia.org/wiki/Thread_(computing)). In reality, the `parallel` function allows you more fine grained control by adjusting how many range elements are allocated to separate threads in the form of tasks. These tasks contain a consecutive section of the iterated range and passes it to a thread for processing. Here’s an example of something that would benefit from being calculated in parallel.

<script src="https://gist.github.com/nomad-software/2befec31def2da0d4cc36bd45d186b0e.js"></script>

Again we’re using our hideously inefficient fibonacci sequence generator to populate elements of an array. When run this program takes about 13 seconds to complete on my computer and it only uses one thread (on one CPU core).

To parallelize the loop we simply use the `parallel` function, like this.

<script src="https://gist.github.com/nomad-software/362a34d07a6214a31bfd64328b7ffd51.js"></script>

Notice the second argument to `parallel`? that’s the number of work units (i.e. consecutive elements to pass to each thread for processing). I’ve set it to `1` to indicate I want each element to be run independently in its own thread. Smaller work units provide better load balancing, but larger work units avoid the overhead of communicating with other threads. The less time a single iteration of the loop takes, the larger work unit should be. For very expensive loop bodies, the unit size should be `1`.

Now that the above loop is parallelized and each element is processed in it’s own thread, the execution time is slashed to 5 seconds. The program now uses multiple threads (and all [four CPU cores](https://en.wikipedia.org/wiki/Multi-core_processor)) on my computer. [View documentation](https://dlang.org/phobos/std_parallelism.html#.TaskPool.parallel).

## std.random

This module implements facilities for random number generation.

### dice

This function provides a way of generating random numbers using [weighting](https://en.wikipedia.org/wiki/Weighting). Take a look at this example.

<script src="https://gist.github.com/nomad-software/e37a58726ffbb2d5c30b40425909c238.js"></script>

Here the random number generated by `dice` will be in the range defined by 0 and the maximum index of the passed weight i.e. it will be between 0 and 2 as there are only three weighted elements. The weights themselves (element values) act as percentages, causing the different indexes to be returned with more or less frequency than others. In this particular example, 0 will be returned seventy percent of the time, 1 twenty percent and 2 ten percent of the time.

I’ve yet to think of a use case for this little function but it seems like it could be really useful and deserves a little light shedding on it. [View documentation](https://dlang.org/phobos/std_random.html#.dice).

## std.typecons

This module implements a variety of type constructors, i.e., templates that allow construction of new, useful general-purpose types.

### Flag

This template defines a simple, self-documenting yes/no flag. This makes it easy for APIs to define functions accepting flags without resorting to [boolean](https://en.wikipedia.org/wiki/Boolean_data_type) values (which are opaque in calls) and without needing to define a separate enumerated type. There is nothing worse when working on code to open up a file and see code like this.

<script src="https://gist.github.com/nomad-software/9fcc40b49b34406796288d612105d27b.js"></script>

What exactly do the three boolean arguments mean? They _mean_ you have to look at the definition of this method to understand their meaning, doh! D introduced flags to avoid this nuisance by documenting the meaning of the flag at the [call site](https://en.wikipedia.org/wiki/Call_site). Here’s how they work.

<script src="https://gist.github.com/nomad-software/a5f0ea58531c9e890b6e68cb51d97ccb.js"></script>

Notice that the second parameter of the `foo` function is a flag. The flag’s string defines its meaning much like a variable. Usually a parameter like this would be defined as a boolean value but using flags we can make it easier to understand. As a bonus, the flag can be tested in the same way as you would a boolean value. One further treat is that because the `Flag` syntax is a little too verbose for the call site there are a couple of helper structs to make the call look a little more presentable. Using these, the above function could be called like this.

<script src="https://gist.github.com/nomad-software/c8fe320161167bc70c070acecc9025cb.js"></script>

Don’t you agree this is much nicer than having to guess what boolean arguments mean? [View documentation](https://dlang.org/phobos/std_typecons.html#.Flag).

### Proxy

This is an extremely handy [mixin template](/articles/templates-in-d-explained.html) for injecting code into a class or struct to make it behave like another type. Doing this manually is quite time consuming and involves a lot of [operator overloading](https://en.wikipedia.org/wiki/Operator_overloading), whereas `Proxy` is a simple one liner that enables lots of automatic functionality.

Here’s an example where I make the struct `Foo` behave as an integral type.

<script src="https://gist.github.com/nomad-software/d290b376d2e08462a6493d5e2557dff2.js"></script>

Notice that all the operators in the above example just work? Here’s another slightly more complicated example using an inner string array.

<script src="https://gist.github.com/nomad-software/ff3baea41ac28c3bf93590fe89e5d687.js"></script>

In this example i’m accessing the inner array via concatenation, iteration, indexing and using it as a function parameter. Using this mixin is great for quickly creating user defined collections. `Proxy` overloads all the necessary operators making sure the outer type can be used wherever the inner type would be expected. The only functionality that isn’t supported is implicit conversions to the inner type, which is by design. [View documentation](https://dlang.org/phobos/std_typecons.html#.Proxy).

### RefCounted

This struct is a wrapper for creating [reference counted](https://en.wikipedia.org/wiki/Reference_counting) objects. The wrapped type is automatically allocated using [malloc](https://en.wikipedia.org/wiki/C_dynamic_memory_allocation) and the struct keeps track of all references to it. When the reference count reaches zero (meaning all references to it are destroyed) it is freed using [free](https://en.wikipedia.org/wiki/C_dynamic_memory_allocation). Here’s an example.

<script src="https://gist.github.com/nomad-software/e3211f359698e46a9f86bcc7d2159fab.js"></script>

Creating reference counted objects is desirable if you are trying to keep reliance on the [garbage collector](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)) to a minimum and you want make sure objects are destroyed as soon as they have no more references to them. This makes sure you can easily define when objects are deallocated.

There are a few words of warning here though. It doesn’t work with classes and it’s currently considered unsafe and should be used with care. i.e. No references to the payload should be escaped outside the object or you’re defeating the object (pardon the pun) of using it. With that said I still think it’s pretty cool and valuable. [View documentation](https://dlang.org/phobos/std_typecons.html#.RefCounted).

### scoped

This is another nice addition for those who like to control what goes where in memory. Unlike `RefCounted` which can’t be used with classes, `scope` exists purely to cater for them. The idea behind this template is to avoid the reliance on the `new` keyword and the automatic allocation of classes on the garbage collected [heap](https://en.wikipedia.org/wiki/Memory_management#Dynamic_memory_allocation). Instead it instantiates a class in the current scope and on the [stack](https://en.wikipedia.org/wiki/Stack-based_memory_allocation). Here’s an example.

<script src="https://gist.github.com/nomad-software/7e3cfb3a46a6e064d4ae7f193c061130.js"></script>

Here `foo` is allocated on the stack and used just like any other instantiated object. The effect of the `scoped` template is that the object will immediately be destroyed upon leaving the scope it was created in. This provides what is know as [deterministic destruction](https://en.wikipedia.org/wiki/Object_lifetime#Determinism) for class based objects and as a result allows idioms such as [RAII](https://en.wikipedia.org/wiki/Resource_acquisition_is_initialization) to be implemented.

As with `RefCounted` there are a few caveats. It only works with classes and it is also deemed unsafe, i.e. it is the responsibility of the user to not escape a reference to the object outside the scope. [View documentation](https://dlang.org/phobos/std_typecons.html#.scoped).

## Conclusion

D provides an absolute wealth of fantastic features and advanced ideas in the standard library. Featured above are only a few of the treasures to be found. Two of the most amazing modules; [std.algorithm](https://dlang.org/phobos/std_algorithm.html) and [std.range](https://dlang.org/phobos/std_range.html) aren’t even mentioned here. Click the links above and read more about each one and see for yourself the appeal and productivity of a modern system programming language such as D.

---
author: Gary Willoughby
title: Alternative function syntax in D explained
description: An alternative syntax has not been included by accident but by design and as a result could potentially make code more complicated to understand and add more friction to first learning the language.
---

![](/articles/images/alternative-function-syntax-in-d-banner.jpg)

# Alternative function syntax in D explained

<time>Posted on 8th August 2013 by [Gary Willoughby](/pages/about.html)</time>

This is an extension article to [Templates in D explained](/articles/templates-in-d-explained.html) where I introduce the alternative function syntax and how it complements template usage. This article will expand a little more on that syntax and make clear what is available in [D](https://dlang.org/) and why.

An alternative syntax has not been included by accident but by design and as a result can potentially make code more complicated to understand and add more friction to first learning the language. This particular trade off, I believe is worth it, enabling particular features when using different paradigms.


## Optional parentheses
The first alternative syntax enables calling a function without using parens. This is possible with member functions as well as non member functions.

### Non member functions

The following demonstrates how functions defined without value parameters can be called without parens and return a value. Here `foo()` has no value parameters and can simply be called as `foo` which returns its value. This by itself seems a bit lazy and at first doesn’t seem very useful but combined with the dot notation syntax (discussed further down) it becomes very useful indeed.

<script src="https://gist.github.com/nomad-software/df1e94925b6d53720af2374eaad461fd.js"></script>

Non member functions can also be called as an assignment, passing the assigned value as the first function parameter.

<script src="https://gist.github.com/nomad-software/6c3d2998ea76a3298636c3e69c6640af.js"></script>

In the above example I pass the value `123` as an argument to the `foo` function during a simulated assignment. This is really weird and in my opinion not very useful for non member functions.

### Member functions

These behave in exactly the same way as non member functions and can be called without parens too. However, it makes far more sense here as this makes simulating object [properties](https://en.wikipedia.org/wiki/Property_(programming)) very easy.

<script src="https://gist.github.com/nomad-software/ac593726cd73751708d686a1a729fa50.js"></script>

Above, the [overloading](https://en.wikipedia.org/wiki/Function_overloading) of `bar` simulates a property quite nicely as both defined functions can be called without parens.

This behavior is further enhanced by a compiler command line argument `-property` which only allows this alternative syntax on member functions marked with the `@property` attribute. There is [quite a controversy surrounding this](http://forum.dlang.org/thread/uskutitmqgdfjeusrtfv@forum.dlang.org) so use with care.

### Template parameters

Template parameters (and templates in general) are detailed in a previous post [previous post](/articles/templates-in-d-explained.html) where it’s explained that the rules for their parens are very similar to functions. At the most basic, if there is only one template parameter then those parens can be omitted and in some cases the template parameter can be omitted too.

For example these three calls instantiate this templated function in exactly the same way:

<script src="https://gist.github.com/nomad-software/7e57ce98947cf5568b4371ac53e728fb.js"></script>

When calling a templated function using the last option however, the type must be able to be inferred by the compiler at compile time. If that’s possible, the template will be instantiated successfully. If more than one template parameter is defined and specified in the call then parens must always be used.

**Not explicitly passing template parameters is referred to as IFTI (Implicit Function Template Instantiation)** i.e. template parameters can be omitted when they can be deduced from the function arguments.

The same also applies for template parameters in classes, structures and interfaces.

<script src="https://gist.github.com/nomad-software/7a2c2e92c4f2621128e65a063bab447d.js"></script>

Here i’ve instantiated the `Stack` class using no parens whatsoever which looks extremely weird but mirrors what we’ve learned so far. First, there is only one template parameter so parens are not needed there. Second, there’s no constructor defined for this class so we don’t need parens there either. The constructor is a member function too so it also adheres to previous rules regarding parens usage with functions that have no parameters.

## Dot notation (UFCS)

Aside from optional parentheses there is another important alternative syntax when using non member functions. This syntax is relatively easy to understand but unless it’s been explained can cause huge confusion. Essentially any non member function can infer the first value parameter from the identifier prefixing the call appended via a dot.

<script src="https://gist.github.com/nomad-software/306fbfb52f7c88e234066236a689b896.js"></script>

Here the `foo` function defines an `int` as its first parameter. During the call we pass this argument using a literal (or alternatively a variable) prefixing the call appended via a dot e.g. `123.foo()`. Because the first parameter is now fulfilled using dot notation, the argument is no longer required to be passed in the call’s parens. Because the function no longer needs any arguments, the parens are optional as shown on by the last `assert`.

**This dot notation syntax is commonly referred to as UFCS (Uniform Function Call Syntax)** You can read more about the rationale behind it in an aptly named article called [Uniform Function Call Syntax](http://www.drdobbs.com/cpp/uniform-function-call-syntax/232700394) by [Walter Bright](https://en.wikipedia.org/wiki/Walter_Bright).

## Common usage

These alternate syntaxes are there to make programming using D more expressive and concise and easing the rules on templates and functions can lead to some surprisingly elegant constructs.

### Properties

As shown above, the big win for optional parens are to allow properties to be created easily, eliminating the need for ubiquitous [getters and setters](https://en.wikipedia.org/wiki/Mutator_method). In [object oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming) this is a big win for simplicity.

### Chaining calls

Having optional parens on non member functions coupled with dot notation allows chaining many together leading to more simple and concise code.

<script src="https://gist.github.com/nomad-software/e46bfe73e572461912e9ce18be94c65a.js"></script>

Here i’ve chained templates and functions together to create the array `x`, each passed an argument via dot notation and all missing their parens. This style lends itself very well to [functional programming](https://en.wikipedia.org/wiki/Functional_programming).

### Extension methods

One of the most useful applications of the dot notation syntax is to create [extension methods](https://en.wikipedia.org/wiki/Extension_method) for existing types. This allows a library of functions to be imported and reused while seeming to belong to the types on which they are used.

<script src="https://gist.github.com/nomad-software/a6e31fab79941b029ff1c79eb84cb3cd.js"></script>

Although here the `increment()` function is defined separately (and could quite easily be imported from a module) its use through dot notation makes it appear to be a native property or method of `x`. This alternative syntax can be a great way to create flexible libraries. In fact this pattern is used extensively in [Phobos](https://dlang.org/phobos/index.html), the standard library included with all D compilers.

> A huge reason for them is to head off the temptation to write ‘kitchen sink’ classes that are filled with every conceivable method. The  desired approach is to have the class implement the bare minimum of functionality, and add other functionality with extension methods (that do not have access to the class’ private state). – Walter Bright

## Conclusion

Hopefully this article will ease confusion over these alternative syntaxes and help newcomers learn this great language. Once these simple rules are learned reading most D code becomes a breeze and further enhances your toolset.

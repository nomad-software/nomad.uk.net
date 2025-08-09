---
author: Gary Willoughby
title: Forget currying, use partial application
description: I'm currently reading more about advanced JavaScript design patterns and an interesting concept i've come across a lot is Currying and Partial Application.
---

![](/nomad.uk.net/articles/images/forget-currying-use-partial-application-banner.jpg)

# Forget currying, use partial application

<time>Posted on 10th July 2013 by [Gary Willoughby](/nomad.uk.net/pages/about.html)</time>

I'm currently reading more about advanced [JavaScript](https://en.wikipedia.org/wiki/JavaScript) [design patterns](https://en.wikipedia.org/wiki/Design_pattern) and an interesting concept i've come across a lot is **Currying** and **Partial Application**. For years i've used partial application but not known its name or how it can be used to its fullest, so it was a pleasant surprise to read more and fully understand it. Currying on the other hand is partial application's more serious cousin and something i've never really used. Here follows the differences and why they may or may not be useful.

## Partial application

I'll start with partial application first as I think it's the easiest to understand and the most useful in JavaScript programming.

So what is it? It's basically a function factory that customises the returned function via the passed arguments to the main function. Here's an example:

<script src="https://gist.github.com/nomad-software/d00c7c233a643ec186faf3001812518e.js"></script>

Here i've passed argument values during the factory calls that are going to be used in the returned function's calculations when itself will be called. These initial argument values are held as state in the returned function because of Closure.1 This way of returning customised functions negates the need to pass large amounts of argument data in a function call and also negates the need to create objects to hold state. It's incredibly simple and incredibly useful for priming functions with known data.

As a cool by-product, the example above elegantly demonstrates two of JavaScript's most awesome features, functions as [first class objects](https://en.wikipedia.org/wiki/First-class_citizen) and closures.

## Currying

Before it start to describe currying in any detail, i'll describe its etymology. Currying is a rediscovery of an earlier technique discovered by a guy named [Moses Schönfinkel](https://en.wikipedia.org/wiki/Moses_Sch%C3%B6nfinkel) and in many cases it is referred to as Schönfinkeling! I guess because Moses' last name is hard to pronounce people tend to use the name of its re-discoverer [Haskell Curry](https://en.wikipedia.org/wiki/Haskell_Curry). For the sake of brevity i'll use the term Currying.

Earlier I wrote that currying is the more serious cousin to partial application purely because it's used more in true [Functional Languages](https://en.wikipedia.org/wiki/Functional_programming) and for more mathematical applications such as [Lambda Calculus](https://en.wikipedia.org/wiki/Lambda_calculus). In principle however the two are very much alike and are frequently confused.

Currying is very similar to partial application but is a process that transforms a function to act differently regarding the data it consumes through it's arguments. Once curried, the new function returns another function with a reduced amount of parameters with state held in closure. The difference from partial application is that each returned function will only everhave one parameter. Each invocation of the returned function will return another function that requires one parameter until the operation is complete and a value is returned.

Once a function has been curried, it is effectively 'primed' for partial application, because as soon as you pass an argument into a curried function, you are partially applying that argument. Unlike partial application, however, a curried function will keep returning curried functions until all arguments of the original function have been specified.

This sounds like an awesome construct and something that would be very useful, but in reality i've had a hard time even finding any practical application of currying anywhere on the internet. Currying is an advanced technique which is more at home in theoretical computer science than in practice.2

## Conclusion

When people tend to say use currying to solve a problem in JavaScript they probably mean partial application which is incredibly useful. Currying isn't because i've yet to find a useful application of it.

---

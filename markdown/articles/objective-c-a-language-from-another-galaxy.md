---
author: Gary Willoughby
title: Objective-C, A language from another galaxy
description: Over the last few weeks i've been learning Objective-C, Apple's flagship programming language, preferred for all Mac OS and iOS development.
---

![](/articles/images/objective-c-a-language-from-another-galaxy-banner.jpg)

# Objective-C, A language from another galaxy

<time>Posted on 9th July 2013 by [Gary Willoughby](/pages/about.html)</time>

Over the last few weeks i’ve been learning [Objective-C](https://en.wikipedia.org/wiki/Objective-C), [Apple’s](https://en.wikipedia.org/wiki/Apple_Inc.) flagship programming language, preferred for all [Mac OS](https://en.wikipedia.org/wiki/Macintosh_operating_systems) and [iOS](https://en.wikipedia.org/wiki/IOS) development. Wanting to create my own iPhone and iPad apps, i wanted to learn Objective-C and of course after doing a great deal of programming using C type languages I thought it would be quite easy to learn and program using it, …how wrong i was!

## A galaxy far, far away

If you’ve ever programmed using C or C++ some things will be familiar but a lot will be very alien. Objective-C is a strict superset of ANSI C with the addition of [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk) style messaging designed to add [OOP](https://en.wikipedia.org/wiki/Object-oriented_programming) features. Where as C++ and Java both have their origins in the Simula language. If you’re only used to [Simula](https://en.wikipedia.org/wiki/Simula) based languages Objective-C starts getting very weird very quickly.

> The Objective-C model of object-oriented programming is based on message passing to object instances. In Objective-C one does not call a method; one sends a message. This is unlike the Simula-style programming model used by C++. The difference between these two concepts is in how the code referenced by the method or message name is executed. In a Simula-style language, the method name is in most cases bound to a section of code in the target class by the compiler. In Smalltalk and Objective-C, the target of a message is resolved at runtime, with the receiving object itself interpreting the message. A method is identified by a selector which is a NULL-terminated string representing its name and which is resolved to a C method pointer implementing it. A consequence of this is that the message passing system has no type checking. The object to which the message is directed is not guaranteed to respond to a message, and if it does not, it simply raises an exception. <sup>1</sup>

## Do or do not. There is no try

Calling a method of an object pointed to by the pointer ‘*object’ would require the following code in C++:

<script src="https://gist.github.com/nomad-software/f97408e81fe20de541aecb194e5f415d.js"></script>

In Objective-C, this is expressed as a message using square brackets:

<script src="https://gist.github.com/nomad-software/154e9b7680433791882eb0633efb8781.js"></script>

If you notice in the above code, after the first argument, each further argument is given a name when using it in a message. Very strange but actually quite informative and very useful.

Objective-C, like Smalltalk, can use dynamic typing, for example, an object can be sent a message that is not specified in its definition. This can allow for increased flexibility, as it allows an object to ‘capture’ a message and send it on to a different object which can respond to the message appropriately, or likewise send the message on to another object. This behaviour is known as message forwarding or delegation. Alternatively, an error handler can be used in case the message cannot be forwarded. If an object does not forward a message, respond to it, or handle an error, the message is silently discarded.

## I am your father

Objective-C also has way of extending objects at runtime without inheriting from them or even needing access to the source code. These are called Categories and can be added to any object. [Categories](https://en.wikipedia.org/wiki/Objective-C#Categories) are very similar to C#’s [extension methods](https://en.wikipedia.org/wiki/Extension_method). A category can collect method implementations into separate files if needed. A programmer can then place groups of related methods into a named category to make them more readable. For instance, one could create a spell checking category in the String object, collecting all of the methods related to spell checking into a single place. If a category declares a method with the same method signature as an existing method in a class, the category’s method is adopted.

## You are a protocol droid are you not?

[Protocols](https://en.wikipedia.org/wiki/Objective-C#Protocols) are very similar to interfaces in C# or Java but can be informal or formal. Put simply, an interface is a set of definitions of methods and values which the objects agree upon in order to cooperate. In Objective-C, informal protocols when declared in an object’s definition don’t have to be implemented, but can be in order to support optional messages, etc. Formal protocols when declared in an object’s definition must be implemented by the object to provide a strict contract that other objects can rely on when using this object. Usually only formal protocols are available in other languages.

## The end

I’m still learning Objective-C and i already like what i see. It’s one of the weirdest languages i’ve ever used but i like C and the object stuff bolted on by Objective-C is the icing on the cake. Good programmers always advise you should occasionally try your hand with other languages and try something different once in a while to keep better informed and to get more experience I’m loving learning Objective-C because it’s so different from what i’m used to and there’s so much new stuff to learn. I’m learning this language to eventually create my own iPhone and iPad apps, hopefully i’ll keep you updated on what i discover while learning.

If you have the time and a sense of adventure, i’d strongly recommend you give Objective-C a go. You’ll be confused for a while but who knows, you may enjoy learning something new and get some valuable experience along the way?

---

1. [http://en.wikipedia.org/wiki/Objective-C#Messages](http://en.wikipedia.org/wiki/Objective-C#Messages)

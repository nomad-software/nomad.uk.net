---
author: Gary Willoughby
title: Why Go's design is a disservice to intelligent programmers
description: Go is shaping up to be a popular language for doing serious large scale work and a language created by Google is not to be sniffed at. With all that said, I honestly think Go's design is a disservice to intelligent programmers.
---

![](/nomad.uk.net/articles/images/why-gos-design-is-a-disservice-to-intelligent-programmers-banner.jpg)

# Why Go's design is a disservice to intelligent programmers

<time>Posted on 25th March 2015 by [Gary Willoughby](/nomad.uk.net/pages/about.html)</time>

**EDIT:** This is now an old post and my opinion of Go has changed a great deal over the years. This article has been used to cause harm on the reputation of Go and its community which is not warranted. Over the years i've come to appreciate the simplicity of Go and the ethos behind its creation. Today, I'm employed as a Go engineer and I enjoy using it tremendously. In fact, I'd go further and say it's one of the finest languages I've ever used. With all honesty, my opinion was wrong when I wrote this article and the quotes by Rob Pike were obviously a reaction to the complexity of other bloated languages.

---

Over the course of the past few months I've been using [Go](https://golang.org/) to implement a [proof of concept](https://en.wikipedia.org/wiki/Proof_of_concept) program in my spare time. This was done in part to learn Go and to also see if such a program would work. The program itself is very simplistic and not the focus of this article but my experience of using Go is worth writing a few words. Go is shaping up to be a popular language for doing serious large scale work and a language created by [Google](https://github.com/golang/go) is not to be sniffed at. With all that said, I honestly think Go's design is a disservice to intelligent programmers.

## Created for lesser programmers?

![](/nomad.uk.net/articles/images/an-introduction-to-programming-in-go-book-cover.jpg)

Go is very easy to learn, in fact it's so easy it took me one evening to read an introductory text and be productive almost immediately. The book I learned from was entitled [An Introduction to Programming in Go](http://www.golang-book.com/) and is available on-line. Similar to Go, the book is easy to read with good examples and clocking in at about 150 pages you can finish it in one sitting. Initially this simplicity starts off very refreshing in a programming world full of overly complicated technologies but there's a niggling thought of "Is that it?".

Google maintains that Go's simplicity is a selling point and it's designed that way for maximising productivity in large teams but I'm not convinced. There are aspects of Go that are either seriously lacking or overly verbose because it doesn't trust developers to get things right. This focus on simplicity was a concious decision made by the language designers and in order to fully understand why, we need to understand the motivation for developing Go and the state of mind of the creators.

So why create it so simple? Well, here's a few quotes from [Rob Pike](https://en.wikipedia.org/wiki/Rob_Pike):

> The key point here is our programmers are Googlers, they're not researchers. They're typically, fairly young, fresh out of school, probably learned Java, maybe learned C or C++, probably learned Python. They're not capable of understanding a brilliant language but we want to use them to build good software. So, the language that we give them has to be easy for them to understand and easy to adopt. – Rob Pike <sup>1</sup>

> It must be familiar, roughly C-like. Programmers working at Google are early in their careers and are most familiar with procedural languages, particularly from the C family. The need to get programmers productive quickly in a new language means that the language cannot be too radical. – Rob Pike <sup>2</sup>

What? So Rob Pike is basically saying that the developers at Google aren't very good so they've developed a dumbed down language so they can get things done. What a condescending view on your own employees. I've always thought that the developers at Google are hand picked from the brightest and best on Earth. Surely they can handle something a little more complicated?

## Artifacts of being too simple

Being simple is a noble pursuit of any design and trying to make something simple is hard. However, when trying to solve (or even express) complicated problems you sometimes need a complicated tool. Of course too much complexity is bad in programming but there is a nice middle ground when the language allows you to create elegant abstractions that make things easier to understand and use. From my experience of using Go it's just too simple to create useful abstractions.

### Not very expressive

Because Go is so simple most constructs that other languages take for granted have been left out. On the surface this looks like a good idea but when confronted with a problem you can only write verbose code. A reason for Go's simplicity is to help developers read other people's code but being overly simplistic actually hurts readability. There are no shortcuts in Go, it's verbose code or nothing.

For example, if you are writing a command line tool that needs to read text input from [stdin](https://en.wikipedia.org/wiki/Standard_streams#Standard_input_.28stdin.29) or a file passed as an argument, you might do it like this:

<script src="https://gist.github.com/nomad-software/682fa91b30fcb7dd243e43cf3d3b33f1.js"></script>

Although this code is trying to be as generic as possible you are hamstrung by Go's forced verbosity and a simple task ends up being a _lot_ of code.

Here's the same example using the [D language](https://dlang.org/):

<script src="https://gist.github.com/nomad-software/2098c42493b1ff04a79497c14da31671.js"></script>

Now, which one is more readable? I'd choose the D version. It's a lot more readable purely because it's expressing the program's intent in a much more clear way. This code also uses concepts that are more advanced than the Go code but they're nothing too complicated that an intelligent programmer couldn't pick up [quickly](/nomad.uk.net/articles/alternative-function-syntax-in-d.html) and [easily](/nomad.uk.net/articles/templates-in-d-explained.html).

### Boiler plate hell

A feature often requested for Go is support for [generics](https://en.wikipedia.org/wiki/Generic_programming). This would at least allow for stopping all the unnecessary boiler plate code that has to be created to support all needed data types. If for example you'd like to create a function which calculates the sum of a list of integers you are immediately sentenced to implementing the same function for all needed data types. There simply is no other way around it.

Here's an example:

<script src="https://gist.github.com/nomad-software/3b7d517dfb5404efbace11e4f254f29c.js"></script>

This example doesn't even implement all the integer types, just the [signed](https://en.wikipedia.org/wiki/Integer_%28computer_science%29) ones. This is a complete violation of [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), one of programmings most well known and understood principles and ignoring it is a huge source of bugs. Why on Earth would you want to do this? This is a terrible facet of Go.

Here's the same example in D:

<script src="https://gist.github.com/nomad-software/2efe729e232120230d085ef6fb807e3f.js"></script>

Simple, elegant and straight to the point. Here the `reduce` function can handle _any_ type and the predicate (passed as a template parameter) defines how to reduce the list. Yes it's more complicated than Go but not so complicated that intelligent programmers can't understand it. Which is more maintainable and easy to read?

### An easily circumvented type system

I guess by now Go programmers reading this will be frothing at the mouth shouting “You're doing it wrong!”. Well, there is another way of implementing generic functions and data types, and that is to completely break the type system!

Check this example out for a showcase of ~~stupidity~~ patching a language to overcome shortfalls:

<script src="https://gist.github.com/nomad-software/4b5a837ce7df363abb840ea7ffa296aa.js"></script>

This `Reduce` implementation was taken from an on-line article entitled [Idiomatic generics in Go](http://bouk.co/blog/idiomatic-generics-in-go/). Well if that's idiomatic, i'd hate to see un-idiomatic. Using `interface{}` is a farce and is only included in the language to circumvent type checking. It is an empty interface which is implicitly implemented by all types allowing a total free for all. This style of programming is as ugly as hell and not only that but to perform such acrobatics in the above example you are also forced to use runtime [reflection](https://en.wikipedia.org/wiki/Reflection_(computer_programming)). Even Rob Pike doesn't like people abusing reflection and has mentioned this in many talks.

> It's a powerful tool that should be used with care and avoided unless strictly necessary. – Rob Pike <sup>3</sup>

I'd take [D's templates](/nomad.uk.net/articles/templates-in-d-explained.html) any day over this nonsense. How can anyone say `interface{}`  is more readable or even type safe?

## Dependency management woes

Go has a built-in dependency system which is built upon popular source control hosting services. The tools that ship with Go are aware of these services and can retrieve code from them, install and build it in one fell swoop. While this is great, there is a major oversight and that is versioning! Yes that's right you can retrieve source code from services such as [github](https://github.com/) or [bitbucket](https://bitbucket.org/) using the Go tools but you can't specify a version of the code. Again this screams that the design has been made as simple as possible to the detriment of being useful. I can't fathom the thinking behind such a decision.

When questions where asked about this state the Go team wrote a [forum thread](https://groups.google.com/forum/#!msg/golang-dev/nMWoEAG55v8/iJGgur7W_SEJ) outlining how they where going to get around this issue. Their recommendation was to just copy the entire repository at that time into your project and leave it as-is. What the hell are they thinking? We have these awesome source control systems with great tagging and version support which the Go creators ignore and just copy the whole thing around.

## Cultural baggage from C

In my opinion Go has been designed by people who have been using [C](https://en.wikipedia.org/wiki/C_%28programming_language%29) all their lives and don't want to try anything new. The language could be described as C with [training wheels](https://en.wikipedia.org/wiki/Training_wheels). There is no new ideas in the language apart from the concurrency support (which is excellent by the way) and it's such a shame. You have this great concurrency support in a barely usable, hamstrung language.

Another grating issue is that because Go is [procedural](https://en.wikipedia.org/wiki/Procedural_programming) (just like C 'shock horror') you start writing code in a procedural way which feels archaic and old hat. I know [object-oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming) is no silver bullet but it would have been nice to be able to abstract details away into types and provide better [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)).

## Simplicity for its own sake

Go was designed to be simple and it has succeeded in that goal. It has been written for lesser programmers using an old language as a template. It comes complete with simple tools for doing simple things. It is simple to learn and simple to use.

It's overly verbose, inexpressive and a disservice to intelligent programmers everywhere.

---

1. [http://channel9.msdn.com/Events/Lang-NEXT/Lang-NEXT-2014/From-Parallel-to-Concurrent](http://channel9.msdn.com/Events/Lang-NEXT/Lang-NEXT-2014/From-Parallel-to-Concurrent)
2. [https://talks.golang.org/2012/splash.article](https://talks.golang.org/2012/splash.article)
3. [https://blog.golang.org/laws-of-reflection](https://blog.golang.org/laws-of-reflection)

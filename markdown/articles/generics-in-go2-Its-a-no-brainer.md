---
author: Gary Willoughby
title: Generics in Go v2.0 It’s a no-brainer!
description: Recently there has been a lot of talk about adding Generics to the popular programming language Go. Not only do I think this is a good idea, I actually think it's a complete no-brainer!
---

![](/articles/images/generics-in-go2-Its-a-no-brainer-banner.jpg)

# Generics in Go v2.0 It’s a no-brainer!

<time>Posted on 25th July 2017 by [Gary Willoughby](/pages/about.html)</time>

Recently there has been a lot of talk about adding [Generics](https://en.wikipedia.org/wiki/Generic_programming) to the popular programming language [Go](https://golang.org/). Not only do I think this is a good idea, I actually think it’s a complete no-brainer! Go has been maturing at a rapid rate over the last few years and the Go team have recently [started asking for user experiences](https://github.com/golang/go/wiki/ExperienceReports) to influence Go’s future. In my humble opinion, they only need to focus on one thing. Can you guess what it is?

## Go’s hype is real

[I’ve written before about Go](/articles/why-gos-design-is-a-disservice-to-intelligent-programmers.html) and how I was initially pretty unimpressed with the over simplicity and parenting that is forced upon you. However, over time I’ve come to enjoy using Go to the point that every new project I tackle, Go is the first language I consider. In my opinion, it’s unsurpassed for cross-platform support, tooling and libraries. The language itself is simple and straightforward and the concurrency support is second to none. It really is an absolute joy to create [concurrent programs](https://en.wikipedia.org/wiki/Concurrent_computing) in such a simple, robust way. I, like many people, just enjoy using Go. So what’s the problem?

## Its problem is a lack of reusability

This is the [elephant in the room](https://en.wikipedia.org/wiki/Elephant_in_the_room), or as some have described it, the [‘N’ word of Go](https://www.quora.com/Which-language-has-the-brightest-future-in-replacement-of-C-between-D-Go-and-Rust-And-Why). Generics are a feature that solves real world problems which Go literally can’t cope with. These problems that are nigh on impossible to solve without resorting to bypassing [type system](https://en.wikipedia.org/wiki/Type_system) or using [reflection](https://en.wikipedia.org/wiki/Reflection_(computer_programming)) hacks, both of which are highly discouraged.

These are currently impossible to do with Go in any sane way

1. Create reusable [abstract data types](https://en.wikipedia.org/wiki/Abstract_data_type)
1. Create reusable algorithms (for comparison, iteration, mutation, searching and sorting)
1. Implement reusable interfaces (for [ranges](http://www.informit.com/articles/article.aspx?p=1407357&amp;seqNum=2) or [iterators](https://en.wikipedia.org/wiki/Iterator))
1. Create any non-trivial [abstraction](https://en.wikipedia.org/wiki/Abstraction_(software_engineering))

The list goes on but the startling common thread running through this list is reusability. Why is Go so adverse to reusability or to writing libraries? I know [Rob Pike](https://en.wikipedia.org/wiki/Rob_Pike) likes to espouse "[A little copying is better than a little dependency.](https://go-proverbs.github.io/)" but the copying is getting out of control and whats more, this is a solved problem.

Even the [Go team has suffered from the lack of reusability](https://www.airs.com/blog/archives/559) making difficult decisions to add new built-in functions to the language because of the lack of library friendly generics.

> I’m not really opposed to a builtin append function but I want to make the obvious comment that, like copy, this is a function we are only considering because we don’t have generics. – Ian Lance Taylor <sup>1</sup>

## Generics will solve this

You don’t need user experience reports to clearly see the problems people are facing using Go. You just have to open any Go discussion on the internet. This is a bigger problem than experience reports will show because people simply use another language if they have to implement the above list. Generics are the missing part of the puzzle to make Go a world class, leading language. [Adding this for Go v2.0 is the right thing to do](https://github.com/golang/go/issues/15292).

---

1. [https://www.airs.com/blog/archives/559](https://www.airs.com/blog/archives/559)

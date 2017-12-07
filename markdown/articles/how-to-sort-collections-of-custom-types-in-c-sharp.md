---
author: Gary Willoughby
title: How to sort collections of custom types in C#
description: I've recently created a program which sorts collections of custom types quite extensively and i thought i'd share the standard method of doing this.
---

![](/articles/images/how-to-sort-collections-of-custom-types-in-c-sharp-banner.jpg)

# How to sort collections of custom types in C#

<time>Posted on 9th July 2013 by [Gary Willoughby](/pages/about.html)</time>

I’ve recently created a program which sorts collections of custom types quite extensively and i thought i’d share the standard method of doing this. When i first started designing my program, i honestly thought it would be quite a pain sorting these collections but i was pleasantly surprised, as usual by the .NET framework, that there are built in shortcuts.

## IComparable

The first stage to allow a custom type to be sorted is to implement the IComparable interface. This consists of one method `CompareTo&lt;T&gt;` where T is your custom type. This becomes your default comparer.

Here’s an example:

<script src="https://gist.github.com/nomad-software/a5167f6b866338cd9dcb243f5e982ee0.js"></script>

Once that method is implemented (here we’ve implemented it using the name field to compare against) you can use the native sort methods on a collection of such types and have them sorted via this default comparer. For example if you are using an array as your collection, you can use the default static ‘Sort’ method to sort it:

<script src="https://gist.github.com/nomad-software/7e54b8618213bd736ecd525078dddf81.js"></script>

If you are using a generic list you can use the built in ‘Sort’ method:

<script src="https://gist.github.com/nomad-software/33715f7cacbe80fbaed90d49881a5343.js"></script>

Again this uses the default comparer and sorts the collection by the name field.

## Comparison

If you need to give the user the option of multiple ways of sorting your collection you must implement other comparers. This is achieved by implementing Comparison delegates. Let’s implement some in our custom type to allow sorting of every field:

<script src="https://gist.github.com/nomad-software/c393b614afe0541b464b6388324ae920.js"></script>

Here, as well as the default comparer, we have implemented three Comparison delegates to provide the rules of sorting the three fields in the custom type. They have been made static so you can use them without referring to an instance of the custom type.

Here is an example of sorting an array of our custom type by the Age field.

<script src="https://gist.github.com/nomad-software/148edbfd338be90d9071c97ce875f9f8.js"></script>

and here is how you sort a generic list collection by the Age field:

<script src="https://gist.github.com/nomad-software/3701599a4aaf8d80c9a9d4d8dc18002d.js"></script>

Simple.

Hopefully this gives you good grounding on sorting custom type collections and although there are other ways of sorting available in the .NET framework, these are the most common.

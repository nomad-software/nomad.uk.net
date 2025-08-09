---
author: Gary Willoughby
title: Developers who hate on OOP don't know how to use it
description: Object-oriented programming seems to be receiving a lot of hate recently, usually from inexperienced developers who have just learned functional programming.
---

![]($root-path$/articles/images/developers-who-hate-on-oop-don't-know-how-to-use-it.jpg)

# Developers who hate on OOP don't know how to use it

<time>Posted on 28th July 2019 by [Gary Willoughby]($root-path$/pages/about.html)</time>

[Object-Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming) seems to be receiving a lot of hate recently, usually from inexperienced developers who have just "learned" [Functional Programming](https://en.wikipedia.org/wiki/Functional_programming) and then want to hate on anything that doesn't support [functional purity](https://en.wikipedia.org/wiki/Pure_function). Unfortunately, this crowd always seems to fit the same mold. They are usually web developers, fairly young, seemingly intelligent but extremely impatient and easily swayed by new technology (e.g. JavaScript developers fit this mold precisely) but the most important trait that sets them apart from developers who embrace OOP, is not persevering long enough to actually learn how to use it.

## So what's the problem?

As far as I can tell, the biggest reason developers hate on OOP is over the misapplication of [inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)) (resulting in [bloated code](https://en.wikipedia.org/wiki/Code_bloat)) or [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)) isn't working out (diffusing responsibilities of objects). The irony here is that if they had exposure to better code they wouldn't have such a negative view. Inheritance and encapsulation are extremely important when modeling problems using OOP and when used correctly can result in beautiful, easy to maintain code.

It's a paradoxical scenario in which developers will never gain the experience or guidance to write good object-oriented code because they'll never have the experience of working with a well-written source to learn from. This is especially true of web development. Web development is notorious for creating terribly structured code, usually because of time pressures and the natural lazy predisposition afforded by immediate results in a browser.

### Inheritance

When complaining about inheritance, the following quote is usually wheeled out to much fanfare and regurgitated ad nauseam.

> The problem with object-oriented languages is they've got all this implicit environment that they carry around with them. You wanted a banana but what you got was a gorilla holding the banana and the entire jungle. - Joe Armstrong (Author of Erlang)

This is obviously alluding to receiving imagined bloat when extending a class you have no control over. I say "no control over" because If you did have control of it you could refactor, redesign and simplify it to avoid any bloat.

Huge sprawling inheritance hierarchies are bad, everyone knows that when trying to write maintainable object-oriented code. To suggest that _all_ code is bad in this regard (as the above quote does) is being disingenuous. Just because you can do something in code, doesn't mean you always should. Learning to apply any programming language correctly and effectively takes time.

#### Perceived fragility

Another inheritance criticism I hear from the OOP hating crowd is that when extending a class, your new one could break if the base class were to change in future. Well duh! Changing any public API of any codebase always has the potential of breakage. Even if the base class implementation changes you will have to verify that everything still works as expected. And guess what, there's a solution for that, it's called [unit testing](https://en.wikipedia.org/wiki/Unit_testing).

### Encapsulation

When developers complain about encapsulation being a problem of OOP it's usually because they have no idea how to correctly perform it. Encapsulation is all about the responsibility of a particular object. i.e. What data and behavior is assigned to that object and what access is allowed if any.

It's not a difficult concept to grasp, in fact, it's surprisingly simple _but_ takes years to master even after being taught well. Encapsulation is something most inexperienced developers fail at when writing object-oriented code. Not because of lack of effort but because of a lack of any upfront design, a lack of thought and consideration of where code should go and an impatient impulse to just get writing code. As is usually the case in web development. Good encapsulation is only realized through exercising rigor when assigning responsibilities to objects.

### Weaponizing functional programming

Whenever OOP is attacked, these developers tend to stand in their ivory towers, holding functional programming aloft as some mighty hammer with which to smite all unbelievers. Smug in their superior knowledge of the secret sauce everyone else should be using, chanting mantras such as:

> Functional programming is clearly superior to OOP, everyone should use it! - New FP User

Unfortunately while practicing this fundamentalism they never allow for the fact that some of us lowly object-oriented developers also know functional programming and have simply decided to not use it. Functional programming is not superior to OOP, it's just different. OOP and functional programming are useful in [very different situations](https://stackoverflow.com/a/2079678/13227). Saying one is better than the other is clearly not understanding either and guess what, [in some languages, you can use both](https://en.wikipedia.org/wiki/D_(programming_language)#Programming_paradigms).

## OOP handles complexity well

Object-oriented programming isn't a silver bullet and no one ever said it was. The main reason of using it is to handle the complexity of programming. There is also the more-or-less mapping of real-world objects to their virtual counterparts which makes reasoning about problems and code easier. Of course, some people will argue this (as those above do) but it _is_ there for the most part.

If you have used OOP well and the program still turns out more complicated than if it was written in a [procedural style](https://en.wikipedia.org/wiki/Procedural_programming) then you may as well use procedural code. (Hoping you don't need to extend it later.)

If OOP is _causing_ complexity in your program it's either the wrong tool for the job or you are using it poorly. If your program is bigger than a command-line tool and you are experiencing these problems, it's the latter.

## Learn and practice OOP before hating on it

For me and other experienced developers to take your criticisms of OOP seriously you are going to have to show us where things have gone wrong. If you do this, I can almost guarantee it's because of bad practice and not understanding the fundamentals. OOP is very easy to pick up but hard to master. You can read a book on it in an afternoon and understand core principles. However, it takes years of programming and experience for the penny to drop and to have a clear understanding.

There's also the issue of discipline to actually do it. When I talk to other developers about OOP, almost all will fully understand the textbook definitions and most will understand the practical application. They just don't do it! You can ask a developer what does encapsulation mean and they will answer well but when you look at their code they just haven't applied it. This is a massive hurdle to get over for inexperienced developers. For me personally, I would say it took about ten years to truly understand encapsulation and have the discipline to always do it correctly.

If you're going to hate on OOP you better be using it correctly or you're going to look like a fool.

---

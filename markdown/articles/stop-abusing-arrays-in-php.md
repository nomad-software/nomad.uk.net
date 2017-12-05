![](/articles/images/stop-abusing-arrays-in-php-banner.jpg)

# Stop abusing arrays in PHP

<time>Posted on 29th June 2014 by [Gary Willoughby](/pages/about.html)</time>

This is an issue i’ve wanted to get of my chest for a long time. It’s been latently brewing inside me for a considerable amount of time and it’s starting to come to a head. The issue is with PHP and the total abuse of arrays. Whether this issue is an artifact of the language’s historical baggage or because PHP just attracts a lot of inexperienced developers is up for debate. My problem here is that arrays are nearly always used where objects should be!

Let’s take a look at some truly horrendous code abusing arrays. Let’s say for example that we are retrieving some data from a database (or saving it for that matter) and the way we handle that data is via arrays. Here is a made up example i see daily.

<script src="https://gist.github.com/nomad-software/4ef174e03e6f87673ac3c5ba81da41ff.js"></script>

Here we have a giant [multidimensional array](https://en.wikipedia.org/wiki/Array_data_structure#Multidimensional_arrays) holding information about a particular fishing pond. There is only one pond listed here but imagine if there were hundreds in this array with much more rich data. So what’s up with this? Well think about it, here we have a shed load of data stored in an array but absolutely no associated behaviour. When we need to work with this data we have to construct complicated processor classes or functions full of nested loops to handle it. For example, how do i get the total amount of fish stocked in a pond? I’d have to iterate through the array and add and the numbers together. To the untrained eye that would not be such a big deal but it would be nicer to handle that calculation like this.

<script src="https://gist.github.com/nomad-software/12fca8711de70ef1173b2f89824f5a85.js"></script>

No processor class needed and a lot less code to get at the exact piece of data i need. Of course the calculation has to take place somewhere and you can’t escape looping through the data to add this up but this behaviour should be nicely encapsulated inside the relevant classes. And that’s the main problem here. Using arrays as gigantic storage bins means you are robbing yourself blind from all of the advantages of [object oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming). The above should be structured more like this.

<script src="https://gist.github.com/nomad-software/67751e417b3ef29a79c4b4a79f31e61e.js"></script>

## Needless complexity

Using huge multidimensional arrays not only means all associated behaviour is absent but you need complicated access mechanisms in place to actually work with the data. Usually these are implemented as processor classes which employ huge methods using nested loops. It’s not unusual to see code like this.

<script src="https://gist.github.com/nomad-software/40405c92bee49630b4075349cfe41e57.js"></script>

Usually though these processor classes are a lot more complicated because the nesting levels in the arrays are a lot more deep and contain way too much information. Complexity and maintainability goes through the roof making future modifications of the array structure or the processor time consuming and fraught with danger. Also the behaviour implemented here has nothing in common with the data it’s using. It’s literally just a processor iterating through data, there’s no relationship at all. The more i think about this i’m convinced this is another facet of the [anemic domain model](https://www.martinfowler.com/bliki/AnemicDomainModel.html) anti-pattern [Martin Fowler](https://en.wikipedia.org/wiki/Martin_Fowler) talked about years ago. Again, wouldn’t it be a lot simpler to do this?

<script src="https://gist.github.com/nomad-software/fdd0e067b263893cde339f52d72c2382.js"></script>

Using classes to encapsulate the data better might seem like you are writing more code but i guarantee from experience it’s less in the long run. Just think of all the code needed to be written in processors that deal with arrays. All those loops are not necessary. Not only will it turn out to be less code written but you are also defining clear boundaries to what each class does and [what it’s responsible for](https://en.wikipedia.org/wiki/Single_responsibility_principle) making future maintenance work easier to perform. Lots of little components are easier to work with than [huge balls of code](https://en.wikipedia.org/wiki/Big_ball_of_mud).

## You’re doing it wrong

The only reason i see the above being used on a daily basis is because either the developer is inexperienced, doesn’t understand object oriented programming or is lost in the past. I don’t care how you justify using arrays like this, at it’s core is [procedural programming](https://en.wikipedia.org/wiki/Procedural_programming), it’s not scalable and you’re doing it wrong! Object oriented programming was invented to handle this kind of stuff especially for associating behaviour with state, helping with maintainability and keeping complexity to an absolute minimum. Believe it or not i’ve seen code from extremely popular e-commerce companies using this [anti pattern](https://en.wikipedia.org/wiki/Anti-pattern) for something as important as shopping carts and orders. In some places developers are not allowed to touch the code (even when it’s bugged) because it’s so complicated and brittle, change is literally impossible. It’s crazy!

## Working with collections

Get it out of your head that you need to use an array because you have a collection of data. **The word ‘collection’ does _not_ mean use an array!** This is where inexperience of PHP developers show through because they have never heard of [iterators](https://en.wikipedia.org/wiki/Iterator). Using iterators enables you to work with collections of data while implementing associated behaviour. It sounds complicated but it’s actually really simple. Here is a class implementing an iterator.

<script src="https://gist.github.com/nomad-software/08035d4bbd536850752ea981e021bab4.js"></script>

Boom, that’s it. Implementing a class like this creates an iterable collection of data with associated behaviour. At it’s heart is an array but an array which can now be nicely decorated with associated methods for working with the data. Implementing the <code>IteratorAggregate</code> interface on this class makes it immediately available to loops.

<script src="https://gist.github.com/nomad-software/87336117022349f1f09817e7954bf53c.js"></script>

Here the value of <code>\$pond</code> is whatever the individual elements of <code>\$collection</code> are, which of course can be instances of other objects. This is how collections should be handled in PHP when they need any behaviour associated with them. Instead of this associated behaviour being spread around the application in different processors, it’s now actually attached to the collection itself. More information on iterators can be found here.

* [http://www.php.net/manual/en/class.iteratoraggregate.php](http://www.php.net/manual/en/class.iteratoraggregate.php)
* [http://www.php.net/manual/en/spl.iterators.php](http://www.php.net/manual/en/spl.iterators.php)

## Conclusion

 Arrays are not evil but should only be used when a collection of data has no associated behaviour. Please stop this madness of using (and abusing) arrays for everything!

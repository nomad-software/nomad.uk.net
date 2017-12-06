![](/articles/images/templates-in-d-explained-banner.png)

# Templates in D explained

<time>Posted on 20th July 2013 by [Gary Willoughby](/pages/about.html)</time>

Let’s get one thing straight from the outset, [template metaprogramming](https://en.wikipedia.org/wiki/Template_metaprogramming) scares the hell out of most developers! I have no idea why, probably because it simply _sounds_ scary? Whatever the reason, many developers shy away from even learning about such techniques, let alone use them. This is such a shame because templates offer a superb tool for programming at a higher level of [abstraction](https://en.wikipedia.org/wiki/Abstraction_(software_engineering)) which is something that can aid in better program design.

Even though many programming languages support template metaprogramming this article is about using templates in [D](https://dlang.org/). D is one of the best languages I have ever used and the more I use it the more I realise it’s getting everything just right. Hopefully this article will remove the above fear and educate developers on what can be achieved.

## So what are templates?

Put simply templates are a tool to enable automatic generation of source code at [compile time](https://en.wikipedia.org/wiki/Compile_time) which is then inserted into your program. You create a template for the source code and the compiler generates the needed code based on that template. It really is that simple. With that in mind let’s start.

## Type parameters

To start understanding templates you first need to understand type parameters. These are the things that give templates their flexibility. These type parameters can be applied to classes, member functions, interfaces and structs but for the purpose of initial instruction i’ll demonstrate how they are used with _non_ member functions. So without further ado, take a look at this function definition:

<script src="https://gist.github.com/nomad-software/16796639f8f9ca52779a3e4aadb30515.js"></script>

Here i’ve declared a function called `foo` which takes an integer as a parameter and then returns it. This is pretty straightforward stuff but by using the `int` type hint for the parameter i’ve effectively constrained this particular function to only accept that particular type. It can only be called successfully by passing an integer as a parameter, as shown in the call. This might not seem like a big deal here but imagine if this was a very useful function that would also make sense to take a string as a parameter too. If that was the case we could achieve this in two ways. The first option is to [overload](https://en.wikipedia.org/wiki/Function_overloading) the function and therefore declare one for each supported type:

<script src="https://gist.github.com/nomad-software/e7d18682e9e8d3f4ea9383743a263bfb.js"></script>

but that means we have to duplicate the definition, which is less than ideal. The second option to handle this scenario is to use type parameters. Take a look at this:

<script src="https://gist.github.com/nomad-software/7fae6587905d21113a9cc01eb2598ce2.js"></script>

Here only _one_ function is needed to support multiple types. In this definition we simply substitute the type hint for a type place holder which will be replaced when we call the function. I’m using the letter `T` here as the place holder to replace all types, even for the return type. Let me explain this a bit further.

### Why two sets of parentheses?

You’ll notice that I declare the function with two sets of parentheses that contain the letter `T`. This is how you define type parameters. The first set defines place holders that are going to substitute the types we use (here i’ve only used one, `T`). The second set of parens assign these place holders to values as you would for normal value parameters. So essentially i’ve declared that the parameter `x` is of a type represented by `T`. We don’t need to declare any types at this stage only the place holders.

### What’s that strange exclamation mark?

To call this templated function we need to pass type information along with the value parameter. This information will be passed into the definition at compile time and replace the place holders. This is called template instantiation. To pass this in correctly you use another set of parens preceded by an exclamation mark `!` during the call:

<script src="https://gist.github.com/nomad-software/1e8452386132b34e7a2af0e044dc426c.js"></script>

The first of the above calls passes `int` as the type which should replace `T` and `12345` as the value parameter. The second call passes `string` which should replace `T` and the string `hello` as the value parameter. The compiler then generates two functions when compiling, effectively recreating the overload example above but without repeating any code.

When defining a function that uses type parameters you can define as many as you need and use them anywhere in the definition anywhere where real types are expected:

<script src="https://gist.github.com/nomad-software/e147ad6603a807a3282fcbe1d8f63b0a.js"></script>

Notice i’m using `A[]` for the type of `container` and `B` as the iterator type in the `for` loop.

### Alternative syntax

So far we have seen the longhand way of calling functions with template parameters. Meaning, i’ve only so far shown the most explicit way of calling a function with type parameters. There also exists a alternative syntax.

The following is sometimes used when calling a defined function where there exists only one type parameter. If that’s the case we don’t need to use parens around the type parameter in the call. These two calls instantiate the template in exactly the same way:

<script src="https://gist.github.com/nomad-software/a81a35239148c7bc759a530b90cbdd3a.js"></script>

To further shorten this, we could even take away the type parameter completely. These are all equal:

<script src="https://gist.github.com/nomad-software/079f9b11ba3aff198b2f9822801c3949.js"></script>

When calling a templated function using the last option however, the type must be able to be inferred by the compiler at compile time. If that’s possible, the template will be instantiated successfully.

The last alternative can be the most confusing and exists only because **in D all functions defined without value parameters can be called without their parens**.

<script src="https://gist.github.com/nomad-software/a93adbae0a350a1690b05e503a64e5cd.js"></script>

Here i’ve opted to call the function only specifying the type parameters (without the parens) and without the normal parameter parens (because the function doesn’t take any parameters).

I try to stay away from alternative styles where possible to make sure the code is as readable as possible for other developers. I can however understand why these alternative styles exist so they need to be understood.

### Dot notation support

As with all non member functions you can call templated versions using the dot notation syntax too. **In D any non member function can infer the first value parameter from the identifier prefixing the call appended via a dot**:

<script src="https://gist.github.com/nomad-software/fd28cc6daa27888603018634bf44145c.js"></script>

All seven calls above instantiate the templated function successfully and all produce the same output. In the case of the calls where no type parameter is passed, the type is inferred from the literal. Using dot notation is an excellent way to create [extension methods](https://en.wikipedia.org/wiki/Extension_method) for existing types and to create very flexible libraries. In fact this pattern is used extensively in [Phobos](https://dlang.org/phobos/index.html), the standard library included with all D compilers.

## Parameterized classes, interfaces and structs

So far i’ve used non member functions to demonstrate type parameters but they can also be applied to classes, interfaces and structs. Here’s an example implementation of a queue using type parameters on an interface and a class. (Structures use them in exactly the same way.)

<script src="https://gist.github.com/nomad-software/96e4ba0162dca82d3ccd3dd3a91a565c.js"></script>

The usage of type parameters above makes sure the type represented by the place holder flows through not only the class but the interface as well. The type is then used throughout the entire definition for the type of the `data` member variable, the parameter type of the `enqueue` method and return type of the `dequeue` method.

To demonstrate the true flexibility of the above implementation we can easily create a queue that uses integers instead, like this:

<script src="https://gist.github.com/nomad-software/a110dd54a3b56a6c690f240d64175cc8.js"></script>

And that is it! Simply by changing the type we instantiate the template in a different way. Each instantiated template, both the string and integer version are strongly typed and react as if two implementations had been created by hand.

Notice i’ve used the longhand syntax to define the interface and class. For me this is easier to read and understand what is being asked of the compiler. When instantiating the queue object i’m in two minds whether the longhand or alternative is better. Some people prefer `auto x = new Queue!(string)();` while others prefer `auto x = new Queue!string;`. After learning the alternative syntax above, both are equal.

## Parameterized scopes

After reading the above few paragraphs you should now have a grasp on what type parameters are and how they are used in definitions. Sometimes however you might like to perform some compile time type manipulation but don’t want to create a class, struct or function doing it. This is where parameterized scopes come into play. These allow you to define a block scope using the `template` keyword and later instantiate it while passing parameters. These scopes (or templates as we’ll refer to them from now on) can be instantiated whenever they are needed. Once the template has been instantiated you can then read types or values from it. Here is an example:

<script src="https://gist.github.com/nomad-software/33db1eae40694f06c07172c7fba092d8.js"></script>

Above i’ve defined a template called `FixedSizeArray` that can create many array types depending on the parameters passed. The first thing to notice is that you can pass type parameters and value parameters to the template in the same set of parens. This is intended and as long as everything passed is available at compile time the template will instantiate successfully.

When first instantiating the template I pass the type `short` and the literal `2` like this:

<script src="https://gist.github.com/nomad-software/d10248fffbb4f4927269b1a2ba9b6ece.js"></script>

I then access the aliased type definition inside the template scope by using dot notation and use it as a type to define `location`. In the above line `type` is the alias i’m accessing (created by the template) therefore the entire line compiles to:

<script src="https://gist.github.com/nomad-software/09e3c04fc7f74ae722aa7145c8398162.js"></script>

Of course this is a contrived example to demonstrate how templates are used but the example clearly shows how types and values are passed into a template and how values or (in this case) types are accessed from outside the scope. A template can create as many types and values as needed and all can be accessed from outside via dot notation. However, templates usually only define one type or value purely to keep things modular and simple.

### Eponymous templates

I can guess what you’re thinking, oh no, another template to learn? Well not exactly. **Eponymous templates are templates defined in a particular way enabling alternative access of one type or value inside**. If you look at the above template again, it only defines one aliased type called `type` and we then access that using dot notation to actually use it. It would be nicer to infer that type or value for use during template instantiation. To do this is to create an eponymous template. Here is the above example re-written to be one:

<script src="https://gist.github.com/nomad-software/5aa14fec8cc353b6d2c8b50c7fc027e3.js"></script>

The only change i’ve made is to rename the type alias to the same name as the template itself and remove the dot notation when instantiating it. That’s all that’s needed for a type or value to be automatically used on template instantiation. In fact all the compiler is doing is automatically adding the dot notation for us. So in effect when we use the template like this:

<script src="https://gist.github.com/nomad-software/77e0d1ac99adc7849a71c96776a8b354.js"></script>

The compiler is really doing this:

<script src="https://gist.github.com/nomad-software/35b16ecab4d3acd144d2e8c3a0817ffa.js"></script>

This is awesome and makes the code a lot cleaner. There is however one draw back in that you can’t access any other types or values within the template as any dot notation used will always have the inferred name appended first.

## Mixins templates

The final part of understanding templates is learning about mixins. These are templates that allow you to inject code anywhere where the mixin is used. Using one is very similar to using parameterized scopes (templates) but instead of accessing that scope from outside, the mixin is instantiated (compiled) and injected where it’s used. Look at this example:

<script src="https://gist.github.com/nomad-software/f2a0a2033ae286cb12cbcf36bccee7b7.js"></script>

Here i’ve created a mixin template called `property` to allow automatic creation of class member variables. When instantiated using the `mixin` keyword followed by its name and type parameters, this template will copy its contents to that position in the code. You can see this in action in the above class definition of `C`. There you can see the template instantiation and point of injection:

<script src="https://gist.github.com/nomad-software/b49e25561a1a736d47e54e6cd2356b6c.js"></script>

The above line means replace `T` with `int` in the mixin definition and then inject all of the mixin’s contents here. Once this class is then instantiated we have access to the injected property through the mutator and accessor methods as also defined by the mixin.

### Mixin scopes

Another feature of mixins is that a scope can be introduced when injecting a mixin. This allows us to resolve ambiguity when referring to code that is injected multiple times. For example, if we try and inject another property into the class above we will encounter an error because each mixin is trampling over the other. To get around this problem the idea of scopes can be added to the mixin instantiation. Using the same mixin template as before we can modify the class definition to add scopes to mixin injection.

<script src="https://gist.github.com/nomad-software/952015627c1f184a5871a5583dcd3ee0.js"></script>

Introducing scopes like this means we can now refer to each piece of injected code separately.

### A brief warning

Mixins can inject any code anywhere and as such require a great deal of discipline to use without creating an unholy undecipherable monster. You have been warned!

## Common template features

Most of the template types discussed above have common features that can be used for each. For example the type parameters are a common feature of all template types and were introduced first as they are fundamental to understanding all templates. There are however a few more common features that can be applied to all of the above template types.

### Variadic type parameters

Similar to variadic value parameters in functions, templates also support variadic type parameters too. These are useful for passing an arbitrary amount of types or values to any kind of template. When passing types or values this way the place holder refers to a [Tuple](https://en.wikipedia.org/wiki/Tuple) containing the passed data. As a by-product of this and as a demonstration we can create an eponymous template to create usable tuples extremely easily:

<script src="https://gist.github.com/nomad-software/fda0d4136b3f13428a91838a6ccfa792.js"></script>

Notice the [ellipsis](https://en.wikipedia.org/wiki/Ellipsis) immediately after the place holder `T` in the `Tuple` template definition. That denotes this is an arbitrary length tuple of types and/or values. I haven’t done it in this template but the tuple data itself can be accessed via array like indexes. The tuple is assigned to the `rhyme` variable and passed to the `format` function which itself requires variadic value parameters for its data. Just for information, when passing a tuple like this to a function it is flattened out as a comma delimited list of its contents. Read more about tuples in D [here](https://dlang.org/tuple.html).

### Template constraints

When defining type parameters you can also create constraints to make sure templates only instantiate when parameters of a certain type are passed. These are called template constraints or template specialisations and there are two forms. The first is a simple type hint on the type parameter like this:

<script src="https://gist.github.com/nomad-software/2c055c39095f31dd5a835799ecd82586.js"></script>

Here we’ve decorated the place holder `T` with the type hint `int` using a colon character. This only allows type parameters that can be implicitly cast to an integer. All the calls above will instantiate the template correctly.

The second form is a more firm constraint used to strongly define the only allowed type that should be used for a particular type parameter:

<script src="https://gist.github.com/nomad-software/e6294fcacf1a551bb93f4b52b7a31f0b.js"></script>

Using the `if` and `is` keywords together only `int` can now be specified as the type parameter to replace `T` and successfully instantiate the template.

## Conclusion

Okay, this article has expanded to way more than i first imagined but after writing it i’m glad a single resource like this now exists. Hopefully this article will give future D developers a firm grounding of how to use templates in D and what options are available. I could expand a little further giving multiple examples and use cases but i prefer to keep it as simple as possible for now. There is a lot more to learn about templates especially about what’s really going on ‘under the hood’ but you don’t need to know that in order to use them effectively.

I hope this has been insightful and given you the confidence to use template meta programming in your D programs and i hope it has removed a lot of the fear that surrounds it. D is a fantastic language and makes stuff like this fun and intuitive. Give it a go!

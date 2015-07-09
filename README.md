Functional Utilities for Coffeescript and Javascript
----------------------------------------------------

`Underscore`/`lodash` too much but never enough?

So you have `async` for breaking all your `Promise`s?

Fuc it all!

    require('fuc')._it_all()           # fuc the global namespace, fuc prototypes

    1 + __ 2                           # logs 2, returns 3

    unite {a: 1}, {b: 2}               # => {a: 1, b: 2}

    do thus {a: 1}, -> this.a + 1      # => 2

    [1, 2, 4]._fap (it) ->
      if it%2 then null else it-2      # => [0, 2]


Also, fuc the browser (TODO)

    <script src='out/fuc.min.js'></script>
    <script>Fuc.it.all()</script>

If you think that looks dangerous, you can fuc less but stay safe:

    {__, thus, fap, extend} = require 'fuc'


Srsly? Why?
-----------

Yes. `lodash` is nice, but most functions have wrong argument order, and they're not curried. Also some are sorely missing (like `flip`).

So, here's a bundle of functions, in all its 20-line glory, that most of the time obviates the need to include helper libraries, for me at least.

I'll add some async helpers as well, I promise!


Documentation
-------------

    __ (arg [, args...]) -> arg
    arg.__([args...]) -> arg
    # console.log all arguments, return the first one. great for debugging.

    ___ (prefix, arg [, args...]) -> arg
    arg.___(prefix [, args...]) -> arg
    # console.log prefix and all arguments, return first argument (after prefix)

    curry (fn(a, b [, c...])) -> fn(b, a [, c...])
    # takes a function with two or more arguments, returns a function that can
    # be called either with two or more arguments (same as the original),
    # or with one argument, in which case it returns a function that awaits
    # the second argument and possibly more - ultimate flexibility

    flip (fn) -> fn
    # takes a function with two or more arguments, returns it with the first two # arguments flipped, and curried

    flap (arg, fn [, args...]) -> result
    obj._flap (fn [, args...]) -> result
    # applies the function to the argument(s); `flip apply`

    thus (this_object, fn) -> fn
    this_object._thus (fn) -> fn
    # bind the `this` object in the function body; flipped `Function.bind`

    unite (object, other_object [, other_objects...]) -> object
    object._unite (other_object [, other_objects...]) -> object
    # create a new object with properties merged from all the arguments

    fap (fn, array) -> array
    array._fap (fn) -> array
    # map, then filter out undefineds and nulls (but not `false`s, `0`s or ''s)

    zop (array) -> object
    array.zop() -> object
    # create an object from a list of pairs of [key, value]


All functions with two or more arguments can be used in a curried fashion: If you call them with only one argument, they will return a function awaiting the other argument (and any optional arguments).

Prototypes of built-in objects like `Object` and `Array` are only extended if you call `Fuc._it_all()`, and the new methods always start with an underscore to avoid name clashes.


Motivating Examples
-------------------

### `__`

I'm not saying we're stuck with console.log debugging in javascript. But it's the easiest, and yields the most results for the effort.
Inspecting runtime values is much more important than in static languages: where proper languages throw errors, Javascript does something stupid and moves on like nothing happened. So you need to trace expressions' values to see what's going on. You could do that by setting breakpoints and watches, but that stops program execution and you need to muck about in Developer Tools. It's not so straightforward in `node.js`.

Logging could be more convenient though. When you want to log a subexpression, you have to copy it, since console.log doesn't return anything. Also, it's kind of boring to type it all the time. Well, that's fixed now, just insert '__' wherever, and add parens as needed.

     Array(16).join(__ 'here'-1) + 'Fapman'      # logs 'NaN', returns something

I used to include the definition for `__` at the top of every single Coffeescript/Javascript source file I wrote, plus usually a few of the other functions here. Now I don't have to.

### `unite`

Lodash and jQuery have `extend`. It's why I include lodash most of the time (along with zipObject). But it mutates the argument. Bleah.

### `flap`

So you want to write the argument first, and then the function you to call with it. Coffeescript has `do` which calls the function immediately after it, and passes the arguments with the same name as the function arguments.

Sometimes you need more though.

### `fap`

Filter map. or `f(x) for x in arr when f(x) is null or f(x) is undefined`.


License
-------

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, for any purpose, commercial or non-commercial.
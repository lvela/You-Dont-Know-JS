# You Don't Know JS
# Preface

Before I begin, let me first dispel (or perhaps start!) a rumor. The "JS" in this book series title is "not" an abbreviation for a common curse-word, though said curse-word is often used when talking *about* the topic which "JS" actually stands for: JavaScript.

From the earliest days of the web, JavaScript has been a foundational technology that drives interactive experience around the content we consume. While flickering mouse trails and annoying pop-up prompts may be where JavaScript started, nearly 2 decades later, the technology and capability of JavaScript has grown many orders of magnitude, and few doubt its importance at the heart of the world's most widely available software platform: the web.

But as a language, it has perpetually been a target for a great deal of criticism, owing partly to its heritage but even more to its design philosophy. Even the name evokes, as Brendan Eich once put it, "dumb kid brother" status next to its more mature older brother "Java". But the name is merely an accident of politics and marketing. The two languages are vastly different in many important ways. "JavaScript" is as related to "Java" as "Carnival" is to "Car".

Because JavaScript borrows concepts and syntax idioms from several languages, including proud C-style procedural roots as well as subtle, less obvious Scheme/Lisp-style functional roots, it is exceedingly approachable to a broad audience of developers, even those with just none to little programming experience. The "Hello World" of JavaScript is so simple that the language is inviting and easy to get comfortable with in early exposure.

While JavaScript is perhaps one of the easiest languages to get up and running with, its eccentricities make solid mastery of the language a vastly less common occurrence than in many other languages. Where it takes a pretty in-depth knowledge of a language like C or C++ to write a full-scale program, full-scale production JavaScript can, and often does, barely scratch the surface of what the language can do.

Sophisticated concepts which are deeply rooted into the language tend instead to surface themselves in *seemingly* simplistic ways, such as passing around functions as callbacks, which encourages the JavaScript developer to just use the language as-is and not worry too much about what's going on under the hood.

It is simultaneously a simple, easy-to-use language that has broad appeal, and a complex and nuanced collection of language mechanics which without careful study will elude *true understanding* even for the most seasoned of JavaScript developers.

But therein lies the paradox of JavaScript, the Achilles' Heel of the language, the challenge we are presently addressing. Because JavaScript *can* be used without understanding, the understanding of the language is often never attained. But this *friendliness* offers no protection to a developer from the binary harshness of the "it works or it doesn't" reality. The language cannot magically do something other than what you tell it to do. If you fail to instruct it correctly, because you do not understand *how* to do so, you will inevitably receive an unexpected (to you, anyway!) result.

And yet, since the language still feels so friendly and unassuming of such nuance, JavaScript developers, and indeed, developers of other languages who grudgingly tolerate the necessity of JS in a project, will not turn first their finger of blame at their own lack of understanding, but instead towards the language itself.

Perhaps the most famous indictment (among many!) is aimed squarely at the "implicit coercion" mechanism in JavaScript, and accuses that *feature* of being a design flaw, a bug, a mistake. This criticism, to be fair, targets a part of the language which is littered with many treacherous stumbling blocks. But when you analyze the argument and the mindset, you begin to see that implicit coercion is an intentional and powerful feature like any other, and has both its shining moments and its danger zones which you must be careful around.

To hear this criticism to its full extent, what is argued is that the mechanism is too complex, too fraught with issues and misunderstanding, and rather than trudge through *to* the land of enlightenment, JavaScript developers should simply not travel down that difficult path. It's a textbook case of "throwing the baby out with the bathwater".

While avoiding such pitfalls certainly protects you, the JS developer, from the pain of misstep, it also cuts off at the knees the power and potential of the language and what you can do with it.

And most dangerously of all, it perpetuates in you a mindset which emphasizes avoidance and blame shifting, instead of cheering you on *and assisting you* to deeper and more mature understanding. If at every point that you encounter a surprise or frustration in JavaScript, your response is to add it to the blacklist, you soon will be relegated to a hollow shell of the richness of JavaScript.

While this subset has been famoulsy dubbed "The Good Parts", I would implore you, dear reader, to instead consider it the "The Easy Parts", "The Safe Parts", or even "The Incomplete Parts".

Our "You Don't Know JavaScript" book series offers a contrary challenge: learn and deeply understand *all* of JavaScript, even and especially "The Tough Parts".

Here, we address head on the tendency of JS developers not only to learn "just enough" to get by, without ever forcing themselves to learn exactly how and why the language behaves the way it does, but we eschew the common advice to *retreat* when the road gets rough.

I am not content, nor should you be, at stopping once something *just works*, and not really knowing *why*. I gently challenge you to journey down that bumpy "road less traveled" and embrace all that JavaScript is and can do. With that knowledge, no technique, no framework, no popular buzzword acronym of the week, will be beyond your understanding.

These books each take on specific core parts of the language which are most commonly misunderstood or under-understood, and dive very deep and exhaustively into them. You should come away from reading with a firm confidence in your understanding, not just of the theoretical, but the practical "what you need to know" bits.

The JavaScript you know *right now* is probably *parts* handed down to you by others tending to and bandaging their battle scars. *That* JavaScript is but a shadow of the true language. You don't *really* know JavaScript, *yet*, but if you dig into this series, you *will*. Read on, my friends. JavaScript awaits you.

## Review (TL;DR)

JavaScript is awesome. It's easy to learn partially, and much harder to learn completely (or even *sufficiently*). When developers encounter confusion, they usually blame the language instead of their lack of understanding. These books aim to fix that, inspiring a strong appreciation for the language you can now, and *should*, deeply *know*.
# You Don't Know JS: Scope & Closures
# Appendix A: Dynamic Scope

In Chapter 2, I mentioned "Dynamic Scope" as a contrast to how scope works in JavaScript (and in fact, most other languages): Lexical Scope.

We will briefly examine dynamic scope, to hammer home the contrast. But, more importantly, dynamic scope actually is a near cousin to another mechanism in JavaScript, which we will not cover in this title but *do* cover in the "*this & Object Prototypes*" title: `this`.

As we saw in Chapter 2, lexical scope is the set of rules about how the *Engine* can look-up a variable and where it will find it. The key characteristic of lexical scope is that it is defined at author-time, when the code is written (assuming you don't cheat with `eval()` and `with`).

Dynamic scope seems to imply, and for good reason, that there's a model whereby scope can be determined dynamically at runtime, rather than statically at author-time. That is in fact the case. Let's illustrate via code:

```js
function foo() {
	console.log(a); // 2
}

function bar() {
	var a = 3;
	foo();
}

var a = 2;

bar();
```

Lexical scope holds that the RHS reference to `a` in `foo()` will be resolved to the global variable `a`, which will result in value `2` being output.

Dynamic scope, by contrast, doesn't concern itself with how and where functions and scopes are declared, but rather *where they are called from*. In other words, the scope chain is based on the call-stack, not the nesting of scopes in code.

So, if JavaScript had dynamic scope, when `foo()` is executed, **theoretically** the code below would instead result in `3` as the output.

```js
function foo() {
	console.log(a); // 3  !!?!
}

function bar() {
	var a = 3;
	foo();
}

var a = 2;

bar();
```

How can this be? Because when `foo()` cannot resolve the variable reference for `a`, instead of stepping up the nested (lexical) scope chain, it walks up the call-stack, to find where `foo()` was *called from*. Since `foo()` was called from `bar()`, it checks the variables in scope for `bar()`, and finds an `a` there with value `3`.

Strange? Probably you're thinking so, at the moment.

But that's just because you've probably only ever worked on (or at least deeply considered) code which is lexically scoped. So dynamic scoping seems foreign. If you had only ever written code in a dynamically scoped language, it would seem natural and lexical scope would be the odd-ball.

To be clear, JavaScript does not, in fact, have dynamic scope. It has lexical scope. Plain and simple. But the `this` mechanism is kind of like dynamic scope.

The key contrast: **lexical scope is write-time, whereas dynamic scope (and `this`!) are runtime**. Lexical scope cares *where a function was declared*, dynamic scope cares where a function was *called from*, and (not to spoil the other book title) `this` cares *how a function was called*. To dig more into `this`, go read the title "*this & Object Prototypes*".
# You Don't Know JS: Scope & Closures
# Appendix B: Polyfilling Block Scope

In Chapter 3, we explored Block Scope. We saw that `with` and the `catch` clause are both tiny examples of block scope that have existed in JavaScript since at least the introduction of ES3.

But it's ES6's introduction of `let` that finally gives full, unfettered block-scoping capability to our code. There are many exciting things, both functionally and code stylistically, that block scope will enable.

But what if we wanted to use block scope in pre-ES6 environments?

Consider this code:

```js
{
	let a = 2;
	console.log(a); // 2
}

console.log(a); // ReferenceError
```

This will work great in ES6 environments. But can we do so pre-ES6? `catch` is the answer.

```js
try{throw 2}catch(a){
	console.log(a); // 2
}

console.log(a); // ReferenceError
```

Whoa, man! That's some ugly, weird looking code. We see a `try/catch` that appears to forcibly throw an error, but the "error" it throws is just a value `2`, and then the variable declaration that receives it is in the `catch(a)` clause. Mind blown.

That's right, the `catch` clause has block-scoping to it, which means it can be used as a polyfill for block scope in pre-ES6 environments.

"But...", you say. "...no one wants to write ugly code like that!" That's true. No one writes (some of) the code output by the CoffeeScript compiler, either. That's not the point.

The point is that tools can transpile ES6 code to work in pre-ES6 environments. You can write code using block-scoping, and benefit from such functionality, and let a build-step tool take care of producing code that will actually *work* when deployed.

This is actually the preferred migration path for all (ahem, most) of ES6: to use a code transpiler to take ES6 code and produce ES5-compatible code during the transition from pre-ES6 to ES6.

## Traceur

Google maintains a project called "Traceur" [^note-traceur], which is exactly tasked with transpiling ES6 features into pre-ES6 (mostly ES5, but not all!) for general usage. The TC39 committee relies on this tool (and others) to test out the semantics of the features they specify.

What does Traceur produce from our snippet? You guessed it!

```js
{
	try {
		throw undefined;
	} catch (a) {
		a = 2;
		console.log(a);
	}
}

console.log(a);
```

So, with the use of such tools, we can start taking advantage of block scope regardless of if we are targeting ES6 or not, because `try/catch` has been around (and worked this way) from ES3 days.

## Implicit vs. Explicit Blocks

In Chapter 3, we identified some potential pitfalls to code maintainability/refactorability when we introduce block-scoping. Is there another way to take advantage of block scope but to reduce this downside?

Consider this alternate form of `let`, called the "let block" or "let statement" (contrasted with "let declarations" from before).

```js
let (a = 2) {
	console.log(a); // 2
}

console.log(a); // ReferenceError
```

Instead of implicitly hijacking an existing block, the let-statement creates an explicit block for its scope binding. Not only does the explicit block stand out more, and perhaps fare more robustly in code refactoring, it produces somewhat cleaner code by, grammatically, forcing all the declarations to the top of the block. This makes it easier to look at any block and know what's scoped to it and not.

As a pattern, it mirrors the approach many people take in function-scoping when they manually move/hoist all their `var` declarations to the top of the function. The let-statement puts them there at the top of the block by intent, and if you don't use `let` declarations strewn throughout, your block-scoping declarations are somewhat easier to identify and maintain.

But, there's a problem. The let-statement form is not included in ES6. Neither does the official Traceur compiler accept that form of code.

Tools are meant to solve our problems. So, I built a tool called "let-er" [^note-let_er] to address just this issue. *let-er* is a build-step code transpiler, but its only task is to find let-statement forms and transpile them. It will leave alone any of the rest of your code, including any let-declarations. You can safely use *let-er* as the first ES6 transpiler step, and then pass your code through something like Traceur if necessary.

Moreover, *let-er* has a configuration flag `--es6`, which when turned on, changes the kind of code produced. Instead of the `try/catch` ES3 polyfill hack, *let-er* would take our snippet and produce the fully ES6-compliant, non-hacky:

```js
{
	let a = 2;
	console.log(a);
}

console.log(a); // ReferenceError
```

So, you can start using *let-er* right away, and target all pre-ES6 environments, and when you only care about ES6, you can add the flag and instantly target only ES6.

And most importantly, you can use the more preferable let-statement form even though it is not an official part of any ES version (yet).

## Performance

Let me add one last quick note on the performance of `try/catch`, and/or to address the question, "why not just use an IIFE to create the scope?"

Firstly, the performance of `try/catch` *is* slower, but there's no reasonable assumption that it *has* to be that way, or even that it *always will be* that way. Since the official TC39-approved ES6 transpiler uses `try/catch`, the Traceur team has asked Chrome to improve the performance of `try/catch`, and they are obviously motivated to do so.

Secondly, IIFE is not a fair apples-to-apples comparison with `try/catch`, because a function wrapped around any arbitrary code changes the meaning, inside of that code, of `this`, `return`, `break`, and `continue`. IIFE is not a suitable general substitute. It could only be used manually in certain cases.

The question really becomes: do you want block-scoping, or not. If you do, these tools provide you that option. If not, keep using `var` and go on about your coding!

[^note-traceur]: [Google Traceur](http://traceur-compiler.googlecode.com/git/demo/repl.html)

[^note-let_er]: [let-er](https://github.com/getify/let-er)
# You Don't Know JS: Scope & Closures
# Appendix C: Lexical-this

Though this title does not address the `this` mechanism in any detail, there's one ES6 topic which relates `this` to lexical scope in an important way, which we will quickly examine.

ES6 adds a special syntactic form of function declaration called the "arrow function". It looks like this:

```js
var foo = a => {
	console.log(a);
};

foo(2); // 2
```

The so-called "fat arrow" is often mentioned as a short-hand for the *tediously verbose* (sarcasm) `function` keyword.

But there's something much more important going on with arrow-functions that has nothing to do with saving keystrokes in your declaration.

Briefly, this code suffers a problem:

```js

var obj = {
	id: "awesome",
	cool: function() {
		console.log(this.id);
	}
};

var id = "not awesome"

obj.cool(); // awesome

setTimeout(obj.cool, 100); // not awesome
```

The problem is the loss of `this` binding on the `cool()` function. There are various ways to address that problem, but one often-repeated solution is `var self = this;`.

That might look like:

```js
var obj = {
	count: 0,
	cool: function() {
		var self = this;

		if (self.count < 1) {
			setTimeout(function(){
				self.count++;
				console.log("awesome?");
			},100);
		}
	}
};

obj.cool(); // awesome?
```

Without getting too much into the weeds here, the `var self = this` "solution" just ends-around the whole problem of understanding and properly using `this` binding, and instead falls back to something we're perhaps more comfortable with: lexical scope. `self` becomes just an identifier that can be resolved via lexical scope and closure, and cares not what happened to the `this` binding along the way.

People don't like writing verbose stuff, especially when they do it over and over again. So, a motivation of ES6 is to help alleviate these scenarios, and indeed, *fix* common idiom problems, such as this one.

The ES6 solution, the arrow-function, introduces a behavior called "lexical this".

```js
var obj = {
	count: 0,
	cool: function() {
		var self = this;

		if (self.count < 1) {
			setTimeout(() => { // arrow-function ftw?
				this.count++;
				console.log("awesome?");
			},100);
		}
	}
};

obj.cool(); // awesome?
```

The short explanation is that arrow-functions do not behave at all like normal functions when it comes to their `this` binding. They discard all the normal rules for `this` binding, and instead take on the `this` value of their immediate lexical enclosing scope, whatever it is.

So, in that snippet, the arrow-function doesn't get its `this` unbound in some unpredictable way, it just "inherits" the `this` binding of the `cool()` function (which is correct if we invoke it as shown!).

While this makes for shorter code, my perspective is that arrow-functions are really just codifying into the language syntax a common *mistake* of developers, which is to confuse and conflate "this binding" rules with "lexical scope" rules.

A more appropriate approach, in my perspective, to this "problem", is to use the `this` mechanism correctly.

```js
var obj = {
	count: 0,
	cool: function() {
		var self = this;

		if (self.count < 1) {
			setTimeout(function(){
				this.count++;
				console.log("more awesome");
			}.bind(this),100); // look, `bind()`!
		}
	}
};

obj.cool(); // more awesome
```

Whether you prefer the new lexical-this behavior of arrow-functions, or you prefer the tried-and-true `bind()`, it's important to note that arrow-functions are **not** just about less typing of "function".

They have an *intentional behavioral difference* that we should learn and understand, and if we so choose, leverage.

Now that we fully understand lexical scoping (and closure!), understanding lexical-this should be a breeze!
# You Don't Know JS: Scope & Closures
# Appendix D: Thank Yous!

I have many people to thank for making this book title and the overall series happen.

Since the "You Don't Know JS" book series was born on Kickstarter, I wish to thank all my 500 generous backers:

...
# You Don't Know JS: Scope & Closures
# Chapter 1: What is Scope?

One of the most fundamental paradigms of nearly all programming languages is the ability to store values in variables, and later retrieve or modify those values. In fact, the ability to store values and pull values out of variables is what gives a program *state*.

Without such a concept, a program could perform some tasks, but they would be extremely limited and not terribly interesting.

But the inclusion of variables into our program begets the most interesting questions we will now address: where do those variables *live*? In other words, where are they stored? And, most importantly, how does our program find them when it needs them?

These questions speak to the need for a well-defined set of rules for storing variables in some location, and for finding those variables at a later time. We'll call that set of rules: *Scope*.

The way we will approach learning about scope is to think of the process in terms of a conversation, a dialogue. A one-sided conversation isn't really a conversation at all, so we need to first understand *who* is having the conversation.

## Compiler Theory

It may be self-evident, or it may be surprising, depending on your level of interaction with various languages, but despite the fact that JavaScript falls under the general category of "dynamic" or "interpreted" languages, it is in fact a compiled language. It is *not* compiled well in advance, as are many traditionally-compiled languages, nor are the results of compilation portable among various distributed systems.

But, nevertheless, the JavaScript engine performs many of the same steps, albeit in more sophisticated ways than we may commonly be aware, of any traditional language-compiler.

As this is not really a book on compiler theory, I will try to keep our discussion here brief and not too overwhelming. But it is important for you to understand some of the ways the engine works, so that you can understand that *conversation* that occurs about scope.

### Compilation

In traditional compiled-language process, a chunk of source code, your program, would undergo typically three steps *before* it is executed, roughly called "compilation":

1. **Tokenizing/Lexing:** breaking up a string of characters into meaningful (to the language) chunks, called tokens. For instance, consider the program: `var a = 2;`. This program would likely be broken up into the following tokens: `var`, `a`, `=`, `2`, and `;`. Whitespace may or may not be persisted as a token, depending on whether its meaningful or not.

    **Note:** The difference between tokenizing and lexing is subtle and academic, but it centers on whether or not these tokens are identified in a *stateless* or *stateful* way. Put simply, if the tokenizer were to invoke stateful parsing rules to figure out whether `a` should be considered a distinct token or just part of another token, *that* would be **lexing**.

2. **Parsing:** taking a stream (array) of tokens and turning it into a tree of nested elements, which collectively represent the grammatical structure of the program. This tree is called an "AST" (**A**bstract **S**yntax **T**ree).

    The tree for `var a = 2;` might be a top-level node called `VariableDeclaration`, with a child node called `Identifier` (whose value is `a`), and another child called `AssignmentExpression` which itself has a child called `NumericLiteral` (whose value is `2`).

    OK, I know, that's confusing and way too deep! Sorry, I promised we'd explore only what's necessary to learn *Scope*. Stick with me!

3. **Code Generation:** the process of taking an AST and turning it into executable code. This part varies greatly depending on the language, the platform it's targeting, etc.

    So, rather than get mired in details, we'll just handwave and say that there's a way to take our above described AST for `var a = 2;` and turn it into a set of machine instructions to actually *create* a variable called `a`, and then store a value into `a`.

The JavaScript engine is vastly more complex than that, as are most other language compilers. For instance, in the process of parsing and code generation, there is almost certainly processes to optimize the performance of the execution, including collapsing redundant elements, etc.

So, I'm painting only with broad strokes here. But I think you'll see shortly why *these* details, even at a high level, are relevant.

For one thing, JavaScript engines don't get the luxury (like other language compilers) of taking their "sweet time" to optimize. JavaScript compilation doesn't happen ahead of time, in a build step.

For JavaScript, the compilation that occurs happens, in many cases, mere microseconds (or less!) before the code is executed. To ensure the fastest performance, JS engines use all kinds of tricks (like JITs, which lazy compile and even hot re-compile, etc) which are well beyond the "scope" of our discussion here.

Let's just say, for simplicity sake, that any snippet of JavaScript has to be compiled before (usually *right* before!) it's executed. So, the JS compiler will take `var a = 2;` and compile it *first*, and then be ready to execute it, usually right away.

**Wait a minute!** What's all this got to do with the *scope conversation*? Great question.

### Meet: *Engine*

For our purposes, we are going to anthropomorphize the JavaScript engine. In other words, we're going to treat it like someone we *can* actually have a conversation with.

So, Reader, meet *Engine*, *Engine*, meet our Reader. Shake hands.

For you to *fully understand* how JavaScript works, you need to begin to *think* like *Engine* thinks, ask the questions *Engine* asks, and answer those questions how *Engine* answers them.

## Scope Conversations

When you see the program `var a = 2;`, you most likely see that as one statement. But that is not how our new friend *Engine* sees it. In fact, *Engine* sees two distinct statements, one which it will handle in compilation, and one which it will handle in execution.

So, let's break down how *Engine* will approach the program `var a = 2;`.

The first thing *Engine*'s compiler will do with this program is perform lexing to break it down into tokens, then it will parse those tokens into a tree. But next, when the compiler does code generation, it will treat this program somewhat differently than you or I may have assumed.

We might tend to think that it will produce code that could be summed up by this pseudo-code'ish: "allocate space for a variable, call it `a`, then stick the value `2` into that variable."

*Engine* will instead act like this:

1. Produce code at the beginning of the program (technically at the beginning of the appropriate *Scope*), from the `var a`, that checks the scope to see if a variable `a` already exists. If so, ignore this declaration. Otherwise, declare a new variable called `a` in the current scope.

2. Produce code for the `a = 2` assignment, wherever it appears normally in code flow, which first checks to see if there is a variable called `a` in the current scope. If so, it uses it. If not, it looks *elsewhere* (see *Nested Scope* below). If it eventually finds a variable, it assigns the value `2` to it. If not, it will raise its hand and yell out an error!

Hopefully you caught the two distinct actions/statements that *Engine* performs. It first declares a variable (if not previously declared), and then, when executing, it looks up the variable and assigns to it, if found.

### Compiler Speak

OK, I have to introduce a little bit more compiler-talk. I promise, it's important.

When *Engine* executes the code that *Compiler* produced for step (2), he has to look-up the variable `a` to see if it has been declared, and this look-up is exercising *Scope*. But the type of look-up he performs affects the outcome of the look-up.

In our case, it is said that *Engine* would be performing an "LHS" look-up for the variable `a`. The other type of look-up is called "RHS".

I bet you can guess what the "L" and "R" mean. These terms stand for "Left-hand Side" and "Right-hand Side".

Side... of what? **Of an assignment operation.**

In other words, an LHS look-up is done when a variable appears on the left-hand side of an assignment operation, and an RHS look-up is done when a variable appears on the right-hand side of an assignment operation.

Actually, let's be a little more precise. An RHS look-up is indistiguishable, for our purposes, from simply a look-up of the value of some variable, whereas the LHS look-up is trying to find the variable container itself, so that it can assign. In this way, RHS doesn't *really* mean "right-hand side of an assignment" per se, it just, more accurately, means "not left-hand side".

Being slightly glib for a moment, you could say "RHS" instead means "retrieve his source (value)", implying that RHS means "go get the value of...".

Let's dig into that deeper.

When I say:

```js
console.log(a);
```

The reference to `a` is an RHS reference, because nothing is being assigned to `a` here. Instead, we're looking-up to retrieve the value of `a`, so that the value can be passed to `console.log(..)`.

By contrast:

```js
a = 2;
```

The reference to `a` here is an LHS reference, because we don't actually care what the current value is, we simply want to find the variable as a target for the `= 2` assignment operation.

**Note:** LHS and RHS meaning "left/right-hand side of an assigment" doesn't necessarily literally imply "... side of the `=` assignment operator". There are several other ways that assignments happen, and so you have to conceptually think about it as: "who's the target of the assignment (LHS)" and "who's the source of the assignment (RHS)".

Consider this program. There are both LHS and RHS references going on here.

```js
function foo(a) {
	console.log(a); // 2
}

foo(2);
```

Firstly, `foo(..)` is an RHS reference to `foo`, meaning, "go look-up the value of `foo`, and give it to me." Moreover, `(..)` means I want to execute it, so it'd better actually be a function!

There's a subtle but important assignment here. Did you spot it?

You may have missed the implied `a = 2` in this code snippet. It happens when the value `2` is passed as an argument to the `foo(..)` function, in which case that value is **assigned** to the parameter `a`. The `LHS` reference look-up here is the parameter `a`.

There's another RHS reference, for the value of `a`, and that value is passed to `console.log(..)`. But then, `console.log(..)` needs a reference. It's an RHS, first for the `console` object, then a property-resolution occurs to see if it has a method called `log`.

Finally, we can conceptualize that there's an LHS/RHS exchange of passing the value `2` (by way of variable `a`'s RHS look-up) into `log(..)`. Inside of the native implementation of `log(..)`, we can assume it has parameters, the first of which (perhaps called `arg1`) is has an LHS reference look-up, before assigning `2` to it.

### Conversation?

So, what's this whole deal about the conversation?

Let's imagine the above exchange as a conversation. To process that above code snippet, the conversation would go a little something like this:

> ***Engine***: Hey *Scope*, I have an RHS reference for `foo`. Ever heard of him?

> ***Scope***: Why yes, I have. *Compiler* declared him just a second ago. He's a function. Here you go.

> ***Engine***: Great, thanks! OK, I'm executing `foo`.

> ***Engine***: Hey, *Scope*, I've got an LHS reference for `a`, ever heard of him?

> ***Scope***: Why yes, I have. *Compiler* declared him as a formal parameter to `foo` just recently. Here you go.

> ***Engine***: Helpful as always, *Scope*. Thanks again. Now, time to assign `2` to `a`.

> ***Engine***: Hey, *Scope*, sorry to bother you again. I need an RHS look-up for `console`. Ever heard of him?

> ***Scope***: No problem, *Engine*, this is what I do all day. Yes, I've got `console`. He's built-in. Here ya go.

> ***Engine***: Perfect. Looking up `log(..)`. OK, great, it's a function.

> ***Engine***: Yo, *Scope*. Can you help me out with an RHS reference to `a`. I think I remember him, but just want to double-check.

> ***Scope***: You're right, *Engine*. Same guy, hasn't changed. Here ya go.

> ***Engine***: Cool. Passing the value of `a`, which is `2`, into `log(..)`.

> ***Engine***: I need to LHS reference `arg1`. You dig?

> ***Scope***: As always, here you go.

> ...

## Quiz
Check your understanding so far. Make sure to play the part of *Engine* and have a "conversation" with the *Scope*:

```js
function foo(a) {
	var b = a;
	return a + b;
}

var c = foo(2);
```

1. Identify all the LHS look-ups (there are 3!).

2. Identify all the RHS look-ups (there are 4!).

## Nested Scope

We said that *Scope* is a set of rules for looking up variables by their identifier name. Sometimes, you will look up a variable, and it won't exist in the most immediate *Scope* you are currently executing in.

But, never fear. *Nested Scope* is *Scope*'s friendly cousin, and he rescues us.

Consider:

```js
function foo(a) {
	console.log(a + b);
}

var b = 2;

foo(2); // 4
```

The RHS reference for `b` cannot be resolved inside the function `foo`, but it can be resolved in the *Scope* surrounding it (in this case, the global, but could just be another *Nested Scope* cousin!).

So, the conversation between *Engine* and *Scope* is:

> ***Engine***: "Hey, *Scope* of `foo`, ever heard of `b`? Got an RHS reference for him."

> ***Scope***: "Nope, never heard of him. Go fish."

> ***Engine***: "Hey, *Scope* outside of `foo`, oh you're the global *Scope*, ok cool. Ever heard of `b`? Got an RHS reference for him."

> ***Scope***: "Yep, sure have. Here ya go."

*Nested Scope*'s rules simply are that you start at the inner-most *Scope* you are currently executing, look for a variable there, then if you don't find it, keep going up one level, and looking there, and on up. Once you get to the global *Scope*, nowhere else to go, either you find it, or stop.

### Building on Metaphors

To visualize the process of *Nested Scope* resolution, I want you to think of this tall building.

<img src="fig1.png">

The building represents our program's *Nested Scope* rule set. The first floor of the building represents your currently executing *Scope*, wherever you are. The top level of the building is the global *Scope*.

You resolve LHS and RHS references by looking on your current floor, and if you don't find it, taking the elevator to the next floor, looking there, then the next, and so on. Once you get to the top floor, you either find what you're looking for, or you don't. But you have to stop regardless.

## Errors

Why does it matter whether we call it LHS or RHS?

Because these two types of look-ups behave differently in the circumstance where the variable has not yet been declared.

Consider:

```js
function foo(a) {
	console.log(a + b);
	b = a;
}

foo(2);
```

When the RHS look-up occurs for `b` the first time, it will not be found. This is said to be an "undeclared" variable, because it is not found in the scope.

If an RHS look-up fails to ever find a variable, anyhwere in the *Nested Scope*, this results in a `ReferenceError` being thrown by the *Engine*. It's important to note that the error is of the type `ReferenceError`, as distinct from another error type we'll talk about in a moment.

By contrast, if you are performing an LHS look-up, and you arrive at the top floor (global *Scope*) without finding it, if you are not running your program in "Strict Mode" [^note-strictmode], then the global *Scope* will create a new variable of that name **in the global scope**, and hand it back to you. "No, there wasn't one before, but I was helpful and created one for you."

"Strict Mode" [^note-strictmode], which was added as a feature in ES5, has a number of different behaviors from normal/relaxed/lazy mode. One such behavior is that it disallows the automatic/implicit global variable creation. In that case, there would be no global *Scope*'d variable to hand back from an LHS look-up, and you'd get a `ReferenceError` similarly to the RHS case.

Now, if a variable is found for an RHS look-up, but you try to do something with its value that is impossible, such as trying to execute-as-function a non-function value, or reference a property on a `null` or `undefined` value, then you get a different kind of error, called a `TypeError`.

`ReferenceError` is *Scope* resolution-failure related, whereas `TypeError` implies that *Scope* resolution was successful, but that there was an illegal/impossible action attempted against the result.

## Review (TL;DR)

So, what is scope?

Scope is the set of rules that determines where and how a variable (identifier) can be looked-up. This look-up may be for the purposes of assigning to the variable, which is an LHS (left-hand-side) reference, or it may be for the purposes of retrieving its value, which is an RHS (right-hand-side) reference.

LHS references result from assignment operations. *Scope*-related assignments can occur either with the `=` operator or by passing arguments to (assign to) function parameters.

The JavaScript *Engine* first compiles code before it executes, and in so doing, it splits up statements like `var a = 2;` into two separate steps:

1. First, `var a` to declare it in that *Scope*. This is performed at the beginning, before code execution.

2. Later, `a = 2` to look up the variable (LHS reference) and assign to it if found.

Both LHS and RHS reference look-ups start at the currently executing *Scope*, and if need be (that is, they don't find what they're looking for there), they work their way up the *Nested Scope*, one scope (floor) at a time, looking for the identifier, until they get to the global (top floor) and stop, and either find it, or don't.

Unfulfilled RHS references result in `ReferenceError`s being thrown. Unfulfilled LHS references result in an automatic, implicitly-created global of that name (if not in "Strict Mode" [^note-strictmode]), or a `ReferenceError` (if in "Strict Mode" [^note-strictmode]).

[^note-strictmode]: MDN: [Strict Mode](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode)
# You Don't Know JS: Scope & Closures
# Chapter 2: Lexical Scope

In Chapter 1, we defined "scope" as the set of rules that govern how the *Engine* can look up a variable by its identifier name and find it, either in the current *Scope*, or in any of the *Nested Scopes* it's contained within.

There are two predominant models for how scope works. The first of these is by far the most common, used by the large majority of programming languages. It's called Lexical Scope, and we will examine it in-depth. The other model, which is still used by some languages (such as Bash scripting, some modes in Perl, etc) is called Dynamic Scope.

Dynamic Scope is covered in Appendix A. I mention it here only to provide a contrast with Lexical Scope, which is the scope model that JavaScript employs.

## Lex-time

As we discussed in Chapter 1, the first traditional phase of a standard language compiler is called lexing (aka, tokenizing). If you recall, the lexing process examines a string of source code characters and assigns semantic meaning to the tokens as a result of some stateful parsing.

It is this concept which provides the foundation to understand what lexical scope is and where the name comes from.

To define it somewhat circularly, lexical scope is scope that is defined at lexing time. In other words, lexical scope is based on where variables and blocks of scope are authored, by you, at write time, and thus is relatively set in stone by the time the lexer processes your code.

**Note:** We will see in a little bit there are some ways to cheat lexical scope, thereby modifying it after the lexer has passed by, but these are frowned upon. It is considered best practice to treat lexical scope as, in fact, lexical-only, and thus entirely author-time in nature.

Let's consider this block of code:

```js
function foo(a) {

	function bar(c) {
		console.log(a, b, c);
	}

	var b = a * 2;

	bar(b * 3);
}

foo(2); // 2, 4, 12
```

There are three nested scopes inherent in this code example. It may be helpful to think about these scopes as bubbles inside of each other.

<img src="fig2.png">

**Bubble 1** encompasses the global scope, and has just one identifier in it: `foo`.

**Bubble 2** encompasses the scope of `foo`, which includes the two identifiers: `bar` and `b`.

**Bubble 3** encompasses the scope of `bar`, and it includes just one identifier: `c`.

Scope bubbles are defined by where the blocks of scope are written, which one is nested inside the other, etc. In the next chapter, we'll discuss different units of scope, but for now, let's just assume that each function creates a new bubble of scope.

The bubble for `bar` is entirely contained within the bubble for `foo`, because (and only because) that's where we chose to define the function `bar`.

Notice that these nested bubbles are strictly nested. We're not talking about Venn diagrams where the bubbles can cross boundaries. In other words, no bubble for some function can simultaneously exist (partially) inside two other outer scope bubbles, just as no function can partially be inside each of two parent functions.

<img src="fig2.png">

### Look-ups

The structure and relative placement of these scope bubbles fully explains to the *Engine* all the places it needs to look to find an identifier.

In the above code snippet, the *Engine* executes the `console.log(..)` statement and goes looking for the three referenced variables `a`, `b`, and `c`. It first starts with the innermost scope bubble, the scope of the `bar(..)` function. It won't find `a` there, so it goes up one level, out to the next nearest scope bubble, the scope of `foo(..)`. It finds `a` there, and so it uses that `a`. Same thing for `b`. But `c`, it does find inside of `bar(..)`.

Had there been a `c` both inside of `bar(..)` and inside of `foo(..)`, the `console.log(..)` statement would have found and used the one in `bar(..)`, never getting to the one in `foo(..)`.

**Scope look-up stops once it finds the first match**. The same identifier name can be specified at multiple layers of nested scope, which is called "shadowing" (the inner identifer "shadows" the outer identifier). Regardless of shadowing, scope look-up always starts at the innermost scope being executed at the time, and works its way outward/upward until the first match, and stops.

**Note:** Global variables automatically become properties of the global object (`window` in browsers, etc), so it *is* possible to reference a global variable not directly by its lexical name, but instead indirectly as a property reference of the global object.

```js
window.a
```

This technique gives access to a global variable which would otherwise be inaccessible due to it being shadowed. However, non-global shadowed variables cannot be accessed.

No matter *where* a function is invoked from, or even *how* it is invoked, its lexical scope is **only** defined by where the function was declared.

The lexical scope look-up process *only* applies to first-class identifiers, such as the `a`, `b`, and `c`. If you had a reference to `foo.bar.baz` in a piece of code, the lexical scope look-up would apply to finding the `foo` identifier, but once it locates that variable, object property-access rules take over to resolve the `bar` and `baz` properties, respectively.

## Cheating Lexical

If lexical scope is defined only by where a function is declared, which is entirely an author-time decision, how could there possibly be a way to "modify" (aka, cheat) lexical scope at run-time?

JavaScript has two such mechanisms. Both of them are equally frowned-upon in the wider community as bad practices to use in your code. But the typical arguments against them are often missing the most important point: **cheating lexical scope leads to poorer performance.**

Before I explain the performance issue, though, let's look at how these two mechanisms work.

### `eval`

The `eval(..)` function in JavaScript takes a string as an argument, and treats the contents of the string as if it had actually been authored code at that point in the program. In other words, you can programatically generate code inside of your authored code, and run the generated code as if it had been there at author time.

Evaluating `eval(..)` (pun intended) in that light, it should be clear how `eval(..)` allows you to modify the lexical scope environment by cheating and pretending that author-time (aka, lexical) code was there all along.

On subsequent lines of code after an `eval(..)` has executed, the *Engine* will not "know" or "care" that the previous code in question was dynamically interpreted and thus modified the lexical scope environment. The *Engine* will simply perform its lexical scope look-ups as it always does.

Consider the following code:

```js
function foo(str, a) {
	eval(str); // cheating!
	console.log(a, b);
}

var b = 2;

foo("var b = 3;", 1); // 1, 3
```

The string `"var b = 3;"` is treated, at the point of the `eval(..)` call, as code that was there all along. Because that code happens to declare a new variable `b`, it modifies the existing lexical scope of `foo(..)`. In fact, as mentioned above, this code actually creates variable `b` inside of `foo(..)` that shadows the `b` that was declared in the outer (global) scope.

When the `console.log(..)` call occurs, it finds both `a` and `b` in the scope of `foo(..)`, and never finds the outer `b`. Thus, we print out "1, 3" instead of "1, 2" as would have normally been the case.

**Note:** In this example, for simplicity sake, the string of "code" we pass in was a fixed literal. But it could easily have been programatically created by adding characters together based on your program's logic. `eval(..)` is usually used to execute dynamically created code, as dynamically evaluating essentially static code from a string would provide no real benefit to just authoring the code directly.

By default, if a string of code that `eval(..)` executes contains one or more declarations (either variables or functions), this action modifies the existing lexical scope in which the `eval(..)` resides. Technically, `eval(..)` can be invoked "indirectly", through various tricks (beyond our discussion here), which causes it to instead execute in the context of the global scope, thus modifying it. But in either case, `eval(..)` can at runtime modify an author-time lexical scope.

### `with`

The other frowned-upon feature in JavaScript which cheats lexical scope is the `with` keyword. There are multiple valid ways that `with` can be explained, but I will choose here to explain it from the perspective of how it interacts with and affects lexical scope.

`with` is typically explained as a short-hand for making multiple property references against an object *without* repeating the object reference itself each time.

For example:

```js
var obj = {
	a: 1,
	b: 2,
	c: 3
};

// more "tedious" to repeat "obj"
obj.a = 2;
obj.b = 3;
obj.c = 4;

// "easier" short-hand
with (obj) {
	a = 3;
	b = 4;
	c = 5;
}
```

However, there's much more going on here than just a convenient short-hand for object property access. Consider:

```js
function foo(obj) {
	with (obj) {
		a = 2;
	}
}

var o1 = {
	a: 3
};

var o2 = {
	b: 3
};

foo(o1);
console.log(o1.a); // 2

foo(o2);
console.log(o2.a); // undefined
console.log(a); // 2
```

In this code example, two objects `o1` and `o2` are created. One has an `a` property, and the other does not. The `foo(..)` function takes an object reference `obj` as an argument, and calls `with (obj) { .. }` on the reference. Inside the `with` block, we make what appears to be a normal lexical reference to a variable `a`, an LHS reference in fact (see Chapter 1), to assign to it the value of `2`.

When we pass in `o1`, the `a = 2` assignment finds the property `o1.a` and assigns it the value `2`, as reflected in the subsequent `console.log(o1.a)` statement. However, when we pass in `o2`, since it does not have an `a` property, no such property is created, and `o2.a` remains `undefined`.

But then we note a peculiar side-effect, the fact that a global variable `a` was created by the `a = 2` assignment. How can this be?

The `with` statement takes an object, one which has zero or more properties, and **treats that object as if *it* is a wholly separate lexical scope**, and thus the object's properties are treated as lexically defined identifiers in that "scope".

The `eval(..)` function can modify existing lexical scope if it takes a string of code with one or more declarations in it. But the `with` statement actually creates a whole new lexical scope out of thin air, from the object you pass to it.

Understood in this way, the "scope" declared by the `with` statement when we passed in `o1` was `o1`, and that "scope" had an "identifier" in it which corresponds to the `o1.a` property. But when we used `o2` as the "scope", it had no such `a` "identifier" in it, and so the normal rules of LHS identifier look-up (see Chapter 1) occurred.

Neither the "scope" of `o2`, nor the scope of `foo(..)`, nor the global scope even, had an `a` identifier to be found, so when `a = 2` was executed, it resulted in the automatic-global being created.

It is a strange sort of mind-bending thought to see `with` turning, at runtime, an object and its properties into a "scope" *with* "identifiers". But that is the clearest explanation I can give for the results we see.

**Note:** In addition to being a bad idea to use, both `eval(..)` and `with` are affected (restricted) by Strict Mode. `with` is outright disallowed, whereas various forms of indirect or unsafe `eval(..)` are disallowed while retaining the core functionality. Don't use them.

### Performance

Both `eval(..)` and `with` cheat the otherwise author-time defined lexical scope by modifying or creating new lexical scope at runtime.

So, what's the big deal, you ask? If they offer more sophisticated functionality and coding flexibility, aren't these *good* features? **No.**

The JavaScript *Engine* has a number of performance optimizations that it performs during the compilation phase. Some of these boil down to being able to essentially statically analyze the code as it lexes, and pre-determine where all the variable and function declarations are, so that it takes less effort to resolve identifiers during execution.

But if the *Engine* finds an `eval(..)` or `with` in the code, it essentially has to *assume* that all its awareness of identifier location may be invalid, because it cannot know at lexing time exactly what code you may pass to `eval(..)` to modify the lexical scope, or what object you may pass to `with` to create a new lexical scope to be consulted.

In other words, in the pessimistic sense, most of those optimizations it *would* make are pointless if `eval(..)` or `with` are present, so it simply doesn't perform the optimizations *at all*. Put simply: your code will almost certainly tend to run slower simply by the fact that you include an `eval(..)` or `with` anywhere in the code. No matter how smart the *Engine* may be about trying to limit the side-effects of these pessmistic assumptions, **there's no getting around the fact that without the optimizations, code runs slower.**

## Review (TL;DR)

Lexical scope means that scope is defined by author-time decisions of where functions are declared. The lexing phase of compilation is essentially able to know where and how all identifiers are declared, and thus predict how they will be looked-up during execution.

Two mechanisms in JavaScript can "cheat" lexical scope: `eval(..)` and `with`. The former can modify existing lexical scope (at runtime) by evaluating a string of "code" which has one or more declarations in it. The latter essentially creates a whole new lexical scope (again, at runtime) by treating an object reference *as* a "scope" and that object's properties as scoped identifiers.

The downside to these mechanisms is that it defeats the *Engine*'s ability to perform compile-time optimizations regarding scope look-up, because the *Engine* has to assume pessimistically that such optimizations will be invalid. Code *will* run slower as a result of using either feature.
# You Don't Know JS: Scope & Closures
# Chapter 3: Function vs. Block Scope

As we explored in Chapter 2, scope consists of a series of "bubbles" that each act as a container or bucket, in which identifiers (variables, functions) are declared. These bubbles nest neatly inside each other, and this nesting is defined at author-time.

But what exactly makes a new bubble? Is it only the function? Can other structures in JavaScript create bubbles of scope?

## Function Scope

The most common answer to those questions is that JavaScript *only* has function-based scope. That is, each function you declare creates a bubble for itself, but no other structures create their own scope bubbles. As we'll see in just a little bit, this is not quite true.

But first, let's explore function scope and its implications.

Consider this code:

```js
function foo(a) {
	var b = 2;

	// some code

	function bar() {
		// ...
	}

	// more code

	var c = 3;
}
```

In this snippet, the scope bubble for `foo(..)` includes identifiers `a`, `b`, `c` and `bar`. It doesn't matter *where* in the scope a declaration appears, the variable or function belongs to the containing scope bubble, regardless. We'll explore how exactly *that* works in the next chapter.

`bar(..)` has its own scope bubble. So does the global scope, which has just one identifier attached to it: `foo`.

Because `a`, `b`, `c`, and `bar` all belong to the scope bubble of `foo(..)`, they are not accessible outside of `foo(..)`. That is, the following code would all result in `ReferenceError` errors, as the identifiers are not available to the global scope:

```js
bar(); // fails

console.log(a, b, c); // all 3 fail
```

However, all these identifiers (`a`, `b`, `c`, `foo`, and `bar`) are accessible *inside* of `foo(..)`, and indeed also available inside of `bar(..)` (assuming there are no shadow identifier declarations inside `bar(..)`).

Function scope also encourages the idea that all variables belong to the function, and can be used and re-used throughout the entirety of the function (and indeed, accessible even to nested scopes). This design approach can be quite useful, and certainly can make full use of the "dynamic" nature of variables to take on values of different types.

On the other hand, if you don't take careful precautions, variables existing across the entirety of a scope can lead to all sorts of unexpected pitfalls.

## Hiding In Plain Scope

The traditional way of thinking about functions is that you declare a function, and then add code inside it. But the inverse thinking is equally powerful and useful: take any arbitrary section of code you've written, and wrap a function declaration around it.

The practical effect of this approach is to create a scope bubble around the code in question, which means that any declarations (variable or function) in that code will now be tied to the scope of the new wrapping function, rather than the previously enclosing scope. In other words, you can "hide" variables and functions by enclosing them in the scope of a function.

Why would "hiding" variables and functions be a useful technique?

There's a variety of reasons motivating this scope-based hiding. They tend to spring from the software design principle "Principle of Least Privilege" [^note-leastprivilege], also sometimes called "Least Authority" or "Least Exposure". This principle states that in the design of software, such as the API for a module/object, you should expose only what is minimally necessary, and "hide" everything else.

This principle extends to the choice of which scope to contain variables and functions. If all variables and functions were in the global scope, they would of course be accessible to any nested scope. But this would violate the "Least..." principle in that you are (likely) exposing many variables or functions which you should otherwise be kept private, as proper use of the code would discourage access to those variables/functions.

For example:

```js
function doSomething(a) {
	b = a + doSomethingElse(a * 2);

	return b * 3;
}

function doSomethingElse(a) {
	return a - 1;
}

var b;

doSomething(2); // 15
```

In this snippet, the `b` variable and the `doSomethingElse(..)` function, are likely "private" details of how `doSomething(..)` does its job. Giving the enclosing scope "access" to `b` and `doSomethingEles(..)` is not only unnecessary but also possibly "dangerous", in that they may be used in unexpected ways, intentionally or not, and this may violate pre-condition assumptions of `doSomething(..)`.

A more "proper" design would hide these private details inside the scope of `doSomething(..)`, such as:

```js
function doSomething(a) {
	function doSomethingElse(a) {
		return a - 1;
	}

	var b;

	b = a + doSomethingElse(a * 2);

	return b * 3;
}

doSomething(2); // 15
```

Now, `b` and `doSomethingElse(..)` are not accessible to any outside influence, instead controlled only by `doSomething(..)`. The functionality and end-result has not been affected, but the design keeps private details private, which is usually considered better software.

### Collision Avoidance

Another benefit of "hiding" variables and functions inside a scope is to avoid unintended collision between two different identifiers with the same name but different intended usages. Collision results often in unexpected overwriting of values.

For example:

```js
function foo() {
	function bar(a) {
		i = 3;
		console.log(a + i);
	}

	for (var i=0; i<10; i++) {
		bar(i * 2); // oops, inifinite loop ahead!
	}
}

foo();
```

The `i = 3` assignment inside of `bar(..)` overwrites, unexpectedly, the `var i` that was declared in `foo(..)` at the for-loop. In this case, it will result in an infinite loop, because `i` is set to a fixed value of `3` and that will forever remain `< 10`.

The assignment inside `bar(..)` needs to declare a local variable to use, regardless of what identifier name is chosen. `var i = 3;` would fix the problem (and would create the previously mentioned "shadowed variable" declaration for `i`). An *additional*, not alternate, option is to pick another identifier name entirely, such as `var j = 3;`. But your software design may naturally call for the same identifier name, so utilizing scope to "hide" your inner declaration is your best/only option.

A particularly strong example of (likely) variable collision occurs in the global scope. Multiple libraries loaded into your program can quite easily collide with each other if they don't properly hide their internal/private functions and variables.

Such libraries typically will create a single variable declaration, often an object, with a sufficiently unique name, in the global scope. This object is then used as a "namespace" for that library, where all specific exposures of functionality are done as properties off that namespace, rather than as top-level lexically scoped identifiers.

For example:

```js
var MyReallyCoolLibrary = {
	awesome: "stuff",
	doSomething: function() {
		// ...
	},
	doAnotherThing: function() {
		// ...
	}
}
```

#### Module Management

Another option for collision avoidance is the more modern "module" approach, using any of various dependency managers. Using these tools, no libraries ever add any identifiers to the global scope, but are instead required to have their identifier(s) be explicitly imported into another specific scope through usage of the dependency manager's various mechanisms.

It should be observed that these tools do not possess "magic" functionality that is exempt from lexical scoping rules. They simply use the rules of scoping as explained here to enforce that no identifiers are injected into any shared scope, and are instead kept in private, non-collision-susceptible scopes, which prevents any accidental scope collisions.

As such, you can code defensively and achieve the same results as the dependency managers do without actually needing to use them, if you so choose. See the later chapter on Closure for more information about the module pattern.

## IIFE

We've seen that we can take any snippet of code and wrap a function around it, and that effectively "hides" any enclosed variable or function declarations from the current scope inside that function's inner scope.

For example:

```js
var a = 2;

function foo() { // <-- insert this

	var a = 3;
	console.log(a); // 3

} // <-- and this
foo(); // <-- and this

console.log(a); // 2
```

While this technique "works", it is not necessarily very ideal. There are a few problems it introduces. The first is that we have to declare a named-function `foo()`, which means that the identifier name `foo` itself "pollutes" the enclosing scope (global, in this case). We also have to explicitly call the function by name (`foo()`) so that the wrapped code actually executes.

It would be more ideal if the function didn't need a name (or, rather, the name didn't pollute the enclosing scope), and if the function could automatically be executed.

Fortunately, JavaScript offers us just such a solution to both problems.

```js
var a = 2;

(function foo(){ // <-- insert this

	var a = 3;
	console.log(a); // 3

})(); // <-- and this

console.log(a); // 2
```

Let's break down what's happening here.

First, notice that the wrapping function statement starts with `(function...` as opposed to just `function`. While this may seem like a minor detail, it's actually a major change. Instead of treating the function as a standard declaration, the function is treated as a function-expression.

The easiest way to distinguish is if the word "function" is the very first thing in a statement (not just a line, but a statement), then it's a declaration. Otherwise, it's an expression. You are probably most familiar with function expressions as they are used in callback parameters, such as when you do:

```js
setTimeout(function(){
	console.log("I waited 1 second!");
},1000);
```

We see what is called an "anonymous function expression", because `function()...` has no name identifier on it. Anonymous functions can be expressions, but you cannot have an anonymous function declaration -- that's illegal JS grammar.

**Note:** Anonymous function expressions are easy to type, and many libraries and tools tend to encourage this style of code. However, they are less desirable in that they create harder to debug code. Also, naming your function expressions removes any need to ever use the deprecated `arguments.callee` to refer to the current function from within itself, for instance to re-invoke a function for recursion, etc.

Notice back in the previous snippet that we kept the name `foo` on our function expression. This is, not surprisingly, called a "named function expression". Named function expressions are, generally, a more preferred form of function expressions. Other than typing fatigue, there's pratically no benefit to the anonymous function expression form.

But importantly, we now see the first major difference in our wrapping-function technique: the name `foo` when used in a declaration is, obviously, bound (scoped) as an identifier in the enclosing scope (so that we can call it like `foo()`), but the name `foo` when used in a function expression is scoped only to the function itself, and *not* to the enclosing scope.

In other words, `(function foo(){ .. })` as an expression means the identifier `foo` is found *only* in the scope where the `..` indicates, not in the containing scope.

Now that we have a function as an expression by virtue of wrapping it in a `( )` pair, we can execute that function by adding another `()` on the end, like `(function foo(){ .. })()`. The first enclosing `( )` pair makes the function an expression, and the second `()` executes the function.

This pattern is so common, a few years ago the community agreed on a term for it: IIFE, which stands for **I**mmediately **I**nvoked **F**unction **E**xpression.

Of course, IIFE's don't need names, necessarily, so we could have used `(function(){ .. })()`, which is the traditional IIFE form. On the other hand, anonymous function expressions are less desirable because they are harder to understand in a debug stack trace, so giving your IIFE a name is perhaps a good idea.

```js
var a = 2;

(function IIFE(){

	var a = 3;
	console.log(a); // 3

})();

console.log(a); // 2
```

There's a slight variation on the traditional IIFE form (`(function(){ .. })()`), which some prefer: `(function(){ .. }())`. Look closely to see the difference. In the first form, the function expression is wrapped in `( )`, and then the invoking `()` pair is on the outside. In the second form, the invoking `()` pair is moved to the inside of the `( )` wrapping pair.

These two forms are identical in functionality. It's purely a stylistic choice which you prefer.

Another variation on IIFE's which is quite common is to use the fact that they are, in fact, just function calls, and pass in parameter(s), even renaming them.

For instance:

```js
var a = 2;

(function IIFE( global ){

	var a = 3;
	console.log(a); // 3
	console.log(global.a); // 2

})( window );

console.log(a); // 2
```

We pass in the `window` object reference, but we name the parameter `global`, so that we have a clear stylistic delineation for global vs. non-global references. Of course, you can pass in anything from an enclosing scope you want, and you can name the parameter(s) anything that suits you. This is mostly just stylistic choice.

Still another variation of the IIFE inverts the order of things, where the function to execute is given second, after the invocation and parameters to pass to it. This pattern is used in the UMD (Universal Module Definition) project. Some people find it a little cleaner to understand, though it is slightly more verbose.

```js
var a = 2;

(function IIFE( def ){
	def( window );
})(function def( global ){

	var a = 3;
	console.log(a); // 3
	console.log(global.a); // 2

});

console.log(a); // 2
```

## Block Scope

While functions are the most common unit of scope, and certainly the most wide-spread of the design approaches in the majority of JS in circulation, other units of scope are possible, and the usage of these other scope units can lead to even better, cleaner to maintain code.

Many languages other than JavaScript support Block Scope, and so developers from those languages are accustomed to the mindset, whereas those who've primarily only worked in JavaScript may find the concept slightly foreign.

But even if you've never written a single line of code in block-scoped fashion, you are still probably familiar with this extremely common idiom in JavaScript:

```js
for (var i=0; i<10; i++) {
	console.log(i);
}
```

We declare the variable `i` directly inside the for-loop head, most likely because our *intent* as developers is to use `i` only within the context of that for-loop, and essentially ignore the fact that the variable actually scopes itself to the enclosing scope (function or global).

That's what block-scoping is all about. Declaring variables as close as possible, as local as possible, to where they will be used. Another example:

```js
// some code

if (foo) {
	var bar = foo * 2;
	bar = something(bar);
	console.log(bar);
}

// more code
```

We are using a `bar` variable only in the context of the if-statement, so it makes a kind of sense that we would declare it inside the if-block. However, where we declare variables is not relevant when using `var`, because they will always belong to the enclosing scope. This snippet is essentially "fake" block-scoping, for stylistic reasons, and relying on self-enforcement not to accidentally use `bar` in another place in that scope.

Block scope is a tool to extend the earlier "Principle of Least ~~Privilege~~ Exposure" [^note-leastprivilege] from hiding information in functions to hiding information in blocks of our code. Why pollute the entire scope of a function with the `i` variable that is only going to be (or only *should be*, at least) used for the for-loop?

But, the sad reality is that, on the surface, JavaScript has no facility for block scope.

That is, until you dig a little further.

### `with`

We learned about `with` in Chapter 2. While it is a frowned upon construct, it *is* an example of (a form of) block scope, in that the scope that is created from the object only exists for that `with` statement, and not anywhere else in the enclosing scope.

### `try/catch`

It is a very little known fact that JavaScript specified the variable declaration in the `catch` clause of a `try/catch` to be block-scoped to the `catch` block.

For instance:

```js
try {
	undefined(); // illegal operation!
}
catch (err) {
	console.log(err); // works!
}

console.log(err); // ReferenceError: `err` not found
```

As you can see, `err` exists only in the `catch` clause, and throws an error when you try to reference it elsewhere.

**Note:** While this behavior has been specified and true of practically all standard JS environments (except perhaps old-n-busted IE), many linters seem to still complain if you have two or more `catch` clauses in the same scope which each declare their error variable with the same identifier name. This is not actually a re-definition, since the variables are safely block-scoped, but the linters still seem to, annoyingly, complain about this fact.

The block-scoping nature of `catch` may seem like a useless academic fact, but see Appendix B for more information on just how useful it might be.

### `let`

Thus far, we've seen that JavaScript only has some strange niche behaviors which expose block scope functionality. If that were all we had, and *it was* for many, many years, then block scoping would never be useful to the JavaScript developer.

Fortunately, ES6 changes that, and introduces a new keyword, `let`, which sits alongside `var` as another way to declare a variable.

The `let` keyword attaches the variable declaration to the scope of whatever block (commonly a `{ .. }` pair) it's contained in. In other words, `let` hijacks any block's scope for its variable declaration.

```js
// some code

if (foo) {
	let bar = foo * 2;
	bar = something(bar);
	console.log(bar);
}

console.log(bar); // ReferenceError

// more code
```

A particular case where `let` shines is in the for-loop case as we discussed previously.

```js
for (let i=0; i<10; i++) {
	console.log(i);
}

console.log(i); // ReferenceError
```

Not only does `let` in the for-loop head bind the `i` to the for-loop body, but in fact, it re-binds it to each *iteration* of the loop, making sure to re-assign it the value that it had at the end of the previous loop iteration.

Here's another way of illustrating more clearly the per-iteration binding behavior that occurs:

```js
{
	let j;
	for (j=0; j<10; j++) {
		let i = j; // re-bound for each iteration!
		console.log(i);
	}
}
```

The reason why this per-iteration binding is interesting will become clear in Chapter 5.

**Note:** Because `let` declarations attach to arbitrary blocks rather than to the enclosing function's scope (or global), there can be gotchas where existing code has a hidden reliance on function-scoped `var`, and replacing the `var` with `let` may require additional care when refactoring code.

Consider:

```js
if (foo) {
	var bar = 3;

	if (baz > bar) {
		console.log(baz);
	}

	// ...
}
```

This code is fairly easily re-factored as:

```js
if (foo) {
	var bar = 3;

	// ...
}

if (baz > bar) {
	console.log(baz);
}
```

But, be careful of such changes when using block-scoped variables:

```js
if (foo) {
	let bar = 3;

	if (baz > bar) { // <-- don't forget `bar`!
		console.log(baz);
	}

	// ...
}
```

See Appendix B for an alternate style of block-scoping which may provide easier to maintain/refactor code in these scenarios.

### `const`

In addition to `let`, ES6 also introduces `const`, which creates a block-scoped variable whose value is fixed. Any attempt to change that value at a later time results in an error.

```js
if (foo) {
	var a = 2;
	const b = 3;

	a = 3; // just fine!
	b = 4; // error!
}

console.log(a); // 3
console.log(b); // ReferenceError!
```

## Review (TL;DR)

Functions are the most common unit of scope in JavaScript. Variables and functions that are declared inside another function are essentially "hidden" from any of the enclosing "scopes", which is an intentional design principle of good software.

But functions are by no means the only unit of scope. Block-scope refers to the idea that variables and functions can belong to an arbitrary block (generally, any `{ .. }` pair) of code, rather than only to the enclosing function.

Starting with ES3, the `try/catch` structure has block-scope in the `catch` clause. Also, though frowned-upon for its negative performance (and other) side-effects, the `with` block is also a form of block-scoping.

In ES6, the `let` keyword (a cousin to the `var` keyword) is introduced to allow declarations of variables in any arbitrary block of code. `if (..) { let a = 2; }` will declare a variable `a` that essentially hijacks the scope of the `if`'s `{ .. }` block and attaches itself there, instead of to the enclosing scope (function or global).

Though some seem to believe such, block scope should not be taken as an outright replacement of function scope. Both functionalities co-exist, and developers can and should use both function-scope and block-scope techniques to produce better, more readable/maintainable code.

[^note-leastprivilege]: [Principle of Least Privilege](http://en.wikipedia.org/wiki/Principle_of_least_privilege)
# You Don't Know JS: Scope & Closures
# Chapter 4: Hoisting

By now in this book, you should be fairly comfortable with the idea of scope, and how variables are attached to different levels of scope depending on where and how they are declared. Both function scope and block scope behave by the same rules in this regard: any variable declared within a scope is attached to that scope.

But there's a subtle detail of how scope attachment works with declarations that appear in various locations within a scope, and that detail is what we will examine here.

## Chicken Or The Egg?

There's a temptation to think that all of the code you see in a JavaScript program is interpreted line-by-line, top-down in order, as the program executes. While that is substantially true, there's one part of that assumption which can lead to incorrect thinking about your program.

Consider this code:

```js
a = 2;

var a;

console.log(a);
```

What do you expect to be printed in the `console.log(..)` statement?

Many developers would expect `undefined`, since the `var a` statement comes after the `a = 2`, and it would seem natural to assume that the variable is re-defined, and thus assigned the default `undefined`. However, the output will be `2`.

Consider another piece of code:

```js
console.log(a);

var a = 2;
```

You might be tempted to assume that, since the previous snippet exhibited some less-than-top-down looking behavior, perhaps in this snippet, `2` will also be printed. Others may think that since the `a` variable is used before it is declared, this must result in a `ReferenceError` being thrown.

Unfortunately, both guesses are incorrect. `undefined` is the output.

**So, what's going on here?** It would appear we have a chicken-and-the-egg question. Which comes first, the declaration, or the assignment?

## The Compiler Strikes Again

To answer this question, we need to refer back to Chapter 1, and our discussion of compilers. Recall that the *Engine* actually will compile your JavaScript code before it interprets it. Part of the compilation phase was to find and associate all declarations with their appropriate scopes. Chapter 2 showed us that this is the heart of Lexical Scope.

So, the best way to think about things is that all declarations, both variables and functions, are processed first, before any part of your code is executed.

When you see `var a = 2;`, you probably think of that as one statement. But JavaScript actually thinks of it as two statements: `var a;` and `a = 2;`. The first statement, the declaration, is processed during the compilation phase. The second statement, the assignment, is left **in place** for the execution phase.

Our first snippet then should be thought of as being handled like this:

```js
var a;
```
```js
a = 2;

console.log(a);
```

...where the first part is the compilation and the second part is the execution.

Similarly, our second snippet is actually processed as:

```js
var a;
```
```js
console.log(a);

a = 2;
```

So, one way of thinking, sort of metaphorically, about this process, is that variable and function declarations are "moved" from where they appear in the flow of the code to the top of the code. This gives rise to the name "Hoisting".

In other words, **the egg comes before the chicken**.

**Note:** Only the declarations themselves are hoisted, while any assignments or other executable logic are left *in place*. If hoisting were to re-arrange the executable logic of our code, that could really wreak havoc.

```js
foo();

function foo() {
	console.log(a); // undefined

	var a = 2;
}
```

The function `foo`'s declaration (which in this case *includes* the implied value of it as an actual function) is hoisted, such that the call on the first line is able to execute.

It's also important to note that hoisting is **per-scope**. So while our previous snippets were simplified in that they only included global scope, the `foo(..)` function we now are examining itself exhibits that `var a` is hoisted to the top of `foo(..)` (not, obviously, to the top of the program). So the program can perhaps be more accurately interpreted like this:

```js
function foo() {
	var a;
}
```
```js
function foo() {
	console.log(a); // undefined

	a = 2;
}

foo();
```

Function declarations are hoisted, as we just saw. But function expressions are not.

```js
foo(); // not ReferenceError, but TypeError!

var foo = function bar() {
	// ...
};
```

The variable identifier `foo` is hoisted and attached to the enclosing scope (global) of this program, so `foo()` doesn't fail as a `ReferenceError`. But `foo` has no value yet (as it would if it had been a true function declaration instead of expression). So, `foo()` is attempting to invoke the `undefined` value, which is a `TypeError` illegal operation.

Also recall that even though it's a named function expression, the name identifier is not available in the enclosing scope:

```js
foo(); // TypeError
bar(); // ReferenceError

var foo = function bar() {
	// ...
};
```

This snippet is more accurately interpreted (with hoisting) as:

```js
var foo;

foo(); // TypeError
bar(); // ReferenceError

foo = function() {
	var bar = ...self...
	// ...
}
```

## Review (TL;DR)

We can be tempted to look at `var a = 2;` as one statement, but the JavaScript *Engine* does not see it that way. It sees `var a` and `a = 2` as two separate statements, the first one a compiler-phase task, and the second one an execution-phase task.

What this leads to is that all declarations in a scope, regardless of where they appear, are processed *first* before the code itself is executed. You can visualize this as declarations (variables and functions) being "moved" to the top of their respective scopes, which we call "hoisting".

Declarations themselves are hoisted, but assignments, even assignments of function expressions, are *not* hoisted.
# You Don't Know JS: Scope & Closures
# Chapter 5: Scope Closure

We arrive at this point of the book with hopefully a very healthy, solid understanding of how scope works. In fact, we should see that scope was always something we almost intuitively understood, even without the formality and rigor of understanding we have now explored.

We turn our attention to an incredibly important, but persistently elusive, *almost mythological*, part of the language: closure. If you have followed our discussion of lexical scope thus far, the payoff is that closure is going to be, largely, anti-climatic, almost self-obvious. *There's a man behind the wizard's curtain, and we're about to see him*. No, his name is not Crockford!

If however you have nagging questions about lexical scope, now would be a good time to go back and review Chapter 2 before proceeding.

## Enlightenment

For those who are somewhat experienced in JavaScript, but have perhaps never fully grasped the concept of closures, *understanding closure* can seem like a special nirvana that one must strive and sacrifice to attain.

I recall years back when I had a firm grasp on JavaScript, but had no idea what closure was. The hint that there was *this other side* to the language, one which promised even more capability than I already possessed, teased and taunted me. I remember reading through the source code of early frameworks trying to understand how it actually worked. I remember the first time something of the "module pattern" began to emerge in my mind. I remember the a-ha! moments quite vividly.

What I didn't know back then, what took me years to understand, and what I hope to impart to you presently, is this secret: **closure is all around you in JavaScript, you just have to recognize and embrace it.** Closures are not a special opt-in tool that you must learn new syntax and patterns for. No, closures are not even a weapon that you must learn to wield and master as Luke trained in The Force.

Closures happen as a result of writing code that relies on lexical scope. They just happen. You do not even really have to intentionally create closures to take advantage of them. Closures are created and used for you all over your code. What you are *missing* is the proper mental context to recognize, embrace, and leverage closures for your own will.

The enlightenment moment should be: **oh, closures are already occurring all over my code, I can finally *see* them now.** Understanding closures is like when Neo sees the Matrix for the first time.

## Nitty Gritty

OK, enough hyperbole and shameless movie references.

Here's a down-n-dirty definition of what you need to know to understand and recognize closures:

> Closure is when a function is able to remember and access his lexical scope even when that function is executing outside his lexical scope.

Let's jump into some code to illustrate that definition.

```js
function foo() {
	var a = 2;

	function bar() {
		console.log(a); // 2
	}

	bar();
}

foo();
```

This code should look familiar from our discussions of Nested Scope. Function `bar()` has *access* to the variable `a` in the outer enclosing scope because of lexical scope look-up rules (in this case, it's an RHS reference look-up).

Is this "closure"?

Well, technically... *perhaps*. But by our what-you-need-to-know definition above... *not exactly*. I think the most accurate way to explain `bar()` referencing `a` is via lexical scope look-up rules, and those rules are *only* (an important!) **part** of what closure is.

From a purely academic perspective, what is said of the above snippet is that the function `bar()` has a *closure* over the scope of `foo()` (and indeed, even over the rest of the scopes it has access to, such as the global scope in our case). Put slightly differently, it's said that `bar()` closes over the scope of `foo()`. Why? Because `bar()` appears nested inside of `foo()`. Plain and simple.

But, closure defined in this way is not directly *observable*, nor do we see closure *exercised* in that snippet. We clearly see lexical scope, but closure remains sort of a mysterious shifting shadow behind the code.

Let us then consider code which brings closure into full light:

```js
function foo() {
	var a = 2;

	function bar() {
		console.log(a);
	}

	return bar;
}

var baz = foo();

baz(); //logs 2, whoa. closure was just observed, man.
```

DJ, break it down.

The function `bar()` has lexical scope access to the inner scope of `foo()`. But then, we take `bar()` and pass it *as* a value. We actually pass the function itself around. In this case, we `return` the variable `bar` itself, which of course has the value of the function in question.

After we execute `foo()`, we assign the value it returned (our inner `bar()` function) to a variable called `baz`, and then we actually invoke `baz()`, which of course is invoking our inner function `bar()`, just by a different identifier reference.

`bar()` is executed, for sure. But in this case, it's executed *outside* of his declared lexical scope.

After `foo()` executed, normally we would expect that the entirety of the inner scope of `foo()` would go away, because we know that the *Engine* employs a *Garbage Collector* that comes along and frees up memory once it's no longer in use. Since it would appear that the contents of `foo()` are no longer in use, it would seem natural that they should be considered *gone*.

But the "magic" of closures does not let this happen. Because the inner function `bar()` has, by virtue of where he was declared, a lexical scope closure over that inner scope of `foo()`, that inner scope is in fact *still* "in use"... **by the function `bar()`**. The scope doesn't go away.

**`bar()` still has a reference to that scope, and that reference is called closure.**

So, a few microseconds later, when the variable `baz` is invoked, being just another reference to the inner function we initially labeled `bar`, this inner function executes, and duly has *access* to his normal lexical scope, so he can access the variable `a` just as we'd see before.

But the inner function is being invoked well outside of his lexical scope. The "magic" that allows him to maintain a reference to access his lexical scope even though he's no longer *acting inside* that scope is... you guessed it: **closure**.

Of course, any of the various ways that functions can be *passed around* as values, and indeed invoked in other locations, are all examples of observing/exercising closure.

```js
function foo() {
	var a = 2;

	function baz() {
		console.log(a); // 2
	}

	bar(baz);
}

function bar(fn) {
	fn(); // look ma, I saw closure!
}
```

We pass the inner function `baz` over to `bar`, and call that inner function `fn` now, and when we execute `fn()`, its closure over the inner scope of `foo()` is observed.

These passings-around of functions can be indirect, too.

```js
var fn;

function foo() {
	var a = 2;

	function baz() {
		console.log(a); // when invoked logs 2
	}

	fn = baz;
}

function bar() {
	fn(); // look ma, I saw closure!
}

foo();

bar(); //logs, 2
```

Whatever facility we use to *transport* an inner function outside of his lexical scope, he will maintain a scope reference to where he was originally declared, and wherever we execute him, that closure will be exercised.

## Now I Can See

The previous code snippets are somewhat academic and artifically constructed to illustrate *using closure*. But I promised you something more than just a cool new toy. I promised that closure was something all around you in your existing code. Let us now *see* that truth.

```js
function wait(message) {

	setTimeout(function(){
		console.log(message);
	},1000);

}

wait("Hello, closure!");
```

We take an inner function (shame on me for making it anonymous -- see Chapter 3!) and pass it to `setTimeout(..)`. But our inner function has a scope closure over `wait(..)`, indeed keeping and using a reference to the variable `message`.

A full thousand milliseconds after we have executed `wait(..)`, and his inner scope should otherwise be long gone, that anonymous function still has closure over that scope. Deep down in the guts of the *Engine*, the built-in utility `setTimeout(..)` has reference to some parameter, probably called `fn` or `func` or something like that. He goes to invoke that function, which is invoking our inner (anonymous) function, and the lexical scope reference is still intact.

**Closure.**

Or, if you're of the jQuery persuasion (or any JS framework, for that matter):

```js
function activateBot(name,selector) {
	$(selector).click(function(){
		console.log("Activating: " + name);
	});
}

activateBot("Closure Bot 1", "#bot_1");
activateBot("Closure Bot 2", "#bot_2");
```

I am not sure what kind of code you write, but I regularly write code which is responsible for controlling an entire global drone army of closure bots, so this is totally realistic!

(Some) joking aside, essentially *whenever* and *wherever* you treat functions (which access their own respective lexical scopes) as first-class values and pass them around, you are likely to see those functions exercising closure. Be that timers, event handlers, Ajax requests, cross-window messaging, web workers, or any of the other asynchronous (or synchronous!) tasks, when you pass in a *callback function*, get ready to sling some closure around!

**Note:** Chapter 3 introduced the IIFE pattern. While it is often said that IIFE (alone) is an example of closure, I would somewhat disagree by our definition above.

```js
var a = 2;

(function IIFE(){
	console.log(a);
})();
```

This code "works", but it's not strictly an observation of closure. Why? Because the function (which we labeled "IIFE" here) is not executed outside his lexical scope. He's still invoked right there in the same scope as he was declared. While closure might technically be happening at declaration time, it is *not*, strictly, observable, and so, as they say, *it's a tree falling in the forest with no one around to hear it.*

Though an IIFE is not *itself* an example of closure, because it absolutely creates scope, it's one of the most common tools we use to create scope which can be closed over. So IIFEs are indeed heavily related to closure, even if not closure themselves.

Put this book down right now, dear reader. I have a task for you. Go open up some of your recent JavaScript code. Look for your functions-as-values and identify where you are already using closure and maybe didn't even know it before.

I'll wait.

Now... you see!

## Loops + Closure

The most common canonical example used to illustrate closure involves the humble for-loop.

```js
for (var i=1; i<=5; i++) {
	setTimeout(function(){
		console.log(i);
	},i*1000);
}
```

The spirit of this code snippet is that we would normally *expect* for the behavior to be that the numbers "1", "2", .. "5" would be printed out, one at a time, one per second, respectively.

In fact, if you run this code, you get "6" printed out 5 times, at the one-second intervals.

**Huh?**

Firstly, let's explain where `6` comes from. The terminating condition of the loop is when `i` is *not* `<=5`. The first time that's true is when `i` is 6. So, the output is reflecting the final value of the `i` after the loop terminates.

This actually seems obvious on second glance. The timeout function callbacks are all running well after the completion of the loop. In fact, as timers go, even if it was `setTimeout(.., 0)` on each iteration, all those function callbacks would still run strictly after the completion of the loop, and thus print `6` each time.

But there's a deeper question at play here. What's *missing* from our code to actually have it behave as we semantically have implied?

What's missing is that we are trying to *imply* that each iteration of the loop "captures" its own copy of `i`, at the time of the iteration. But, the way closure works, all 5 of those functions, though they are defined separately in each loop iteration, all **are closed over the same shared global scope**, which has, in fact, only one `i` in it.

Put that way, *of course* all functions share a reference to the same `i`. Something about the loop structure tends to confuse us into thinking there's something else more sophisticated at work. There is not. There's no difference than if each of the 5 timeout callbacks were just declared one right after the other, with no loop at all.

OK, so, back to our burning question. What's missing? We need more ~~cowbell~~ closured scope. Specifically, we need a new closured scope for each iteration.

We learned in Chapter 3 that the IIFE creates scope by declaring a function and immediately executing it.

Let's try:

```js
for (var i=1; i<=5; i++) {
	(function(){
		setTimeout(function(){
			console.log(i);
		},i*1000);
	})();
}
```

Does that work? Try it. Again, I'll wait.

I'll end the suspense for you. **Nope.** But why? We now obviously have more lexical scope. Each timeout function callback is indeed closing over its own per-iteration scope.

It's not enough to have a scope to close over if that scope is empty. Look closely. Our IIFE is just an empty do-nothing scope. It needs *something* in it to be useful to us.

It needs its own variable, with a copy of the `i` value at each iteration.

```js
for (var i=1; i<=5; i++) {
	(function(){
		var j = i;
		setTimeout(function(){
			console.log(j);
		},j*1000);
	})();
}
```

**Eureka! It works!**

A slight variation some prefer is:

```js
for (var i=1; i<=5; i++) {
	(function(j){
		setTimeout(function(){
			console.log(j);
		},j*1000);
	})(i);
}
```

Of course, since these IIFEs are just functions, we can pass in `i`, and we can call it `j` if we prefer, or we can even call it `i` again. Either way, the code works now.

The use of an IIFE inside each iteration created a new scope for each iteration, which gave our timeout function callbacks the opportunity to close over a new scope for each iteration, one which had a variable with the right per-iteration value in it for us to access.

Problem solved!

### Block Scoping Revisited

Look carefully at our analysis of the previous solution. We used an IIFE to create new scope per-iteration. In other words, we actually *needed* a per-iteration **block scope**. Chapter 3 showed us the `let` declaration, which hijacks a block and declares a variable right there in the block.

**It essentially turns a block into a scope that we can close over.** So, the following awesome code "just works":

```js
for (var i=1; i<=5; i++) {
	let j = i; // yay, block-scope for closure!
	setTimeout(function(){
		console.log(j);
	},j*1000);
}
```

*But, that's not all!* (in my best Bob Barker voice). There's a special behavior defined for `let` declarations used in the head of a for-loop. This behavior says that the variable will be declared not just once for the loop, but each iteration. And, it will, helpfully, be initialized at each subsequent iteration with the value at the end of the previous iteration.

```js
for (let i=1; i<=5; i++) {
	setTimeout(function(){
		console.log(i);
	},i*1000);
}
```

How cool is that? Block scoping and closure working hand-in-hand, solving all the world's problems. I don't know about you, but that makes me a happy JavaScripter.

## Modules

There are other code patterns which leverage the power of closure but which do not on the surface to appear to be about callbacks. Let's examine the most powerful of them: *the module*.

```js
function foo() {
	var something = "cool";
	var another = [1, 2, 3];

	function doSomething() {
		console.log(something);
	}

	function doAnother() {
		console.log(another.join(" ! "));
	}
}
```

As this code stands right now, there's no observale closure going on. We simply have some private data variables `something` and `another`, and a couple of inner functions `doSomething()` and `doAnother()`, which both have lexical scope (and thus closure!) over the inner scope of `foo()`.

But now consider:

```js
function CoolModule() {
	var something = "cool";
	var another = [1, 2, 3];

	function doSomething() {
		console.log(something);
	}

	function doAnother() {
		console.log(another.join(" ! "));
	}

	return {
		doSomething: doSomething,
		doAnother: doAnother
	};
}

var foo = CoolModule();

foo.doSomething(); // cool
foo.doAnother(); // 1 ! 2 ! 3
```

This is the pattern in JavaScript we call *module*. Other common names for it include "Revealing Module".

Let's examine some things about this code.

Firstly, `CoolModule()` is just a function, but it *has to be invoked* for there to be a module. Without the execution of the outer function, the creation of the inner scope and the closures would not occur.

Secondly, the `CoolModule()` function returns an object, denoted by the object-literal syntax `{ key: value, ... }`. The object we return has references on it to our inner functions, but *not* to our inner data variables. We keep those hidden and private. It's appropriate to think of this object return value as essentially a public API for our module.

This object return value is ultimately assigned to the outer variable `foo`, and then we can access those property methods on the API, like `foo.doSomething()`.

**Note:** It is not required that we return an actual object (literal) from our module. We could just return back an inner function directly. jQuery is actually a good example of this. The `jQuery` and `$` identifiers are the public API for the jQuery "module", but they are, themselves, just a function (which can itself have properties, since all functions are objects).

The `doSomething()` and `doAnother()` functions have closure over the inner scope of the module "instance" (arrived at by actually invoking `CoolModule()`). When we transport those functions outside of the lexical scope, by way of property references on the object we return, we have now set up a condition by which closure can be observed and exercised.

To state it more simply, there are two "requirements" for the module pattern to be exercised:

1. There must be an outer enclosing function, and it must be invoked at least once (each time creates a new module instance).

2. The enclosing function must return back at least one inner function, so that this inner function has closure over the private scope, and can access and/or modify that private state.

An object with a function property on it alone is not *really* a module. An object which is returned from a function invocation which only has data properties on it and no closure-functions is not *really* a module.

The code snippet above shows a standalone module function called `CoolModule()` which can be invoked any number of times, each time creating a new module instance. A slight variation on this pattern is when you only care to have one instance, a "singleton" of sorts:

```js
var foo = (function CoolModule() {
	var something = "cool";
	var another = [1, 2, 3];

	function doSomething() {
		console.log(something);
	}

	function doAnother() {
		console.log(another.join(" ! "));
	}

	return {
		doSomething: doSomething,
		doAnother: doAnother
	};
})();

foo.doSomething(); // cool
foo.doAnother(); // 1 ! 2 ! 3
```

Here, we turned our module function into an IIFE (see Chapter 3), and we *immediately* invoked it and assigned its return value directly to our single module instance `foo`.

Modules are just functions, so they can receive parameters:

```js
function CoolModule(id) {
	function identify() {
		console.log(id);
	}

	return {
		identify: identify
	};
}

var foo1 = CoolModule("foo 1");
var foo2 = CoolModule("foo 2");

foo1.identify(); // "foo 1"
foo2.identify(); // "foo 2"
```

Another slight but powerful variation on the module pattern is to name the object you are returning as your public API:

```js
var foo = (function CoolModule(id) {
	function change() {
		// modifying the public API
		publicAPI.identify = identify2;
	}

	function identify1() {
		console.log(id);
	}

	function identify2() {
		console.log(id.toUpperCase());
	}

	var publicAPI = {
		change: change,
		identify: identify1
	};

	return publicAPI;
})("foo module");

foo.identify(); // foo module
foo.change();
foo.idenfify(); // FOO MODULE
```

By retaining an inner reference to the public API object inside your module instance, you can modify that instance, including adding and removing methods, properties, and changing their values.

### Modern Modules

Various module dependency loaders/managers essentially wrap up this pattern of module definition into a friendly API. Rather than examine any one particular library, let me present a *very simple* proof of concept for illustration purposes (only):

```js
var MyModules = (function Manager() {
	var modules = {};

	function define(name, deps, impl) {
		for (var i=0; i<deps.length; i++) {
			deps[i] = modules[deps[i]];
		}
		modules[name] = impl.apply(impl, deps);
	}

	function get(name) {
		return modules[name];
	}

	return {
		define: define,
		get: get
	};
})();
```

The key part of this code is `modules[name] = impl.apply(impl, deps)`. This is invoking the definition wrapper function for a module (passing in any dependencies), and storing the return value, the module's API, into an internal list of modules tracked by name.

And here's how I might use it to define some modules:

```js
MyModules.define("bar", [], function(){
	function hello(who) {
		return "Let me introduce: " + who;
	}

	return {
		hello: hello
	};
});

MyModules.define("foo", ["bar"], function(bar){
	var hungry = "hippo";

	function awesome() {
		console.log( bar.hello(hungry).toUpperCase() );
	}

	return {
		awesome: awesome
	};
});

var bar = MyModules.get("bar");
var foo = MyModules.get("foo");

bar.hello("hippo"); // Let me introduce: hippo

foo.awesome(); // LET ME INTRODUCE: HIPPO
```

Both the "foo" and "bar" modules are defined with a function that returns a public API. "foo" even receives the instance of "bar" as a dependency parameter, and can use it accordingly.

Spend some time examining these code snippets to fully understand the power of closures put to use for our own good purposes. The key take-away is that there's not really any particular "magic" to module managers. They fulfill both characteristics of the module pattern I listed above: invoking a function definition wrapper, and keeping its return value as the API for that module.

In other words, modules are just modules, even if you put a friendly wrapper tool on top of them.

### Future Modules

ES6 adds first-class syntax support for the concept of modules. They are not, in large part, new functionality, but rather better syntax than the function patterns we just examined.

At the time of this writing, ES6 modules (should) look something like this:

```js
module "bar" {
	function hello(who) {
		return "Let me introduce: " + who;
	}

	export hello;
}

module "foo" {
	import "bar" as bar;
	var hungry = "hippo";

	function awesome() {
		console.log( bar.hello(hungry).toUpperCase() );
	}

	export awesome;
}

bar.hello("hippo"); // Let me introduce: hippo

foo.awesome(); // LET ME INTRODUCE: HIPPO
```

`import` imports one module into another, by name. `export` exports an identifier (variable, function) to the public API for the module. Both statements can be used as many times in a module's definition as is necessary.

## Review (TL;DR)

Closure seems to the un-enlightened like a mystical world set apart inside of JavaScript which only the few bravest souls can reach. But it's actually just a standard and almost obvious fact of how we write code in a lexically scoped environment, where functions are values and can be passed around at will.

Closure is when a function can remember and access his lexical scope even when he's invoked outside his lexical scope.

They require two key characteristics: 1) an outer wrapping function being invoked, to create the enclosing scope 2) the return value of the wrapping function must include reference to at least one inner function that then has closure over the private inner scope of the wrapper.

Closures can trip us up, for instance with loops, if we're not careful to recognize them and how they work. But they are also an immensely powerful tool, enabling patterns like *modules* in their various forms.

Now we can see closures all around our existing code, and we have the ability to recognize and leverage them to our own benefit!
# You Don't Know JS: Scope & Closures

## Table of Contents

* Preface
* Chapter 1: What is Scope?
	* Compiler Theory
	* Engine/Scope "Conversation"
	* Nested Scope
	* Errors
* Chapter 2: Lexical Scope
	* Lex-time
	* Cheating Lexical
* Chapter 3: Function vs. Block Scope
	* Function Scope
	* Hiding In Plain Scope
	* IIFE
	* Block Scope
* Chapter 4: Hoisting
	* Chicken Or The Egg?
	* The Compiler Strikes Again
* Chapter 5: Scope Closures
	* Enlightenment
	* Nitty Gritty
	* Now I Can See
	* Loops + Closure
	* Modules
* Appendix A: Dynamic Scope
* Appendix B: Polyfilling Block Scope
* Appendix C: Lexical-this
* Appendix D: Thank You's!
# You Don't Know JS: *this* & Object Prototypes
# Chapter 1: `this` Or That?

One of the most confused mechanisms in JavaScript is the `this` keyword. It's a special identifier keyword that's automatically defined in the scope of every function, but what exactly it refers to bedevils even seasoned JavaScript developers.

> Any sufficiently *advanced* technology is indistinguishable from magic. -- Arthur C. Clarke

JavaScript's `this` mechanism isn't actually *that* advanced, but developers often paraphrase that quote in their own mind by inserting "complex" or "confusing", and there's no question that without lack of clear understanding, `this` can seem downright magical in *your* confusion.

**Note:** The word "this" is a terribly common pronoun in general discourse. So, it can be very difficult, especially verbally, to determine whether we are using "this" as a pronoun or using it to refer to the actual keyword identifier. For clarity, I will always use `this` to refer to the special keyword, and "this" or *this* or this otherwise.

## Why `this`?

If the `this` mechanism is so confusing, even to seasoned JavaScript developers, one may wonder why it's even useful? Is it more trouble than it's worth? Before we jump into the *how*, we should examine the *why*.

Let's try to illustrate the motivation and utility of `this`:

```js
function identify() {
	return this.name.toUpperCase();
}

function speak() {
	var greeting = "Hello, I'm " + identify.call(this);
	console.log(greeting);
}

var me = {
	name: "Kyle"
};

var you = {
	name: "Reader"
};

identify.call(me); // KYLE
identify.call(you); // READER

speak.call(me); // Hello, I'm KYLE
speak.call(you); // Hello, I'm READER
```

If the *how* of this snippet confuses you, don't worry! We'll get to that shortly. Just set those questions aside briefly so we can look into the *why* more clearly.

This code snippet allows the `identify()` and `speak()` functions to be re-used against multiple "contexts", rather than needing a separate version of the function for each object.

The astute reader will notice that in our simple example, instead of relying on `this`, you could have explicitly passed in a context object to both `identify()` and `speak()`. However, the `this` mechanism provides a more elegant way of "passing along" an object reference, leading to cleaner API design and easier re-use.

The more complex your usage pattern is, the more clearly you'll see that passing context around as an explicit parameter is sometimes messier than passing around a `this` context. When we explore objects and prototypes, you will see the helpfulness of a collection of functions being able to automatically reference the proper context object.

## Confusions

We'll soon begin to explain how `this` *actually* works, but first we must  dispel some misconceptions about how it *doesn't* actually work.

The name "this" creates confusion when developers try to think about it too literally. There are two meanings often assumed, but both are incorrect.

### Itself

The first common temptation is to assume `this` refers to the function itself. That's a reasonable grammatical inference, at least. For instance, one may write code like *this*, and expect it to work, but be frustrated when it does not:

```js
function foo(num) {
	console.log("foo: " + num);

	// have `foo` keep track of how many times called
	this.count++;
}

foo.count = 0;

var i, tmp;

for (i=0; i<10; i++) {
	tmp = Math.random();
	if (tmp > 0.5) {
		foo(tmp);
	}
}

// how many times was `foo` called?
console.log(foo.count); // 0 -- WTF?
```

The developer observes `foo.count` is *always* `0`, even though some `console.log` statements were clearly made indicating `foo` was in fact called. Their frustration stems from their *too literal* interpretation of what `this` means.

When the code sets `foo.count` to `0`, indeed it's adding a property `count` to the function object `foo` (all functions in JavaScript are objects as well). But for the `this.count` reference inside of the function, `this` is not in fact pointing at all to that function object, and so even though the property names are the same, the root objects are different, and chaos ensues.

**Note:** The responsible developer *should* ask, "If I was incrementing a `count` property but it wasn't the one I expected, which one *was* I incrementing?" In fact, were he to dig deeper, he would find that he had accidentally created a global variable `count`, and it currently has the value `NaN`. Of course, once he identifies this peculiar outcome, he then has a whole other set of questions. "How was it global, and why did it end up `NaN` instead of some proper count value?"

Instead of stopping at this point and digging into why the `this` reference doesn't seem to be behaving as *expected*, and answering those tough but important questions, many developers simply avoid the issue altogether, and hack toward some other solution, such as creating another object to hold the `count` property:

```js
function foo(num) {
	console.log("foo: " + num);

	// have `foo` keep track of how many times it's called
	data.count++;
}

var data = {
	count: 0
};

var i, tmp;

for (i=0; i<10; i++) {
	tmp = Math.random();
	if (tmp > 0.5) {
		foo(tmp);
	}
}

// how many times was `foo` called?
console.log(data.count); // will be correct now! yay?
```

While it is true that this approach "solves" their problem, unfortunately it simply ignores the real problem -- lack of understanding what `this` means and how it works -- and instead falls back to the comfort zone of a more familiar mechanism: lexical scope.

**Note:** Lexical scope is a perfectly fine and useful mechanism; I am not belittling the use of it, by any means. But constantly *guessing* at how to use `this`, and usually being *wrong*, is not a good reason to retreat back to lexical scope and never learn *why* `this` eludes you.

A function object can only be referenced by a lexical identifier, so to reference a function from within itself, you need that function to have a name identifier. Anonymous functions have no such name identifier, and thus cannot be referenced in that way.

The old-school but now frowned-upon `arguments.callee` reference inside a function *also* points to the function object of the currently executing function. This reference is typically the only way to access an anonymous function's object from inside itself. The best approach is to avoid the use of anonymous functions altogether, at least for those which require a self-reference, and instead use the name identifier. `arguments.callee` is deprecated and should not be used.

Another solution to the above snippet then would have been to use the `foo` identifier as a function object reference in each place, and not use `this` at all, which *works*:

```js
function foo(num) {
	console.log("foo: " + num);

	// have `foo` keep track of how many times it's called
	foo.count++;
}

foo.count = 0;

var i, tmp;

for (i=0; i<10; i++) {
	tmp = Math.random();
	if (tmp > 0.5) {
		foo(tmp);
	}
}

// how many times was `foo` called?
console.log(foo.count); // Works! Forget `this`!
```

However, that approach similarly side-steps *actual* understanding of `this`. Instead, we could make sure `this` is pointing at the `foo` function object:

```js
function foo(num) {
	console.log("foo: " + num);

	// have `foo` keep track of how many times it's called
	this.count++;
}

foo.count = 0;

var i, tmp;

for (i=0; i<10; i++) {
	tmp = Math.random();
	if (tmp > 0.5) {
		foo.call(foo, tmp);
	}
}

// how many times was `foo` called?
console.log(foo.count); // Works! `this` FTW!
```

Instead of avoiding `this`, we embrace it. We'll explain in a little bit *how* it works, so don't worry!

### Its Scope

The next most common misconception about the meaning of `this` is that it somehow refers to the function's scope. It's a tricky question, because in one sense there is some truth, but in the other sense, it's quite misguided.

To be clear, `this` does not, in any way, refer to a function's **lexical scope**. It is true that internally, scope is kind of like an object with properties for each of the available identifiers. But the scope "object" is not accessible to JavaScript code. It's an inner part of the *Engine*'s implementation.

Consider code which attempts (and fails!) to cross over the boundary and use `this` to implicitly refer to a function's lexical scope:

```js
function foo() {
	var a = 2;
	this.bar();
}

function bar() {
	console.log(a);
}

foo();
```

There's more than one mistake in this snippet. While it may seem contrived, the code you see is a distillation of actual real-world code that has been exchanged in public community help forums. It's a wonderful (if not sad) illustration of just how misguided `this` assumptions can be.

Firstly, an attempt is made to reference the `bar()` function via `this.bar()`. It is almost certainly an *accident* that it works, but we'll explain the *how* of that shortly. The most natural way to have invoked `bar()` would have been to omit the leading `this.` and just make a lexical reference to the identifier.

However, the developer who writes such code is attempting to use `this` to create a bridge between the lexical scopes of `foo()` and `bar()`, so that `bar()` has access to the variable `a` in the inner scope of `foo()`. **No such bridge is possible.** You cannot use a `this` reference to look something up in a lexical scope. It is not possible.

Every time you feel yourself trying to mix lexical scope look-ups with `this`, remind yourself: *there is no bridge*.

## What's `this`?

Having set aside various incorrect assumptions, let us now turn our attention to how the `this` mechanism really works.

We said earlier that `this` is not an author-time binding but a runtime binding. It is contextual based on the conditions of the function's invocation. `this` binding has nothing to do with where a function is declared, but has instead everything to do with the manner in which the function is called.

When a function is invoked, an activation record, otherwise known as an execution context, is created. This record contains information about where the function was called from (the call-stack), *how* the function was invoked, what parameters were passed, etc. One of the properties of this record is the `this` reference which will be used for the duration of that function's execution.

In the next chapter, we will learn to find a function's **call-site** to determine how its execution will bind `this`.

## Review (TL;DR)

`this` binding is a constant source of confusion for the JavaScript developer who does not take the time to learn how the mechanism actually works. Guesses, trial-and-error, and blind copy-n-paste from Stack Overflow answers is not an effective or proper way to leverage *this* important `this` mechanism.

To learn `this`, you first have to learn what `this` is *not*, despite any assumptions or misconceptions that may lead you down those paths. `this` is neither a reference to the function itself, nor is it a reference to the function's *lexical* scope.

`this` is actually a binding that is made when a function is invoked, and *what* it references is determined entirely by the call-site where the function is called.
# You Don't Know JS: *this* & Object Prototypes
# Chapter 2: `this` All Makes Sense Now!

In Chapter 1, we discarded various misconceptions about `this` and learned instead that `this` is a binding made for each function invocation, based entirely on its **call-site** (how the function is called).

## Call-site

To understand `this` binding, we have to understand the call-site: the location in code where a function is called (**not where it's declared**). We must inspect the call-site to answer the question: what's *this* `this` a reference to?

Finding the call-site is generally: "go locate where a function is called from", but it's not always that easy, as certain coding patterns can obscure the *true* call-site.

What's important is to think about the **call-stack** (the stack of functions that have been called to get us to the current moment in execution). The call-site we care about is *in* the invocation *before* the currently executing function.

Let's demonstrate call-stack and call-site:

```js
function foo() {
	// call-stack is: `baz` -> `bar` -> `foo`
	// so, our call-site is in `bar`

	console.log("foo");
}

function bar() {
	// call-stack is: `baz` -> `bar`
	// so, our call-site is in `baz`

	console.log("bar");
	foo(); // <-- call-site for `foo`
}

function baz() {
	// call-stack is: `baz`
	// so, our call-size is in the global scope

	console.log("baz");
	bar(); // <-- call-site for `bar`
}

baz(); // <-- call-site for `baz`
```

Take care when analyzing code to find the actual call-site (from the call-stack), because it's the only thing that matters for `this` binding.

## Rules, Nothing But Rules

We turn our attention now to *how* the call-site determines where `this` will point during the execution of a function.

You must inspect the call-site and determine which of 4 rules applies. We will first explain each of these 4 rules independently, and then we will illustrate their order of precedence, if multiple rules *could* apply to the call-site.

### Default Binding

The first rule we will examine comes from the most common case of function calls: standalone function invocation. Think of *this* `this` rule as the default catch-all rule when none of the other rules apply.

Consider this code:

```js
function foo() {
	console.log(this.a);
}

var a = 2;

foo(); // 2
```

The first thing to note, if you were not already aware, is that variables declared in the global scope, as `var a = 2` is, are synonymous with global-object properties of the same name. They're not copies of each other, they *are* each other. Think of it as two sides of the same coin.

Secondly, we see that when `foo()` is called, `this.a` resolves to our global variable `a`. Why? Because in this case, the *default binding* for `this` applied to the function call, and so points `this` at the global object.

How do we know that the *default binding* rule applies here? We examine the call-site to see how `foo()` is called. In our snippet, `foo()` is called with a plain, un-decorated function reference. None of the other rules we will demonstrate will apply here, so the *default binding* applies instead.

**Note:** If Strict Mode is in effect, the global object is not eligible for the *default binding*, so the `this` is instead set to `undefined`.

```js
function foo() {
	"use strict";

	console.log(this.a);
}

var a = 2;

foo(); // TypeError: `this` is `undefined`
```

A subtle but important detail is: even though the overall `this` binding rules are entirely based on the call-site, the global object is **only** eligible for the *default binding* if the **contents** of `foo()` are **not** running in Strict Mode; the Strict Mode state of the `foo()` call-site is irrelevant.

```js
function foo() {
	console.log(this.a);
}

var a = 2;

(function(){
	"use strict";

	foo(); // 2
})();
```

**Note:** Intentionally mixing Strict Mode and non-Strict Mode together in your own code is generally frowned upon. Your entire program should probably either be Strict or non-Strict. However, sometimes you include a third-party library that has different Strict'ness than your own code, so care must be taken over these subtle details.

### Implicit Binding

Another rule to consider is: does the call-site have a context object, also referred to as an owning or containing object, though *these* alternate terms could be slightly misleading.

Consider:

```js
function foo() {
	console.log(this.a);
}

var obj = {
	a: 2,
	foo: foo
};

obj.foo(); // 2
```

Firstly, notice the manner in which `foo()` is declared and then later added as a reference property onto `obj`. Regardless of whether `foo()` is initially declared *on* `foo`, or is added as a reference later (as this snippet shows), in neither case is the **function** really "owned" or "contained" by the `obj` object.

However, the call-site *uses* the `obj` context to **reference** the function, so you *could* say that the `obj` object "owns" or "contains" the **function reference** at the time the function is called.

Whatever you choose to call this pattern, at the point that `foo()` is called, it's preceeded by an object reference to `obj`. When there is a context object for a function reference, the *implicit binding* rule says that it's *that* object which should be used for the function call's `this` binding.

Because `obj` is the `this` for the `foo()` call, `this.a` is synonymous with `obj.a`.

Only the top/last level of an object property reference chain matters to the call-site. For instance:

```js
function foo() {
	console.log(this.a);
}

var obj2 = {
	a: 42,
	foo: foo
};

var obj1 = {
	a: 2,
	obj2: obj2
};

obj1.obj2.foo(); // 42
```

#### Implicitly Lost

One of the most common frustrations that `this` binding creates is when an *implicitly bound* function loses that binding, which usually means it falls back to the *default binding*, of either the global object or `undefined`, depending on Strict Mode.

Consider:

```js
function foo() {
	console.log(this.a);
}

var obj = {
	a: 2,
	foo: foo
};

var bar = obj.foo; // function reference/alias!

bar(); // undefined
```

Even though `bar` appears to be a reference to `obj.foo`, in fact, it's really just another reference to `foo` itself. Moreover, the call-site is what matters, and the call-site is `bar()`, which is a plain, un-decorated call and thus the *default binding* applies.

The more subtle, more common, and more unexpected way this occurs in when we consider passing a callback function:

```js
function foo() {
	console.log(this.a);
}

function doFoo(fn) {
	// `fn` is just another reference to `foo`

	fn(); // <-- call-site!
}

var obj = {
	a: 2,
	foo: foo
};

doFoo(obj.foo); // undefined
```

Parameter passing is just an implicit assignment, and since we're passing a function, it's an implicit reference assignment, so the end result is the same as the previous snippet.

What if the function you're passing your callback to is not your own, but built-in to the language? No difference, same outcome.

```js
function foo() {
	console.log(this.a);
}

var obj = {
	a: 2,
	foo: foo
};

setTimeout(obj.foo, 100); // undefined
```

Think about this crude theoretical pseudo-implementation of `setTimeout()` provided as a built-in from the JavaScript environment:

```js
function setTimeout(fn, delay) {
	// wait (somehow) for `delay` milliseconds
	fn(); // <-- call-site!
}
```

It's quite common that our function callbacks *lose* their `this` binding, as we've just seen. But another way that `this` can surprise us is when the function we've passed our callback to intentionally changes the `this` for the call. Event handlers in popular JavaScript libraries are quite fond of forcing your callback to have a `this` which points to, for instance, the DOM element that triggered the event. While that may sometimes be useful, other times it can be downright infuriating. Unfortunately, these tools rarely let you choose.

Either way the `this` is changed unexpectedly, you are not really in control of how your callback function reference will be executed, so you have no way (yet) of controlling the call-site to give your intended binding. We'll see shortly a way of "fixing" that problem by *fixing* the `this`.

### Explicit Binding

With *implicit binding* as we just saw, we had to mutate the object in question to include a reference on itself to the function, and use this property function reference to indirectly (implicitly) bind `this` to the object.

But, what if you want to force a function call to use a particular object for the `this` binding, without putting a property function reference on the object?

"All" functions in the language have some utilities available to them (via their `[[Prototype]]` -- more on that later) which can be useful for this task. Specifically, functions have `call(..)` and `apply(..)` methods. Technically, JavaScript host environments sometimes provide functions which are special enough (a kind way of putting it!) that they do not have such functionality. But those are few. The vast majority of functions provided, and certainly all functions you will create, do have access to `call(..)` and `apply(..)`.

How do these utilities work? They both take, as their first parameter, an object to use for the `this`, and then invoke the function with that `this` specified. Since you are directly stating what you want the `this` to be, we call it *explicit binding*.

Consider:

```js
function foo() {
	console.log(this.a);
}

var obj = {
	a: 2
};

foo.call(obj); // 2
```

Invoking `foo` with *explicit binding* by `foo.call(..)` allows us to force its `this` to be `obj`.

**Note:** With respect to `this` binding, `call(..)` and `apply(..)` are identical. They *do* behave differently with their additional parameters, but that's not something we care about presently.

Unfortunately, *explicit binding* alone still doesn't offer any solution to the issue mentioned previously, of a function "losing" its intended `this` binding, or just having it paved over by a framework, etc.

#### Hard Binding

But a variation pattern around *explicit binding* actually does the trick. Consider:

```js
function foo() {
	console.log(this.a);
}

var obj = {
	a: 2
};

var bar = function() {
	foo.call(obj);
};

bar(); // 2
setTimeout(bar, 100); // 2

// hard-bound `bar` can no longer have its `this` overriden
bar.call(window); // 2
```

Let's examine how this variation works. We create a function `bar()` which, internally, manually calls `foo.call(obj)`, thereby forcibly invoking `foo` with `obj` binding for `this`. No matter how you later invoke the function `bar`, he will always manually invoke `foo` with `obj`. This binding is both explicit and strong, so we call it *hard binding*.

The most typical way to wrap a function with a *hard binding* creates a pass-thru of any arguments passed and any return value received:

```js
function foo(something) {
	console.log(this.a, something);
	return this.a + something;
}

var obj = {
	a: 2
};

var bar = function() {
	return foo.apply(obj, arguments);
};

var b = bar(3); // 2 3
console.log(b); // 5
```

Another way to express this pattern is to create a re-usable helper:

```js
function foo(something) {
	console.log(this.a, something);
	return this.a + something;
}

// simple PoC `bind` helper
function bind(fn, obj) {
	return function() {
		fn.apply(obj, arguments);
	};
}

var obj = {
	a: 2
};

var bar = bind(foo, obj);

var b = bar(3); // 2 3
console.log(b); // 5
```

Since *hard binding* is such a common pattern, it's provided with a built-in utility as of ES5: `Function.prototype.bind`, and it's used like this:

```js
function foo(something) {
	console.log(this.a, something);
	return this.a + something;
}

var obj = {
	a: 2
};

var bar = foo.bind(obj);

var b = bar(3); // 2 3
console.log(b); // 5
```

`bind(..)` returns a new function that is hard-coded to call the original function with the `this` context set as you specified.

#### API call "contexts"

Many libraries' functions, and indeed many new built-in functions in the JavaScript language and host environment, provide an optional parameter, usually called "context", which is designed as a work-around for you not having to use `bind(..)` to ensure your callback function uses a particular `this`.

For instance:

```js
function foo(el) {
	console.log(el, this.id);
}

var obj = {
	id: "awesome"
};

// use `obj` as `this` for `foo(..)` calls
[1, 2, 3].forEach(foo, obj); // 1 awesome  2 awesome  3 awesome
```

Internally, these various functions almost certainly use *explicit binding* via `call(..)` or `apply(..)`, saving you the trouble.

### `new` Binding

The fourth and final rule for `this` binding requires us to re-think a very common misconception about functions and objects in JavaScript.

In traditional class-oriented languages, "constructors" are special methods attached to classes, that when the class is instantiated with a `new` operator, the constructor of that class is called. This usually looks something like:

```js
something = new MyClass(..);
```

JavaScript has a `new` operator, and the code pattern to use it looks basically identical to what we see in those class-oriented languages; most developers assume that JavaScript's mechanism is doing something similar. However, there really is *no connection* to class-oriented functionality implied by `new` usage in JS.

First, let's re-define what a "constructor" in JavaScript is. In JS, constructors are **just functions** that happen to be called with the `new` operator in front of them. They are not attached to classes, nor are they instantiating a class. They are not even special types of functions. They're just regular functions that are, in essence, hijacked by the use of `new` in their invocation.

So, pretty much any ol' function can be called with `new` in front of it, and that makes that function call a *constructor call*. This is an important but subtle distinction: there's really no such thing as "constructor functions", but rather construction calls *of* functions.

When a function is invoked with `new` in front of it, otherwise known as a constructor call, the following things are done automatically:

1. a brand new object is created (aka, constructed) out of thin air
2. *the newly constructed object is `[[Prototype]]`-linked*
3. the newly constructed object is set as the `this` binding for that function call
4. unless the function returns its own alternate **object**, the `new`-invoked function call will *automatically* return the newly constructed object.

Steps 1, 3, and 4 apply to our current discussion. We'll skip over step 2 for now and come back to it shortly.

Consider this code:

```js
function foo(a) {
	this.a = a;
}

var bar = new foo(2);
console.log(bar.a); // 2
```

By calling `foo(..)` with `new` in front of it, we've constructed a new object and set that new object as the `this` for the call of `foo(..)`. **So `new` is the final way that a function call's `this` can be bound.** We'll call this *new binding*.

## Ordered Rules

So, now we've uncovered the 4 rules for binding `this` in function calls. *All* you need to do is find the call-site and inspect it to see which rule applies. But, what if the call-site has multiple eligible rules? There must be an order of precedence to these rules, and so we will next demonstrate what order to ask the rules in.

It should be clear that the *default binding* is the lowest priority rule of the 4. So we'll just set that one aside.

Which is more precedent, *implicit binding* or *explicit binding*? Let's test it:

```js
function foo() {
	console.log(this.a);
}

var obj1 = {
	a: 2,
	foo: foo
};

var obj2 = {
	a: 3,
	foo: foo
};

obj1.foo(); // 2
obj2.foo(); // 3

obj1.foo.call(obj2); // 3
obj2.foo.call(obj1); // 2
```

So, *explicit binding* takes precedence over *implicit binding*, which means you should ask **first** if *explicit binding* applies before checking for *implicit binding*.

Now, we just need to figure out where *new binding* fits in the precedence.

```js
function foo(something) {
	this.a = something;
}

var obj1 = {
	foo: foo
};

var obj2 = {};

obj1.foo(2);
console.log(obj1.a); // 2

obj1.foo.call(obj2,3);
console.log(obj2.a); // 3

var bar = new obj1.foo(4);
console.log(obj1.a); // 2
console.log(bar.a); // 4
```

OK, *new binding* is more precedent than *implicit binding*. But do you think *new binding* is more or less precedent than *explicit binding*?

**Note:** It's not grammatically valid to try `new foo.call(obj1)` to test *new binding* directly against *explicit binding*. `new` and `call`/`apply` cannot be used together. But we can still use a *hard binding* to test the precedence of the two rules.

Before we explore that in a snippet, think back to how *hard binding* works, which is that `Function.prototype.bind(..)` creates a new wrapper function that is hard-coded to ignore its own `this` binding (whatever it may be), and use a manual one we provide. By that reasoning, it would seem obvious to assume that *hard binding* (which is a form of *explicit binding*) is more precedent than *new binding*, and thus cannot be overriden with `new`.

Let's check:

```js
function foo(something) {
	this.a = something;
}

var obj1 = {};

var bar = foo.bind(obj1);
bar(2);
console.log(obj1.a); // 2

var baz = new bar(3);
console.log(obj1.a); // 2
console.log(baz.a); // 3
```

Whoa! Look at how `new bar(3)` did **not** overwrite `obj1.a` to be `3` as you ight have expected. Instead, the *hard bound* (to `obj1`) call to `bar(..)` ***is*** able to be overriden with `new`, which is how `baz.a` instead ends up as the value `3`.

This is surprising if you go back to our "fake" bind helper:

```js
function bind(fn, obj) {
	return function() {
		fn.apply(obj, arguments);
	};
}
```

This simple helper clearly cannot provide a way for a `new` operator call to override the hard-binding to `obj`.

But the built-in `Function.prototype.bind(..)` as of ES5 is more sophisticated, quite a bit so in fact. Here is the (slightly reformatted) polyfill provided by the MDN page for `bind(..)`:

```js
if (!Function.prototype.bind) {
	Function.prototype.bind = function(oThis) {
		if (typeof this !== "function") {
			// closest thing possible to the ECMAScript 5
			// internal IsCallable function
			throw new TypeError("Function.prototype.bind - what " +
				"is trying to be bound is not callable"
			);
		}

		var aArgs = Array.prototype.slice.call(arguments, 1),
			fToBind = this,
			fNOP = function(){},
			fBound = function(){
				return fToBind.apply(
					(
						this instanceof fNOP &&
						oThis ? this : oThis
					),
					aArgs.concat(Array.prototype.slice.call(arguments))
				);
			}
		;

		fNOP.prototype = this.prototype;
		fBound.prototype = new fNOP();

		return fBound;
	};
}
```

The part that's doing the task (allowing `new` overriding) is:

```
this instanceof fNOP &&
oThis ? this : oThis

// ... and:

fNOP.prototype = this.prototype;
fBound.prototype = new fNOP();
```

We won't actually dive into explaining how this trickery works (it's complicated and beyond our scope here), but essentially the snippet determines whether or not the bound function has been called with `new` (resulting in a newly constructed object being its `this`), and if so, it uses *that* new `this` rather than the previously specified *hard binding* for `this`.

Why is `new` being able to override *hard binding* useful? Imagine a function that you are given (might be hard-bound, might not, you don't know), and you want to use that function but *not* cause any side-effects on any object it may have been hard-bound to. Call it with `new`, and you **always** get the newly constructed object back, regardless of if the function was previously hard-bound.

While that distinction may not be a terribly common need everyday coding, it's important to fully understand how all these parts of the mechanism interact, so we have an accurate set of rules to analyze and predict its outcome.

### Determining `this`

Now, we can summarize the rules for determining `this` from a function call's call-site, in their order of precedence. Ask these questions in this order, and stop when the first rule applies.

1. Is the function called with `new` (*new binding*)? If so, `this` is the newly constructed object.

    `var bar = new foo()`

2. Is the function called with `call` or `apply` (*explicit binding*), even hidden inside *hard binding*? If so, `this` is the explicitly specified object.

    `var bar = foo.call(obj2)`

3. Is the function called with a context (*implicit binding*), otherwise known as an owning or containing object? If so, `this` is *that* context object.

    `var bar = obj1.foo()`

4. Otherwise, default the `this`. If in Strict Mode, pick `undefined`, otherwise pick the global object.

    `var bar = foo()`

That's it. That's all it takes to understand the traditional rules of `this` binding for function calls.

## Lexical `this`

Normal functions abide by the 4 rules we just covered. But ES6 introduces a special kind of function that does not use these rules: arrow-function.

Arrow-functions are signified not by the `function` keyword, but by the `=>` so called "fat arrow" operator. Instead of using the four standard `this` rules, arrow-functions inherit (lexically speaking) the `this` binding from the enclosing (function or global) scope.

Let's illustrate arrow-function lexical scope:

```js
function foo() {
	// return an arrow function
	return (a) => {
		// `this` here is lexically inherited from `foo()`
		console.log(this.a);
	};
}

var obj1 = {
	a: 2
};

var obj2 = {
	a: 3
};

var bar = foo.call(obj1);
bar.call(obj2);
```

The arrow-function created in `foo()` lexically captures whatever `foo()`s `this` is, and that's what is used, regardless of trying to subsequently override the `this`.

The most common use-case will likely be in the use of callbacks, such as event handlers or timers:

```js
function foo() {
	setTimeout(() => {
		// `this` here is lexically inherited from `foo()`
		console.log(this.a);
	},100);
}

var obj = {
	a: 2
};

foo.call(obj); // 2
```

While arrow-functions provide an alternative to using `bind(..)` on a function to ensure its `this`, which can seem attractive, it's important to note that they essentially are disabling the traditional `this` mechanism in favor of the more widely-understood lexical scoping. Pre ES-6, we already have a fairly common pattern for doing so, which is basically almost indistinguishable from the spirit of ES6 arrow-functions:

```js
function foo() {
	var self = this; // lexical capture of `this`
	setTimeout(function(){
		console.log(self.a);
	},100);
}

var obj = {
	a: 2
};

foo.call(obj); // 2
```

While `self = this` and arrow-functions both seem like good "solutions" to not wanting to use `bind(..)`, they are essentially fleeing from `this` instead of understanding and embracing it.

If you find yourself writing `this`-style code, but most or all the time, you defeat the `this` mechanism with lexical `self = this` or arrow-function "tricks", perhaps you should either:

1. Use only lexical scope and forget the false pretense of `this`-style code.

2. Embrace `this`-style mechanisms completely, including using `bind(..)` where necessary, and try to avoid `self = this` and arrow-function "lexical this" tricks.

A program can effectively use both styles of code (lexical and `this`), but inside of the same function, and indeed for the same sorts of look-ups, mixing the two mechanisms is usually asking for harder-to-maintain code, and probably working too hard to be too clever.

## Review (TL;DR)

Determining the `this` binding for an executing function requires finding the direct call-site of that function. Once examined, four rules can be applied to the call-site, in order *this* of precedence:

1. Called with `new`? Use the newly constructed object.

2. Called with `call` or `apply`? Use the specified object.

3. Called with a context object owning the call? Use that context object.

4. Default: `undefined` in Strict Mode, global object otherwise.

Instead of these four rules, ES6 arrow-functions use lexical scoping for `this` binding, which means they inherit the `this` binding (whatever it is) from its enclosing function. They are essentially a syntactic embrace of `self = this` in pre-ES6 code patterns.
# You Don't Know JS: *this* & Object Prototypes

## Table of Contents

* Preface
* Chapter 1: `this` Or That?
	* Why `this`?
	* Confusions
	* What's `this`?
* Chapter 2: `this` All Makes Sense Now!
	* Call-site
	* Rules, Nothing But Rules
	* Ordered Rules
	* Lexical `this`

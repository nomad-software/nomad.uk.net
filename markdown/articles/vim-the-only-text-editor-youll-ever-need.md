---
author: Gary Willoughby
title: Vim – The only text editor you'll ever need
description: Well, not wanting to shy away from an argument i'm going to make the case for the Vim text editor and explain why it's so awesome.
---

![](/nomad.uk.net/articles/images/vim-the-only-text-editor-youll-ever-need-banner.jpg)

# Vim – The only text editor you'll ever need

<time>Posted on 10th July 2013 by [Gary Willoughby](/nomad.uk.net/pages/about.html)</time>

Text editors are a huge topic of discussion and [argument](https://en.wikipedia.org/wiki/Editor_war) in the software world and every developer has their favorite. I've seen so many [flame wars](https://en.wikipedia.org/wiki/Flaming_(Internet)) erupting all over the net about this subject that I sometimes dare not bring it up. Well, not wanting to shy away from an argument i'm going to make the case for the [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)) text editor and explain why it's so awesome.

## History

Nearly forty years ago, the [BSD](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution) operating system was developed and along with that came a simple text editor called [Vi](https://en.wikipedia.org/wiki/Vi). Vi was run from within a terminal and was used to edit configuration files within the OS. After a while Vi was ported to all other Unix derivatives and started to gain a lot of popularity.

In 1988 [Bram Moolenaar](http://www.moolenaar.net/) released [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)) for the Amiga computer. The name 'Vim' is an acronym for 'Vi IMproved' because Vim is an iteration of the vi editor. Not only does Vim contain all the functionality of the vi editor it also provides a lot more features especially for editing program source code. Vim can be used from the command line within a terminal or it can be used as gVim which has a stand-alone native GUI.

## Cross platform

Vim will work almost everywhere that you do. Vim is widely used on Windows, Linux, and Mac OS X and is available for many other platforms. Users can run it from the terminal or operate it with a native graphical interface on all three major operating systems. Many system administrators value Vim because it gives them a productive text editing environment on practically any remote Linux or Mac OS X system that they access through the terminal via ssh. This is a list of currently (known) supported platforms as found [here](http://www.vim.org/download.php)

* Linux
* PC: MS-DOS and MS-Windows
* Macintosh
* Android
* i/OS
* Unix
* Amiga
* OS/2
* and many more…

## Sophisticated keyboard shortcuts

Vim has separate interaction modes for text input and text editing. Insert mode behaves largely as you would expect a regular text editor to work, commands are performed with conventional keyboard shortcuts and characters are appended to the buffer as you press the associated keys. In Normal mode, however, sequences of key presses perform commands. The most useful commands allow you to quickly navigate and manipulate the text in the buffer. You can extensively customize the behavior of the bindings to create custom shortcuts and commands. Combining several commands in Normal mode can create extremely sophisticated text editing behavior.

## Text objects

In Normal mode Vim treats all text as virtual objects. Vim is aware of words, brackets, braces, lines, sentences and paragraphs, etc. In combination with sophisticated keyboard shortcuts all text objects are easily transformed, copied or deleted when the cursor is upon them. The text object commands are one of the biggest productivity boosts in Vim as they make editing any text object an absolute breeze.

## Multiple document interface

In Vim, your files and unsaved documents are referred to as buffers. The editor gives you a tremendous amount of control over how your buffers are displayed on the screen. You can horizontally and vertically split the window as many times as you want so that you can view many buffers at the same time. You can even have the same buffer displayed in multiple splits, which lets you view separate parts of the same document simultaneously. You can also optionally organize sets of split layouts into tabs. Layouts and state can be preserved by saving a 'session' and restoring it later. Buffer windows can also be used for displaying information about the current buffer being edited. Many plugins use this feature to display information or create user interface elements within buffers.

## Multiple clipboards

Instead of a conventional clipboard, Vim stores copied text with a mechanism that it calls registers. There is a default register that is used to store text that is copied by the standard yank (copy) and delete operations, but the user can also indicate a specific register in which they want to store text when they cut or copy. This effectively acts like a clipboard multiplexer. The contents of the registers persist between uses of Vim, which means that they are preserved when you quit and will still be there when you open the editor again. Registers also store recorded macros as a sequence of characters to be played back. You may paste those characters as normal text, edit the sequence and then copy back to the register. This makes editing macros extremely easy and intuitive.

## Macros

Vim has a macro system that allows you to record keypresses for later playback. Macros are trivially easy to create from the keyboard and can consist of operations across multiple Vim modes and buffers. Macros are stored in registers, just like the clipboard items. As such, they can also persist across uses of the application or be loaded from an external file.

##Powerful search capabilities

Vim has some very sophisticated tools for automated search and replace, including extensive support for [regular expression](https://en.wikipedia.org/wiki/Regular_expression) matching. It also has a built-in version of the [grep](https://en.wikipedia.org/wiki/Grep) command which is tremendously powerful when searching through source code files. The search capability in Vim makes it extremely easy to traverse large files and quickly find your target.

## Greatly extensible

Vim is greatly scriptable and highly conducive to automation. It has its own native scripting language ([Vimscript](https://en.wikipedia.org/wiki/Vim_(text_editor)#Vim_script)) with container types, a unique variable scoping model, and a bunch of useful Vim-specific functionality. It also has built-in scripting engines and bindings that allow it to be customized via numerous mainstream programming languages, including

* Python
* Perl
* Ruby
* Tcl
* Lua

Vim can also be extended to add syntax highlighting for additional languages or create custom color schemes. Users widely share their scripts through various online repositories and package them into plugins. Installing a few simple plugins and scripts can give Vim many of the advanced capabilities of a full [IDE](https://en.wikipedia.org/wiki/Integrated_development_environment).

## Give it a go

![](/nomad.uk.net/articles/images/vim-logo.jpg)

Vim has been my editor of choice for over a year now after I started using Linux full time at work. Although I've experimented with a lot of conventional modern text editors and IDEs, I haven't found any that match Vim's efficiency, programmability or ubiquitousness. After using Vim every day over the past year, i'm still discovering new features, capabilities, and useful behaviors that further improve my productivity.

Not only is Vim an extremely advanced text editor it is a hacker's toy that can never be fully be learned in its entirety (the feature list is simply to large). Thus it provides immense fun to explore while simply editing text.

Vim has aged well over the past 20 years and is still in active development. It's not a crusty relic, the editor is still as compelling as ever and continues to attract new users. The learning curve can be a little steep and may put new users off but the productivity gains, the sense of achievement and fun of discovering a great tool are well worth the effort in the long run. **Give Vim a go and you'll never use another editor, I guarantee it!**

---

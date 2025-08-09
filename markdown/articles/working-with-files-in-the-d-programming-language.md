---
author: Gary Willoughby
title: Working with files in the D programming language
description: Hopefully this article will change that and show the simplicity and power of the D language when working with files.
---

![](/articles/images/working-with-files-in-the-d-programming-language-banner.jpg)

# Working with files in the D programming language

<time>Posted on 28th September 2015 by [Gary Willoughby](/pages/about.html)</time>

The inspiration for this article was one written a few weeks ago entitled [Working with Files in Go](https://www.devdungeon.com/content/working-files-go). In that article the author details numerous ways of interacting with files highlighting the capabilities of [Go](https://golang.org/). I thought I would write a companion piece, this time detailing how to interact with files using the [D programming language](https://dlang.org/). Interacting with files is a fundamental task of any programming language and while such tasks are commonplace, it's not entirely obvious how to achieve certain file related tasks using D. Hopefully this article will change that and show the simplicity and power of the D language when working with files.

Some of following code examples make good use of D's uniform function call syntax (UFCS). Don't be put off by this, a very simple explanation can be found [here](/articles/alternative-function-syntax-in-d.html).

## Reading and writing

### Open and close files

The following code show how to open and close a file in a safe way. Generally D does not attempt to provide thin wrappers over equivalent functions from the [C](https://en.wikipedia.org/wiki/C_(programming_language)) standard library, but manipulating such file handles directly is unsafe and error-prone in many ways. The `File` type ensures safe manipulation, automatic file closing, and a lot of convenience. The underlying handle is maintained in a [reference-counted](https://en.wikipedia.org/wiki/Reference_counting) manner, such that as soon as the last `File` variable goes out of scope, the underlying handle is automatically closed.

<script src="https://gist.github.com/nomad-software/33365afda104c3ff4d50c20341c73773.js"></script>

If an exception is thrown, there has been an error accessing the file and the `errno` property of the exception can be examined to find out what went wrong. Because the `File` type is a wrapper over a C function, the error number returned will be equal to the constants defined in `core.stdc.errno`. This is the most common way of accessing files and handling any errors that occur. Extended information can be gleaned from a file using the `std.file.getAttributes` function which returns an unsigned integer. This integer contains several [bit flags](https://en.wikipedia.org/wiki/Bit_field) that are set in an operating system specific manner. More information about these flags can be found [here](https://dlang.org/phobos/std_file.html#.getAttributes).

[Documentation](https://dlang.org/phobos/std_stdio.html#.File)

### Seek positions in a file

Sometimes it's necessary to move to a particular place in a file before you start reading or writing. The following example shows how to move to an offset from different starting points.

<script src="https://gist.github.com/nomad-software/6bc07e5b0337fe6bf1265f17b05c3027.js"></script>

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.seek)

### Write bytes to a file

This example shows how to write bytes to a file.

<script src="https://gist.github.com/nomad-software/8cb50779909ac7092aea11464944bbea.js"></script>

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.rawWrite)

### Quick write to a file

Sometimes is nice to just dump a buffer of data to a file and let the library take care of opening and closing it. This example shows you how.

<script src="https://gist.github.com/nomad-software/a095607b75391956909dd0fc8b031876.js"></script>

This is writing an array of bytes to the file but it could just as easily be a string.

[Documentation](https://dlang.org/phobos/std_file.html#.write)

### Writing strings to a file

When dealing with files there's always a lot of reading and writing of strings. This example shows the different methods available for writing a string to a file.

<script src="https://gist.github.com/nomad-software/b7f53835e6903dec58faf3007feb8452.js"></script>

These methods can be used to provide a bit more convenience depending on different scenarios.

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.write)

### Use an output buffer before writing

As an optimisation technique, sometimes it's necessary to write to a buffer in memory before writing it to disk to save time on [disk IO](https://en.wikipedia.org/wiki/Input/output). This example shows one of many ways of creating and writing such a buffer.

<script src="https://gist.github.com/nomad-software/657cf2dfc43b0354072733e1ff1de105.js"></script>

Using a buffer this way enables data to be written to memory very quickly before being dumped to disk. This saves time from making many small writes and decreases the wear on a drive.

[Documentation](https://dlang.org/phobos/std_outbuffer.html)

### Read bytes from a file

This example shows how to read bytes from a file.

<script src="https://gist.github.com/nomad-software/be7dce7a437df53057eff78ee59d9e26.js"></script>

When reading bytes like this you have to provide a buffer which receives the read data. This example uses a [dynamic array](https://dlang.org/spec/arrays.html#dynamic-arrays) for such a buffer and preallocates 1024 bytes before reading. The `rawRead` method fills the buffer with data and returns a [slice](https://dlang.org/d-array-article.html) of that buffer. The buffer length is the maximum number of bytes that will be read.

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.rawRead)

### Quick read from a file

Sometimes is nice to just read data from a file and let the library take care of opening and closing it. This example shows you how.

<script src="https://gist.github.com/nomad-software/af181ab8d66957b622c77ad845d3c4c0.js"></script>

The returned data is typed as a [void](https://en.wikipedia.org/wiki/Void_type) array. This can be cast to a more useful type and in the above example it's [cast](https://en.wikipedia.org/wiki/Type_conversion) to an array of bytes.

[Documentation](https://dlang.org/phobos/std_file.html#.read)

### Read _n_ bytes from a file

This example uses the `read` function again but this time uses the second parameter to define a limit of bytes to read. If the file is smaller than the defined limit, only the data in the file will be returned.

<script src="https://gist.github.com/nomad-software/16f932512ff84c5894160bc07a89e5c6.js"></script>

As before, the data returned can be cast to different array types.

[Documentation](https://dlang.org/phobos/std_file.html#.read)

### Read a file in chunks

This example reads a file in 1024 byte chunks.

<script src="https://gist.github.com/nomad-software/e1b7d6bcca32971375782a197ce510fb.js"></script>

The `byChunk` method returns an [input range](https://dlang.org/phobos/std_range.html) of bytes which reads from the file handle a chunk at a time. In this case, each call will return a maximum of 1024 bytes. The buffer is reused for every call so if you need the data to persist between calls, copies must be made.

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.byChunk)

### Read strings from a file

These examples show how to read strings from a file.

<script src="https://gist.github.com/nomad-software/09e72ff00a9b459322bcefa6363e4c58.js"></script>

While the above example is convenient for reading strings from a file there is a downside and that is `readln` allocates a new buffer for every line read. Because of this potential performance issue there is an [overloaded method](https://en.wikipedia.org/wiki/Function_overloading) which takes a buffer as a parameter, like this.

<script src="https://gist.github.com/nomad-software/45bdac475dff4f3c567d96c10194d887.js"></script>

This buffer can then be reused for each string read (which increases performance) but on the downside you have to take copies if you need the data to persist between calls. D leaves you to make the decision which is preferred.

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.readln)

### Read file as a range of strings

Reading a file as a range allows you to use many generic algorithms defined in [Phobos](https://dlang.org/phobos/index.html). This example shows how.

<script src="https://gist.github.com/nomad-software/96eb6246e5479bdf67eee0399f0d504d.js"></script>

The `byLine` method returns an input range which reads from the file handle one line at a time. Internally a buffer is reused for every line so if you need this data to persist between calls, copies must be made. There is a convenience method called `byLineCopy` which does this automatically.

[Documentation](https://dlang.org/phobos/std_stdio.html#.File.byLine)

### Quick read whole file as string

This example shows how to read an entire text file into a string.

<script src="https://gist.github.com/nomad-software/f1a4cb8fd017e963c3ff3a8d03ae77e3.js"></script>

This reads and validates a text file. No character width conversion is performed. If the width of the characters in the file don't match the specified string type the file will fail validation.

[Documentation](https://dlang.org/phobos/std_file.html#.readText)

## Basic operations

### Create an empty file

This creates a new file (if one doesn't exist) when initialising a `File` struct. If a file with the same name already exists, its contents are discarded and the file is treated as a new empty file.

<script src="https://gist.github.com/nomad-software/49343c39a8ecb37af30e29b941e12bbb.js"></script>

[Documentation](https://dlang.org/phobos/std_stdio.html#.File)

### Check if a file exists

This simply checks if a file exists.

<script src="https://gist.github.com/nomad-software/4d815f8332057ce42ca16272b1baa249.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.exists)

### Rename and move file

This renames and/or moves a file. If the destination file exists, it is overwritten.

<script src="https://gist.github.com/nomad-software/b5e88c138a9fe982b571628bdea3904e.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.rename)

### Copy a file

This copies a file. If the destination file exists, it is overwritten.

<script src="https://gist.github.com/nomad-software/3d36e1687614c9a3ff8f1579ced7218c.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.copy)

### Delete a file

This simply deletes a file.

<script src="https://gist.github.com/nomad-software/4e2c13b000cdf276af06590888292efe.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.remove)

### Get information about a file

This gets information for a particular file, similar to what you'd get from [stat](https://en.wikipedia.org/wiki/Stat_(system_call)) on a [Posix](https://en.wikipedia.org/wiki/POSIX) system. The following code shows only cross-platform information, more is available for individual operating systems by decoding the `attributes` member.

<script src="https://gist.github.com/nomad-software/748957f1cf59757d46c066054ca0a633.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.DirEntry)

### Truncate an existing file

This truncates an existing file to a maximum of 100 bytes. If the existing file's size is less, no truncation takes place.

<script src="https://gist.github.com/nomad-software/e620b076ad276f48ae8078187fcdf38a.js"></script>

[Documentation](https://dlang.org/phobos/std_file.html#.write)

## Archiving

### Create a Zip archive

Building upon later examples, the following shows how to create a zip archive.

<script src="https://gist.github.com/nomad-software/4056fa562d79ab54b681cba3ec40b4cc.js"></script>

[Documentation](https://dlang.org/phobos/std_zip.html#.ZipArchive)

### Read a Zip archive

This example shows how to read a zip archive.

<script src="https://gist.github.com/nomad-software/52ada72b67e3437b4764fb4e5ed0e884.js"></script>

[Documentation](https://dlang.org/phobos/std_zip.html#.ZipArchive)

## Compression

### Write compressed data to a file

This example shows how to compress data before writing to a file.

<script src="https://gist.github.com/nomad-software/216b4306fc06cca0ffc23637f790c9c9.js"></script>

In the above example a string is used but any data can be compressed. Internally the `std.zlib` module uses the [zlib](http://www.zlib.net/) C library.

[Documentation](https://dlang.org/phobos/std_zlib.html#.compress)

### Read compressed data from a file

This shows how to read compressed data from a file.

<script src="https://gist.github.com/nomad-software/5c908cae4314e02bfebe7852b583fec3.js"></script>

[Documentation](https://dlang.org/phobos/std_zlib.html#.uncompress)

## Posix operations

### Change file access rights

This changes file access rights on a [Posix](https://en.wikipedia.org/wiki/POSIX) system such as [Linux](https://en.wikipedia.org/wiki/Linux) or [Mac OS](https://en.wikipedia.org/wiki/Macintosh_operating_systems). There is no cross-platform [Phobos](https://dlang.org/phobos/index.html) solution for this task so we can only use a Posix specific [system call](https://en.wikipedia.org/wiki/System_call).

<script src="https://gist.github.com/nomad-software/43accf5342006b317af628d4a42a1d6e.js"></script>

The `chmod` system call functions in exactly the same way as the chmod [shell](https://en.wikipedia.org/wiki/Unix_shell) command. A file name is specified along with its new [access rights](https://en.wikipedia.org/wiki/File_system_permissions#Numeric_notation) (expressed as an [octal](https://en.wikipedia.org/wiki/Octal) number). When modifying a file in this way, you also need permission to actually perform the operation. This can be accomplished by owning the file or by being a [super user](https://en.wikipedia.org/wiki/Superuser).

[Documentation](https://en.wikipedia.org/wiki/Chmod)

### Change file ownership

This changes the ownership of a file on a Posix system. Once a file is owned, file access rights can be changed without being a super user.

<script src="https://gist.github.com/nomad-software/abc8f6d9fbb7c0e6ca0e9b7c033b28ae.js"></script>

The `chown` system call functions in exactly the same way as the chown shell command. A file name is specified along with its new owner and group. Your program will need super user permissions to change the owner.

[Documentation](https://en.wikipedia.org/wiki/Chown)

### Create hard links and symbolic links

Sometimes it's necessary to create [hard links](https://en.wikipedia.org/wiki/Hard_link) or [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link) on a Posix system. The following example first shows you how to create a hard link.

<script src="https://gist.github.com/nomad-software/ba6f70fb41ddc3dd9df2f63b67cdca51.js"></script>

To create a symbolic link, replace line 9 with the following line.

<script src="https://gist.github.com/nomad-software/bb8ec0ff9c3bd7643ea0c0eb55316ba9.js"></script>

## Conclusion

There is rarely one canonical way of interacting with files and developers like to perform different file related tasks in their own particular way. Hopefully this article demonstrates the power and convenience of D and highlights convenient functions in the standard library for use when working with files.

---

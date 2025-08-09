---
author: Gary Willoughby
title: Interesting ways of using Go channels
description: I've created this post to document slides accompanying a talk on Go channels given by John Graham-Cumming during GopherCon 2014. The presentation was entitled 'A Channel Compendium' and is available to view on youtub.com.
---

![](/articles/images/interesting-ways-of-using-go-channels-banner.jpg)

# Interesting ways of using Go channels

<time>Posted on 21st January 2016 by [Gary Willoughby](/pages/about.html)</time>

I've created this post to document [slides](https://www.slideshare.net/cloudflare/a-channel-compendium) accompanying a talk on [Go](https://golang.org/) channels given by [John Graham-Cumming](https://en.wikipedia.org/wiki/John_Graham-Cumming) during [GopherCon 2014](https://www.gophercon.com/). The presentation was entitled 'A Channel Compendium' and is available below.

During the talk, he presents interesting ways of using Go channels and makes you aware of the possibilities and advantages of [concurrent programming](https://en.wikipedia.org/wiki/Concurrent_computing). For me personally, this opened my eyes to several new ways of structuring programs and novel techniques for synchronising work done across [multiple processor cores](https://en.wikipedia.org/wiki/Parallel_computing).

<iframe class="youtube" src="https://www.youtube.com/embed/SmoM1InWXr0" frameborder="0" allowfullscreen></iframe>

The following examples demonstrate various techniques how to use channels in Go. The code has been intentionally simplified to express these rather than being production level. For example, all error handling has been omitted.

## Signalling

### Wait for an event

In this example, a goroutine is started, does some work (in this case waiting for five seconds) then closes the channel. Unbuffered channels always halt the current goroutine until communication can take place. Closing the channel signals to the goroutine that it can continue because there is no more data to be received. Closed channels never halt execution of the goroutine.

<script src="https://gist.github.com/nomad-software/aa3f5d242f6afbf3f0eed390b7dab0c0.js"></script>

### Coordinate multiple goroutines

In this example, a hundred goroutines are started, waiting for communication of data on the `start` channel (or for it to be closed). In this case, once closed, all goroutines start.

<script src="https://gist.github.com/nomad-software/9714bef93f932b028f2bd6ec0c7be138.js"></script>

### Coordinated termination of workers

In this example, a hundred goroutines are started, waiting for communication of data on the `die` channel (or for it to be closed). In this case, once closed all goroutines end.

<script src="https://gist.github.com/nomad-software/b2c2e936f22f8f353bc09a42c7f82398.js"></script>

### Verify termination of workers

In this example, a goroutine is started, waiting for communication of data on the `die` channel (or for it to be closed). In this case, once closed, the goroutine performs termination tasks, then signals to the main goroutine (via the same `die` channel) that it's finished.

<script src="https://gist.github.com/nomad-software/36ca3d628f524c07256d33512799c321.js"></script>

## Hide state

### Unique ID service

In this example, a goroutine is started to generate unique hexadecimal id's. Each id is sent via the `id` channel and the goroutine halts until the channel is read. Each time the channel is read, the goroutine is free to increment the value and send another.

<script src="https://gist.github.com/nomad-software/219b2931e5fc825bca02646043542048.js"></script>

### Memory recycler

In this example, a goroutine is started to recycle memory buffers. The `give` channel receives old memory buffers and stores them in a list. While the `get` channel dispenses these buffers for use. If no buffers are available in the list, a new one is created.

<script src="https://gist.github.com/nomad-software/b29afb25a376c6fbedb40bafad954f4d.js"></script>

### Capped memory recycler

In this example, a single buffered channel is used as a store for memory buffers. The channel is set to buffer five entries at any given time. This means the channel will not halt the current goroutine if there is capacity in the channel to accept another entry.

The select statements provide non-blocking access to this channel in the case that it would be full. The first select creates a new buffer if it's unable to get a buffer from the store. The second select defaults to nothing if it's unable to place one on the store, which invokes the garbage collector to deallocate the given buffer.

<script src="https://gist.github.com/nomad-software/c6cb83b41a0222e5c995302cd6a60626.js"></script>

## Nil channels

### Disable receiving case statements

In this example, a goroutine is started and using `select` tries to receive on two channels. If a channel is closed, it is set to `nil`. Because `nil` channels always block, this has the effect of disabling the associated `case` statement. If both channels are set to `nil`, the goroutine exits because it cannot receive anything else.

<script src="https://gist.github.com/nomad-software/8f34e50f561ce54d3a46443880618f55.js"></script>

### Disable sending case statements

In this example, a goroutine is started to generate random numbers and send them on the `c` channel. If a message is sent on the `d` channel, the `c` channel is set to `nil`, disabling the associated case statement. Once disabled, the goroutine can no longer send random numbers.

<script src="https://gist.github.com/nomad-software/a97f5ba70a1c93ce9f34b3c9f0b3111f.js"></script>

## Timers

### Timeout

In this example, a goroutine is started to do some work. A `timeout` channel is created to make sure a `case` is executed if the `select` is halting for too long. In this case, the goroutine is terminated after thirty seconds of being idle. The timeout is assigned on every iteration of the `select` to make sure that if work is done, the timeout is reset.

<script src="https://gist.github.com/nomad-software/0ff7b3bd50a91d366b9949c1cf84648d.js"></script>

### Heartbeat

In this example, a goroutine is started to do some work. A `heartbeat` channel is created to make sure a `case` statement is executed at regular intervals. The `heartbeat` channel is not reset on each iteration to make sure it always executes on time.

<script src="https://gist.github.com/nomad-software/eae38fe99db4976f1b2d47abe7042329.js"></script>

## Examples

### Network multiplexer

This example demonstrates a simple network multiplexer. Within the main goroutine, a channel is created to handle transferring messages and a network connection is established. A hundred goroutines are then spawned to generate strings (to act as our messages) and sent along this channel. Each message is read from the channel during a continuous loop and sent to the network connection.

This example doesn't run (because we are trying to connect to an example domain) but it expresses how easy it is to have many asynchronous processes sending messages to a single network connection.

<script src="https://gist.github.com/nomad-software/b2b1faf4383d5c0fe86e4aa0cf0ae5a0.js"></script>

### First response

In this example, an array of web URL's are iterated upon and passed individually to separate goroutines. Each goroutine executes asynchronously and queries the passed URL. Each query response is passed into the `first` channel, which (of course) ensures the first query to respond is the first passed into the channel. We can then read this response from the channel and act accordingly.

<script src="https://gist.github.com/nomad-software/1cd5e1448c91037bae786b017217b780.js"></script>

### Passing a channel

In this example, the `w` channel is created to transfer a unit of work to a goroutine. This unit of work is received and a request is made to the contained URL. As part of this work, a `resp` channel is also passed. Once the request is performed, the response is sent back along the response channel. This allows this goroutine to process work and send a response back on different channels configured for each unit of work.

<script src="https://gist.github.com/nomad-software/43874dbd7c3024afca5d0c732816f83e.js"></script>

### HTTP load balancer

In this example, a load balancer has been created building upon previous examples. It handles reading URL's from stdin and starting goroutines to perform a request for each. Each request is passed through a load balancer to filter these jobs into a finite number of workers. These workers process the requests and ultimately return a response to a single channel.

Using a load balancer such as this can take a huge number of requests, balance them across resources available and process them in an orderly manner.

<script src="https://gist.github.com/nomad-software/d5da97074ae4788da362b095c5f45a1d.js"></script>

## Conclusion

Go is a language that in my opinion [does have it's problems](/articles/why-gos-design-is-a-disservice-to-intelligent-programmers.html) but it's a language I'm willing to learn and use. For me, this presentation of ideas opened my mind to new concepts and really gets me interested in starting a new project which takes advantage of the fantastic concurrency support in Go. It also reinforces the need to read and understand the standard library that ships with languages such as Go to truly understand the ethos and design decisions of the language.

---

---
author: Gary Willoughby
title: Hey, stop ruining my work!
description: My beautiful website was knackered! Pixel perfect divs not lining up, new colours used not from the original palette, text flowing unnaturally.
---

![]($root-path$/articles/images/hey-stop-ruining-my-work-banner.jpg)

# Hey, stop ruining my work!

<time>Posted on 18th January 2010 by [Gary Willoughby]($root-path$/pages/about.html)</time>

Recently a friend of mine ask me to design and create a small website for their fledgling business. Although slightly weary of creating such websites, he was a good friend so I agreed to do it free of charge. The business was something I am not familiar with and while nothing to do with technology I approached the project with enthusiasm and proceeded to gather information from him as I would any other client.

Now, this is what puts me off creating such websites: the information gathering stage. At first I asked him what do you want the site to do for you? He didn't really know. So I asked him what content should it contain? He wasn't sure. Not too surprising though I guess because he wasn't technically minded and never owned a website before, so I suggested I should come up with something to start with then use that as a base to build on and amend as needed.


## The rot

After a week or so of coding and producing, if I do say so myself, a very beautiful site, I presented it to my friend. He was overjoyed and liked it immediately, but then it happened, over and over again, “just one thing, can we change this bit here?”. This was the start of a fortnight of never ending streams of amendments and additions.

Now this created two problems.

1. When gathering the original specifications, content was very sparse so I created a website which fills the screen with filler to hide the fact that content was almost non existent.
1. I was getting fed up with losing my time to a never ending spree of ammendments.

Over the years I have come to expect this, after all many people have no idea what they want on their first business website but once they have something to look at they know exactly what they don't want! I did what I could and gently reminded him I was working for nothing and politely persuaded him to pursue another web developer to carry on any further work. After all, adding too much content would mean a full re-design. This seemed like a good idea to me as experience has shown the more something is tampered with overtime, it loses its original shine, while paying someone to maintain a website is a good incentive to make people think hard about changes they make.

## The demolition

After a few weeks had sailed by and enjoying a free night, I decided to visit my friends website to see if he had made any new changes and to see how things were. As the page loaded my heart sank. My beautiful website was knackered! Pixel perfect divs not lining up, new colours used not from the original palette, text flowing unnaturally, garbage text appearing randomly, navigation spelt differently on each page. I had to stop counting the flaws, I had to view the source.

I still had the FTP login details of the webhost so I logged in and downloaded a copy of the site to browse locally. It was a complete mess. I was in shock. Had he tried to edit it himself? Had he passed it on to another friend to edit? Someone had hacked it about with obviously no real regard for the website or its asthetic quality? Well, I though, I won't bother him tonight as it was very late, i'll just do him a favour and just put things right. So after an hour and a half, everything looked great and no change was made to the updated content, I just corrected the source code of the site. I uploaded it and it looked good again, a site to be proud of. I calmed my nerves and went to bed.

Four more weeks passed and after fixing the site yet again a week ago, I was itching to take another look. But what if it was a mess again, i'd have to put it right. I decided not to look, ….yeah right as if I could stop myself, I immediately opened the site for the third time and to my horror it was a freaking mess again! This time it had new content and more garish graphics! I thought, what next week, flashing gifs??? I realised what had happened, whoever was editing the site had a local master copy and was updating that then re-uploading the whole site back to the webhost overwriting my fixes. I had to ring my friend.

## A little chat

I spoke with him on the phone about what had been going on, about my fixes and the god awful edits done to the site. I explained in detail what was actually wrong each time and how I had corrected it without changing the edits he had asked for from the other developer. I explained to him that any confrontation will be pointless but in the future he must furnish the other developer with style guidelines I immediately wrote in order for these amateurish edits to stop. I emailed the guidelines and that was that.

Am I being anal? Am I being too overprotective? Not when my name is on the site. Yes, that's right, my name is on the bottom of every page in the footer explicitly saying I designed and developed that site. No amateur is going to soil my name, especially if I have a say in the matter.

For those interested, here are what was wrong with the site, time after time:

1. It had been edited using Dreamweaver which inserted many unnecesary tags causing layout problems.
1. For some reason all of the HTML files had double line spacings, destroying layout in a PRE tag on one of the pages.
1. New embedded CSS styles were added to the HTML files themselves, not the main 'content.css' file.
1. New styles where applied inline and had names such as 'style2', 'style3', etc. Ughh!
1. Edits to javascript which introduced bugs due to not enclosing strings correctly.
1. A piece of linked text had each word linking to somewhere different.
1. Garbage characters appearing on screen due to malformed HTML.
1. Divs not lining up properly.
1. A promotion was added using tables filled in primary colours when the site was using a light pastel palette.
1. USA and UK spellings using throughout, even for the same words.
1. The navigation didn't read the same on every page, causing much confusion.
1. More I can't remember, let me just say it was a right mess.

And the kicker of this whole episode is that the person 'maintaining' the site is a 'professional' self employed web developer charging 16.50 GBP an hour, that's about 27 USD an hour for our USA cousins! Has this person never read any best practises or style guidelines for maintaining websites? I dread to think what other sites have been ruined!

I put the site right once again and politely asked my friend to pass along the guidelines I had written. From now on, any site I author will be delivered with style guidelines written to be passed on to whoever maintains the site.

---

![](/docs/pages/images/contribute-banner.jpg)

# nomad.uk.net

This blog is where i can rant and rave about all the different aspects of software development, save code and ideas for later and somewhere where readers and i can both learn from each other. What better way is there to reach other like minded developers than to keep a journal of ideas and thoughts that hopefully will help our community as a whole. Plus, it’s also a storage facility for me, so i don’t forget this stuff!

## Building the site

### Prerequisites

1. Install [Pandoc](https://pandoc.org/). on Linux it's as easy as `sudo apt install pandoc`

### Build the HTML files

1. Execute the `build-site.sh` bash script
2. The entire site should now reside in the 'docs' directory

### Viewing the site

You can use any web server to view the site, just make sure the 'docs' folder is the root directory. If you have [Docker](https://www.docker.com/) and [Docker compose](https://docs.docker.com/compose/) installed you can easily serve the site by spinning up an [Nginx](https://www.nginx.com) container.

1. In the repository directory execute `docker-compose up`
2. Visit `localhost:80` in your browser to view

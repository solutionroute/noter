# noter

`noter` provides a simple blog/journal/post, link/short URL and image/file
publishing tool.

> *This is a **work in progress** (late April 2020) - not much to see here yet
> aside from some docs and a possibly useful Makefile.*

Written in Go, `noter` uses a single-file Bolthold (BoltDB-backed) datastore and
a file system for storing posts and files. Templates use Go's `html/template`
and the CSS is project specific, leaning on the Tailwind CSS utility-first
approach.

A `Makefile` automates some routine tasks and provides a `watch` function for
development server restarts on code changes.

There's no source yet available; Noter is currently a work in progress (April
2020) and aims to be simple, understandable and customizable by developers
rather than end-users.

Once there's enough complete to play with I'll be pushing source out regularly.

## Customization

* **HTML** - templates are Go html/template; hack away.  
* **CSS** - I've elected to give the Tailwind CSS approach a spin. If you want
  to customize or generate a new minified `http/static/noter.css`, you'll need
  to install the `node` related tool chain.

## Installation

Currently the app meant to be run from sources in order to access HTML templates.

    go get github.com/solutionroute/noter

Explore within.

### Node, Tailwind and Related

`noter` makes use of [Tailwind CSS](https://tailwindcss.com), a *utility-first*
CSS framework. A maximal (every class, and rather large) CSS file is included in the
source for those who don't care to install the `node` toolchain required to
produce a very trim app-specific CSS file. Simply copy `http/static/noter.all.css` to
`http/static/noter.css`. Alternatively you could use the Tailwind CDN
([see notes on the Tailwind site](https://tailwindcss.com/docs/installation/#using-tailwind-via-cdn)):

    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">

Node tools:

    # based on node / npm / npx being installed globally
    # let's update npm
    sudo npm install -g npm

    # installs within the project director tailwind, postcss-cli, autoprefixer
    npm install
    # install chokidar-cli globally, used for file-watching and server restart
    sudo npm install -g chokidar-cli

Read the `Makefile` for available build and run commands.

## Motivation

At this time of writing, the world is gripped by the COVID-19 pandemic and I
have a bit of spare time. I wrote `noter` primarily to improve my grasp of Go,
and to solve a need.

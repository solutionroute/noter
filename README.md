# noter

`noter` provides an easy to deploy journal, link and file http server
application with an online Markdown editing and publishing environment.

Written in Go, no outboard database engine is required for `noter`; Metadata for
notes, links and attachments is managed by an in-process single-file
[Bolthold](https://github.com/timshannon/bolthold) database; any file objects
pointed to reside on your filesystem.

> **Note**: Source is not yet available; this README is a bit of a spec document
> while I sketch out the app basics (at time of writing, approaching mid-May in
> the pandemic year of 2020). Currently there's not much to see here except for
> a possibly useful `Makefile` and `package.json` showing Go code reloading and
> Tailwind CSS processing.

## Installation

Install the `noter` binary (and source) with:

    go get github.com/solutionroute/noter/... 

Explore within.

## Running & deploying noter

Be aware that the `NOTER_PORT` environment variable is mandatory, a usage notice
will be output to `stderr` if it isn't available.

    # Example Command line:
    NOTER_PORT=1234 noter

All other configuration tweaks are optional:

    # Supported environment variables showing defaults.
    #
    # NOTER_PORT = 8080

The application is configured using using zero or more of the following
enviroment variables:

    NOTER_HOST = 0.0.0.0
    NOTER_DBPATH = /home/$(USER)/.noter/noter.db
    NOTER_FILEPATH = /home/$(USER)/.noter/files
    NOTER_STATIC = = /home/$(USER)/go/src/github.com/solutionroute/noter/http/static
    NOTER_TEMPLATES = /home/$(USER)/go/src/github.com/solutionroute/noter/http/templates
    NOTER_SECRET = YouWouldChangeThIsOfCourse

## Customizing noter templates or CSS

**Template customization**: `noter` defaults to looking for its
[Golang text/html](https://golang.org/pkg/html/template/) html templates in your
`GOPATH` unless you  specify otherwise.

To modify the templates, and avoid new versions of `noter` stomping on your
changes, it's best to copy the http/templates directory and everything below it
to your own theme directory and then point to this new template location by
setting the `NOTER_TEMPLATES` environment variable in your environment or on the
command line:

    NOTER_TEMPLATES=/home/mw/.noter/mytheme NOTER_PORT=4321 noter

**CSS customization**: The CSS styling utilizes
[Tailwind CSS](https://tailwindcss.com/) *utility-first* approach. The project
relies on Tailwind and a number of supporting `npm` packages; see `package.json`
for details. Commands in `package.json` are also available via `make`. Producing a minified (and we are talking very small indeed for a responsive, mobile-first HTML app) is easy:

    make css

Assuming you've got `node` / `npm` installed, install `noter`'s dependencies:

    npm install

## Modifying noter itself

Feel free to fork this; I'm happy to merge any changes that are in keeping with
the "remain simple" vibe I hope `noter` has.

You'll possibly need to update Go dependencies.

    # cd noter
    go mod tidy

## Motivation and objectives

I adore and use [Hugo](https://gohugo.io/) extensively but had a specific need
for a non-profit I volunteer at where Hugo wouldn't fit in well. So, `noter`.

What drove me to write `noter` also included, in somewhat descending order of
importance (at the time):

    * Something to fill my idle time while furloughed due to the COVID-19 pandemic
    * Wanting to know Go better; learn some best practices and hopefully end up
      with something both usable and a library offering some reusable components
    * For future projects, having a reusable project layout and web tool chain

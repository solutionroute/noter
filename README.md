# noter

`noter` provides an easy to deploy online publishing system for one or more
authenticated users and features Markdown editing of notes (journal entries),
link collections and short URL redirection, and file/image *attachment* serving
via the built-in http server.

Written in Go, no outboard database engine is required for `noter`; metadata for
notes, links and attachments is managed by an in-process single-file
[Bolthold](https://github.com/timshannon/bolthold) database; attachments
(files/images) reside on your the filesystem.

> **Note**: Source is not yet available; this README is a bit of a spec document
> while I sketch out the app basics (at time of writing, approaching mid-May in
> the pandemic year of 2020). Currently there's not much to see here except for
> a possibly useful `Makefile` and `package.json` showing Go code reloading and
> Tailwind CSS processing.

An API endpoint allows for backing up the Bolthold database in JSON format using
nothing but HTTP.

## Installation

Install the `noter` binary (and source) with:

    go get github.com/solutionroute/noter/... 

Explore within.

## Running & deploying noter

The `NOTER_PORT` environment variable is the only mandatory variable; if not
found a usage notice will be output to `stderr`.

    # Example Command line:
    NOTER_PORT=1234 noter

All other configuration tweaks are optional. All the available variables and
their defaults:

    # NOTER_PORT = 8080
    NOTER_HOST = 0.0.0.0
    NOTER_DBPATH = /home/$(USER)/.noter/noter.db
    NOTER_FILEPATH = /home/$(USER)/.noter/files
    NOTER_STATIC = = /home/$(USER)/go/src/github.com/solutionroute/noter/http/static
    NOTER_TEMPLATES = /home/$(USER)/go/src/github.com/solutionroute/noter/http/templates
    NOTER_SECRET = YouWouldChangeThIsOfCourse

The *secret* is for producing short, random looking, non-sequential hashes of
link IDs, suitable for a short-URL redirection service included in `noter`.

## Customizing noter templates or CSS

**Templates**: `noter` defaults to looking for its
[Golang text/html](https://golang.org/pkg/html/template/) html templates in your
`GOPATH` unless you  specify otherwise.

To modify the templates, and avoid new versions of `noter` stomping on your
changes, it's best to copy the http/templates directory and everything below it
to your own theme directory and then point to this new template location by
setting the `NOTER_TEMPLATES` environment variable in your environment or on the
command line:

    NOTER_TEM>ll

 The project relies on Tailwind and a number of supporting `npm` packages; see
 `package.json` for script commands; these are also available via `make`.

Producing minified CSS is easy:

    make css            # or npm run css

## Modifying noter itself

Feel free to fork this; I'm happy to merge any changes that are in keeping with
the "remain simple" vibe I hope `noter` has. It would be trivial to add a SQL
storage.

You'll possibly need to update Go dependencies.

    # cd noter
    go mod tidy

## Motivation and objectives

I adore and use [Hugo](https://gohugo.io/) extensively but had a specific need
for a non-profit I volunteer at where Hugo wouldn't fit in well. So, `noter`.

What also drove me to write `noter` included, in somewhat descending order of
importance (at the time):

    * Something to fill my idle time while furloughed due to the COVID-19 pandemic
    * Wanting to know Go better; learn some best practices and hopefully end up
      with something both usable and a library offering some reusable components
    * For future projects, having a reusable project layout and web tool chain

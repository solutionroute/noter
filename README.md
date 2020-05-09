# noter

`noter` provides a simple journal, link and image/file http server application.

Written in Go, no external database is required for `noter`; Metadata for notes,
links and attachments is managed within a single-file
[Bolthold](https://github.com/timshannon/bolthold) database; any file objects
pointed to reside on your filesystem.

> **Note**: Source is not yet available; this README is a bit of a spec document
> while I sketch out the app basics (at time of writing, approaching mid-May in
> the pandemic year of 2020). Currently there's not much to see here except for
> a possibly useful `Makefile` and `package.json` showing Go code reloading and
> Tailwind CSS  
> processing.

## Installation

Install the `noter` binary (and source) with:

    go get github.com/solutionroute/noter/... 

Explore within.

## Running Noter

    # Example Command line:
    NOTER_PORT=1234 noter

The application is configured using using zero or more of the following
enviroment variables:

    # Supported environment variables showing defaults:
    NOTER_HOST = 0.0.0.0
    NOTER_PORT = 8080
    NOTER_DBPATH = /home/$(USER)/.noter/noter.db
    NOTER_FILEPATH = /home/$(USER)/.noter/files
    NOTER_STATIC = = /home/$(USER)/go/src/github.com/solutionroute/noter/http/static
    NOTER_TEMPLATES = /home/$(USER)/go/src/github.com/solutionroute/noter/http/templates
    NOTER_SECRET = YouWouldChangeThIsOfCourse

There is only one command line argument:

    noter -h        # prints the available environment variables

## Customizing Noter Templates

Noter's default HTML templates are Go's `html/template` and are
overridable/customizable. The CSS styling utilizes
[Tailwind CSS](https://tailwindcss.com/) *utility-first* approach. The project's
`package.json` and Makefile should make it easy to install any dependencies and
build a custom CSS.

Noter assumes the app is installed in your GOPATH and will access its html
templates there by default. Simply copy all of these to your own "theme"
directory and point to your customized set by setting the NOTER_TEMPLATES
environment variable.

* TODO: Allow for simple theming where one or more user-provided html-templates
  will be used in preference over the stock template.

## Forking or Modifying Noter

You'll possibly need to update dependencies.

    # cd noter
    go mod tidy

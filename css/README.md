# noter/css

This directory contains CSS source files that are processed by our CSS toolchain -
see package.json and Makefile for details.

To produce a maximal noter.css containing all Tailwind (and any custom) CSS styles:

    make cssmax

The resulting CSS output is located in `noter/http/static`.

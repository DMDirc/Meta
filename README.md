DMDirc
================================================================================

DMDirc is an IRC client written in Java. It's cross-platform, hugely
configurable, and is easily extensible with a robust plugins system.

This repository doesn't actually contain the source for DMDirc. Instead it's
split over four different components, each with their own repository:

* [client](https://github.com/DMDirc/client):
  contains the main guts of the client
* [parser](https://github.com/DMDirc/parser):
  an interface for parsers and a full IRC parser
* [plugins](https://github.com/DMDirc/plugins):
  official plugins, including the main UI
* [util](https://github.com/DMDirc/util):
  general purpose utility classes not directly related to IRC

Each of the repositories can be worked on and built independently of all the
others (and we've paid particular care to make sure the parser and util projects
can be dropped in to other applications with the minimum of fuss).  If you
actually want to develop the client, though, it's a lot easier if they're all
together — that's what this repository is for! Each of the components mentioned
above is included as a submodule, and there are some handy top-level build
scripts for bundling everything together.

Getting Started
--------------------------------------------------------------------------------

First off, clone this repository and init the submodules:

    git clone https://github.com/DMDirc/Meta.git
    cd Meta
    git submodule update --init --remote

You can then use the provided gradle wrapper to start a build, or run all the
tests in the project:

    ./gradlew jar
    ./gradlew test

[Currently the gradle scripts do not generate a functioning client... we're
 working on that still!]

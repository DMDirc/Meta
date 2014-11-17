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

### Project set up

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

### Using an IDE

We strongly recommend using [IntelliJ IDEA](http://www.jetbrains.com/idea/).
There are project files available in this repository which will load all of the
subprojects properly, and configure IDEA with our preferred code style,
license headers, etc. Simply tell IDEA to open a new project, and select the
directory this repository is checked out to.

Contributing and Continuous Integration
--------------------------------------------------------------------------------

We welcome pull requests on GitHub for all the DMDirc repositories. The tests
for the module will run on CircleCI, and the pull request will be updated with
the result.

Please bear in mind that these are just unit tests for the individual modules —
they don't test how your change will affect DMDirc itself. It's good practice
to run all of the tests in the project and compile and run an actual client to
make sure everything actually still works!

The current CI status for the major projects are shown below:

| Project | Status                                                              |
|---------|---------------------------------------------------------------------|
| Meta    | [![Circle CI](https://circleci.com/gh/DMDirc/Meta.png?style=badge)](https://circleci.com/gh/DMDirc/Meta) |
| Client  | [![Circle CI](https://circleci.com/gh/DMDirc/DMDirc.png?style=badge)](https://circleci.com/gh/DMDirc/DMDirc) |
| Parser  | [![Circle CI](https://circleci.com/gh/DMDirc/Parser.png?style=badge)](https://circleci.com/gh/DMDirc/Parser) |
| Plugins | [![Circle CI](https://circleci.com/gh/DMDirc/Plugins.png?style=badge)](https://circleci.com/gh/DMDirc/Plugins) |
| Util    | [![Circle CI](https://circleci.com/gh/DMDirc/Util.png?style=badge)](https://circleci.com/gh/DMDirc/Util) |

Miscellaneous
--------------------------------------------------------------------------------

### Running Clover

Clover is disabled by default as it requires a license file we can't distribute.
When running clover tasks, the build script will try and download our license
from a private webserver. If your IP isn't whitelisted you will need to supply
a username/password.

To enable clover, set the enableClover property to true value:

    ./gradlew -PenableClover=true cloverAggregateReports

This will place a HTML report in `build/reports/clover/html`.

### Dependencies

All cross-repository dependencies are specified as artifacts, rather than
project dependencies. That means if (say) the client is compiled on its own,
it will pull snapshot versions of the parser and util modules from our maven
repository.

The meta repository includes a gradle build script that finds these dependencies
and replaces them with project links instead. This ensures that while developing
the client your changes are reflected across modules properly.

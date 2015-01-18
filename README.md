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

### Prerequisites

To build and run the DMDirc client, you will need to have **Java 8** or greater.
DMDirc will work with either the Oracle JDK or Open JDK. All other dependencies
are downloaded by the build scripts automatically.

### Project set up

First off, clone this repository and init the submodules:

    git clone https://github.com/DMDirc/Meta.git
    cd Meta
    git submodule update --init --remote

You can then use the provided gradle wrapper to start a build, or run all the
tests in the project:

    ./gradlew jar
    ./gradlew test

### Using an IDE

We strongly recommend using [IntelliJ IDEA](http://www.jetbrains.com/idea/).
There are project files available in this repository which will load all of the
subprojects properly, and configure IDEA with our preferred code style,
license headers, etc. Simply tell IDEA to open a new project, and select the
directory this repository is checked out to.

### Running the client

Once you have executed `./gradlew jar`, a copy of the client jar will be placed
in `client/dist` and all of the plugins will be collected in `plugins/dist`. For
development work, it is often easiest to symlink the `plugins` directory from
your DMDirc profile to the dist directory in the source tree. This ensures the
latest plugins are always used.

For convenience a skeleton profile is located in `etc/profile` in this
repository, and includes a symlink to the correct plugins directory. To run the
client using this profile, use the `-d` option:

    java -jar DMDirc.jar -d path/to/etc/profile

Contributing
--------------------------------------------------------------------------------

### Contributing changes

We welcome pull requests on GitHub for all the DMDirc repositories. The tests
for the module will run on CircleCI, and the pull request will be updated with
the result.

Please bear in mind that these are just unit tests for the individual modules —
they don't test how your change will affect DMDirc itself. It's good practice
to run all of the tests in the project and compile and run an actual client to
make sure everything actually still works!

You can see an overview of open pull requests across all of the DMDirc projects [here](https://github.com/pulls?q=is%3Aopen+is%3Apr+user%3Admdirc).

### Continuous Integration and Code Coverage

The current CI and coverage status for the major projects are shown below:

| Project | Status | Coverage |
|:-------:|:------:|:--------:|
| Meta    | [![Circle CI](https://circleci.com/gh/DMDirc/Meta.png?style=badge)](https://circleci.com/gh/DMDirc/Meta) | (No code) |
| Client  | [![Circle CI](https://circleci.com/gh/DMDirc/DMDirc.png?style=badge)](https://circleci.com/gh/DMDirc/DMDirc)  | [![Coverage Status](https://img.shields.io/coveralls/DMDirc/DMDirc.svg)](https://coveralls.io/r/DMDirc/DMDirc?branch=master) |
| Parser  | [![Circle CI](https://circleci.com/gh/DMDirc/Parser.png?style=badge)](https://circleci.com/gh/DMDirc/Parser)  | [![Coverage Status](https://img.shields.io/coveralls/DMDirc/Parser.svg)](https://coveralls.io/r/DMDirc/Parser?branch=master) |
| Plugins | [![Circle CI](https://circleci.com/gh/DMDirc/Plugins.png?style=badge)](https://circleci.com/gh/DMDirc/Plugins) | [![Coverage Status](https://img.shields.io/coveralls/DMDirc/Plugins.svg)](https://coveralls.io/r/DMDirc/Plugins?branch=master) |
| Util    | [![Circle CI](https://circleci.com/gh/DMDirc/Util.png?style=badge)](https://circleci.com/gh/DMDirc/Util) | [![Coverage Status](https://img.shields.io/coveralls/DMDirc/Util.svg)](https://coveralls.io/r/DMDirc/Util?branch=master) |

### Issues

We track issues in each of the separate projects listed above (for example,
issues with the IRC parser are raised in the 'parser' repository; issues
with the Swing UI are raised in the 'plugins' repository). If you are unsure
where to raise an issue, feel free to raise it in Meta (this repository) and
we'll relocate it accordingly.

You can see an overview of open issues across all of the DMDirc projects
[here](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Admdirc).

Miscellaneous
--------------------------------------------------------------------------------

### Running Clover

Clover is disabled by default as it requires a license file we can't distribute.
If you have a Clover license, or have access to DMDirc's license, place it in
etc/clover/clover.license.

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

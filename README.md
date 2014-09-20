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
license headers, etc. Simply open the `dmdirc.iml` file with IDEA to get going.

Contributing
--------------------------------------------------------------------------------

### Client, Parser and Plugin repositories

At present, we use Gerrit to perform code reviews for most of our repositories.
This is tied fairly heavily into our continuous integration infra-structure.
To push a change to Gerrit you'll need an account created by an admin - the
easiest way to do that is to pop in to
[#DMDirc on Quakenet](irc://quakenet.org/DMDirc) and we'll help you out. Once
you have an account, the easiest way to push is to install the
[git-review](https://github.com/openstack-infra/git-review) tool. You then
simply change to a directory and use git-review:

    cd client
    git review
    > remote: Resolving deltas: 100% (6/6)
    > remote: Processing changes: new: 1, refs: 1, done
    > remote:
    > remote: New Changes:
    > remote:   http://gerrit.dmdirc.com/12345
    > remote:
    > To ssh://user@dmdirc.com:29418/client
    > * [new branch]      HEAD -> refs/publish/master

### Meta and Util repositories

For this repository and the util repository we welcome pull requests on GitHub.
The tests for the module will run on Travis CI, and the pull request will be
updated with the result.

Please bear in mind that these are just unit tests for the individual modules —
they don't test how your change will affect DMDirc itself. It's good practice
to run all of the tests in the project and compile and run an actual client to
make sure everything actually still works!

Miscellaneous
--------------------------------------------------------------------------------

### Running Clover

Clover is disabled by default as it requires a license file we can't distribute.
When running clover tasks, the build script will try and download our license
from a private webserver. If your IP isn't whitelisted you will need to supply
a username/password.

To enable clover, set the enableClover property to a true-ish value:

    ./gradlew -PenableClover=1 cloverAggregateReports

This will place a HTML report in `build/reports/clover/html`.

### Dependencies

All cross-repository dependencies are specified as artifacts, rather than
project dependencies. That means if (say) the client is compiled on its own,
it will pull snapshot versions of the parser and util modules from our maven
repository.

The meta repository includes a gradle build script that finds these dependencies
and replaces them with project links instead. This ensures that while developing
the client your changes are reflected across modules properly.
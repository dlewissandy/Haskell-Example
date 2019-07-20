# HASKELL-EXAMPLE

This package contains a working example of a simple haskell package that contains 
a library, an executable and a test suite.  

The library exposes two functions *isSorted* and *qsort*.   The first is a predicate
that tests if a list is in ascending standard order, while the second is an
implementation of the quicksort algorithm.  The source code for the library is 
in the "src" folder.

The executable imports the example library and sorts a hardcoded list of 
integers.   If the resulting list is ascending order then it prints a friendly
message.  The source code for the executable is in the "exec" folder.

The test suite imports the library and uses quick check to verify some 
universal properties of the qsort function.   The source code for the test 
code is in the "test" folder.

## Build Configuration
The haskell-example.cabal file contains the package description.  This enumerates
the different build targets (library, executable and test-suites).  For more 
details on the syntax of this file, consult: https://www.haskell.org/cabal/users-guide/developing-packages.html

I prefer to use haskell stack to build.   This requires a little extra 
configuration, but has the benefit that I have a
managed set of packages that I know work together.  The stack.yaml file 
contains the additional configuration information.

## Building Using Docker (recommended)
I have configurated a multi-stage docker file that builds the library 
and executable, then if the unit tests pass, creates a docker image
suitable for deployment.  To build the docker image, run the following
command from within the project's folder:

docker build -t haskell-example .

Once the image has been built, then you can run the program inside
the docker container with the following command:

docker run -ti haskell-example

## Building Using Stack 
If you want to build and test the program "on-the-metal", you can 
do this by installing the command line haskell stack tool.   To 
build, execute the following command from within the project's folder:

stack build --system-ghc

This will use whatever version of ghc you have locally installed, 
rather than creating isolated installations of ghc, but will still
use the managed collection of packages in the stackage datbase

## Building using Cabal (Here be Dragons)
You can stil build this using the legacy cabal build tool, but be warned.
Cabal will attempt to resolve the version of each dependency and 
can end up in "dependency hell".   If you are going to use cabal, you
should explicitly state the version of each dependency that you are 
using to avoid this problem.   The commands below will build and test
the executable using cabal:

cabal build && cabal test




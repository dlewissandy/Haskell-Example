# BUILD THE LIBRARY AND EXECUTABLE USING THE LATEST STACK
# TOOLCHAIN
FROM fpco/stack-build:lts-13.28 as build
RUN mkdir /opt/build
COPY . /opt/build
RUN cd /opt/build && stack build --system-ghc

# TEST THE CODE THAT WAS BUILT IN THE BUILD STAGE. 
FROM build as test
WORKDIR /opt/build
RUN cd /opt/build && stack test --system-ghc

# SETUP AN UBUNTU CONTAINER FOR DEPLOYMENT.   THIS WILL COPY THE 
# EXECUTABLE(S) FROM THE BUILD STAGE SO WE DON'T GET ANY CRUFT THAT
# WAS INSTALLED DURING TESTING.
FROM ubuntu:18.04 as exec
RUN mkdir -p /opt/myapp
WORKDIR /opt/myapp
RUN apt-get update && apt-get install -y \
  ca-certificates \
  libgmp-dev
# COPY THE EXECUTABLE FROM THE BUILD IMAGE TO THIS ONE.
COPY --from=build /opt/build/.stack-work/install/x86_64-linux/*/8.6.5/bin .
# SET THE CONTAINER UP TO RUN THE EXECUTABLE BY DEFAULT WHEN IT IS STARTED
CMD ["/opt/myapp/example"]
# Diagnose dotnet apps inside running container.

These files reside in https://github.com/he2s/tracing and the Docker image is also available as dsfnctnl/tracing:<VERSION_TAG>.

The 'build.sh' needs a version tag as suffix for the built Docker image as the only parameter and will do weird stuff with less or more than one parameter.

Example:

```bash
./build.sh 0.1    # Please just use alphanumeric characters or a dot.
```

The 'run.sh' script needs a container hash or name as a target and the version tag of the used tracing container, in that order. Like so:

```bash
./run.sh aspnetcoreapp 0.1
```

The same goes for 'pull.sh' and 'push.sh' whoch will, provided with a version tag push or pull images from a specified repo on the Docker Hub.

Links or info about the used tools are generally found [here](https://docs.microsoft.com/en-us/dotnet/core/diagnostics) or by googling for 'dotnet-trace', 'dotnet-counters', 'dotnet-dump', 'dotnet-gcdumop', 'lldb sos dotnetcore', 'PerfView' or such words. Names that are important in that domain are Damian Edwards, David Fowler, Ben Adams, Vance Morrison, Adam Sitnik, Matt Warren, Mike Rousos. Podcasts, blog posts and talks of those people on YouTube might be relevant.

Further info also [here](https://docs.microsoft.com/en-us/dotnet/core/diagnostics/debug-memory-leak).

This list will be extended as time goes by.

# Diagnose dotnetcore apps inside running container.

This repo contains tooling to generate and use a docker image to diagnose issues in containers running dotnet core apps.

These files reside in https://github.com/he2s/dotnetcore-tracing and the Docker image is also available as dsfnctnl/dotnetcore-tracing:<VERSION_TAG>.

Generally you will take the 'build.sh' script to build am image from the 'Dockerfile'. This Dockerfile may be extended as you wish. Then you push and pull the images from their repo. If a not customized image already present in the repo, like the '1.0' version is sufficient, just pull it, omitting the build step.

Then you run via 'run.sh'. The container will share resources with the target container under test and will run with elevated privileges (!). Inside the running shell inside the tracing container there are several tools available.

## Scripts and tooling

The 'build.sh' needs a version tag as suffix for the built Docker image as the only parameter and will do weird stuff with less or more than one parameter.

Example:

```bash
./build.sh 0.1    # Please just use alphanumeric characters or a dot.
```

The 'run.sh' script needs a container hash or name as a target and the version tag of the used tracing container, in that order. Like so:

```bash
./run.sh aspnetcoreapp 0.1    # Here you should should also provide the repo (currently 'dsfnctnl/'), if just 'dotnetcore-tracing' (in the script) and your provided tag does give an error.
```

The same goes for 'pull.sh' and 'push.sh' which will, provided with a version tag push or pull images from the said repo on the Docker Hub.

## Performance tools

### dotnet core diagnostics tools

Links or info about the used tools are generally found [here](https://docs.microsoft.com/en-us/dotnet/core/diagnostics) or by googling for 'dotnet-trace', 'dotnet-counters', 'dotnet-dump', 'dotnet-gcdumop', 'lldb sos dotnetcore', 'PerfView' or such words. Names that are important in that domain are Damian Edwards, David Fowler, Ben Adams, Vance Morrison, Adam Sitnik, Matt Warren, Mike Rousos. Podcasts, blog posts and talks of those people on YouTube might be relevant.

This only works with apps run on CoreCLR 3.1!

Here is one example 'session':

```bash
dotnet counters ps                 # Returning the PIDs of any running dotnet core processes. Usually this will just be '1'.
dotnet counters monitor -p 1       # View live some perf counters (like GC, threads, ...) of PID 1.
dotnet gcdump collect -p 1         # Generate GC dump of PID 1 in the current working directory. The filename is then displayed.
dotnet trace collect -p 1          # Collect traces of PID 1 in the current working directory. This file will be called 'trace.nettrace' and can be read by 'PerfView.exe' on Windows.
mv trace.nettrace /tracing-port    # Copy the generated tarce file to '/port', which is already mounted to the host filesystem's '/tracing-port'. From there you can fetch it to Windows.
# ....
```

More info is also [here](https://docs.microsoft.com/en-us/dotnet/core/diagnostics/debug-memory-leak) or [here](https://devblogs.microsoft.com/dotnet/collecting-and-analyzing-memory-dumps/).

### LLDB, SOS

The tooling around lldb does currently not work correctly as far as SOS is concerned. Hints: [1](https://github.com/dotnet/diagnostics/blob/master/documentation/installing-sos-instructions.md), [2](https://devblogs.microsoft.com/premier-developer/debugging-net-core-with-sos-everywhere/), [3](https://www.raydbg.com/2018/Debugging-Net-Core-on-Linux-with-LLDB/), [4](https://github.com/dotnet/diagnostics/blob/master/documentation/debugging-coredump.md).

### Miscellaneous

'htop' is available in version 3.0.0beta5, including support for some new OS/CPU performance counters. Further info is at [the developer's page](https://hisham.hm/htop/). Generally you can tab between tabs via TAB, until you are shown the performance counters pane. You then can customize the shown values by pressing F2 and then 'Categories/Screens->Screens/Perf Counters->Active Columns/...'.

Performance counters are also provided by the 'tiptop' tool, a top like display of the processes sorted by IPC, cache misses, etc.

Also included is the perfcollect script from Microsoft which runs some installations of Linux performance tools including the perf-tools and collects data to be shown in the Windows based PerfView.exe. More on this by googling 'perfcollect', 'perfview' or 'vance morrison'.

Sadly perf is currently not possible on some devices.

Also provided is Microsoft's brand new Linux port of ProcDump. See [here](https://github.com/Microsoft/ProcDump-for-Linux).

This list will be extended as time goes by.

General info is also found [here](http://www.brendangregg.com/linuxperf.html).

# Collectd

## Quick Start

```bash
# start collectd
docker run --privileged --net="host" -v "/:/mnt/root" -v /etc:/mnt/etc:ro -v /dev:/mnt/dev:ro -v /proc:/mnt/proc:ro --name collectd erwinnttdata/collectd:5.4.1-6_deb8u1_001
```

## Description

Collectd as a docker container. It have to run in privileged mode to access the
host `/proc` directory. The system directories from the host need to be
mounted for the container. Additional directories can be mounted to `/mnt`
for the `df` plugin.

## Volumes

* `/mnt/collectd`

## Build

The build and deployment can be started by using the included `Makefile` 
build file.

```bash
# Build the Docker image.
make build
# Deploy the Docker image.
make deploy DOCKER_HUB_USER=user DOCKER_HUB_PASSWORD='password'
```

To test the build locally, the included `Makefile` also have the goals

* `test-collectd`
  Starts the build collectd image.

* `test-collectd-bash`
  Executes bash inside the container.

```bash
make test-collectd
# or,
make test-collectd-consul
# or,
make test-collectd-bash
```

It depends on an installed Graphite with Carbon instance and uses the write-graphite
plugin configured in `test-graphite/write_graphite.conf`. The host needs to be
updated to the real host in the configuration file.

## Credits

Inspired by [signalfx/docker-collectd](https://github.com/signalfx/docker-collectd)

# License

*The MIT License (MIT)*

Copyright (c) 2016 Erwin Müller, erwin.mueller@nttdata.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

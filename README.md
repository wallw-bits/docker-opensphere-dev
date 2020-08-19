# OpenSphere Docker Development

This provides an environment to do OpenSphere builds through Docker.


## Setup

On the host:

    docker build -t opensphere-dev:latest .
    cd /path/to/opensphere-yarn-workspace
    docker run -it --rm -v $(pwd):/yarn-workspace -w /yarn-workspace opensphere-dev

Once in Docker:

    yarn upgrade
    cd workspace/opensphere
    yarn build

Note that this image does not currently serve the application, it only serves to run builds.

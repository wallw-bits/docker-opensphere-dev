# OpenSphere Docker Development

This provides an environment to do OpenSphere builds through Docker.


## Setup

On the host:

    docker build -t opensphere-dev:latest .
    cd /path/to/opensphere-yarn-workspace
    docker run -it --rm \
      -e LOCAL_USER_ID=$(id -u $USER) \
      -v $(pwd):/yarn-workspace \
      -w /yarn-workspace \
      opensphere-dev

You should also consider mounting a docker volume or local folder as `/yarn-cache` so that the yarn cache is preserved between runs.

Once in Docker:

    yarn install # the first time; subsequently 'yarn upgrade'
    cd workspace/opensphere
    yarn build
    yarn test

Note that this image does not currently serve the application, it only serves to run builds.

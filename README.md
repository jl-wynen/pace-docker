# Pace Neutrons Docker Image

This repo contains a Dockerfile for building a Docker image for working with Pace Neutrons on a machine that cannot natively run MATLAB.
The image contains:
- MATLAB Runtime
- Mount of a directory on the host
- Python environment with Jupyter and a package from the host

## Usage

Clone the repo and `cd` into it.

### Configuration

Edit `docker-compose.yaml` by following the comments in that file.
Most importantly, you have to specify a directory of a Python project in the `source` in the `volumes` array.
Additionally, you must specify the UID and GID of the host user that owns the project directory.
You can find them by running the `id` command.

### Launching

Run
```bash
docker compose up --build
```
This will build the image if necessary and start a container.
When the container is up, it will run Jupyter lab in a virtual environment that contains your project and any other dependencies you specified. 

Note that this will take several minutes the first time you call it.
It needs to download and install the MATLAB runtime in the image.

### Connecting to Jupter

Click the link shown on the terminal to connect to Jupyter in a browser.
When `JUPYTER_TOKEN` is set in `docker-compose.yaml`, you need to specify that token in the browser.

## Caveats

The container uses the host network.
So the Jupyter server is directly accessible like when running it natively.
This is convenient and should play nice with other Jupyter instances.
But I make no guarantees.

The container has write access to the project directory.
Further, it has an editable installation of the project as a Python package (`pip install -e .`).
So be careful about modifications.

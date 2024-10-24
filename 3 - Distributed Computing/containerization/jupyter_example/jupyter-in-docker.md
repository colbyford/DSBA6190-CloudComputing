# Run Jupyter Lab in Docker


## Pull desired Docker image

```bash
docker pull jupyter/datascience-notebook
```

## Run the image

```bash
docker run -v ./:/data -p 8888:8888 --gpus all --name jupyter jupyter/datascience-notebook
```

Flags:
- -v: Mount current working directory "./" to "/data" in the container
- -p: Forwards localhost:8888 to port 8888 in the container
- --gpus: Enables the usage of GPUs (note that the image also needs to have the CUDA drivers to work)
- --name: The friendly name of the container running locally
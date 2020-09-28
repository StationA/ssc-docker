# ssc-docker

Docker images with prebuilt SAM Simulation Core (SSC) libraries, supporting:

- Alpine
- Ubuntu

## Building

```
docker build -t stationa/ssc:<alpine|ubuntu> -f Dockerfile.<alpine|ubuntu> .
```

## Running

```
docker run -it stationa/ssc:<alpine|ubuntu>
```

## Contributing

When contributing to this repository, please follow the steps below:

1. Fork the repository
1. Submit your patch in one commit, or a series of well-defined commits
1. Submit your pull request and make sure you reference the issue you are addressing

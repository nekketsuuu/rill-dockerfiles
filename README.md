## About

This repository contains some [Docker](https://www.docker.com/) container definitions for [Rill programming language](https://github.com/yutopp/rill).

## Containers

| Rill Version | Command |
|:-------------|:--------|
| [2c2e05e](https://github.com/yutopp/rill/commit/2c2e05e5a772d5f6f9d2ce49b861fae283d15082) | `docker pull nekketsuuu/rill:2c2e05e` |

## Usage

``` bash
docker run -it --rm rill bash  # Note: Sometimes `sudo` is required.
```

In the container, you can use `rillc`. For example,

``` bash
# In the container...
rillc ~/rill/examples/fizzbuzz.rill -o a.out
./a.out
```

### Use the Container as a Compiler

You can use this container as a Rill compiler by using the following function on bash.

``` bash
rillc () {
    local args="$@" ;
    docker run --rm -u $(id -u):$(id -g) -v $(pwd):/code rill:latest bash -c "cd /code && rillc $args"
}
```

Example:

``` bash
cd rill/examples && rillc fizzbuzz.rill -o a.out
```

## Local Build

To build a docker container locally, run

``` bash
docker build -t rill:test .
docker run -it --rm rill:test bash
```

## Contributing

Feel free to make an issue or a pull-request!

## Maintainer

[nekketsuuu](https://github.com/nekketsuuu)
# [Salmefelt](https://www.salmefelt.com)

## Requirements
`make` - I have GNU Make 3.81 installed.

`npm >5.2.0` - Comes with `npx`, which is used in the Makefile.

`node >12.13.0` - Used to generate elm files from json.

`elm 0.19.1`

`ImageMagick` - Used to optimize images. I have version 7.0.9-16 installed.

## Run
``` bash
# Generate translations and optimize imges
make generate

# Run development server
make develop
```

## Build
```
make build
```
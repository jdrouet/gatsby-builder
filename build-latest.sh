#!/bin/bash

PLATFORM=linux/arm/v7,linux/arm64/v8,linux/amd64

BASE_VERSION=latest
GATSBY_VERSION=$(docker run --rm node:lts-buster npm view gatsby version)
GATSBY_IMAGE_VERSION=$(docker run --rm node:lts-buster npm view gatsby-image version)
GATSBY_PLUGIN_SHARP_VERSION=$(docker run --rm node:lts-buster npm view gatsby-plugin-sharp version)
GATSBY_TRANSFORMER_SHARP_VERSION=$(docker run --rm node:lts-buster npm view gatsby-transformer-sharp version)

IMAGE_TAG=${BASE_VERSION}-${GATSBY_VERSION}-${GATSBY_IMAGE_VERSION}-${GATSBY_PLUGIN_SHARP_VERSION}-${GATSBY_TRANSFORMER_SHARP_VERSION}

docker buildx build --push \
  --build-arg GATSBY_VERSION=${GATSBY_VERSION} \
  --build-arg GATSBY_IMAGE_VERSION=${GATSBY_IMAGE_VERSION} \
  --build-arg GATSBY_PLUGIN_SHARP_VERSION=${GATSBY_PLUGIN_SHARP_VERSION} \
  --build-arg GATSBY_TRANSFORMER_SHARP_VERSION=${GATSBY_TRANSFORMER_SHARP_VERSION} \
  --platform ${PLATFORM} \
  --tag jdrouet/gatsby-builder:latest \
  --tag jdrouet/gatsby-builder:${IMAGE_TAG} \
  .

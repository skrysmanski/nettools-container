# Network Tools Container

This container provides various network tools that can be used to diagnose network problems.

This image is available both for x64 (amd64) and ARM (arm64).

## Kubernetes

To use this image in Kubernetes, use:

```sh
kubectl run nettools-pod -it --rm --image=ghcr.io/skrysmanski/nettools
```

If you need to run this image on a specific node, use:

```sh
kubectl run nettools-pod -it --rm --image=ghcr.io/skrysmanski/nettools --overrides='{ "apiVersion": "v1", "spec": { "nodeName": "<your-node-name>" } }'
```

## Docker

To use this image in Docker:

```sh
docker run -it --rm --name nettools ghcr.io/skrysmanski/nettools
```

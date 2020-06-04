# To build the base image

* Remove current image if exists. Note you might need to remove iamges/containers depending on this image:
  `docker image ls`
  `docker image rm kfrajer/hugo`
* Run `docker build -t kfrajer/hugo:v0.71.1 -f Dockerfile.base .`
* `docker image tag kfrajer/hugo:v0.71.1 kfrajer/hugo:latest`
* `docker login`
* `docker image push kfrajer/hugo:v0.71.1`
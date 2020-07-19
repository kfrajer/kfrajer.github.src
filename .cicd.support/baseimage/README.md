# To build the base image

* Remove current image if exists in current image list in local machine. 
  Note you might need to remove containers first currently using this image.  
  - `docker image ls`
  - `docker image rm kfrajer/hugo`
* Build image, tag it and push it to DockerHub:
  - `docker build -t kfrajer/hugo:v0.71.1 -f Dockerfile.base .`
  - `docker image tag kfrajer/hugo:v0.71.1 kfrajer/hugo:latest`
  - `docker login`
  - `docker image push kfrajer/hugo:v0.71.1`
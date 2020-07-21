# conda-quantlib
Jupyter Lab notebook with Quantlib Docker image for x86_64 platform

- Used [docker-anaconda](https://hub.docker.com/r/continuumio/anaconda3) as a base image.
- [Quantlib](https://anaconda.org/domosute/quantlib-python) and [Quantlib-Python](https://anaconda.org/domosute/quantlib) are pulled from [here](https://anaconda.org/domosute/repo).
----
## Confirmed Environment
```
[root@srv ~]# rpm -q centos-release
centos-release-7-8.2003.0.el7.centos.x86_64
[root@srv ~]# docker -v
Docker version 19.03.12, build 48a66213fe
[root@srv ~]# docker-compose -v
docker-compose version 1.26.2, build eefe0d31
```

## How to Run the Image
1. clone this repository.
```
[root@srv opt]# git clone https://github.com/domosute/conda-quantlib.git
```
2. Enter the pulled directory and run `docker-compose` command to build.
```
[root@srv conda-quantlib]# docker-compose build
```
3. Once image is created run it.
```
[root@srv conda-quantlib]# docker-compose up -d
```
4. From browser, Access to `http://host:9999`.  Use `jupyter` as a password for the first time.
5. To stop the server, run the following.
```
[root@srv conda-quantlib]# docker-compose down
```

## How to Build Quantlib Related Package

1. Bring up the docker container.
```
[root@srv conda-quantlib]# docker-compose up -d
```

2. Enter into the running container.
```
[root@srv conda-quantlib]# docker exec -it conda-quantlib /bin/bash
jupyter@xxxxxxxxxxxx:~$ sudo su
root@xxxxxxxxxxxx:/home/jupter# cd /opt
root@xxxxxxxxxxxx:/opt#
```

3. Clone this repository.
```
root@xxxxxxxxxxxx:/opt# git clone https://github.com/domosute/conda-quantlib.git
```

4. Build Quantlib package first. (Change meta.yaml file accordingly.)
```
root@xxxxxxxxxxxx:/opt# cd quantlib
root@xxxxxxxxxxxx:/opt# export PREFIX=/opt/conda
root@xxxxxxxxxxxx:/opt# export LD_LIBRARY_PATH=/opt/conda/lib
root@xxxxxxxxxxxx:/quantlib# conda build .
```

5. Once build process is finished, upload Quantlib package into Anaconda Cloud.
```
root@xxxxxxxxxxxx:/opt# anaconda upload /opt/conda/conda-bld/linux-64/quantlib-<version>.tar.bz2
```

6. Install Quantlib from Anaconda Cloud
```
root@xxxxxxxxxxxx:/opt# conda install -c <Anaconda Cloud handle name> quantlib
```

7. Update system link and cache
```
root@xxxxxxxxxxxx:/opt# ldconfig
```

8. Build Quantlib-SWIG
```
root@xxxxxxxxxxxx:/opt# cd ../quantlib-python
root@xxxxxxxxxxxx:/opt# apt-get install dh-autoreconf
root@xxxxxxxxxxxx:/opt# conda build .
```

9. Once build process is finished, upload Quantlib-SWIG package into Anaconda Cloud.
```
root@xxxxxxxxxxxx:/opt# anaconda upload /opt/conda/conda-bld/linux-64/quantlib-python-<version>.tar.bz2
```

10. Install Quantlib-SWIG from Anaconda Cloud
```
root@xxxxxxxxxxxx:/opt# conda install -c <Anaconda Cloud handle name> quantlib-python
```

11. Exit out, close the running container.
```
root@xxxxxxxxxxxx:/opt# exit
jupyter@xxxxxxxxxxxx:/opt$ exit
[root@srv conda-quantlib]# docker-compose down
```

12. Modify Dockerfile.

13. Rebuild
```
[root@srv conda-quantlib]# docker-compose build
```

14. Bring up the container back.


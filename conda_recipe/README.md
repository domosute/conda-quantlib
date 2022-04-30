## How to Build conda-based Quantlib Related Package (Quantlib, Quantlib-SWIG)

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

4. Create environment with specific python version (Example below is version 3.8)
```
root@xxxxxxxxxxxx:/opt# conda env create --name py3.08 python=3.8
(py3.08)root@xxxxxxxxxxxx:/opt/# export PREFIX=/opt/conda/envs/py3.08
(py3.08)root@xxxxxxxxxxxx:/opt/# export LD_LIBRARY_PATH=$PREFIX/lib
(py3.08)root@xxxxxxxxxxxx:/opt/# conda install -y -c conda-forge conda-build
(py3.08)root@xxxxxxxxxxxx:/opt/# conda install -y -c conda-forge gcc gxx gcc_linux-64 gxx_linux-64 automake autoconf binutils make
(py3.08)root@xxxxxxxxxxxx:/opt/# conda install -y -c conda-forge toolchain toolchain_c_linux-64 toolchain_cxx_linux-64 toolchain_fort_linux-64
```

5. Build Quantlib package first. (Change meta.yaml file accordingly.)
```
(py3.08)root@xxxxxxxxxxxx:/opt# cd /opt/conda-quantlib/conda_recipe/quantlib
(py3.08)root@xxxxxxxxxxxx:/quantlib# conda-build .
```

6. Once the build process is finished, upload Quantlib package into Anaconda Cloud.
```
(py3.08)root@xxxxxxxxxxxx:/quantlib# /opt/conda/bin/anaconda upload /opt/conda/conda-bld/linux-64/quantlib-<version>.tar.bz2
```

7. Install Quantlib from Anaconda Cloud
```
(py3.08)root@xxxxxxxxxxxx:/opt# conda install -c <Anaconda Cloud handle name> quantlib
```

8. Update the system link and cache
```
(py3.08)root@xxxxxxxxxxxx:/opt/# echo "/opt/conda/lib" > /etc/ld.so.conf.d/conda.conf
(py3.08)root@xxxxxxxxxxxx:/opt/# ldconfig
```

9. Build Quantlib-SWIG
```
(py3.08)root@xxxxxxxxxxxx:/opt# cd /opt/conda-quantlib/conda_recipe/quantlib-python
(py3.08)root@xxxxxxxxxxxx:/opt# conda-build .
```

10. Once build process is finished, upload Quantlib-SWIG package into Anaconda Cloud.
```
(py3.08)root@xxxxxxxxxxxx:/opt# anaconda upload /opt/conda/conda-bld/linux-64/quantlib-python-<version>.tar.bz2
```

11. Install Quantlib-SWIG from Anaconda Cloud
```
(py3.08)root@xxxxxxxxxxxx:/opt# conda install -c <Anaconda Cloud handle name> quantlib-python
```

12. Exit out, close the running container.
```
(py3.08)root@xxxxxxxxxxxx:/opt# conda deactivate
root@xxxxxxxxxxxx:/opt# exit
jupyter@xxxxxxxxxxxx:/opt$ exit
[root@srv conda-quantlib]# docker-compose down
```

13. Modify Dockerfile. (modify domosute with relevant Anaconda Cloud handle name)
```
# Install QuantLib related packages
/opt/conda/bin/conda install -y -c domosute quantlib quantlib-python
```

14. Rebuild the Docker image
```
[root@srv conda-quantlib]# docker-compose build
```

15. Bring up the container back.

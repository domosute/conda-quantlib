## How to Build Quantlib Related Package
1. Bring up the docker container.
2. Enter into the running container.
3. Clone this repository.
```
[root@srv opt]# git clone https://github.com/domosute/conda-quantlib.git
```
4. Build Quantlib package first. (Change meta.yaml file accordingly.)
```
[root@srv conda_recipe]# cd quantlib
[root@srv quantlib]# conda build .
```
5. Once build process is finished, upload Quantlib package into Anaconda Cloud.
```
[root@srv quantlib]# anaconda upload /opt/conda/conda-bld/linux-64/quantlib-<version>.tar.bz2
```
6. Install Quantlib from Anaconda Cloud
7. Update system link and cache
```
[root@srv quantlib]# ldconfig
```
8. Build Quantlib-SWIG
```
[root@srv quantlib]# cd ../quantlib-python
[root@srv quantlib-python]# conda build .
```
9. Once build process is finished, upload Quantlib-SWIG package into Anaconda Cloud.
10. Install Quantlib-SWIG from Anaconda Cloud

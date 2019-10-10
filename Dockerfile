FROM continuumio/anaconda3

USER root

RUN apt-get update && \
# Install apt Packages:
# Note: nodejs and npm is used for installing Jupyterlab spellchecker.
apt-get install -y sudo apt-utils nodejs npm && \
/opt/conda/bin/conda update -y --prefix /opt/conda conda && \
# Install Jupyter related Packages
/opt/conda/bin/conda install -y jupyter numpy pandas matplotlib bokeh ipyparallel && \
# Install PostgreSQL driver
/opt/conda/bin/conda install -y psycopg2 && \
# Installing samba related package
/opt/conda/bin/conda install -y -c conda-forge pysmbclient && \
# Installing numba related package
/opt/conda/bin/conda install -y -c numba numba && \
# Install QuantLib related Packages
/opt/conda/bin/conda install -y -c domosute quantlib quantlib-python

# Setup for Jupyter Notebook
RUN echo "export PATH=/opt/conda/bin:$PATH" > /etc/profile.d/conda.sh && \
cp /etc/profile.d/conda.sh /root/.bashrc && \
groupadd -g 1000 jupyter && \
useradd -g jupyter -m -s /bin/bash jupyter && \
mkdir /home/jupyter/notebook && \
echo "jupyter:jupyter" | chpasswd && \
echo "jupyter ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jupyter && \
chmod 0440 /etc/sudoers.d/jupyter && \
# Below file enable password access instead of token
echo "c.NotebookApp.token = 'jupyter'" > /home/jupyter/jupyter_notebook_config.py && \
# Enable IPython cluster
/opt/conda/bin/ipcluster nbextension enable && \
# Install Jupyterlab spellchecker
/opt/conda/bin/jupyter labextension install @ijmbarr/jupyterlab_spellchecker && \
# Conda clean up
/opt/conda/bin/conda clean -y --all


# Add shell script to start postfix and jupyter
COPY entrypoint.sh /usr/local/bin

EXPOSE 9999 9000 443
USER jupyter
WORKDIR /home/jupyter/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD []

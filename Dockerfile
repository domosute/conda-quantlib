FROM continuumio/anaconda3

USER root

RUN apt-get update && \
# Install apt Packages:
# Note: nodejs and npm is used for installing Jupyterlab spellchecker.
apt-get install -y sudo apt-utils nodejs npm && \
# Install Tex related package
apt-get install -y texlive-xetex texlive-fonts-recommended texlive-generic-recommended && \
# Install pandoc related packages
apt-get install -y pandoc poppler-utils
# Prep for Conda installation
# (4/4/2020: Solving environment: failed with initial frozen solve. Retrying with flexible solve. https://github.com/conda/conda/issues/9367)
RUN /opt/conda/bin/conda config --add channels conda-forge && \
/opt/conda/bin/conda config --set channel_priority false
# Update Conda and Package List
RUN /opt/conda/bin/conda update -y --prefix /opt/conda anaconda && \
/opt/conda/bin/conda update --all
# Install Jupyter related packages
RUN /opt/conda/bin/conda install -y jupyter numpy pandas matplotlib bokeh ipyparallel && \
# Install PostgreSQL driver
/opt/conda/bin/conda install -y psycopg2 && \
# Installing samba related packages
/opt/conda/bin/conda install -y -c conda-forge pysmbclient && \
# Installing numba related packages
/opt/conda/bin/conda install -y -c conda-forge numba && \
# Installing boost
/opt/conda/bin/conda install -y -c conda-forge boost libboost && \
# Install QuantLib related packages
# /opt/conda/bin/conda install -y -c domosute quantlib quantlib-python
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

FROM nvidia/cuda:11.2.0-cudnn8-runtime-ubuntu18.04 
# update
RUN apt-get -y update && apt-get install -y \
    build-essential \
    gcc \
    graphviz \
	libsm6 \
	libxext6 \
	libxrender-dev \
	libglib2.0-0 \
    libssl-dev \
    libffi-dev \
    libncurses5-dev \
    zlib1g \
    zlib1g-dev \
    libreadline-dev \
    libbz2-dev \
    libsqlite3-dev \
	make \
    sudo \
	wget \
	vim \
    unzip
#install python
WORKDIR /opt
# download python
RUN sudo apt-get -y install software-properties-common
RUN wget https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tar.xz && \
tar -xf Python-3.11.1.tar.xz && \
rm -f Python-3.11.1.tar.xz

# build
RUN cd Python-3.11.1 && \
sudo ./configure --enable-optimizations && \
sudo make altinstall 

# install pip
RUN sudo apt -y install python3-pip

# update pip and install pxackages
RUN python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install --upgrade scikit-learn && \
    python3.11 -m pip install opencv-python && \
    python3.11 -m pip install nibabel && \
    python3.11 -m pip install --upgrade plotly && \
    python3.11 -m pip install chart_studio && \
    python3.11 -m pip install jupyter-dash && \
    python3.11 -m pip install --upgrade "ipywidgets>=7.6" && \
    python3.11 -m pip install lightgbm && \
    python3.11 -m pip install xgboost && \
    python3.11 -m pip install graphviz && \
    python3.11 -m pip install catboost && \
    python3.11 -m pip install category_encoders && \
    python3.11 -m pip install hyperopt && \
    python3.11 -m pip install hpsklearn

RUN python3.11 -m pip install jupyterlab

WORKDIR /
RUN mkdir /work  

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]
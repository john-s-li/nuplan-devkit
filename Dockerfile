FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y curl gnupg2 software-properties-common default-jdk

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list \
    && add-apt-repository "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" \
    && apt-get update \
    && apt-get install -y \
    bazel \
    file \
    zip \
    nvidia-container-toolkit \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Download miniconda and install silently.
ENV PATH /opt/conda/bin:$PATH
RUN curl -fsSLo Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    conda clean -a -y

# Setup working environment
ARG NUPLAN_HOME=/nuplan_devkit
WORKDIR $NUPLAN_HOME

COPY requirements.txt requirements_torch.txt /nuplan_devkit/
RUN bash -c "python -m pip install --upgrade pip --pre && \
    pip install --no-cache-dir -r $NUPLAN_HOME/requirements_torch.txt -f https://download.pytorch.org/whl/torch_stable.html \
    pip install --no-cache-dir -r $NUPLAN_HOME/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html"

RUN mkdir -p $NUPLAN_HOME/nuplan

COPY setup.py $NUPLAN_HOME
COPY nuplan $NUPLAN_HOME/nuplan

RUN bash -c "pip install -e ."

ENV NUPLAN_MAPS_ROOT=/data/sets/nuplan/maps \
    NUPLAN_DATA_ROOT=/data/sets/nuplan \
    NUPLAN_EXP_ROOT=/data/exp/nuplan

RUN mkdir -p {$NUPLAN_MAPS_ROOT, $NUPLAN_DATA_ROOT, $NUPLAN_EXP_ROOT}

CMD ["/bin/bash"]

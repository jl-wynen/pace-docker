FROM ubuntu:24.04
LABEL authors="jan-lukas.wynen@ess.eu"

# Install dependencies.
RUN --mount=type=bind,source=dependencies.txt,target=dependencies.txt \
    export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --no-install-recommends --yes `cat dependencies.txt` \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Install MATLAB runtime
RUN wget https://ssd.mathworks.com/supportfiles/downloads/R2024b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2024b_Update_6_glnxa64.zip -O /tmp/MATLAB_Runtime.zip \
    && unzip -X -K /tmp/MATLAB_Runtime.zip -d /tmp/MATLAB_Runtime \
    && /tmp/MATLAB_Runtime/install -agreeToLicense yes \
    && rm -rf /tmp/MATLAB_Runtime.zip /tmp/MATLAB_Runtime

# Setup user
# User ID and group ID of the host user.
# Is assigned to the container user to give it write access to the project folder.
ARG HOST_UID
ARG HOST_GID
RUN --mount=type=bind,source=setup-user.sh,target=setup-user.sh \
    sh setup-user.sh ubuntu jovyan $HOST_UID $HOST_GID
USER jovyan
WORKDIR /home/jovyan

# Install uv
RUN wget -qO- https://astral.sh/uv/0.6.16/install.sh | sh

# [Optionally create venv], install packages, and launch Jupyter
COPY start-jupyter.sh /tmp/start-jupyter.sh
ENTRYPOINT ["bash", "/tmp/start-jupyter.sh", "/home/jovyan/project"]

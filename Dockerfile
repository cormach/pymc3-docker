# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# FROM mcr.microsoft.com/devcontainers/miniconda:3
FROM mambaorg/micromamba:1.3.1


# LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# # Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# # Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh &&

USER root

# RUN pip install "cryptography==38.0.4"

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

# RUN conda clean -i && rm -f ~/.condarc

# RUN mamba install -c conda-forge "pymc>=4"
# RUN apt-get update --yes && \
#     apt-get install --yes --no-install-recommends \
#     # for cython: https://cython.readthedocs.io/en/latest/src/quickstart/install.html
#     build-essential \
#     # for latex labels
#     cm-super \
#     dvipng \
#     # for matplotlib anim
#     ffmpeg && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# USER ${NB_UID}

# # Install Python 3 packages
# RUN mamba install --quiet --yes \
#     'altair' \
#     'beautifulsoup4' \
#     'bokeh' \
#     'bottleneck' \
#     'cloudpickle' \
#     'conda-forge::blas=*=openblas' \
#     'cython' \
#     'dask' \
#     'dill' \
#     'h5py' \
#     'ipympl'\
#     'ipywidgets' \
#     # Temporary fix for: https://github.com/jupyter/docker-stacks/issues/1851
#     'jupyter_server>=2.0.0' \
#     'matplotlib-base' \
#     'numba' \
#     'numexpr' \
#     'openpyxl' \
#     'pandas' \
#     'patsy' \
#     'protobuf' \
#     'pytables' \
#     'scikit-image' \
#     'scikit-learn' \
#     'scipy' \
#     'seaborn' \
#     'sqlalchemy' \
#     'statsmodels' \
#     'sympy' \
#     'widgetsnbextension'\
#     'xlrd' && \
#     mamba clean --all -f -y && \
#     fix-permissions "${CONDA_DIR}" && \
#     fix-permissions "/home/${NB_USER}"

# # Install facets which does not have a pip or conda package at the moment
# WORKDIR /tmp
# RUN git clone https://github.com/PAIR-code/facets.git && \
#     jupyter nbextension install facets/facets-dist/ --sys-prefix && \
#     rm -rf /tmp/facets && \
#     fix-permissions "${CONDA_DIR}" && \
#     fix-permissions "/home/${NB_USER}"

# # Import matplotlib the first time to build the font cache.
# ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

# RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
#     fix-permissions "/home/${NB_USER}"

# USER ${NB_UID}

# WORKDIR "${HOME}"

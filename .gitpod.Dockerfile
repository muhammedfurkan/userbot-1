FROM gitpod/workspace-full

RUN mkdir /tmp/kite && \
    curl -fsSL https://linux.kite.com/dls/linux/current > /tmp/kite/kite-installer.sh && \
    cd /tmp/kite && \
    chmod +x ./kite-installer.sh && \
    ./kite-installer.sh --download && \
    ./kite-installer.sh --install && \
    rm -rf /tmp/kite
    
    
LABEL dazzle/layer=lang-python
LABEL dazzle/test=tests/lang-python.yaml
USER gitpod
RUN sudo apt-get update && \
    sudo apt-get install -y python3-pip && \
    sudo rm -rf /var/lib/apt/lists/*
ENV PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
RUN curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && { echo; \
        echo 'eval "$(pyenv init -)"'; \
        echo 'eval "$(pyenv virtualenv-init -)"'; } >> /home/gitpod/.bashrc.d/60-python \
    && pyenv update \
    && pyenv install 3.9.0 \
    && pyenv global 3.9.0 \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install --upgrade \
        setuptools wheel virtualenv pipenv pylint rope flake8 \
        mypy autopep8 pep8 pylama pydocstyle bandit notebook \
        twine \
    && sudo rm -rf /tmp/*

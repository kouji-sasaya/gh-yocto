FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Yocto build dependencies and development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Yocto essential packages
    gawk wget git diffstat unzip texinfo gcc g++ build-essential \
    chrpath socat python3 python3-pip python3-pexpect \
    python3-git python3-jinja2 \
    libegl1 libsdl2-dev xterm python3-subunit \
    zstd liblz4-tool \
    # Additional useful tools
    locales sudo curl ca-certificates \
    # Neovim
    neovim \
    # Additional build tools
    file lz4 iputils-ping pylint \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create symbolic links for vim and vi to neovim
RUN ln -sf /usr/bin/nvim /usr/bin/vim && \
    ln -sf /usr/bin/nvim /usr/bin/vi

# Create a non-root user for development
ARG USERNAME=yocto
ARG USER_UID=1000
ARG USER_GID=1000

RUN (groupadd --gid ${USER_GID} ${USERNAME} 2>/dev/null || \
    (getent group ${USER_GID} >/dev/null && groupmod -n ${USERNAME} $(getent group ${USER_GID} | cut -d: -f1)) || \
    true) && \
    (useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/bash 2>/dev/null || \
    (getent passwd ${USER_UID} >/dev/null && usermod -l ${USERNAME} -d /home/${USERNAME} -m $(getent passwd ${USER_UID} | cut -d: -f1)) || \
    true) && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Set up working directory
WORKDIR /workdir

COPY files/yocto-entry.sh /usr/local/bin/yocto-entry.sh
RUN chmod +x /usr/local/bin/yocto-entry.sh

# Switch to non-root user
USER ${USERNAME}

# Set up basic neovim configuration
RUN mkdir -p /home/${USERNAME}/.config/nvim && \
    echo 'set number' > /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set relativenumber' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set expandtab' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set tabstop=4' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set shiftwidth=4' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set autoindent' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'set smartindent' >> /home/${USERNAME}/.config/nvim/init.vim && \
    echo 'syntax on' >> /home/${USERNAME}/.config/nvim/init.vim

ENTRYPOINT ["/usr/local/bin/yocto-entry.sh", "/workdir"]

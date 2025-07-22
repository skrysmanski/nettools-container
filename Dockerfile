#
# To test changes locally:
#
# 1. docker build -t nettools .
# 2. docker run -it --rm nettools:latest
#
FROM ubuntu:latest

# Define variables for the non-root user.
ARG USERNAME=appuser

# Set environment variable to skip interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# NOTE: We keep the update list so that users can more easily install new software.
RUN apt-get update

# Install tools
RUN apt-get install -y --no-install-recommends \
        curl \
        # Required for proper HTTPS
        ca-certificates \
        wget \
        # For "dig"
        dnsutils \
        # For "host"
        bind9-host \
        iputils-ping \
        nano \
        sudo \
        zsh \
        less \
        man-db \
        # For oh-my-zsh
        git

# Create non-root user
RUN useradd -m $USERNAME
# Add user to "sudo" group and enable it for sudo without password.
RUN usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Change the shell to zsh
RUN usermod -s $(which zsh) $USERNAME

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Set nano as default editor.
ENV EDITOR=nano

# Install oh-my-zsh for the user
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Add customization for zsh
COPY --chown=$USERNAME:$USERNAME ./files/oh-my-zsh/customizations.zsh /home/$USERNAME/.oh-my-zsh/custom/

# Run zsh as default shell
CMD ["zsh"]

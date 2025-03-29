FROM debian:bookworm

ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y \
  bash-completion build-essential clang-format cmake curl doxygen git sudo tree vim wget xz-utils \
  libboost-dev libboost-filesystem-dev libboost-log-dev libboost-program-options-dev libboost-thread-dev \
  libcap-dev libevent-dev libpcap-dev libsqlite3-dev libssl-dev \
  nodejs npm pkg-config python3-dev python3-pip python3-venv

ARG USERNAME=vscode
ARG USER_UID=1000

RUN useradd -l -u $USER_UID -md /home/$USERNAME -s /bin/bash -p $USERNAME $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh /home/$USERNAME/.bash/git-prompt.sh
RUN chown $USERNAME:$USERNAME /home/$USERNAME/.bash/git-prompt.sh \
  && chmod +x /home/$USERNAME/.bash/git-prompt.sh \
  && echo "\nsource ~/.bash/git-prompt.sh" >> /home/$USERNAME/.bashrc \
  && echo "export GIT_PS1_SHOWCOLORHINTS=true" >> /home/$USERNAME/.bashrc \
  && echo "export PROMPT_COMMAND='__git_ps1 \"\W\" \" » \"'" >> /home/$USERNAME/.bashrc

# install edm
RUN python3 -m pip install --no-cache-dir --break-system-packages \
  "git+https://github.com/everest/everest-dev-environment@main#egg=edm_tool&subdirectory=dependency_manager"

# install ev-cli
RUN python3 -m pip install --no-cache-dir --break-system-packages \
  "git+https://github.com/everest/everest-utils@main#egg=ev-dev-tools&subdirectory=ev-dev-tools"

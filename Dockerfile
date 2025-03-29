FROM debian:bookworm

ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y \
  bash-completion build-essential clang-format cmake curl doxygen git sudo tree vim wget xz-utils \
  libboost-dev libboost-filesystem-dev libboost-log-dev libboost-program-options-dev libboost-thread-dev \
  libcap-dev libevent-dev libpcap-dev libsqlite3-dev libssl-dev \
  nodejs npm pkg-config python3-dev python3-pip python3-venv

RUN python3 -m pip install --no-cache-dir --break-system-packages \
  "git+https://github.com/everest/everest-dev-environment@main#egg=edm_tool&subdirectory=dependency_manager"

RUN python3 -m pip install --no-cache-dir --break-system-packages \
  aiofile cryptography environs netifaces psutil pydantic

WORKDIR /opt/everest

COPY workspace-config.yaml .

RUN edm init --workspace . --config workspace-config.yaml
RUN CMAKE_PREFIX_PATH=/opt/everest cmake -S everest-core -B everest-core/build --install-prefix /usr/local
RUN cmake --build everest-core/build -j8 --target install

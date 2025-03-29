# EVerest Workspace

## Initialization

```
edm init --workspace . --config workspace-config.yaml
```

> [!NOTE]
> The workspace config being used above is currently customized to use some
> Patria Security forks and branches of EVerest repositories for testing.

## Build EVerest Core

```
CMAKE_PREFIX_PATH=$(pwd) cmake -S everest-core -B everest-core/build --install-prefix /usr/local
sudo cmake --build everest-core/build -j8 --target install
```

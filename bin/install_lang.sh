#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit
  echo "Installing the following programming languages:"
  echo "  - Go"
  echo "  - Rust"
  echo "  - C++ language server: ccls"
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y)
      install_golang
      install_rust
      install_ccls
      ;;
    *) exit 0 ;;
  esac
}

install_golang() {
  case $(_os) in
    macos)
      brew ls --version golang || brew install golang
      ;;
    debian)
      sudo aptitude install -y golang-1.12
      ;;
  esac
  go get -u golang.org/x/tools/gopls
}

install_rust() {
  curl https://sh.rustup.rs -sSf | sh
}

install_ccls() {
  case $(_os) in
    debian)
      sudo aptitude install -y zlib1g-dev libncurses-dev rapidjson-dev clang libclang-dev
    ;;
  esac

  git clone --depth=1 --recursive https://github.com/MaskRay/ccls $XDG_DATA_HOME/ccls

  pushd $XDG_DATA_HOME/ccls
  git tag $(date +"%Y-%m-%d")
  cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-8 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-8/include
  cmake --build Release

  cat > $XDG_BIN_HOME/ccls<<EOF
#!/usr/bin/env bash
exec "$XDG_DATA_HOME/ccls/Release/ccls" "\$@"
EOF

  chmod +x $XDG_BIN_HOME/ccls
}

main "$@"

#!/usr/bin/env bash

export CARGO_HOME=${CONDA_PREFIX}/.cargo
export CARGO_CONFIG=${CARGO_HOME}/config
export RUSTUP_HOME=${CARGO_HOME}/rustup

[[ -d ${CARGO_HOME} ]] || mkdir -p ${CARGO_HOME}

export CARGO_TARGET_@rust_arch_env_build@_LINKER=${CC_FOR_BUILD:-${CONDA_PREFIX}/bin/@rust_default_cc_build@}
export CARGO_TARGET_@rust_arch_env@_LINKER=${CC:-${CONDA_PREFIX}/bin/@rust_default_cc@}
export CARGO_BUILD_TARGET=@rust_arch@
export CONDA_RUST_HOST=@rust_arch_env_build@
export CONDA_RUST_TARGET=@rust_arch_env@
export PKG_CONFIG_PATH_@rust_arch_env_build@=${CONDA_PREFIX}/lib/pkgconfig
export PKG_CONFIG_PATH_@rust_arch_env@=${PREFIX:-${CONDA_PREFIX}}/lib/pkgconfig

if [[ "@cross_target_platform@" == linux*  ]]; then
  export CARGO_BUILD_RUSTFLAGS="-C link-arg=-Wl,-rpath-link,${PREFIX:-${CONDA_PREFIX}}/lib -C link-arg=-Wl,-rpath,${PREFIX:-${CONDA_PREFIX}}/lib"
elif [[ "@cross_target_platform@" == osx* ]]; then
  export CARGO_BUILD_RUSTFLAGS="-C link-arg=-Wl,-rpath,${PREFIX:-${CONDA_PREFIX}}/lib"
fi

export PATH=${CARGO_HOME}/bin:${PATH}

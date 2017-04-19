FROM ocaml/opam:ubuntu-16.04_ocaml-4.04.0
LABEL version="2c2e05e5a772d5f6f9d2ce49b861fae283d15082" \
      maintainer="nekketsuuu <nekketsuuu@users.noreply.github.com>"

# Note that the login user of ocaml/opam is NOT "root", but "opam"

RUN set -x \
 && sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes cmake wget \
 && wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - \
 && sudo apt-add-repository --yes 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main'\
 && sudo apt-get update --yes \
 && sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes clang-3.9 lldb-3.9 \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo --user=opam sh -c 'opam update --yes' \
 && sudo --user=opam sh -c 'opam install --yes \
    batteries \
    bisect_ppx \
    ctypes-foreign \
    llvm.3.9 \
    menhir \
    ocamlgraph \
    ocveralls \
    omake.0.10.2 \
    ounit \
    stdint'
RUN set -x \
 && eval `opam config env` \
 && git clone https://github.com/yutopp/rill.git \
 && cd rill \
 && git checkout --force 2c2e05e5a772d5f6f9d2ce49b861fae283d15082 \
 && omake RELEASE=true \
 && sudo -E env "PATH=$PATH" omake install

# ENTRYPOINT & CMD are the same as ocaml/opam
# ENTRYPOINT [ "opam", "config", "exec", "--" ]
# CMD [ "bash" ]

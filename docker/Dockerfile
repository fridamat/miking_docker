FROM ocaml/opam:ubuntu

RUN sudo apt-get update
RUN sudo apt-get install -y \
    jbuilder \
    iputils-ping \
    flex \
    bison
   

ENV OPAMYES=1
WORKDIR /home/opam/src

# update opam
RUN opam switch 4.12
RUN git -C /home/opam/opam-repository pull origin master && opam update -uy

# pre-install dependencies
RUN opam depext -iy core async ppx_sexp_conv ppx_deriving jbuilder \
    toplevel_expect_test patdiff lambdasoup sexp_pretty fmt re
    # Required for code blocks
    # core_bench mtime yojson astring cryptokit ocp-index atd atdgen ctypes \
    # ctypes-foreign textwrap uri
    # cohttp-async

# until a new release of mdx
# RUN opam pin add -y mdx --dev

# Install specific opam packages
RUN opam install batteries

RUN git clone --depth 1 -b $(uname -r | sed 's/^\([^\.]*\.[^\.]*\)[\.-].*$/v\1/') git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git /home/opam/linux
RUN cd /home/opam/linux/tools/perf && make -j9 && sudo cp perf /usr/bin

#install pandoc
# WORKDIR /tmp
# RUN curl -OL https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-1-amd64.deb && sudo dpkg -i pandoc-2.1.3-1-amd64.deb
WORKDIR /home/opam/src

# compile your project
# COPY . /home/opam/src/
# RUN sudo chown -R opam /home/opam/src
# RUN opam exec -- make

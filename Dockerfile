FROM ubuntu

# ubuntu setup
RUN  apt update && apt install -y curl && apt clean

# install nvim
RUN  curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
RUN  tar xzvf nvim-linux-x86_64.tar.gz && mv nvim-linux-x86_64 /opt && rm nvim-linux-x86_64.tar.gz
ENV  PATH="${PATH}:/opt/nvim-linux-x86_64/bin"
# COPY ./nvim/ /root/.config/nvim/

# install lazy.nvim
RUN  apt install -y git gcc make unzip libreadline-dev
RUN  curl -LO "https://www.lua.org/ftp/lua-5.1.tar.gz" && tar xzvf lua-5.1.tar.gz
RUN  cd /lua-5.1 && make linux && make install
RUN  curl -LO "https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz"
RUN  tar xzvf luarocks-3.11.1.tar.gz
RUN  cd /luarocks-3.11.1 && ./configure --with-lua-include=/usr/local/include &&  make &&  make install
RUN  rm -r lua*
ENV  LANG=C.utf8

# copy section
COPY ./.config/nvim/ /root/.config/nvim/
COPY ./init.lua /root/.config/nvim/init.lua

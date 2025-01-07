FROM ubuntu:focal
LABEL authors="chlee-rdv"
ARG DEBIAN_FRONTEND=noninteractive

ARG PROJDIR="my_nvim"
ARG BUILD_TYPE
ENV BUILD_TYPE=${BUILD_TYPE}

# ----------------------------------------------------------------------------------------------
# RUN apt-get update && apt-get install -y \
#     sudo \
#     && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo git wget curl tar unzip tree xz-utils xclip tmux \
    build-essential cmake g++ net-tools \
    python3-pip python3-venv \
    npm


# ----------------------------------------------------------------------------------------------
RUN useradd -m -s /bin/bash rdv && \
    echo "rdv ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/rdv && \
    chmod 0440 /etc/sudoers.d/rdv


USER rdv
WORKDIR /home/rdv
RUN sudo chown -R rdv:rdv /home/rdv

RUN mkdir -p /home/rdv/.config/nvim/plugged

# 지역 설정
ENV TZ=Asia/Seoul
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ | sudo tee /etc/timezone

# `/etc/skel` 디렉토리의 모든 파일과 디렉토리를 새 사용자 홈 디렉토리로 복사합니다. `.bashrc`와 같은 기본 파일들이 생성
RUN cp -r /etc/skel/. /home/rdv/

# NVM 설치
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

RUN export NVM_DIR="/home/rdv/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install 22

#  NeoVim 설치
RUN wget https://github.com/neovim/neovim-releases/releases/download/v0.10.3/nvim-linux64.deb && sudo apt install ./nvim-linux64.deb
# Vim Plugin 설치
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

COPY ${PROJDIR}/nvim/init.vim /home/rdv/.config/nvim/init.vim

RUN echo "alias vi='nvim'" >> /home/rdv/.bashrc

# NVM 관련 설정을 .bashrc에 추가
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

RUN echo "source /opt/ros/noetic/setup.bash" >> /home/rdv/.bashrc
RUN echo "source /home/rdv/catkin_ws/devel/setup.bash" >> /home/rdv/.bashrc

RUN nvim --headless +PlugInstall +qall
# ----------------------------------------------------------------------------------------------
CMD ["bash"]


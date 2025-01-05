#!/bin/bash

PROJECT_NAME="chlee"
REPO_NAME="nvim"

remote_url=$(git config --get remote.origin.url)
#REPO_NAME=$(basename $remote_url .git)

git_head=$(git rev-parse --abbrev-ref HEAD)

TAG=latest

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # 기본 색상 (No Color)
echo -e "${BLUE}Branch: ${NC}$git_head"
echo -e "${GREEN}Tag: ${RED}$TAG${NC}"

src_dir=$(pwd)
workspace=$src_dir/..

cd $workspace || true
docker build --build-arg BUILD_TYPE=$TAG -t $PROJECT_NAME/$REPO_NAME:$TAG -f $src_dir/Dockerfile .


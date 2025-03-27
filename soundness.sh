#!/bin/bash

# 安装 Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 加载 cargo 环境
. "$HOME/.cargo/env"

# 安装 soundness-layer
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# 加载 bashrc
source ~/.bashrc

# 安装必要的软件包
apt install build-essential
apt install libssl-dev
sudo apt install pkg-config

# 安装并更新 soundnessup CLI
soundnessup install
soundnessup update

# 提示用户输入密钥名称
echo "请输入你的密钥名称："
read key_name

# 使用用户提供的名称生成密钥
soundness-cli generate-key --name "$key_name"

echo "密钥生成完成。请按照后续提示输入密码。"
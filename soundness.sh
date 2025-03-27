#!/bin/bash

# 定义安装函数
install_soundnessup() {
    echo "开始安装 soundnessup..."

    # 安装 Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # 加载 Rust 的 cargo 环境
    . "$HOME/.cargo/env"

    # 安装必要的软件包
    sudo apt update
    sudo apt install build-essential -y
    sudo apt install libssl-dev -y
    sudo apt install pkg-config -y

    # 安装 soundness-layer
    curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

    # 手动添加 soundnessup 的路径到 PATH
    export PATH="/root/.soundness/bin:$PATH"

    # 加载 bashrc
    source /root/.bashrc

    # 安装并更新 soundnessup CLI
    soundnessup install
    soundnessup update

    echo "soundnessup 安装完成！"
}

# 主程序：提示用户选择
echo "请选择操作："
echo "1 - 安装 soundnessup"
echo "输入其他键退出"
read -p "请输入你的选择： " choice

# 根据用户输入执行操作
case $choice in
    1)
        install_soundnessup
        # 安装完成后继续密钥生成流程
        echo "请输入你的密钥名称："
        read key_name
        soundness-cli generate-key --name "$key_name"
        echo "密钥生成完成。请按照后续提示输入密码。"
        echo "!access <public-key> 发到 DC"
        ;;
    *)
        echo "已退出脚本。"
        exit 0
        ;;
esac
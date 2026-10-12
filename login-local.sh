#!/usr/bin/env bash
# login.bat 的 bash 版（Git Bash 下用）
set -euo pipefail
cd "$(dirname "$0")"

export LB2A_UPSTREAM_BASE=https://lobsterai-server.youdao.com
export LB2A_LOGIN_PORTAL=https://lobsterai.youdao.com

AUTH_DIR="./auths"
mkdir -p "$AUTH_DIR"

if [[ ! -x ./login.exe ]]; then
    go build -o login.exe ./cmd/login
fi

echo "正在启动本地回调服务器并生成登录链接..."
AUTH_URL=$(./login.exe url) || { echo "启动回调服务器失败"; exit 1; }

echo ""
echo "请在浏览器中打开以下链接完成登录："
echo ""
echo "  $AUTH_URL"
echo ""
read -rp "完成登录后按 y 继续: " ans
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then echo "已取消"; exit 1; fi

echo "正在获取 token..."
RESULT=$(./login.exe poll) || { echo "获取 token 失败"; exit 1; }
echo "$RESULT"

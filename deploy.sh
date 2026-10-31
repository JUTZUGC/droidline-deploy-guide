#!/usr/bin/env bash
set -euo pipefail
# Droidline 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://droidline.dev/docs/install/
# 更新日期：2026-10-31
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o droidline.tar.gz https://github.com/KnifeLemon/Droidline/releases/download/v0.1.12/droidline_0.1.12_linux_amd64.tar.gz
echo "2eeab8fa110a180a2e8b6f2a78138a98517e6bc171646c1d28501cfa76feafe9  droidline.tar.gz" | sha256sum -c -
tar -xzf droidline.tar.gz
echo "校验通过：把 droidline 放进 PATH 后启动，手机装 droidline-agent.apk 扫码配对"

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://droidline.dev/docs/install/"

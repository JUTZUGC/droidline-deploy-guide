# Droidline 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://droidline.dev/docs/install/
# 更新日期：2026-10-31
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o droidline.zip https://github.com/KnifeLemon/Droidline/releases/download/v0.1.12/droidline_0.1.12_windows_amd64.zip
$h=(Get-FileHash .\droidline.zip -Algorithm SHA256).Hash.ToLower()
if ($h -ne "150654207bae325187be4674aced709d9a89bf9cb75d4334f3452d88567dbb99") { throw "SHA256 校验失败" }
Expand-Archive -Path .\droidline.zip -DestinationPath .\droidline -Force
Write-Host "校验通过：运行 .\droidline\droidline.exe，手机装 droidline-agent.apk 扫码配对"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://droidline.dev/docs/install/'

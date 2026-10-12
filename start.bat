@echo off
rem start.bat — lobsterai2api 一键启动（设置必需的环境变量后运行服务）
rem 上游地址与登录门户只认环境变量，config.json 里的 base_url 不生效。
setlocal
cd /d "%~dp0"

set LB2A_UPSTREAM_BASE=https://lobsterai-server.youdao.com
set LB2A_LOGIN_PORTAL=https://lobsterai.youdao.com

lobsterai2api.exe -config config.json

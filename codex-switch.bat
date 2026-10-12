@echo off
rem codex-switch.bat -- 切换 Codex 默认供应商（调用同名 .ps1）
rem 用法: codex-switch.bat lobsterai  或  codex-switch.bat shanyi
rem lobsterai 需先启动 start.bat(:8367) 和 start-litellm.bat(:4000)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0codex-switch.ps1" %*

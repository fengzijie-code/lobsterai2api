@echo off
rem start-litellm.bat — LiteLLM 翻译层（Codex Responses API -> lobsterai2api chat completions）
rem 前置：先运行 start.bat 启动 lobsterai2api（:8367）
cd /d "%~dp0"
".litellm-venv\Scripts\litellm.exe" --config litellm-config.yaml --port 4000 --host 127.0.0.1

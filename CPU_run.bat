@echo off
REM 取得 .bat 檔案所在的目錄
set SCRIPT_DIR=%~dp0

REM 切換到 .bat 檔案所在的目錄
cd /d %SCRIPT_DIR%

REM 顯示目錄內容以確認 Dockerfile 是否存在
dir

REM 建立 Docker 映像檔
docker build -t mri_project .

REM 運行 Docker 容器並綁定目錄和埠
docker run -v %SCRIPT_DIR%:/workspace -p 8888:8888 -it mri_project

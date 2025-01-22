@echo off
setlocal

:: 설정 변수
set REMOTE_USER=ubuntu
set REMOTE_HOST=127.0.0.1
set REMOTE_PATH="/var/log/auth.log"
set LOCAL_PATH="C:\00.dataSet\auth.log"

:: 기존 로그 파일 삭제 (있다면)
if exist "%LOCAL_PATH%" (
    del "%LOCAL_PATH%"
)

:: SCP 명령어 실행 (새로운 로그 파일 가져오기)
scp %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_PATH% %LOCAL_PATH%

endlocal
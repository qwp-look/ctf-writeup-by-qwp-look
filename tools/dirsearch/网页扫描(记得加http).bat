@echo off
:: 设置UTF-8编码支持中文
chcp 65001 > nul
cls

echo.
echo ===============================
echo 网站目录扫描工具 (基于dirsearch)
echo 脚本由qwp-look制作
echo ===============================
echo.

:input_url
set /p target="请输入目标URL (格式 http[s]://domain): "
if "%target%"=="" (
    echo 错误：输入不能为空！
    echo.
    goto input_url
)

:: 验证URL格式
echo %target% | findstr /r "^http://" > nul || echo %target% | findstr /r "^https://" > nul
if errorlevel 1 (
    echo 错误：URL必须以http://或https://开头
    echo.
    goto input_url
)

echo.
echo 即将开始扫描: %target%
echo 按Ctrl+C可取消操作...
timeout /t 5 > nul

:: 使用正确的递归参数 --recursive 和 --max-recursion-depth
start cmd /k "C:\Users\wtg\AppData\Local\Programs\Python\Python313\python.exe C:\Users\wtg\Desktop\other\dirsearch\dirsearch.py -u %target% -e *"
:: 原本的 start cmd /k "C:\Users\wtg\AppData\Local\Programs\Python\Python313\python.exe C:\Users\wtg\Desktop\other\dirsearch\dirsearch.py -u %target% -e * --recursive --max-recursion-depth 5"
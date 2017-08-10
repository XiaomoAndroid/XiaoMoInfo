@echo off

::协议文件路径, 最后不要跟“\”符号
set SOURCE_FOLDER=proto
::Java编译器路径
set JAVA_COMPILER_PATH=Tools\protoc.exe
::C#编译器路径
set CS_COMPILER_PATH=Tools\ProtoGen\protogen.exe

::如果目录不存在则创建
if not exist Code md Code
if not exist Code\cs md Code\cs
if not exist Code\java md Code\java

::C#文件生成路径, 最后不要跟“\”符号
set CS_TARGET_PATH=Code\cs
::Java文件生成路径, 最后不要跟“\”符号
set JAVA_TARGET_PATH=Code\java

::删除之前创建的文件
del %CS_TARGET_PATH%\*.* /f /s /q
del %JAVA_TARGET_PATH%\*.* /f /s /q

::遍历所有文件
for /f "delims=" %%i in ('dir /b "%SOURCE_FOLDER%\*.proto"') do (
    
    ::生成 C# 代码
    echo %CS_COMPILER_PATH% -i:%SOURCE_FOLDER%/%%i -o:%CS_TARGET_PATH%\%%~ni.cs
    %CS_COMPILER_PATH% -i:%SOURCE_FOLDER%\%%i -o:%CS_TARGET_PATH%\%%~ni.cs

    ::生成 Java 代码
    echo %JAVA_COMPILER_PATH% --java_out=%JAVA_TARGET_PATH% %%i
    %JAVA_COMPILER_PATH% --java_out=%JAVA_TARGET_PATH%  %SOURCE_FOLDER%\%%i
    
)

echo Finish

pause
@echo off
echo Building dental-management-system...

REM Check if Maven is installed
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo Maven is not installed or not in PATH!
    echo Please install Maven from: https://maven.apache.org/download.cgi
    echo Or use IntelliJ IDEA to build and deploy the project.
    pause
    exit /b 1
)

REM Build the project
echo Cleaning and building project...
call mvn clean package

if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

REM Check if WAR file was created
if not exist "target\dental-management-system-1.0-SNAPSHOT.war" (
    echo WAR file not found!
    pause
    exit /b 1
)

REM Deploy to Tomcat
set TOMCAT_DIR=C:\Users\DELL\Downloads\apache-tomcat-9.0.109-windows-x64\apache-tomcat-9.0.109

echo Deploying to Tomcat...
copy "target\dental-management-system-1.0-SNAPSHOT.war" "%TOMCAT_DIR%\webapps\dental.war"

if %errorlevel% eq 0 (
    echo Deployment successful!
    echo.
    echo Your application will be available at:
    echo http://localhost:8080/dental/
    echo.
    echo Make sure Tomcat is running.
) else (
    echo Deployment failed!
)

pause
@echo off
echo ============================================
echo   Dental Management System - Standalone
echo ============================================
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH!
    pause
    exit /b 1
)

REM Compile the project first
echo Compiling project...
javac -cp "target/classes;lib/*" -d target/classes src/main/java/lk/clinic/dentalmanagementsystem/*.java src/main/java/lk/clinic/dentalmanagementsystem/*/*.java 2>nul

REM Run the application
echo Starting application...
java -cp "target/classes;lib/*;target/dental-management-system-1.0-SNAPSHOT/WEB-INF/lib/*" lk.clinic.dentalmanagementsystem.RunApplication

pause
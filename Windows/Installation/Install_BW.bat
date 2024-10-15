

@echo off
cls
:: Customize Window
title Brightway2 and Activity-Browser installation

echo Script version : 02/09/24
echo.
echo.  Miniforge3 installation
echo.
if not exist "D\%UserProfile%\Miniforge3 (
echo Miniforge3 installation will begin
echo Wait ...
start /wait "" Requirements\Miniforge3-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\Miniforge3
echo Installation finished. ) else (
echo Miniforge already existing in this PC )


setlocal EnableExtensions

:: Menu Options
:: Specify as many as you want, but they must be sequential from 1 with no gaps
:: Step 1. List the Application Names
set "Op[1]=Activity-Browser installation"
set "Op[2]=Brightway2 installation"
set "Op[3]=Brightway2 and Activity-Browser installation"


:: Display the Menu
set "Message="
:Menu2
echo.%Message%
echo.
echo.  Brightway2 installation
echo.
set "x=0"
:MenuLoop
set /a "x+=1"
if defined Op[%x%] (
    call echo   %x%. %%Op[%x%]%%
    goto MenuLoop
)
echo.

:: Prompt User for Choice
:Prompt
set "Input2="
set /p "Input2=Select your choice (1, 2 or 3), and press enter : "

:: Validate Input [Remove Special Characters]
if not defined Input2 goto Prompt
set "Input2=%Input2:"=%"
set "Input2=%Input2:^=%"
set "Input2=%Input2:<=%"
set "Input2=%Input2:>=%"
set "Input2=%Input2:&=%"
set "Input2=%Input2:|=%"
set "Input2=%Input2:(=%"
set "Input2=%Input2:)=%"
:: Equals are not allowed in variable names
set "Input2=%Input2:^==%"
call :Validate2 %Input2%

:: Process Input
call :Process %Input2%
goto End


:Validate2
set "Next=%2"
if not defined Op[%1] (
    set "Message=Invalid Input: %1"
    goto Menu2
)
if defined Next shift & goto Validate2
goto :eof


:Process
set "Next=%2"
call set "Op=%%Op[%1]%%"

:: Run Installations
:: Specify all of the installations for each app.
:: Step 2. Match on the application names and perform the installation for each
set root=%UserProfile%\miniforge3

call %root%\Scripts\activate.bat %root%

if "%Op%" EQU "Activity-Browser installation" (
    echo Activity-Browser installation will begin.
    call conda env create -f Requirements\environment_AB_Win64.yml
    echo Installation finished. Activity-Browser is installed in environment ab.
    echo. 
    echo Use the Application file or run the following command in the Miniforge prompt:
    echo.
    echo    conda activate ab
    echo    activity-browser
    echo.
    echo Press a key to close the window...
    )
if "%Op%" EQU "Brightway2 installation" (
    echo Brightway2 installation will begin.
    call conda env create -f Requirements\environment_BW_LCA_algeb.yml
    echo Installation finished. Brigtway2 is installed in environment bw_lca.
    echo. 
    echo Use the Application launcher or run the following command in the Miniforge prompt to use it:
    echo.
    echo For a new project :
    echo    conda activate bw_lca
    echo    jupyter-notebook
    echo.
    echo To load an existing project :
    echo    conda activate bw_lca
    echo    cd path_to_your_project_folder
    echo    jupyter-notebook project-name.ipynb
    echo.
    echo Press a key to close the window...

    )
if "%Op%" EQU "Brightway2 and Activity-Browser installation" (
    echo  Activity-Browser and Brightway2 installation will begin.
    call conda env create -f Requirements\environment_AB_Win64.yml
    call conda env create -f Requirements\environment_BW_LCA_algeb.yml
    echo Installation finished. Brigtway2 is installed in environment bw_lca.
    echo Installation finished. Activity-Browser is installed in environment ab.
    echo. 
    echo ACTIVITY-BROWSER
    echo Use the Application launcher or run the following command in the Miniforge prompt:
    echo.
    echo    conda activate ab
    echo    activity-browser
    echo. 
    echo BRIGHTWAY2
    echo Use the Application launcher or run the following command in the Miniforge prompt to use it:
    echo.
    echo For a new project :
    echo    conda activate bw_lca
    echo    jupyter-notebook
    echo.
    echo To load an existing project :
    echo    conda activate bw_lca
    echo    cd path_to_your_project_folder
    echo    jupyter-notebook project-name.ipynb
    echo.
    echo Press a key to close the window...
    )


:: Prevent the command from being processed twice if listed twice.
set "Op[%1]="
if defined Next shift & goto Process
goto :eof


:End
endlocal
pause >nul  

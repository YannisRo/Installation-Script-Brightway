set root=%UserProfile%\miniforge3

call %root%\Scripts\activate.bat %root%
call conda activate ab
echo wait...
call activity-browser

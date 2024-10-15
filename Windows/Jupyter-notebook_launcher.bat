set root=%UserProfile%\miniforge3

call %root%\Scripts\activate.bat %root%
%root%\env\bw_lca\python.exe %root%\env\bw_lca\cwp.py %root% %root%\env\bw_lca\python.exe %root%\Scripts\env\bw_lca\jupyter-lab-script.py %root%
call conda activate bw_lca
echo wait...    
jupyter-notebook
pause
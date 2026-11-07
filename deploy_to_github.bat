@echo off
echo ===================================================
echo   Pushing Portfolio Nazarul Qudri to GitHub
echo ===================================================
git branch -M main
git remote set-url origin https://github.com/nazarulqudritrkj/portofolionazarulqudri.git
git push -u origin main
echo.
echo ===================================================
echo   Done! Cek GitHub Actions di:
echo   https://github.com/nazarulqudritrkj/portofolionazarulqudri/actions
echo ===================================================
pause

@echo off
echo ====================================
echo Discord Self-Bot Forwarder
echo ====================================
echo.
echo FIRST: Get your Discord user token:
echo 1. Open Discord in browser
echo 2. Press F12 for Developer Tools
echo 3. Go to Console tab
echo 4. Paste this and press Enter:
echo    (webpackChunkdiscord_app.push([[''],{},e=^>{m=[];for(let c in e.c)m.push(e.c[c])}]),m).find(m=^>m?.exports?.default?.getToken!==void 0).exports.default.getToken()
echo.
echo 5. Copy the token that appears
echo.
set /p TOKEN="Paste your Discord user token here: "

echo.
echo Updating config with your token...
echo {> temp-config.json
echo   "user_token": "%TOKEN%",>> temp-config.json
type config.json | findstr /v "user_token" >> temp-config.json
move /y temp-config.json config.json >nul

echo.
echo Starting Discord self-bot forwarder...
pm2 delete discord-forwarder 2>nul
pm2 start discord-selfbot-forwarder.js --name discord-forwarder

echo.
echo Checking status...
timeout /t 3 /nobreak >nul
pm2 logs discord-forwarder --lines 20 --nostream

echo.
echo ====================================
echo Self-bot should now be running!
echo Check: pm2 logs discord-forwarder
echo ====================================
pause
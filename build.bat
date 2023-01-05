@echo off
dir
echo "%1" "%GITHUB_EVENT_NAME%" > "%2"
dir

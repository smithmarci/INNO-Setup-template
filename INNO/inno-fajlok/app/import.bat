@echo off
color a
echo.
echo Bundle-ökbe írás folyamatban (ez eltarthat egy darabig; ne zárd be ezt az ablakot, várd meg, amíg magától eltűnik!)...
echo.
for %%a in (*.assets;*.unity3d;*.bundle;level???) do UnityEX.exe import "%%a"
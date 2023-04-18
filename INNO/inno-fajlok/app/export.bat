@echo off
color a
for %%a in (*.unity3D;*.bundle) do UnityEX.exe exportbundle "%%a" -p "%CD%\"
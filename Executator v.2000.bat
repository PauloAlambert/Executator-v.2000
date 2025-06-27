@echo off
color 2
title Executator v.2000

chcp 65001 > nul
mode 150,20

:TELA_LOGIN
cls
color 2
set "senhaCorreta="

setlocal enabledelayedexpansion

:: Caminho do arquivo de senha
set "senhaFile=C:\pass\pass.txt"

:: Verifica se o arquivo existe
if not exist "%senhaFile%" (
    echo Arquivo de senha nao encontrado em %senhaFile%
    pause
    exit /b
)

:: Lê a linha 10 do arquivo
set /a count=0
for /f "usebackq delims=" %%a in ("%senhaFile%") do (
    set /a count+=1
    if !count! equ 10 (
        set "senhaCorreta=%%a"
        goto pedirSenha
    )
)

:: Caso o arquivo tenha menos de 10 linhas
echo ERROR 101: O arquivo nao tem 10 linhas.
pause
exit /b

:pedirSenha
set /p "senhaDigitada=Digite a senha: "

if /I "%senhaDigitada%"=="%senhaCorreta%" (
    goto menuPrincipal
) else (
    echo Tente novamente.
    pause
    goto TELA_LOGIN
)

:menuPrincipal
cls
call :banner
echo.
echo (1) Liberdade Total (taskkill)
echo (2) Abrir Calculadora
echo (3) Logout (Voltar para tela de login)
echo (4) Sair do Programa
echo.

:ferramenta
set "input="
set /p "input=Escolha a ferramenta: "

:: =============================================================
:: CORRECAO PRINCIPAL AQUI:
:: Removido as aspas de "%input%" para forcar comparacao numerica.
:: Removido o /I, que nao e necessario para numeros.
:: =============================================================

if %input% EQU 1 goto acao_liberdade
if %input% EQU 2 goto acao_calculadora
if %input% EQU 3 goto TELA_LOGIN
if %input% EQU 4 exit /b

echo Opcao invalida. Tente novamente.
pause
goto menuPrincipal


:: =============================================================
:: ACOES DAS FERRAMENTAS (CODIGO MAIS ORGANIZADO)
:: =============================================================

:acao_liberdade
echo Finalizando o processo qubnfe.exe...
taskkill /IM qubnfe.exe /F
echo.
echo Processo finalizado.
pause
goto menuPrincipal

:acao_calculadora
echo Abrindo a calculadora...
start calc
goto menuPrincipal


:banner
echo.
echo. 
echo.
echo         [38;2;255;0;0m███████╗██╗  ██╗███████╗ ██████╗██╗   ██╗████████╗ █████╗ ████████╗ ██████╗ ██████╗     ██╗   ██╗  ██████╗  ██████╗  ██████╗  ██████╗[0m
echo         [38;2;255;118;0m██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║   ██║╚══██╔══╝██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗    ██║   ██║  ╚════██╗██╔═████╗██╔═████╗██╔═████╗[0m
echo         [38;2;255;177;0m█████╗   ╚███╔╝ █████╗  ██║     ██║   ██║   ██║   ███████║   ██║   ██║   ██║██████╔╝    ██║   ██║   █████╔╝██║██╔██║██║██╔██║██║██╔██║[0m
echo         [38;2;255;206;0m██╔══╝   ██╔██╗ ██╔══╝  ██║     ██║   ██║   ██║   ██╔══██║   ██║   ██║   ██║██╔══██╗    ╚██╗ ██╔╝  ██╔═══╝ ████╔╝██║████╔╝██║████╔╝██║[0m
echo         [33m███████╗██╔╝ ██╗███████╗╚██████╗╚██████╔╝   ██║   ██║  ██║   ██║   ╚██████╔╝██║  ██║     ╚████╔╝██╗███████╗╚██████╔╝╚██████╔╝╚██████╔╝[0m
echo         [93m╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝      ╚═══╝ ╚═╝╚══════╝ ╚═════╝  ╚═════╝  ╚═════╝[0m
echo.
echo.  
@echo off
color 2
title Executator v.2000

chcp 65001 > nul
mode 150,30

:TELA_LOGIN
cls
color 2


setlocal enabledelayedexpansion

:: Caminho do arquivo de senha
set "senhaFile=C:\Windows\System32\pass/pass.txt"

:: Verifica se o arquivo existe
if not exist "%senhaFile%" (
goto criarSenha

)

set "senhaCorreta="
set /a count=0
for /f "usebackq delims=" %%a in ("%senhaFile%") do (
    set /a count+=1
    if !count! equ 347 (

        rem ERRO 1 CORRIGIDO: O 'setlocal' foi removido daqui.
        rem Ele estava apagando a variável 'senhaCorreta' assim que o 'if' terminava.

        rem ERRO 2 CORRIGIDO: Usamos '%%a' diretamente no 'for' aninhado.
        rem Isso evita o problema de expansão de variável e é mais eficiente.
        for /f "tokens=2 delims=|" %%b in ("%%a") do (
            set "senhaCorreta=%%b"
            
        )
        
        rem Opcional, mas recomendado: sair do loop para não ler o resto do arquivo
 
        goto pedirSenha
    )
)


:: Caso o arquivo tenha menos de 10 linhas
echo ERROR 101: O arquivo nao tem 10 linhas.
pause
exit /b

:criarSenha
color 2
    echo Criar nova senha!
	set /p "newpass=Digite a nova senha: "
    echo Tem certeza que sua senha vai ser(%newpass%)?
	set /p "pr=(1)sim / (2)não: "

if /I "%pr%"=="1" (
    

	mkdir C:\Windows\System32\pass


:: Camufla com delimitadores fixos (|senha|)
set "crypted=!random!|%newpass%|!random!"



(
  for /L %%i in (1,1,500) do (
  set "al=!random!|!random!|!random!"
    if %%i equ 347 (
      echo !crypted!
    ) else (
      echo !al!
    )
  )
) > C:\Windows\System32\pass\pass.txt
    pause
	cls
    goto TELA_LOGIN
)else (
cls
goto criarSenha
)






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
echo (1) Liberdade Total 
echo (2) git
echo (3) Logout
echo (4) AI/IA
echo (5) dc(dev)
echo (6) np
echo (7) Ip Messager
echo (8) Sair
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
if %input% EQU 2 goto acao_git
if %input% EQU 3 goto TELA_LOGIN
if %input% EQU 4 goto acao_chatgpt
if %input% EQU 5 goto acao_dev
if %input% EQU 6 goto acao_newpass
if %input% EQU 7 goto acao_ipmessager
if %input% EQU 8 exit /b

echo Opcao invalida. Tente novamente.
pause
goto menuPrincipal


:: =============================================================
:: ACOES DAS FERRAMENTAS (CODIGO MAIS ORGANIZADO)
:: =============================================================

:acao_newpass
cls
rmdir /s /q C:\Windows\System32\pass
cls
goto criarSenha


:acao_dev
echo Abrindo...
start https://discord.com/developers/applications
pause
goto menuPrincipal



:acao_chatgpt
echo Abrindo...
start https://chatgpt.com/
pause
goto menuPrincipal


:acao_liberdade
echo Finalizando o processo qubnfe.exe...
taskkill /IM qubnfe.exe /F
echo.
echo Processo finalizado.
pause
goto menuPrincipal

:acao_git
echo Iniciando git...
start https://github.com/PauloAlambert
goto menuPrincipal



:acao_ipmessager
cls
color 2
echo.
echo.
echo         ██╗██████╗     ███╗   ███╗███████╗███████╗███████╗ █████╗  ██████╗ ███████╗██████╗ 
echo         ██║██╔══██╗    ████╗ ████║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝ ██╔════╝██╔══██╗
echo         ██║██████╔╝    ██╔████╔██║█████╗  ███████╗███████╗███████║██║  ███╗█████╗  ██████╔╝
echo         ██║██╔═══╝     ██║╚██╔╝██║██╔══╝  ╚════██║╚════██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
echo         ██║██║         ██║ ╚═╝ ██║███████╗███████║███████║██║  ██║╚██████╔╝███████╗██║  ██║
echo         ╚═╝╚═╝         ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
echo.
echo.
set /p "nameinput=Coloque o nome do pc: "
set /p "msg=Coloque a menssagem: "
msg * /Server:%nameinput% %msg%
pause
cls 
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

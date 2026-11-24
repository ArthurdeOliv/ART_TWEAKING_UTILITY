@echo off
Set Version=0.1.2

:: Color Codes
set w=[97m
set p=[92m
set b=[96m
%B%

:: Enabling ANSI Escape Sequences
Reg.exe add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f  > nul

::Enabling Delayed Expansion
setlocal EnabledelayedExpansion > nul

::Bigger font + maximized window (relaunches once, the argument "big" prevents a loop)
if /i "%~1"=="big" goto ART_big_done
powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $w=[System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width; $h=[int][math]::Floor($w/195/0.55); if($h -gt 40){$h=40}; if($h -lt 16){$h=16}; $k='HKCU:\Console'; Set-ItemProperty $k FaceName 'Consolas'; Set-ItemProperty $k FontFamily 54 -Type DWord; Set-ItemProperty $k FontWeight 400 -Type DWord; Set-ItemProperty $k FontSize ($h*65536) -Type DWord; Set-ItemProperty $k ScreenBufferSize 0x0BB800D2 -Type DWord; Set-ItemProperty $k WindowSize 0x002800D2 -Type DWord" >nul 2>&1
start "" /max cmd /c ""%~f0" big"
exit /b
:ART_big_done
cls 

::Verificando privilegios de administrador (isso garante que as alterações sejam aplicadas corretamente)
chcp 65001 >nul 2>&1
cls 
echo.
echo.
echo.               %w%ART TWEAKING UTILITY V0.1.2 %B%
echo. %b%╔════════════════════════════════════════════════════╗
echo. %b%║                                                    ║
echo. %b%║   %w% Verificando privilegios de administrador... %b%    %b%║
echo. %b%║                                                    ║
echo. %b%╚════════════════════════════════════════════════════╝
timeout /t 1 /nobreak > NUL

rmdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
mkdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
if %errorlevel% neq 0 (   
cls 
echo.
echo.
echo. %b%╔════════════════════════════════════════════════════╗
echo. %b%║                                                    ║
echo. %b%║      %w% Executando como administrador...      %b%       %b%║
echo. %b%║                                                    ║
echo. %b%╚════════════════════════════════════════════════════╝
timeout /t 1 /nobreak > NUL
chcp 437 >nul 2>&1
powershell -NoProfile -NonInteractive -Command start -verb runas -WindowStyle Maximized "'%~s0'" big >nul 2>&1
chcp 65001 >nul 2>&1

if !errorlevel! equ 0 exit /b


echo.
echo             O ART nao esta rodando como administrador!
echo     Algumas otimizacoes nao vao funcionar. Continuar mesmo assim?
echo.
choice /c:"CS" /n /m "%BS%               [C] Continuar  [S] Sair" & if !errorlevel! equ 2 exit /b
)


chcp 65001 >nul 2>&1

set THREADS=%NUMBER_OF_PROCESSORS% > nul
for /f "tokens=2 delims=," %%i in ('whoami /user /fo csv /nh') do set "USER_SID=%%~i"
set "ART_FILE=%~f0"
set "WINBUILD=0"
for /f %%b in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).BuildNumber"') do set "WINBUILD=%%b"


::Enabling Restore points 
chcp 437 >nul 2>&1
powershell -NoProfile Enable-ComputerRestore -Drive 'C:\' >nul 2>&1
Reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /f  >nul 2>&1
Reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "DisableConfig" /f >nul 2>&1
Reg.exe add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
chcp 65001 >nul 2>&1
%b%

CLS
echo.
echo.
echo.                                                                                                    %W%ART TWEAKING UTILITY VERSION 0.1.2
echo.
echo.                                          %p%░██╗░░░░░░░██╗            ██████████╗            ██╗░░░░░░░░           ░████████╗░           ░████████╗░           ███╗░░░███╗           ██████████╗
echo.                                          %p%░██║░░██╗░░██║            ██╔═══════╝            ██║░░░░░░░░           ██╔═════██╗           ██╔═════██╗           ████╗░████║           ██╔═══════╝
echo.                                          %p%░╚██╗████╗██╔╝            ████████╗░░            ██║░░░░░░░░           ██║░░░░░╚═╝           ██║░░░░░██║           ██╔████╔██║           ████████╗░░
echo.                                          %p%░░████╔═████║░            ██╔═════╝░░            ██║░░░░░░░░           ██║░░░░░██╗           ██║░░░░░██║           ██║╚██╔╝██║           ██╔═════╝░░
echo.                                          %p%░░╚██╔╝░╚██╔╝░            ██████████╗            ██████████╗           ╚████████╔╝           ╚████████╔╝           ██║░╚═╝░██║           ██████████╗
echo.                                          %p%░░░╚═╝░░░╚═╝░░            ╚═════════╝            ╚═════════╝           ░╚═══════╝░           ░╚═══════╝░           ╚═╝░░░░░╚═╝           ╚═════════╝
echo.                                          %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                                                                                 Aviso
echo.
echo.                                               Nao nos responsabilizamos por problemas/danos que isto possa causar ao seu PC. Se ocorrer algum, use Backup / Restauracao, tecla P no menu
echo.                                                                                                               principal
echo.
echo.
echo.
echo.                                          %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                                                                   Instrucoes * Perguntas frequentes
echo.
echo.                                                        Digite um NUMERO no teclado e pressione ENTER para escolher uma opcao. Leia todos os avisos, nao aperte botoes sem ler.
echo.
echo.                                                        Voce pode desfazer a maioria das alteracoes com Reversoes / Correcoes [R] e Backup / Restauracao [P] no menu principal.
echo.
echo.                                                                      %w%Feito e distribuido por ART TWEAKS, 2026 * Versao 0.1.2 * Atualizado em 22 de Novembro de 2026
echo.                                          %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.
echo.
echo.                                                                                   %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                   %b%║       %w% Pressione qualquer tecla para continuar...      %b%       %b%║
echo.                                                                                   %b%╚═══════════════════════════════════════════════════════════════╝
echo.
echo.
echo. 
pause > nul
CLS

 
:: Restore Point
:restorepoint
cls
echo.
echo.
echo.                                                                                           %W%ART TWEAKING UTILITY VERSION 0.1.2
echo.
echo.                                                   %p%███████╗░ ████████╗ ░███████╗ █████████╗ ░██████╗░ ███████╗░ ███████╗     ██████╗░░█████╗░██╗███╗░░██╗█████████╗
echo.                                                   %p%██╔═══██╗ ██╔═════╝ ██╔═════╝ ╚═══██╔══╝ ██╔═══██╗ ██╔═══██╗ ██╔════╝     ██╔══██╗██╔══██╗██║████╗░██║╚═══██╔══╝
echo.                                                   %p%███████╔╝ ██████╗░░ ╚██████╗░ ░░░░██║░░░ ██║░░░██║ ███████╔╝ █████╗░░     ██████╔╝██║░░██║██║██╔██╗██║░░░░██║░░░
echo.                                                   %p%██╔═══██╗ ██╔═══╝░░ ░╚════██╗ ░░░░██║░░░ ██║░░░██║ ██╔═══██╗ ██╔══╝░░     ██╔═══╝░██║░░██║██║██║╚████║░░░░██║░░░
echo.                                                   %p%██║░░░██║ ████████╗ ███████╔╝ ░░░░██║░░░ ╚██████╔╝ ██║░░░██║ ███████╗     ██║░░░░░╚█████╔╝██║██║░╚███║░░░░██║░░░
echo.                                                   %p%╚═╝░░░╚═╝ ╚═══════╝ ╚══════╝░ ░░░░╚═╝░░░ ░╚═════╝░ ╚═╝░░░╚═╝ ╚══════╝     ╚═╝░░░░░░╚════╝░╚═╝╚═╝░░╚══╝░░░░╚═╝░░░
echo.                                                   %b%╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.                                                   %b%║                   %w% Deseja criar um ponto de restauracao?                                  %b%                   %b%║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%║             %p%[%w%1%p%]%w% Criar ponto de restauracao       %p%[%w%2%p%]%w% Pular                                     %b%              %b%║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%╠══════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo.                                                   %b%║     %W% Permite restaurar seu PC as mesmas configuracoes de quando o ponto foi criado                     %b%      %b%║
echo.                                                   %b%║          %W% Voce pode usar um ponto de restauracao depois, dentro do utilitario, se quiser           %b%          %b%║
echo.                                                   %b%╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo. 
 
set /p input=:
if /i %input% == 1 goto createRP
if /i %input% == 2 goto profile

) ELSE (
echo Entrada invalida & goto MisspellRedirect1

:MisspellRedirect1
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu1

:RedirectMenu1
goto restorepoint

:createRP
cls 
echo.
echo.
echo.
echo.                                                                  %p%██████╗░███████╗░██████╗████████╗░█████╗░██████╗░███████╗   ██████╗░░█████╗░██╗███╗░░██╗████████╗
echo.                                                                  %p%██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝   ██╔══██╗██╔══██╗██║████╗░██║╚══██╔══╝
echo.                                                                  %p%██████╔╝█████╗░░╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░   ██████╔╝██║░░██║██║██╔██╗██║░░░██║░░░
echo.                                                                  %p%██╔══██╗██╔══╝░░░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░   ██╔═══╝░██║░░██║██║██║╚████║░░░██║░░░
echo.                                                                  %p%██║░░██║███████╗██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗   ██║░░░░░╚█████╔╝██║██║░╚███║░░░██║░░░
echo.                                                                  %p%╚═╝░░╚═╝╚══════╝╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝   ╚═╝░░░░░░╚════╝░╚═╝╚═╝░░╚══╝░░░╚═╝░░░
echo.
echo. %w% Criando ponto de restauracao... %b%
chcp 437 >nul
powershell -NoProfile -Command "Checkpoint-Computer -Description 'ART Tweaks Restore Point' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
echo. %w% Salvando backup do registro, servicos e tarefas agendadas... %b%
call :artps backup
chcp 65001 >nul
echo.
echo. %w% Pressione qualquer tecla para continuar... %b%
pause > nul
cls
goto profile

:profile
cls
echo.
echo.
echo.
echo.                                                   %p%█████████╗░        █████████╗░       ░████████╗░       ██████████╗       ██╗       ██╗░░░░░░░░       ██████████╗
echo.                                                   %p%██╔═════██╗        ██╔═════██╗       ██╔═════██╗       ██╔═══════╝       ██║       ██║░░░░░░░░       ██╔═══════╝
echo.                                                   %p%█████████╔╝        █████████╔╝       ██║░░░░░██║       ████████╗░░       ██║       ██║░░░░░░░░       ████████╗░░
echo.                                                   %p%██╔══════╝░        ██╔═════██╗       ██║░░░░░██║       ██╔═════╝░░       ██║       ██║░░░░░░░░       ██╔═════╝░░
echo.                                                   %p%██║░░░░░░░░        ██║░░░░░██║       ╚████████╔╝       ██║░░░░░░░░       ██║       ██████████╗       ██████████╗
echo.                                                   %p%╚═╝░░░░░░░░        ╚═╝░░░░░╚═╝       ░╚═══════╝░       ╚═╝░░░░░░░░       ╚═╝       ╚═════════╝       ╚═════════╝
echo.                                                   %b%╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.                                                   %b%║                   %w% Qual perfil descreve o seu PC?                                         %b%                   %b%║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%║               %p%[%w%1%p%]%w% PC recem-formatado              %p%[%w%2%p%]%w% PC em uso                               %b%               %b%║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%╠══════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo.                                                   %b%║   %w%[1] Instala VC++, DirectX e .NET via winget e abre a pagina de driver NVIDIA/AMD,                          %b%%b%║
echo.                                                   %b%║   %w%    impede o Windows Update de trocar o driver de video e desliga Delivery                                 %b%%b%║
echo.                                                   %b%║   %w%    Optimization, Inicializacao Rapida e apps em segundo plano.                                            %b%%b%║
echo.                                                   %b%║                                                                                                              ║
echo.                                                   %b%║   %w%[2] Foco em limpeza: mostra o que pesa (processos com mais RAM, itens de inicializacao,                    %b%%b%║
echo.                                                   %b%║   %w%    servicos de terceiros) e deixa VOCE decidir o que desligar.                                            %b%%b%║
echo.                                                   %b%╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo. 
set "input="
set /p input=:
if "!input!"=="1" goto pf_new
if "!input!"=="2" goto pf_used
cls
echo Erro de digitacao detectado
timeout 1 >nul
goto profile

:pf_new
set "PROFILE=new"
cls
echo.
echo.
echo.                                                                  %p%██████╗░██████╗░░█████╗░███████╗██╗██╗░░░░░███████╗
echo.                                                                  %p%██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║░░░░░██╔════╝
echo.                                                                  %p%██████╔╝██████╔╝██║░░██║█████╗░░██║██║░░░░░█████╗░░
echo.                                                                  %p%██╔═══╝░██╔══██╗██║░░██║██╔══╝░░██║██║░░░░░██╔══╝░░
echo.                                                                  %p%██║░░░░░██║░░██║╚█████╔╝██║░░░░░██║███████╗███████╗
echo.                                                                  %p%╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚══════╝
echo.
echo. %w% Perfil: PC recem-formatado    %b%
echo.
where winget >nul 2>&1
if errorlevel 1 goto pf_nowinget
echo %w% - Instalando itens essenciais via winget, pode levar alguns minutos...%b%
call :wg Microsoft.VCRedist.2015+.x64
call :wg Microsoft.VCRedist.2015+.x86
call :wg Microsoft.DirectX
call :wg Microsoft.DotNet.DesktopRuntime.8
goto pf_drivers
:pf_nowinget
echo %w% - O Winget não foi encontrado; a instalacaoo do Essentials sera ignorada. Atualize o "Instalador de Aplicativos" na Microsoft Store..%b%
:pf_drivers
echo %w% - Abrindo a pagina oficial de driver da GPU...%b%
call :artps gpudrivers
echo %w% - Impedindo o Windows Update de trocar o driver de video...%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
echo %w% - Desativando Delivery Optimization...%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
echo %w% - Desativando Inicializacao Rapida...%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
echo %w% - Desativando apps em segundo plano...%b%
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul 2>&1
echo.
echo. %w% Reinicie o PC para finalizar. Instale o driver da GPU pela pagina que foi aberta. %b%
goto pf_done

:pf_used
set "PROFILE=used"
cls
goto menu

:wg
echo %w% - %~1%b%
winget install --id %~1 -e --silent --disable-interactivity --accept-package-agreements --accept-source-agreements >nul 2>&1
if !errorlevel! equ 0 goto wg_ok
if !errorlevel! equ -1978335189 goto wg_ok
echo      falhou ou precisa reiniciar, voce pode instalar manualmente depois.
exit /b
:wg_ok
echo      OK
exit /b

:pf_done
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
pause > nul
cls
goto menu

:14
cls
echo.
echo.
echo.
echo.                                         %p%█████████╗░     ██████████╗     █████████╗░    ░████████╗░    █████████╗░    ███████████╗
echo.                                         %p%██╔═════██╗     ██╔═══════╝     ██╔═════██╗    ██╔═════██╗    ██╔═════██╗    ╚════██╔═══╝
echo.                                         %p%█████████╔╝     ████████╗░░     █████████╔╝    ██║░░░░░██║    █████████╔╝    ░░░░░██║░░░░
echo.                                         %p%██╔═════██╗     ██╔═════╝░░     ██╔══════╝░    ██║░░░░░██║    ██╔═════██╗    ░░░░░██║░░░░
echo.                                         %p%██║░░░░░██║     ██████████╗     ██║░░░░░░░░    ╚████████╔╝    ██║░░░░░██║    ░░░░░██║░░░░
echo.                                         %p%╚═╝░░░░░╚═╝     ╚═════════╝     ╚═╝░░░░░░░░    ░╚═══════╝░    ╚═╝░░░░░╚═╝    ░░░░░╚═╝░░░░
echo.                                         %b%═════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                             %p%[%w%1%p%]%w% Relatorio do PC                    %p%[%w%4%p%]%w% Verificacoes de Hardware
echo.
echo.                                             %p%[%w%2%p%]%w% Antes/Depois: salvar ANTES         %p%[%w%3%p%]%w% Antes/Depois: salvar DEPOIS e comparar
echo.
echo.                                             %p%[%w%5%p%]%w% PC em uso: o que esta pesando
echo.
echo.                                             %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                         %b%═════════════════════════════════════════════════════════════════════════════════════════
echo.                                            %W%Relatorio do PC: CPU, GPU, RAM, tipo de disco, notebook ou desktop, driver de video
echo.                                                                              e espaco livre
echo.                                            %W%Antes/Depois: processos, servicos, RAM em uso e tempo de boot. Salve ANTES, aplique
echo.                                                                    os ajustes, reinicie e salve DEPOIS
echo.                                              %W%Verificacoes: RAM abaixo da velocidade nominal, taxa de atualizacao do monitor,
echo.                                                                   saude do SSD e driver de video antigo
echo.                                             %W%PC em uso: top processos por RAM, itens de inicializacao e servicos de terceiros.
echo.                                                                          So mostra, voce decide
echo.                                         %b%═════════════════════════════════════════════════════════════════════════════════════════
set "input="
set /p input=:
if /i "!input!"=="1" goto t14_1
if /i "!input!"=="2" goto t14_2
if /i "!input!"=="3" goto t14_3
if /i "!input!"=="4" goto t14_4
if /i "!input!"=="5" goto t14_5
if /i "!input!"=="M" cls & goto menu
cls
echo Erro de digitacao detectado
timeout 1 >nul
goto 14

:t14_1
cls
call :artps report
goto t14_end
:t14_2
cls
call :artps before
goto t14_end
:t14_3
cls
call :artps after
goto t14_end
:t14_5
cls
call :artps usedpc
goto t14_end
:t14_4
cls
call :artps checks
goto t14_end
:t14_end
echo.
echo. %w% Pressione qualquer tecla para continuar... %b%
pause > nul
cls
goto 14

:artps
set "ART_MODE=%~1"
chcp 65001 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText($env:ART_FILE); $a=$c.IndexOf('#PS_ART'+'_BEGIN'); $b=$c.IndexOf('#PS_ART'+'_END'); Invoke-Expression $c.Substring($a,$b-$a)"
exit /b


:soon
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto menu

:restore
cls
rstrui.exe
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto menu


:Menu
chcp 65001 >nul 2>&1
cls
echo.
echo.
echo.
echo.                                             %b%╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.                                             %b%║%p%░░░░░█████╗░██████╗░████████╗░░░░░░░░░░██╗░░░██╗████████╗██╗██╗░░░░░██╗████████╗██╗░░░██╗░░░░░░░░░░█████╗░░░░░░███╗░░░░░██████╗░░░░░%b%%b%║
echo.                                             %b%║%p%░░░░██╔══██╗██╔══██╗╚══██╔══╝░░░░░░░░░░██║░░░██║╚══██╔══╝██║██║░░░░░██║╚══██╔══╝╚██╗░██╔╝░░░░░░░░░██╔══██╗░░░░████║░░░░░╚════██╗░░░░%b%%b%║
echo.                                             %b%║%p%░░░░███████║██████╔╝░░░██║░░░░░░░░░░░░░██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░╚████╔╝░░░░░░░░░░██║░░██║░░░██╔██║░░░░░░░███╔═╝░░░░%b%%b%║
echo.                                             %b%║%p%░░░░██╔══██║██╔══██╗░░░██║░░░░░░░░░░░░░██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░░╚██╔╝░░░░░░░░░░░██║░░██║░░░╚═╝██║░░░░░██╔══╝░░░░░░%b%%b%║
echo.                                             %b%║%p%░░░░██║░░██║██║░░██║░░░██║░░░░░░░░░░░░░╚██████╔╝░░░██║░░░██║███████╗██║░░░██║░░░░░░██║░░░░░░░░░░░░╚█████╔╝██╗███████╗██╗███████╗░░░░%b%%b%║
echo.                                             %b%║%p%░░░░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░░░░░░░░░╚═════╝░░░░╚═╝░░░╚═╝╚══════╝╚═╝░░░╚═╝░░░░░░╚═╝░░░░░░░░░░░░░╚════╝░╚═╝╚══════╝╚═╝╚══════╝░░░░%b%%b%║
echo.                                             %b%╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%1%p%]%w% Otimizacoes Gerais            %p%[%w%2%p%]%w% Otimizacao de Mouse e Teclado      %p%[%w%3%p%]%w% Ajustes do Windows                   %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%4%p%]%w% Limpeza do PC                 %p%[%w%5%p%]%w% Otimizacao de Memoria/RAM          %p%[%w%6%p%]%w% Gerenciador de Inicializacao         %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%7%p%]%w% Ajustes de GPU                %p%[%w%8%p%]%w% Ajustes de CPU                     %p%[%w%9%p%]%w% Ajustes de USB                       %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%10%p%]%w% Ajustes de Energia           %p%[%w%11%p%]%w% Debloat do Sistema                %p%[%w%12%p%]%w% Ajustes de Disco                    %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%13%p%]%w% Corrigir Arquivos            %p%[%w%14%p%]%w% Ajustes de Rede                   %p%[%w%15%p%]%w% Relatorio / Checagens               %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║         %p%[%w%R%p%]%w% Reversoes / Correcoes         %p%[%w%X%p%]%w% Sair do Utilitario                 %p%[%w%P%p%]%w% Backup / Restauracao                 %b%         %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%║                   %w%Feito e distribuido por ART TWEAKS, 2026 * Versao 0.1.2 * Atualizado em 22 de Novembro de 2026%b%                   %b%║
echo.                                             %b%║                                                                                                                                    ║
echo.                                             %b%╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝



set /p input=:
if /i %input% == 1 goto 1
if /i %input% == 2 goto 2
if /i %input% == 3 goto 3
if /i %input% == 4 goto 4
if /i %input% == 5 goto 5
if /i %input% == 6 goto 6
if /i %input% == 7 goto 7
if /i %input% == 8 goto 8war
if /i %input% == 9 goto 9
if /i %input% == 10 goto 10war 
if /i %input% == 11 goto 11war
if /i %input% == 12 goto 12
if /i %input% == 13 goto 13
if /i %input% == 14 goto 15
if /i %input% == 15 goto 14

if /i %input% == R goto revert
if /i %input% == P goto backupmenu
if /i %input% == X goto Exit

) ELSE (
echo Entrada invalida & goto MisspellRedirect2

:MisspellRedirect2
cls
echo Erro de digitacao detectado
timeout 1 
goto RedirectMenu2

:RedirectMenu2
cls
goto menu

::Subrotina chamada pela opcao 1 (Otimizacoes Gerais): jogos em janela e Overlay, antiga opcao 14
:gfx_windowed
::MPO agora e controlado em GPU > Ajustes de Jogos e Tela (nao e mais restaurado aqui)
echo %w% - Respeitando a configuracao de tela cheia de cada jogo%b%
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1
if %WINBUILD% LSS 22000 exit /b
echo %w% - Ativando otimizacoes de jogos em janela e desativando VRR em janela, sem apagar as outras opcoes de graficos%b%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$k='HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences'; if (-not (Test-Path $k)) { New-Item -Path $k -Force | Out-Null }; $v=(Get-ItemProperty -Path $k -ErrorAction SilentlyContinue).DirectXUserGlobalSettings; $h=[ordered]@{}; foreach ($p in ([string]$v -split ';')) { if ($p -match '^(.+?)=(.*)$') { $h[$Matches[1]]=$Matches[2] } }; $h['VRROptimizeEnable']='0'; $h['SwapEffectUpgradeEnable']='1'; $s=(($h.Keys | ForEach-Object { $_ + '=' + $h[$_] }) -join ';') + ';'; Set-ItemProperty -Path $k -Name DirectXUserGlobalSettings -Value $s -Type String" >nul 2>&1
exit /b


:15
:network
cls
echo.
echo.
echo.
echo.                                                             %p%███████╗░  ████████╗  ███████╗░  ████████╗
echo.                                                             %p%██╔═══██╗  ██╔═════╝  ██╔═══██╗  ██╔═════╝
echo.                                                             %p%███████╔╝  ██████╗░░  ██║░░░██║  ██████╗░░
echo.                                                             %p%██╔═══██╗  ██╔═══╝░░  ██║░░░██║  ██╔═══╝░░
echo.                                                             %p%██║░░░██║  ████████╗  ███████╔╝  ████████╗
echo.                                                             %p%╚═╝░░░╚═╝  ╚═══════╝  ╚══════╝░  ╚═══════╝
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                         %p%[%w%1%p%]%w% Aplicar otimizacoes de rede (placa e TCP)
echo.
echo.                                                         %p%[%w%2%p%]%w% Testar e aplicar o DNS mais rapido
echo.
echo.                                                         %p%[%w%3%p%]%w% Aprimorar Wi-Fi (ajustes, canais vizinhos, teste de estabilidade)
echo.
echo.                                                         %p%[%w%R%p%]%w% Reverter ajustes de rede
echo.
echo.
echo.                                                         %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════
echo.                                                    %W%Desativa economia de energia da placa, Gigabit Lite, EEE e Nagle
echo.                                                    %W%Coloca velocidade e duplex no maximo e ajusta RSS e TCP
echo.                                                    %W%A placa reinicia e a conexao cai por alguns segundos
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════
echo. 
set "input="
set /p input=:
if /i "%input%"=="1" goto net_do1
if /i "%input%"=="2" goto net_do2
if /i "%input%"=="3" goto net_do3
if /i "%input%"=="R" goto net_dor
if /i "%input%"=="M" cls & goto menu
goto network

:net_do1
cls
call :artps net_apply
call :art_done
goto network

:net_do2
cls
call :artps net_dns
call :art_done
goto network

:net_do3
cls
call :artps wifi_apply
call :art_done
goto network

:net_dor
cls
call :artps net_revert
call :art_done
goto network

::Caixa padrao de conclusao para os menus novos
:art_done
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
exit /b


:12
:storage
cls
echo.
echo.
echo.                                             %p%░████████╗  ██████████╗  ░███████╗░  ███████╗░  ░██████╗░  ░████████╗░ ████████╗
echo.                                             %p%██╔══════╝  ╚═══██╔═══╝  ██╔════██╗  ██╔═══██╗  ██╔═══██╗  ██╔══════╝░ ██╔═════╝
echo.                                             %p%╚███████╗░  ░░░░██║░░░░  ██║░░░░██║  ███████╔╝  ████████║  ██║░░░░██╗░ ██████╗░░
echo.                                             %p%░╚═════██╗  ░░░░██║░░░░  ██║░░░░██║  ██╔═══██╗  ██╔═══██║  ██║░░░░╚██╗ ██╔═══╝░░
echo.                                             %p%████████╔╝  ░░░░██║░░░░  ╚███████╔╝  ██║░░░██║  ██║░░░██║  ╚████████╔╝ ████████╗
echo.                                             %p%╚═══════╝░  ░░░░╚═╝░░░░  ░╚══════╝░  ╚═╝░░░╚═╝  ╚═╝░░░╚═╝  ░╚═══════╝░ ╚═══════╝
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                         %p%[%w%1%p%]%w% Trim/Desfragmentar Unidades
echo.
echo.                                                         %p%[%w%2%p%]%w% Ativar Cache de Gravacao do Usuario
echo.
echo.                                                         %p%[%w%3%p%]%w% Desativar Economia de Energia do SSD/NVMe (StorPort)
echo.
echo.                                                         %p%[%w%4%p%]%w% Verificar TRIM e modo do controlador (AHCI/NVMe)
echo.
echo.                                                         %p%[%w%5%p%]%w% Otimizar SSD: desativar indexacao e defrag agendado
echo.
echo.                                                         %p%[%w%6%p%]%w% Mover pasta Temp para a unidade mais rapida
echo.
echo.
echo.                                                         %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════
echo.                                                  %W%Executa Trim e desfragmenta suas unidades e aplica algumas otimizacoes
echo.                                                                         extras de armazenamento
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════
echo. 
set /p input=:
if /i %input% == 1 goto s1
if /i %input% == 2 goto s2
if /i %input% == 3 goto s3
if /i %input% == 4 goto s4
if /i %input% == 5 goto s5
if /i %input% == 6 goto s6
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect4

:MisspellRedirect4
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu4


:RedirectMenu4
cls
goto :12

:s4
cls
call :artps disk_check
call :art_done
goto :12

:s5
cls
call :artps disk_ssd
call :art_done
goto :12

:s6
cls
call :artps disk_temp
call :art_done
goto :12

:s3
echo %w% - Desativando Idle Power Management do StorPort, pode levar alguns segundos %b%
set "SP_COUNT=0"
for /f "tokens=*" %%s in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort" ^| findstr /b "HKEY" ^| findstr /e "StorPort"') do (
Reg.exe add "%%s" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f >nul 2>&1 && set /a SP_COUNT+=1
)
echo %w% - Dispositivos de armazenamento ajustados: !SP_COUNT! %b%
echo %w% - Reinicie o PC para o ajuste do StorPort ter efeito. Se o numero acima for 0, seu PC nao tem esse ajuste disponivel %b%
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :12

:s1
cls
echo %w% - Otimizando todas as unidades encontradas, Trim nos SSDs e desfragmentacao nos HDs%b%
echo %w% - Pode levar alguns minutos, nao feche esta janela%b%
echo.
defrag /C /O /H /U /V
set "DEFRAG_ERR=!errorlevel!"
if not "!DEFRAG_ERR!"=="0" (
echo.
echo %w% - O defrag terminou com o codigo !DEFRAG_ERR! em alguma unidade, se ja havia outra otimizacao rodando aguarde ela acabar e tente de novo%b%
)
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :12

:s2
cls
echo %w% - Ativando User Write Cache %b%
For /f "Delims=" %%k in ('Reg.exe Query HKLM\SYSTEM\CurrentControlSet\Enum /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s^|Find "HKEY"') do (
Reg.exe add "%%k\Device Parameters\Disk" /v UserWriteCacheSetting /t REG_DWORD /d 1 /f 
)

echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :12
:3
:windows
cls
echo.
echo.
echo.                                             %p%░██╗░░░░░░░██╗    ██╗    ███╗░░██╗    █████████╗░   ░████████╗░   ░██╗░░░░░░░██╗   ░█████████╗
echo.                                             %p%░██║░░██╗░░██║    ██║    ████╗░██║    ██╔═════██╗   ██╔═════██╗   ░██║░░██╗░░██║   ██╔═══════╝
echo.                                             %p%░╚██╗████╗██╔╝    ██║    ██╔██╗██║    ██║░░░░░██║   ██║░░░░░██║   ░╚██╗████╗██╔╝   ╚████████╗░
echo.                                             %p%░░████╔═████║░    ██║    ██║╚████║    ██║░░░░░██║   ██║░░░░░██║   ░░████╔═████║░   ░╚══════██╗
echo.                                             %p%░░╚██╔╝░╚██╔╝░    ██║    ██║░╚███║    █████████╔╝   ╚████████╔╝   ░░╚██╔╝░╚██╔╝░   █████████╔╝
echo.                                             %p%░░░╚═╝░░░╚═╝░░    ╚═╝    ╚═╝░░╚══╝    ╚════════╝░   ░╚═══════╝░   ░░░╚═╝░░░╚═╝░░   ╚════════╝░
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                      %p%[%w%A%p%]%w% Aplicar todas as otimizacoes da categoria Windows
echo.
echo.                                                      %p%[%w%1%p%]%w% Ajustes do Windows 11                   %p%[%w%2%p%]%w% Desativar Animacoes Inuteis
echo.
echo.                                                      %p%[%w%3%p%]%w% Desativar Notificacoes                  %p%[%w%4%p%]%w% Otimizar Pesquisa do Windows
echo.
echo.                                                      %p%[%w%5%p%]%w% Desativar Transparencia                 %p%[%w%6%p%]%w% Desativar Rel. de Erros
echo.
echo.                                                      %p%[%w%7%p%]%w% Desativar Sincronizacao                 %p%[%w%8%p%]%w% Desativar Diagnosticos
echo.
echo.                                                      %p%[%w%9%p%]%w% Desativar Apps em 2o Plano              %p%[%w%10%p%]%w% Desativar Experimentos
echo.
echo.                                                      %p%[%w%11%p%]%w% Desativar Rastreamento                 %p%[%w%12%p%]%w% Desativar Pop-ups e mais
echo.
echo.                                                      %p%[%w%13%p%]%w% Desativar Feed de Atividades           %p%[%w%14%p%]%w% Desativar SmartScreen
echo.
echo.                                                      %p%[%w%15%p%]%w% Impedir Reinstalar Apps Pre-inst.      %p%[%w%16%p%]%w% Desativar Exp. Compart.
echo.
echo.                                                      %p%[%w%17%p%]%w% Registrar So Falhas Importantes
echo.
echo.
echo.                                                      %p%[%w%R%p%]%w% Reverter Categoria
echo.
echo.                                                      %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                            %W%Otimiza varias configuracoes do Windows para o melhor desempenho
echo.                                                           %W%Desativa varios itens incomodos como notificacoes, pop-ups e mais
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.
set /p input=:
if /i %input% == A goto WA
if /i %input% == 1 goto win11menu
if /i %input% == 2 goto w3
if /i %input% == 3 goto w2
if /i %input% == 4 goto w4
if /i %input% == 5 goto w1
if /i %input% == 6 goto w7
if /i %input% == 7 goto w8
if /i %input% == 8 goto w9
if /i %input% == 9 goto w10
if /i %input% == 10 goto w11
if /i %input% == 11 goto w14
if /i %input% == 12 goto w15
if /i %input% == 13 goto w16
if /i %input% == 14 goto w17
if /i %input% == 15 goto w18
if /i %input% == 16 goto w19
if /i %input% == 17 goto w20
if /i %input% == M cls & goto menu
if /i %input% == R cls & goto :revert
) ELSE (
echo Entrada invalida & goto MisspellRedirect5

:MisspellRedirect5
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu5

:RedirectMenu5
goto :3



:w4
echo %w% - Otimizando Pesquisa do Windows%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaCapabilities" /t REG_SZ /d "" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "IsAssignedAccess" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "IsWindowsHelloActive" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchSafeSearch" /t REG_DWORD /d 3 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\Software\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\SearchCompanion" /v "DisableContentFileUpdates" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DoNotUseWebResults" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto windows

:w20
echo %w% - Registrando apenas eventos de falha importantes %b%
Auditpol /set /subcategory:"Process Termination" /success:Disable /failure:Enable
Auditpol /set /subcategory:"RPC Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Filtering Platform Connection" /success:Disable /failure:Enable
Auditpol /set /subcategory:"DPAPI Activity" /success:Disable /failure:Disable
Auditpol /set /subcategory:"IPsec Driver" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Other System Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security State Change" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security System Extension" /success:Disable /failure:Enable
Auditpol /set /subcategory:"System Integrity" /success:Disable /failure:Enable
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "0" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
pause > nul
cls
goto windows

:WA
cls
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Isso aplicara todos os ajustes da pagina do Windows', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo. 
echo. 
echo.                                              %b%╔═════════════════════════════════════════════════════════════════════════╗
echo.                                              %b%║ %w%  Pressione "S" para continuar, "N" para voltar                        %b% %b%║
echo.                                              %b%╚═════════════════════════════════════════════════════════════════════════╝


set /p input=:
if /i %input% == Y goto :WAA
if /i %input% == S goto :WAA
if /i %input% == N cls & goto windows


:waa
cls

echo %w% - Otimizando Pesquisa do Windows%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaCapabilities" /t REG_SZ /d "" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "IsAssignedAccess" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "IsWindowsHelloActive" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchSafeSearch" /t REG_DWORD /d 3 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f
Reg.exe add "HKLM\Software\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\SearchCompanion" /v "DisableContentFileUpdates" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DoNotUseWebResults" /t REG_DWORD /d "1" /f

echo %w% - Registrando apenas eventos de falha importantes %b%
Auditpol /set /subcategory:"Process Termination" /success:Disable /failure:Enable
Auditpol /set /subcategory:"RPC Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Filtering Platform Connection" /success:Disable /failure:Enable
Auditpol /set /subcategory:"DPAPI Activity" /success:Disable /failure:Disable
Auditpol /set /subcategory:"IPsec Driver" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Other System Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security State Change" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security System Extension" /success:Disable /failure:Enable
Auditpol /set /subcategory:"System Integrity" /success:Disable /failure:Enable
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "0" /f

echo %w% - Desativando Experimentos do Windows Insider%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Feed de Atividades%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f

echo %w% - Desativando Notificacoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f


echo %w% - Desativando Servicos de Diagnostico%b%
sc config DiagTrack start= Disabled 
sc config dmwappushservice start= Disabled
sc config diagnosticshub.standardcollector.service start= Disabled 

echo %w% - Desativando Relatorio de Erros do Windows%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 

echo %w%- Desativando Experiencias Compartilhadas %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f

echo %w% - Desativando Sincronizacao de Configuracoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f 

echo %w%- Impedindo a reinstalacao de apps pre-instalados %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" 

echo %w%- Desativando Apps em Segundo Plano %b%
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f 

echo %w%- Desativando Transparencia %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f

echo %w% - Desativando Rastreamento e alguns diagnosticos%b%
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "1" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable


cls 

call :vfx_apply

chcp 65001 >nul 
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto menu









:w19
echo %w%- Desativando Experiencias Compartilhadas %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :windows

:w17
echo %w%- Desativando SmartScreen do Windows %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :windows

:w18
echo %w%- Impedindo a reinstalacao de apps pre-instalados %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows


:w10
cls
echo %w%- Desativando Apps em Segundo Plano %b%
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

 
:w1
cls
echo %w%- Desativando Transparencia %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows


:w14
cls
echo %w% - Desativando Rastreamento e alguns diagnosticos%b%
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "1" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:13
cls
echo.
echo.

echo.                                             %p%██████████╗   ██╗   ██╗░░██╗           █████████╗░   ██╗  ░█████████╗  ░████████╗░
echo.                                             %p%██╔═══════╝   ██║   ╚██╗██╔╝           ██╔═════██╗   ██║  ██╔═══════╝  ██╔═════██╗
echo.                                             %p%████████╗░░   ██║   ░╚███╔╝░           ██║░░░░░██║   ██║  ╚████████╗░  ██║░░░░░╚═╝
echo.                                             %p%██╔═════╝░░   ██║   ░██╔██╗░           ██║░░░░░██║   ██║  ░╚══════██╗  ██║░░░░░██╗
echo.                                             %p%██║░░░░░░░░   ██║   ██╔╝╚██╗           █████████╔╝   ██║  █████████╔╝  ╚████████╔╝
echo.                                             %p%╚═╝░░░░░░░░   ╚═╝   ╚═╝░░╚═╝           ╚════════╝░   ╚═╝  ╚════════╝░  ░╚═══════╝░
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                                     %p%[%w%1%p%]%w% Corrigir Arquivos Corrompidos
echo.
echo.
echo.                                                                     %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════
echo.                                                %w%Repara a imagem do Windows (DISM) e os arquivos protegidos do sistema (SFC)
echo.                                                                                  e depois
echo.                                                 %w%limpa componentes antigos. Nao instala atualizacoes. Pode levar de 10 a 40
echo.                                                                                  minutos.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════

set /p input=:
if /i %input% == 1 goto f1
if /i %input% == M cls & goto menu

) ELSE (
echo %w%- Entrada invalida %b% & goto MisspellRedirect8

:MisspellRedirect8
cls
echo %w%- Erro de digitacao detectado  %b%
timeout 2
goto RedirectMenu8


:RedirectMenu8
cls
goto :13

:f1
echo %w% - Etapa 1 de 3: DISM RestoreHealth, verifica e repara a imagem do Windows, pode parecer travado em 20 a 40 porcento, e normal%b%
DISM /Online /Cleanup-Image /RestoreHealth
set "DISM_ERR=!errorlevel!"
if not "!DISM_ERR!"=="0" (
echo.
echo %w% - O DISM terminou com o erro !DISM_ERR!, a causa mais comum e o Windows Update sem acesso, veja C:\Windows\Logs\DISM\dism.log%b%
)
echo.
echo %w% - Etapa 2 de 3: SFC, verifica e repara os arquivos protegidos do sistema%b%
sfc /scannow
echo.
echo %w% - Etapa 3 de 3: DISM StartComponentCleanup, remove componentes antigos do WinSxS%b%
DISM /Online /Cleanup-Image /StartComponentCleanup
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:11war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Obs: se quiser reverter algo, use a categoria de reversoes na pagina principal do utilitario', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
chcp 65001 >nul 2>&1

:11
:Debloat
cls
echo.
echo.
echo.                                             %p%█████████╗░    ██████████╗   █████████╗░   ██╗░░░░░░░   ░███████╗░   ░███████╗░   ███████████╗
echo.                                             %p%██╔═════██╗    ██╔═══════╝   ██╔═════██╗   ██║░░░░░░░   ██╔════██╗   ██╔════██╗   ╚════██╔═══╝
echo.                                             %p%██║░░░░░██║    ████████╗░░   █████████╦╝   ██║░░░░░░░   ██║░░░░██║   █████████║   ░░░░░██║░░░░
echo.                                             %p%██║░░░░░██║    ██╔═════╝░░   ██╔═════██╗   ██║░░░░░░░   ██║░░░░██║   ██╔════██║   ░░░░░██║░░░░
echo.                                             %p%█████████╔╝    ██████████╗   █████████╦╝   █████████╗   ╚███████╔╝   ██║░░░░██║   ░░░░░██║░░░░
echo.                                             %p%╚════════╝░    ╚═════════╝   ╚════════╝░   ╚════════╝   ░╚══════╝░   ╚═╝░░░░╚═╝   ░░░░░╚═╝░░░░
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                       %p%[%w%A%p%]%w% Aplicar tudo
echo.
echo.                                                       %p%[%w%1%p%]%w% Desativar Telemetria                   %p%[%w%2%p%]%w% Desinstalar Apps Inuteis
echo.
echo.                                                       %p%[%w%3%p%]%w% Desativar Telem. Office                %p%[%w%4%p%]%w% Desativar Impressao e Mapas
echo.
echo.                                                       %p%[%w%5%p%]%w% Desinstalar Cortana                    %p%[%w%6%p%]%w% Desativar Autologgers
echo.
echo.                                                       %p%[%w%7%p%]%w% Desativar Programa de Experiencia      %p%[%w%8%p%]%w% Otimizar Servicos (preset seguro)
echo.
echo.                                                       %p%[%w%9%p%]%w% Modo Jogo (pausar ou retomar servicos pesados)
echo.
echo.                                                       %p%[%w%10%p%]%w% Desativar Game DVR e Game Bar
echo.
echo.
echo.
echo.
echo.                                                       %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                                       %p%[%w%R%p%]%w% Reverter Categoria
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                                         %w%Nao desative o que voce realmente usa!
echo.
echo.                                                                   %w%Desinstala e desativa recursos inuteis do Windows
echo.                                                       %w%Remove bloatware do sistema que roda em segundo plano consumindo recursos
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.

set /p input=:
if /i %input% == A goto AD
if /i %input% == 1 goto d2
if /i %input% == 2 goto d4
if /i %input% == 3 goto d5
if /i %input% == 4 goto d6
if /i %input% == 5 goto d7
if /i %input% == 6 goto d9
if /i %input% == 7 goto d10
if /i %input% == 8 goto d11
if /i %input% == 9 goto d12
if /i %input% == 10 goto d13
if /i %input% == M cls & goto menu
if /i %input% == R cls & goto debloat_revert
) ELSE (
echo Entrada invalida & goto MisspellRedirect9

:MisspellRedirect9
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu9

:RedirectMenu9
goto :11

:AD
cls
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Isso aplicara todos os ajustes desta pagina. Deseja continuar?', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo. 
echo.                                              %b%"═══════════════════════════════════════════════════════════════"
echo.                                                %w%  Pressione "S" para continuar, "N" para voltar
echo.                                              %b%"═══════════════════════════════════════════════════════════════"

set /p input=:
if /i %input% == Y goto :DA
if /i %input% == S goto :DA
if /i %input% == N cls & goto debloat
cls & goto debloat

:d11
cls
call :artps svc_apply
call :art_done
goto :11

:d12
cls
echo.
echo %w% Modo Jogo: pausa servicos pesados enquanto voce joga e retoma depois%b%
echo.
choice /c:PRM /n /m "   [P] Pausar   [R] Retomar   [M] Voltar  "
if errorlevel 3 cls & goto :11
if errorlevel 2 goto d12r
call :artps gm_on
call :art_done
goto :11

:d12r
call :artps gm_off
call :art_done
goto :11

:d13
cls
call :artps dvr_apply
call :art_done
goto :11

:d2
echo %w% - Desativando Telemetria pelo Agendador de Tarefas %b%
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" >nul 2>&1
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\Office 15 Subscription Heartbeat" >nul 2>&1
schtasks /change /TN "\Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Device Information\Device" >nul 2>&1
schtasks /change /TN "\Microsoft\Windows\Device Information\Device" /Disable >nul 2>&1
timeout /t 1 /nobreak > NUL
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls

goto :debloat
:d9
echo %w% - Desativando Autologgers%b%
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :debloat

:DA
call :artps svc_apply
call :artps dvr_apply
::1

echo %w% - Desativando Telemetria pelo Agendador de Tarefas %b%
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" >nul 2>&1
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Office\Office 15 Subscription Heartbeat" >nul 2>&1
schtasks /change /TN "\Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Device Information\Device" >nul 2>&1
schtasks /change /TN "\Microsoft\Windows\Device Information\Device" /Disable >nul 2>&1
timeout /t 1 /nobreak > NUL

echo %w% - Desativando Autologgers%b%
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Programa de Melhoria da Experiencia do Cliente%b%
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" > nul 2>&1

::2
echo %w% - Desativando Servicos de Impressao e Mapas  %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f

::3
echo %w% - Desativando Telemetria do Office  %b%
Reg.exe add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "sendcustomerdata" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "includescreenshot" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "SendTelemetry" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "qmEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "updatereliabilitydata" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "shownfirstrunoptin" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "skydrivesigninoption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\ptwatson" /v "ptwoptin" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Firstrun" /v "Disablemovie" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableFileObfuscation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "accesssolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "olksolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "onenotesolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "pptsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "projectsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "publishersolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "visiosolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "wdsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "xlsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "agave" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "appaddins" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "comaddins" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "documentfiles" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "templatefiles" /t REG_DWORD /d "1" /f

::7
cls
chcp 437 > nul
echo.
echo.
echo [                              ] 0%%
echo.
echo %w%- Desinstalando BingWeather (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.BingWeather* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=                             ] 4%%
echo.
echo %w%- Desinstalando GetHelp (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.GetHelp* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [===                           ] 9%%
echo.
echo %w%- Desinstalando Getstarted (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Getstarted* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [====                          ] 13%%
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Messaging* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=====                         ] 17%%
echo.
echo %w%- Desinstalando Microsoft3DViewer (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=======                       ] 22%%
echo.
echo %w%- Desinstalando MicrosoftSolitaireCollection (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [========                      ] 26%%
echo.
echo %w%- Desinstalando MicrosoftStickyNotes (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=========                     ] 30%%
echo.
echo %w%- Desinstalando MixedReality.Portal (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==========                    ] 35%%
echo.
echo %w%- Desinstalando OneConnect (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.OneConnect* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [============                  ] 39%%
echo.
echo %w%- Desinstalando People (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.People* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=============                 ] 43%%
echo.
echo %w%- Desinstalando Print3D (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Print3D* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==============                ] 48%%
echo.
echo %w%- Desinstalando SkypeApp (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.SkypeApp* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [================              ] 52%%
echo.
cls

echo.
echo.
echo [=================             ] 57%%
echo.
echo %w%- Desinstalando WindowsMaps (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.WindowsMaps* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==================            ] 61%%
echo.
echo %w%- Desinstalando WindowsFeedbackHub (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [====================          ] 65%%
echo.
cls

echo.
echo.
echo [=====================         ] 70%%
echo.
cls

echo.
echo.
echo [======================        ] 74%%
echo.
echo %w%- Desinstalando 3dBuilder (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.3dBuilder* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=======================       ] 78%%
echo.
echo %w%- Desinstalando Apps Bing (Microsoft.Bing*) (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Bing* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=========================     ] 83%%
echo.
echo %w%- Desinstalando CommsPhone (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *CommsPhone* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==========================    ] 87%%
echo.
echo %w%- Desinstalando Drawboard PDF (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Drawboard* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [===========================   ] 91%%
echo.
echo %w%- Desinstalando Sway (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Office.Sway* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [============================= ] 96%%
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsPhone* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==============================] 100%%
echo %w%- Finalizado! %b%
chcp 65001 > nul

::8
echo %w% - Desativando Servicos e Recursos Relacionados a Cortana%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 


chcp 437 >nul 
timeout /t 1 /nobreak > NUL
echo %w% - Desinstalando Cortana%b%
Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" 
timeout /t 1 /nobreak > NUL
chcp 65001 >nul 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu



:d6 
cls
echo %w% - Desativando Servicos de Impressao e Mapas  %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:d5
cls
echo %w% - Desativando Telemetria do Office  %b%
Reg.exe add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "sendcustomerdata" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "includescreenshot" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "SendTelemetry" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "qmEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common" /v "updatereliabilitydata" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "shownfirstrunoptin" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "skydrivesigninoption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Common\ptwatson" /v "ptwoptin" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Firstrun" /v "Disablemovie" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableFileObfuscation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "accesssolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "olksolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "onenotesolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "pptsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "projectsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "publishersolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "visiosolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "wdsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /v "xlsolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "agave" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "appaddins" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "comaddins" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "documentfiles" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /v "templatefiles" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:w8
cls
echo %w% - Desativando Sincronizacao de Configuracoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w7
echo %w% - Desativando Relatorio de Erros do Windows%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w9
echo %w% - Desativando Servicos de Diagnostico%b%
sc stop DiagTrack > nul 2>&1
sc config DiagTrack start= Disabled > nul 2>&1
sc stop dmwappushservice > nul 2>&1
sc config dmwappushservice start= Disabled > nul 2>&1
sc stop diagnosticshub.standardcollector.service > nul 2>&1
sc config diagnosticshub.standardcollector.service start= Disabled > nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w2
cls
echo %w% - Desativando Notificacoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:d7
cls
echo %w% - Desativando Cortana%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 


chcp 437 >nul 
timeout /t 1 /nobreak > NUL
Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" 
timeout /t 1 /nobreak > NUL
chcp 65001 >nul 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:w3
cls 

call :vfx_apply
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

::Subrotina: aplica direto os efeitos visuais em Personalizar, sem abrir a janela Opcoes de Desempenho
::Desmarcados: caixas de combinacao, animacoes da barra de tarefas, controles e janelas, itens de menu, dicas, menus,
::Peek, retangulo de selecao translucido, sombras sob janelas e mouse, rolagem suave, miniaturas salvas da barra
::Marcados: conteudo da janela ao arrastar, miniaturas em vez de icones, fontes suaves, sombras nos rotulos de icones
:vfx_apply
echo %w% - Aplicando efeitos visuais personalizados%b%
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand QQBkAGQALQBUAHkAcABlACAALQBOAGEAbQBlACAATgAgAC0ATgBhAG0AZQBzAHAAYQBjAGUAIABVACAALQBNAGUAbQBiAGUAcgBEAGUAZgBpAG4AaQB0AGkAbwBuACAAJwBbAEQAbABsAEkAbQBwAG8AcgB0ACgAIgB1AHMAZQByADMAMgAuAGQAbABsACIAKQBdACAAcAB1AGIAbABpAGMAIABzAHQAYQB0AGkAYwAgAGUAeAB0AGUAcgBuACAAYgBvAG8AbAAgAFMAeQBzAHQAZQBtAFAAYQByAGEAbQBlAHQAZQByAHMASQBuAGYAbwAoAHUAaQBuAHQAIABhACwAIAB1AGkAbgB0ACAAYgAsACAASQBuAHQAUAB0AHIAIABjACwAIAB1AGkAbgB0ACAAZAApADsAJwANAAoAZgB1AG4AYwB0AGkAbwBuACAAUwBlAHQAUwBwAGkAKAAkAGEALAAkAGIALAAkAGMAKQB7AFsAVQAuAE4AXQA6ADoAUwB5AHMAdABlAG0AUABhAHIAYQBtAGUAdABlAHIAcwBJAG4AZgBvACgAJABhACwAJABiACwAWwBJAG4AdABQAHQAcgBdACQAYwAsADMAKQB8AE8AdQB0AC0ATgB1AGwAbAB9AA0ACgBmAG8AcgBlAGEAYwBoACgAJABhACAAaQBuACAAMAB4ADEAMAA0ADIALAAwAHgAMQAwADQANAAsADAAeAAxADAAMAAzACwAMAB4ADEAMAAxADUALAAwAHgAMQAwADEANwAsADAAeAAxADAAMAA3ACwAMAB4ADEAMAAxAEIALAAwAHgAMQAwADIANQApAHsAUwBlAHQAUwBwAGkAIAAkAGEAIAAwACAAMAB9AA0ACgBTAGUAdABTAHAAaQAgADAAeAAyADUAIAAxACAAMAANAAoAUwBlAHQAUwBwAGkAIAAwAHgANABCACAAMQAgADAADQAKACQAbQA9AFsAUgB1AG4AdABpAG0AZQAuAEkAbgB0AGUAcgBvAHAAUwBlAHIAdgBpAGMAZQBzAC4ATQBhAHIAcwBoAGEAbABdADoAOgBBAGwAbABvAGMASABHAGwAbwBiAGEAbAAoADgAKQANAAoAWwBSAHUAbgB0AGkAbQBlAC4ASQBuAHQAZQByAG8AcABTAGUAcgB2AGkAYwBlAHMALgBNAGEAcgBzAGgAYQBsAF0AOgA6AFcAcgBpAHQAZQBJAG4AdAAzADIAKAAkAG0ALAAwACwAOAApAA0ACgBbAFIAdQBuAHQAaQBtAGUALgBJAG4AdABlAHIAbwBwAFMAZQByAHYAaQBjAGUAcwAuAE0AYQByAHMAaABhAGwAXQA6ADoAVwByAGkAdABlAEkAbgB0ADMAMgAoACQAbQAsADQALAAwACkADQAKAFMAZQB0AFMAcABpACAAMAB4ADQAOQAgADgAIAAkAG0ADQAKAGYAdQBuAGMAdABpAG8AbgAgAFMAZQB0AFIAZQBnACgAJABrACwAJABuACwAJAB2ACkAewBpAGYAKAAhACgAVABlAHMAdAAtAFAAYQB0AGgAIAAkAGsAKQApAHsATgBlAHcALQBJAHQAZQBtACAAJABrACAALQBGAG8AcgBjAGUAfABPAHUAdAAtAE4AdQBsAGwAfQA7AE4AZQB3AC0ASQB0AGUAbQBQAHIAbwBwAGUAcgB0AHkAIAAtAFAAYQB0AGgAIAAkAGsAIAAtAE4AYQBtAGUAIAAkAG4AIAAtAFYAYQBsAHUAZQAgACQAdgAgAC0AUAByAG8AcABlAHIAdAB5AFQAeQBwAGUAIABEAFcAbwByAGQAIAAtAEYAbwByAGMAZQB8AE8AdQB0AC0ATgB1AGwAbAB9AA0ACgAkAGUAPQAnAEgASwBDAFUAOgBcAFMAbwBmAHQAdwBhAHIAZQBcAE0AaQBjAHIAbwBzAG8AZgB0AFwAVwBpAG4AZABvAHcAcwBcAEMAdQByAHIAZQBuAHQAVgBlAHIAcwBpAG8AbgBcAEUAeABwAGwAbwByAGUAcgAnAA0ACgBTAGUAdABSAGUAZwAgACIAJABlAFwAVgBpAHMAdQBhAGwARQBmAGYAZQBjAHQAcwAiACAAVgBpAHMAdQBhAGwARgBYAFMAZQB0AHQAaQBuAGcAIAAzAA0ACgBTAGUAdABSAGUAZwAgACIAJABlAFwAQQBkAHYAYQBuAGMAZQBkACIAIABUAGEAcwBrAGIAYQByAEEAbgBpAG0AYQB0AGkAbwBuAHMAIAAwAA0ACgBTAGUAdABSAGUAZwAgACIAJABlAFwAQQBkAHYAYQBuAGMAZQBkACIAIABMAGkAcwB0AHYAaQBlAHcAQQBsAHAAaABhAFMAZQBsAGUAYwB0ACAAMAANAAoAUwBlAHQAUgBlAGcAIAAiACQAZQBcAEEAZAB2AGEAbgBjAGUAZAAiACAATABpAHMAdAB2AGkAZQB3AFMAaABhAGQAbwB3ACAAMQANAAoAUwBlAHQAUgBlAGcAIAAiACQAZQBcAEEAZAB2AGEAbgBjAGUAZAAiACAASQBjAG8AbgBzAE8AbgBsAHkAIAAwAA0ACgBTAGUAdABSAGUAZwAgACcASABLAEMAVQA6AFwAUwBvAGYAdAB3AGEAcgBlAFwATQBpAGMAcgBvAHMAbwBmAHQAXABXAGkAbgBkAG8AdwBzAFwARABXAE0AJwAgAEUAbgBhAGIAbABlAEEAZQByAG8AUABlAGUAawAgADAADQAKAFMAZQB0AFIAZQBnACAAJwBIAEsAQwBVADoAXABTAG8AZgB0AHcAYQByAGUAXABNAGkAYwByAG8AcwBvAGYAdABcAFcAaQBuAGQAbwB3AHMAXABEAFcATQAnACAAQQBsAHcAYQB5AHMASABpAGIAZQByAG4AYQB0AGUAVABoAHUAbQBiAG4AYQBpAGwAcwAgADAA >nul 2>&1
echo %w% - Alguns efeitos so aparecem apos sair e entrar na conta ou reiniciar o Explorer%b%
exit /b

:d10
cls
echo %w% - Desativando Programa de Melhoria da Experiencia do Cliente%b%
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" > nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:w16
echo %w% - Desativando Feed de Atividades%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w15
echo %w% - Desativando Pop-ups, baloes de dica e mais%b%
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows


:w11
echo %w% - Desativando Experimentos do Windows Insider%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows



:d4
cls
chcp 437 > nul

echo.
echo.
echo [                              ] 0%%
echo.
echo %w%- Desinstalando BingWeather (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.BingWeather* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=                             ] 4%%
echo.
echo %w%- Desinstalando GetHelp (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.GetHelp* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [===                           ] 9%%
echo.
echo %w%- Desinstalando Getstarted (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Getstarted* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [====                          ] 13%%
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Messaging* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=====                         ] 17%%
echo.
echo %w%- Desinstalando Microsoft3DViewer (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=======                       ] 22%%
echo.
echo %w%- Desinstalando MicrosoftSolitaireCollection (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [========                      ] 26%%
echo.
echo %w%- Desinstalando MicrosoftStickyNotes (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=========                     ] 30%%
echo.
echo %w%- Desinstalando MixedReality.Portal (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==========                    ] 35%%
echo.
echo %w%- Desinstalando OneConnect (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.OneConnect* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [============                  ] 39%%
echo.
echo %w%- Desinstalando People (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.People* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=============                 ] 43%%
echo.
echo %w%- Desinstalando Print3D (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Print3D* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==============                ] 48%%
echo.
echo %w%- Desinstalando SkypeApp (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.SkypeApp* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [================              ] 52%%
echo.
cls

echo.
echo.
echo [=================             ] 57%%
echo.
echo %w%- Desinstalando WindowsMaps (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.WindowsMaps* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==================            ] 61%%
echo.
echo %w%- Desinstalando WindowsFeedbackHub (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [====================          ] 65%%
echo.
cls

echo.
echo.
echo [=====================         ] 70%%
echo.
cls

echo.
echo.
echo [======================        ] 74%%
echo.
echo %w%- Desinstalando 3dBuilder (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.3dBuilder* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=======================       ] 78%%
echo.
echo %w%- Desinstalando Apps Bing (Microsoft.Bing*) (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Bing* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [=========================     ] 83%%
echo.
echo %w%- Desinstalando CommsPhone (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *CommsPhone* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==========================    ] 87%%
echo.
echo %w%- Desinstalando Drawboard PDF (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Drawboard* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [===========================   ] 91%%
echo.
echo %w%- Desinstalando Sway (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.Office.Sway* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [============================= ] 96%%
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsPhone* | Remove-AppxPackage -AllUsers" >nul 2>&1
cls

echo.
echo.
echo [==============================] 100%%
echo %w%- Finalizado! %b%

chcp 65001 > nul
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :debloat



:debloat_revert
chcp 65001 >nul 2>&1
echo.
echo.
echo.                                             %p%█████████╗░    ██████████╗   █████████╗░   ██╗░░░░░░░   ░███████╗░   ░███████╗░   ███████████╗
echo.                                             %p%██╔═════██╗    ██╔═══════╝   ██╔═════██╗   ██║░░░░░░░   ██╔════██╗   ██╔════██╗   ╚════██╔═══╝
echo.                                             %p%██║░░░░░██║    ████████╗░░   █████████╦╝   ██║░░░░░░░   ██║░░░░██║   █████████║   ░░░░░██║░░░░
echo.                                             %p%██║░░░░░██║    ██╔═════╝░░   ██╔═════██╗   ██║░░░░░░░   ██║░░░░██║   ██╔════██║   ░░░░░██║░░░░
echo.                                             %p%█████████╔╝    ██████████╗   █████████╦╝   █████████╗   ╚███████╔╝   ██║░░░░██║   ░░░░░██║░░░░
echo.                                             %p%╚════════╝░    ╚═════════╝   ╚════════╝░   ╚════════╝   ░╚══════╝░   ╚═╝░░░░╚═╝   ░░░░░╚═╝░░░░
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                        %p%[%w%A%p%]%w% Reverter tudo
echo.
echo.                                                        %p%[%w%1%p%]%w% Reativar Telemetria                   %p%[%w%2%p%]%w% Reinstalar Apps Removidos
echo.
echo.                                                        %p%[%w%3%p%]%w% Reativar Telem. Office                %p%[%w%4%p%]%w% Reativar Impressao e Mapas
echo.
echo.                                                        %p%[%w%5%p%]%w% Restaurar Pesquisa/Cortana            %p%[%w%6%p%]%w% Restaurar Autologgers
echo.
echo.                                                        %p%[%w%7%p%]%w% Reativar Programa de Experiencia       %p%[%w%8%p%]%w% Reativar Servicos Otimizados
echo.
echo.                                                        %p%[%w%9%p%]%w% Retomar Servicos do Modo Jogo
echo.
echo.                                                        %p%[%w%10%p%]%w% Reativar Game DVR e Game Bar
echo.
echo.
echo.                                                        %p%[%w%M%p%]%w% Voltar ao Debloat
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                        %w%Cada item aqui desfaz o que o item de mesmo numero da pagina Debloat fez
echo.                                                           %w%Apps removidos so voltam se a Microsoft Store ainda tiver o pacote
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════════════════════
echo.
set "input="
set /p input=:
if /i "!input!"=="A" goto rvd_all
if "!input!"=="1" call :rvd_tasks & goto rvd_done
if "!input!"=="2" call :rvd_apps & goto rvd_done
if "!input!"=="3" call :rvd_office & goto rvd_done
if "!input!"=="4" call :rvd_print & goto rvd_done
if "!input!"=="5" call :rvd_cortana & goto rvd_done
if "!input!"=="6" call :rvd_autolog & goto rvd_done
if "!input!"=="7" call :rvd_exp & goto rvd_done
if "!input!"=="8" call :rvd_svc & goto rvd_done
if "!input!"=="9" call :rvd_gm & goto rvd_done
if "!input!"=="10" call :rvd_dvr & goto rvd_done
if /i "!input!"=="M" cls & goto debloat
echo Entrada invalida
timeout /t 1 /nobreak >nul
goto debloat_revert

:rvd_all
call :rvd_tasks
call :rvd_apps
call :rvd_office
call :rvd_print
call :rvd_cortana
call :rvd_autolog
call :rvd_exp
call :rvd_svc
call :rvd_gm
call :rvd_dvr

:rvd_done
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto debloat_revert

:rvd_dvr
call :artps dvr_revert
exit /b

:rvd_svc
call :artps svc_revert
exit /b

:rvd_gm
call :artps gm_off
exit /b

::Reverte Telemetria (opcao 1): reativa todas as tarefas agendadas que o Debloat desativou
:rvd_tasks
echo %w% - Reativando tarefas agendadas de telemetria e diagnostico%b%
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Office\Office 15 Subscription Heartbeat" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /Enable >nul 2>&1
exit /b

::Reverte Apps Inuteis (opcao 2): registra de novo os apps que ainda existem no disco
:rvd_apps
echo %w% - Reinstalando apps padrao do Windows, pode levar alguns minutos%b%
chcp 437 > nul
powershell -NoProfile -Command "Get-AppxPackage -AllUsers | ForEach-Object { if ($_.InstallLocation) { $m = Join-Path $_.InstallLocation 'AppxManifest.xml'; if (Test-Path $m) { Add-AppxPackage -DisableDevelopmentMode -Register $m -ErrorAction SilentlyContinue } } }" >nul 2>&1
chcp 65001 > nul
echo %w% - Apps cujos arquivos foram apagados pelo Debloat nao voltam por aqui, reinstale pela Microsoft Store%b%
exit /b

::Reverte Telemetria do Office (opcao 3): apaga os valores criados, o padrao do Office e nao ter nenhum deles
:rvd_office
echo %w% - Restaurando telemetria padrao do Office%b%
Reg.exe delete "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common" /v "sendcustomerdata" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "includescreenshot" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "SendTelemetry" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common" /v "qmEnable" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common" /v "updatereliabilitydata" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "shownfirstrunoptin" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common\General" /v "skydrivesigninoption" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Common\ptwatson" /v "ptwoptin" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\Firstrun" /v "Disablemovie" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\OSM" /v "Enablelogging" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableUpload" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\OSM" /v "EnableFileObfuscation" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\OSM\preventedapplications" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Microsoft\Office\16.0\OSM\preventedsolutiontypes" /f >nul 2>&1
exit /b

::Reverte Impressao e Mapas (opcao 4): Spooler automatico, PrintNotify manual, MapsBroker automatico atrasado (padroes do Windows)
:rvd_print
echo %w% - Reativando Servicos de Impressao e Mapas%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "DelayedAutostart" /t REG_DWORD /d "1" /f >nul 2>&1
sc start Spooler >nul 2>&1
exit /b

::Reverte Cortana (opcao 5): remove as politicas de pesquisa e tenta registrar o app de novo
:rvd_cortana
echo %w% - Restaurando Pesquisa do Windows e Cortana%b%
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /f >nul 2>&1
chcp 437 > nul
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.549981C3F5F10* | ForEach-Object { if ($_.InstallLocation) { Add-AppxPackage -DisableDevelopmentMode -Register (Join-Path $_.InstallLocation 'AppxManifest.xml') -ErrorAction SilentlyContinue } }" >nul 2>&1
chcp 65001 > nul
echo %w% - A Cortana foi descontinuada pela Microsoft, se o app foi removido ele nao volta, so as configuracoes de pesquisa%b%
exit /b

::Reverte Autologgers (opcao 6): Start=1 so nos que existem, sem criar chaves novas, mais os ajustes extras da opcao
:rvd_autolog
echo %w% - Restaurando Autologgers e ajustes extras%b%
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" >nul 2>&1 && Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /f >nul 2>&1
exit /b

::Reverte Programa de Experiencia (opcao 7): reativa as tarefas CEIP, Compatibilidade e Family Safety
:rvd_exp
echo %w% - Reativando Programa de Melhoria da Experiencia do Cliente%b%
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Enable >nul 2>&1
exit /b

:e
:revert
cls
echo.
echo.
echo.                                           %p%█████████╗░       ██████████╗       ██╗░░░██╗       ██████████╗       █████████╗░      ███████████╗
echo.                                           %p%██╔═════██╗       ██╔═══════╝       ██║░░░██║       ██╔═══════╝       ██╔═════██╗      ╚════██╔═══╝
echo.                                           %p%█████████╔╝       ████████╗░░       ╚██╗░██╔╝       ████████╗░░       █████████╔╝      ░░░░░██║░░░░
echo.                                           %p%██╔═════██╗       ██╔═════╝░░       ░╚████╔╝░       ██╔═════╝░░       ██╔═════██╗      ░░░░░██║░░░░
echo.                                           %p%██║░░░░░██║       ██████████╗       ░░╚██╔╝░░       ██████████╗       ██║░░░░░██║      ░░░░░██║░░░░
echo.                                           %p%╚═╝░░░░░╚═╝       ╚═════════╝       ░░░╚═╝░░░       ╚═════════╝       ╚═╝░░░░░╚═╝      ░░░░░╚═╝░░░░
echo.                                           %b%═══════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                                    %w%Use estas opcoes para reverter certas otimizacoes
echo.
echo.
echo.                                               %p%[%w%1%p%]%w% Restaurar planos de energia padrao
echo.
echo.                                               %p%[%w%2%p%]%w% Reinstalar apps padrao do Windows
echo.
echo.                                               %p%[%w%3%p%]%w% Ativar Servicos XBOX
echo.
echo.                                               %p%[%w%4%p%]%w% Ativar GameDVR
echo.
echo.                                               %p%[%w%5%p%]%w% Ativar Notificacoes
echo.
echo.                                               %p%[%w%6%p%]%w% Ativar Bluetooth
echo.
echo.                                               %p%[%w%7%p%]%w% Ativar Inicializacao Rapida, Hibernacao e Sleep Study (nao recomendado, prejudica o PC)
echo.
echo.                                               %p%[%w%8%p%]%w% Ativar Power Throttling
echo.
echo.                                               %p%[%w%9%p%]%w% Ativar Manutencao
echo.
echo.                                               %p%[%w%10%p%]%w% Ativar Servicos de Impressao e Mapas
echo.
echo.                                               %p%[%w%11%p%]%w% Reverter Ajustes do Windows 11 (Copilot, Recall, Widgets, menu classico)
echo.
echo.                                               %p%[%w%12%p%]%w% Ativar SmartScreen do Windows
echo.
echo.                                               %p%[%w%13%p%]%w% Ativar Diagnosticos
echo.
echo.                                               %p%[%w%14%p%]%w% Ativar Relatorio de Erros
echo.
echo.                                               %p%[%w%15%p%]%w% Reverter todos os ajustes de energia
echo.
echo.                                               %p%[%w%16%p%]%w% Reativar Gerenciamento de Energia Ocioso do StorPort
echo.
echo.                                               %p%[%w%17%p%]%w% Reverter Ajustes de Rede (placa, Nagle, DNS, TCP)
echo.
echo.                                               %p%[%w%18%p%]%w% Reverter Jogos e Tela (HAGS, MPO, tela cheia, perfis por jogo)
echo.
echo.                                               %p%[%w%19%p%]%w% Reverter Disco (indexacao, defrag agendado, pasta Temp)
echo.
echo.                                               %p%[%w%20%p%]%w% Reverter CPU extra (boost, EPP, afinidade de interrupcoes)
echo.
echo.                                               %p%[%w%21%p%]%w% Reverter GPU integrada Intel (plano grafico, efeitos visuais, memoria de video)
echo.
echo.
echo.                                               %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                           %b%═══════════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                      %W%Permite reverter varias configuracoes sem precisar de um ponto de restauracao
echo.                                                %W%O que nao estiver listado aqui pode ser desfeito em Backup / Restauracao, tecla P no menu
echo.                                                                                        principal
echo.                                           %b%═══════════════════════════════════════════════════════════════════════════════════════════════════
echo.
set /p input=:
if /i %input% == 1 goto r1
if /i %input% == 2 goto r2
if /i %input% == 3 goto r3
if /i %input% == 4 goto r4
if /i %input% == 5 goto r5
if /i %input% == 6 goto r6
if /i %input% == 7 goto r7
if /i %input% == 8 goto r8
if /i %input% == 9 goto r9
if /i %input% == 10 goto r10
if /i %input% == 11 goto r12
if /i %input% == 12 goto r13
if /i %input% == 13 goto r14
if /i %input% == 14 goto r15
if /i %input% == 15 goto r16
if /i %input% == 16 goto r_storport
if /i %input% == 17 goto r_net
if /i %input% == 18 goto r_game
if /i %input% == 19 goto r_disk
if /i %input% == 20 goto r_cpu
if /i %input% == 21 goto r_igpu
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect10

:MisspellRedirect10
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu10


:RedirectMenu10
cls
goto :e

:r_net
cls
call :artps net_revert
call :art_done
goto :e

:r_game
cls
call :artps game_revert
call :art_done
goto :e

:r_disk
cls
call :artps disk_revert
call :art_done
goto :e

:r_igpu
cls
call :artps igpu_revert
call :art_done
goto :e

:r_cpu
cls
call :artps cpu_revert
call :art_done
goto :e

:r_storport
echo %w% - Restaurando Idle Power Management do StorPort ao padrao%b%
for /f "tokens=*" %%s in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort" ^| findstr /b "HKEY" ^| findstr /e "StorPort"') do Reg.exe delete "%%s" /v "EnableIdlePowerManagement" /f >nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :E

:r16
echo %w% - Ativando Log de Energia + Telemetria de Energia%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "1" /f 

echo %w%- Ativando Link State Power Management %b%
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\System\CurrentControlSet\Services" /s "EnableHIPM"^| FINDSTR /V "EnableHIPM"') DO (
echo %w%- Ativando HIPM %b%
Reg.exe add "%%a" /v "EnableHIPM" /t REG_DWORD /d "1" /f  > nul 
echo %w%- Ativando DIPM %b%
Reg.exe add "%%a" /v "EnableDIPM" /t REG_DWORD /d "1" /f > nul 
echo %w%- Ativando HDD Parking %b%
Reg.exe add "%%a" /v "EnableHDDParking" /t REG_DWORD /d "1" /f > nul 
FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKLM\System\CurrentControlSet\Services\=!
) > nul 
)
	
echo %w% - Ativando GPU Energy Driver%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "2" /f 

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "1" /f 

echo %w% - Ativando Power Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "0" /f 

echo %w% - Ativando Inicializacao Rapida, Hibernacao e Sleep Study%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f 
powercfg /h on
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /f >nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :E

:r15
echo %w% - Ativando Relatorio de Erros  %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r14
echo %w% - Ativando Diagnosticos %b%
sc config DPS start= auto
sc config DiagTrack start= demand 
sc config dmwappushservice start= demand 
sc config diagnosticshub.standardcollector.service start= demand 
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /Enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Enable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /f >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "0" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r13
echo %w% - Ativando SmartScreen do Windows  %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "On" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e


:r10
call :rvd_print
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r9
echo %w% - Ativando Manutencao %b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r8
echo %w% - Ativando Power Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "0" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r7
echo %w% - Ativando Inicializacao Rapida%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL

echo %w% - Ativando Hibernacao%b%
powercfg /h on
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL

echo %w% - Ativando Sleep Study%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "0" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r6
echo %w% - Ativando Bluetooth%b%
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BTAGService" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bthserv" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "2" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r5
cls
echo %w% - Ativando Notificacoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r4
echo %w% - Ativando Gamedvr Services%b%
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r3
echo %w% - Ativando Servicos Xbox%b%
sc config xbgm start= demand
sc config XblAuthManager start= demand
sc config XblGameSave start= demand
sc config XboxGipSvc start= demand
sc config XboxNetApiSvc start= demand
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r2
call :rvd_apps

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r1
echo %w% - Redefinindo planos de energia%b%
powercfg -restoredefaultschemes
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu



:exit
cls
echo.
echo.
chcp 437 >nul 2>&1
rem Mensagem sem ponto de exclamacao: com Delayed Expansion o cmd engole o texto entre dois "!"
powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $msg = 'Obrigado por usar o ART Utility, %USERNAME%.' + [char]10 + [char]10 + 'Para que todos os ajustes sejam aplicados corretamente, reinicie o PC.' + [char]10 + [char]10 + 'Deseja reiniciar agora?'; $r = [System.Windows.Forms.MessageBox]::Show($msg, 'ART Tweaking Utility', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Information); if ($r -eq 'Yes') { exit 1 } else { exit 0 }"
set "ART_REBOOT=%errorlevel%"
chcp 65001 >nul 2>&1
if "%ART_REBOOT%"=="1" shutdown /r /t 5 /c "ART Utility: reiniciando para aplicar os ajustes"
cls
exit





:8war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('NAO faca estes ajustes se o seu PC tem problemas de superaquecimento', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
timeout /t 1 /nobreak > nul
chcp 65001 >nul 2>&1

:8
:cpu
:cpu1
cls
echo.  
echo.  
echo.
echo.                                                                                    %p%░█████╗░██████╗░██╗░░░██╗
echo.                                                                                    %p%██╔══██╗██╔══██╗██║░░░██║
echo.                                                                                    %p%██║░░╚═╝██████╔╝██║░░░██║
echo.                                                                                    %p%██║░░██╗██╔═══╝░██║░░░██║
echo.                                                                                    %p%╚█████╔╝██║░░░░░╚██████╔╝
echo.                                                                                    %p%░╚════╝░╚═╝░░░░░░╚═════╝░
echo.
timeout 1 /nobreak > NUL

echo %w%- Desativando Core Parking  %b%
Reg.exe add HKLM\SYSTEM\CurrentControlSet\Control\Power /v CoreParkingDisabled /t REG_DWORD /d 1 /f
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100
powercfg /setactive SCHEME_CURRENT

echo %w%- CPU Cooling Tweaks %b%
powercfg /setACvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setDCvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setactive SCHEME_CURRENT

echo %w%- Estado minimo do processador: 100 por cento (CPU sempre na frequencia maxima) %b%
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg /setactive SCHEME_CURRENT

echo %w%- Desativando Throttle States%b%
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0
powercfg /setactive SCHEME_CURRENT

echo %w%- Ajustes extras: boost agressivo, CPU hibrida e afinidade de interrupcoes%b%
call :artps cpu_extra

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:7
:gpu
cls
echo.
echo.
echo.                                             %p%░█████████╗░                █████████╗░               ██╗░░░░░░██╗
echo.                                             %p%██╔═══════╝░                ██╔═════██╗               ██║░░░░░░██║
echo.                                             %p%██║░░░░░██╗░                █████████╔╝               ██║░░░░░░██║
echo.                                             %p%██║░░░░░╚██╗                ██╔══════╝░               ██║░░░░░░██║
echo.                                             %p%╚█████████╔╝                ██║░░░░░░░░               ╚█████████╔╝
echo.                                             %p%░╚════════╝░                ╚═╝░░░░░░░░               ░╚════════╝░
echo.                                             %b%══════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                          %p%[%w%1%p%]%w% Aplicar Otimizacoes para GPU NVIDIA
echo.
echo.                                                          %p%[%w%2%p%]%w% Aplicar Otimizacoes para GPU AMD
echo.
echo.                                                          %p%[%w%3%p%]%w% Aplicar Otimizacoes para GPU Intel
echo.
echo.                                                          %p%[%w%4%p%]%w% Ajustes de Jogos e Tela (HAGS, MPO, tela cheia)
echo.
echo.                                                          %p%[%w%5%p%]%w% Perfil por jogo (prioridade de CPU e GPU de um jogo)
echo.
echo.                                                          %p%[%w%6%p%]%w% GPU integrada Intel (plano grafico, efeitos visuais, memoria de video)
echo.
echo.
echo.
echo.                                                          %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════
echo.                                                           %w%Opcoes 1 a 3: tipo de GPU    4 a 6: jogos e GPU integrada
echo.
echo.                                                         %W%Otimiza sua GPU ajustando configuracoes 3D
echo.                                                        %W%Desativando economia de energia e muito mais
echo.                                             %b%══════════════════════════════════════════════════════════════════
echo.
set /p input=:
if /i %input% == 1 goto g1
if /i %input% == 2 goto g2
if /i %input% == 3 goto g3
if /i %input% == 4 goto gm_apply
if /i %input% == 5 goto gm_prof
if /i %input% == 6 goto gm_igpu
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect12

:MisspellRedirect12
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu12


:RedirectMenu12
cls
goto :7


:gm_apply
cls
call :artps game_apply
call :art_done
goto :7

:gm_igpu
cls
call :artps igpu_apply
call :art_done
goto :7

:gm_prof
cls
call :artps game_profile
call :art_done
goto :7

:g3
cls
echo.
echo.
echo.                                                          %p%██╗███╗░░██╗████████╗███████╗██╗░░░░░   ░██████╗░██████╗░██╗░░░██╗
echo.                                                          %p%██║████╗░██║╚══██╔══╝██╔════╝██║░░░░░   ██╔════╝░██╔══██╗██║░░░██║
echo.                                                          %p%██║██╔██╗██║░░░██║░░░█████╗░░██║░░░░░   ██║░░██╗░██████╔╝██║░░░██║
echo.                                                          %p%██║██║╚████║░░░██║░░░██╔══╝░░██║░░░░░   ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                          %p%██║██║░╚███║░░░██║░░░███████╗███████╗   ╚██████╔╝██║░░░░░╚██████╔╝
echo.                                                          %p%╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚══════╝╚══════╝   ░╚═════╝░╚═╝░░░░░░╚═════╝░
echo.
echo.
echo %w% - Intel Gpu Tweaks%b%
set "GPUFOUND="
for /f "usebackq delims=" %%k in (`powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}' | Where-Object { $_.PSChildName -match '[0-9]{4}$' -and ((Get-ItemProperty -LiteralPath $_.PSPath).MatchingDeviceId -match 'ven_8086') } | ForEach-Object { $_.Name }"`) do call :intel_class "%%k"
if not defined GPUFOUND echo %w% - Nenhuma GPU Intel encontrada. Ajustes do driver Intel ignorados.%b%


if defined GPUFOUND call :artps igpu_vram
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:intel_class
set "GPUFOUND=1"
Reg.exe add "%~1" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d "1" /f
Reg.exe add "%~1" /v "IncreaseFixedSegment" /t REG_DWORD /d "1" /f
Reg.exe add "%~1" /v "AdaptiveVsyncEnable" /t REG_DWORD /d "0" /f
Reg.exe add "%~1" /v "DisablePFonDP" /t REG_DWORD /d "1" /f
exit /b





:1 
cls
echo.
echo.
echo.                                             %p%░████████╗░  █████████╗  ███╗░░██╗  █████████╗  ████████╗░  ░██████╗░ ██╗░░░░░░
echo.                                             %p%██╔══════╝░  ██╔══════╝  ████╗░██║  ██╔══════╝  ██╔════██╗  ██╔═══██╗ ██║░░░░░░
echo.                                             %p%██║░░░░██╗░  ███████╗░░  ██╔██╗██║  ███████╗░░  ████████╔╝  ████████║ ██║░░░░░░
echo.                                             %p%██║░░░░╚██╗  ██╔════╝░░  ██║╚████║  ██╔════╝░░  ██╔════██╗  ██╔═══██║ ██║░░░░░░
echo.                                             %p%╚████████╔╝  █████████╗  ██║░╚███║  █████████╗  ██║░░░░██║  ██║░░░██║ ████████╗
echo.                                             %p%░╚═══════╝░  ╚════════╝  ╚═╝░░╚══╝  ╚════════╝  ╚═╝░░░░╚═╝  ╚═╝░░░╚═╝ ╚═══════╝
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                         %p%[%w%1%p%]%w% Aplicar Otimizacoes Gerais de Latencia e Desempenho
echo.
echo.
echo.
echo.                                                         %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════%w%
echo.                                                 %W%Aplica otimizacoes gerais no registro, bcdedit, jogos em janela e mais!
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════%w%
echo. 
echo. 

set /p input=:
if /i %input% == 1 goto general
if /i %input% == M CLS & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect13 

:MisspellRedirect13
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu13
:RedirectMenu13
cls
goto :1

:general
CLS
echo.
echo.
echo.                                                          %p%░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
echo.                                                          %p%██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
echo.                                                          %p%██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
echo.                                                          %p%██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
echo.                                                          %p%╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
echo.                                                          %p%░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝
echo.
echo.

::microsoft multimedia
echo %w% - Microsoft Mulitimedia Tweaks%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "FpsAll" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "FpsStatusGames" /t REG_DWORD /d "10" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "FpsStatusGamesAll" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "GameFluidity" /t REG_DWORD /d "1" /f

::bcd
echo %w% - Desativando Dynamic Tick%b%
bcdedit /set Disabledynamictick yes >nul 2>&1
echo %w% - Desativando High Precision Event Timer (HPET)%b%
bcdedit /deletevalue useplatformclock  >nul 2>&1
echo %w% - Desativando Synthetic Timers%b%
bcdedit /set useplatformtick yes  >nul 2>&1

echo %w% - Desativando High Precision Event Timer no Gerenciador de Dispositivos (Dispositivos do sistema)%b%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=@(Get-PnpDevice -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -like 'ACPI\PNP0103*' }); if ($d.Count -eq 0) { Write-Host '   HPET nao encontrado neste PC, nada a desativar.' } else { foreach ($x in $d) { try { Disable-PnpDevice -InstanceId $x.InstanceId -Confirm:$false -ErrorAction Stop; Write-Host ('   HPET desativado no Gerenciador de Dispositivos: ' + $x.FriendlyName) } catch { Write-Host '   Nao foi possivel desativar o HPET (precisa de administrador).' } } }"

::Timer do kernel
echo %w% - Garantindo GlobalTimerResolutionRequest = 1%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequest" /t REG_DWORD /d "1" /f >nul 2>&1

::Mouse e acessibilidade
echo %w% - Garantindo MouseThreshold1 e MouseThreshold2 em 0%b%
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
echo %w% - Garantindo Flags das Teclas do Mouse e das Teclas de Filtro em 0%b%
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1

::nfts
echo %w% - NFTS Tweaks%b%
fsutil behavior set memoryusage 2 >nul 2>&1
fsutil behavior set Disablelastaccess 1 >nul 2>&1

::mmcss
echo %w% - MMCSS Priority For Low Latency%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "BackgroundPriority" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Latency Sensitive" /t REG_SZ /d "True" /f
echo %w% - MMCSS Priority For Games%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "BackgroundPriority" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f

::win32priority
echo %w% - Configurando Win32Priority%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f 

 
::Menu Show Delay
echo %w% - Removendo atraso do menu%b%
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f


::CSRSS priority
echo %w% - Configurando CSRSS IO and CPU Priority to Realtime%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 

::Chaves LatencyTolerance removidas: nao trazem ganho comprovado

::SetSystemResponsivness
echo %w% - Configurando System Responsiveness%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f 

::GameMode
echo %w% - Ativando Modo Jogo%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 

::Jogos em janela, VRR e Overlay (antiga opcao 14)
call :gfx_windowed

timeout 3 > nul
cls 
:miti 
echo.
echo.
echo.                                              %p%███╗░░░███╗ ██╗ █████████╗ ██╗ ░███████╗░ ░██████╗░ █████████╗ ██╗░██████╗░███╗░░██╗░███████╗
echo.                                              %p%████╗░████║ ██║ ╚═══██╔══╝ ██║ ██╔═════╝░ ██╔═══██╗ ╚═══██╔══╝ ██║██╔═══██╗████╗░██║██╔═════╝
echo.                                              %p%██╔████╔██║ ██║ ░░░░██║░░░ ██║ ██║░░░██╗░ ████████║ ░░░░██║░░░ ██║██║░░░██║██╔██╗██║╚██████╗░
echo.                                              %p%██║╚██╔╝██║ ██║ ░░░░██║░░░ ██║ ██║░░░╚██╗ ██╔═══██║ ░░░░██║░░░ ██║██║░░░██║██║╚████║░╚════██╗
echo.                                              %p%██║░╚═╝░██║ ██║ ░░░░██║░░░ ██║ ╚███████╔╝ ██║░░░██║ ░░░░██║░░░ ██║╚██████╔╝██║░╚███║███████╔╝
echo.                                              %p%╚═╝░░░░░╚═╝ ╚═╝ ░░░░╚═╝░░░ ╚═╝ ░╚══════╝░ ╚═╝░░░╚═╝ ░░░░╚═╝░░░ ╚═╝░╚═════╝░╚═╝░░╚══╝╚══════╝░
echo.                                              %b%═════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                             %p%[%w%1%p%]%w% Desativar Mitigacoes      %p%[%w%2%p%]%w% Ativar Mitigacoes (reverter)
echo.
echo.
echo.                                                             %p%[%w%X%p%]%w% Pular
echo.
echo.                                              %b%═════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                      Mitigacoes protegem contra ataques baseados em memoria, mas custam desempenho
echo.                                                 Isto desativa varias basicas que causam perda de desempenho mas nao sao tao importantes
echo.                                              %b%═════════════════════════════════════════════════════════════════════════════════════════════%w%
         
set /p input=:
if /i %input% == 1 goto mitioff
if /i %input% == 2 goto mition
if /i %input% == X goto menu

) ELSE (
echo %w%- Entrada invalida %b% & goto MisspellRedirect14

:MisspellRedirect14
cls
echo %w%- Erro de digitacao detectado  %b%
timeout 2
goto RedirectMenu14

:RedirectMenu14
goto miti

:mitioff
::disable basic mitigations
echo %w% - Desativando VirtualizationBasedSecurity%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f 
echo %w% - Desativando HVCIMATRequired%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f 
echo %w% - Desativando Spectre And Meltdown%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu


:mition
echo %w% - Ativando Isolation Memory Integrity%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f
echo %w% - Ativando VirtualizationBasedSecurity%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "1" /f 
echo %w% - Ativando HVCIMAT%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "1" /f 
echo %w% - Ativando ExceptionChainValidation%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "0" /f 
echo %w% - Ativando Sehop%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "1" /f
echo %w% - Ativando CFG%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "1" /f 
echo %w% - Ativando Protection Mode%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "1" /f 
echo %w% - Ativando Spectre And Meltdown%b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /f 
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /f 
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /f
echo %w% - Ativando Address Space Layout Randomization%b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /f >nul 2>&1
 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu









:10war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('NAO faca estes ajustes se o seu PC tem problemas de superaquecimento', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
timeout /t 1 /nobreak > nul
chcp 65001 >nul 2>&1
:10

:power
cls
echo.
echo.
echo.                                             %p%█████████╗░       ░████████╗░       ░██╗░░░░░░░██╗      ██████████╗      █████████╗░
echo.                                             %p%██╔═════██╗       ██╔═════██╗       ░██║░░██╗░░██║      ██╔═══════╝      ██╔═════██╗
echo.                                             %p%█████████╔╝       ██║░░░░░██║       ░╚██╗████╗██╔╝      ████████╗░░      █████████╔╝
echo.                                             %p%██╔══════╝░       ██║░░░░░██║       ░░████╔═████║░      ██╔═════╝░░      ██╔═════██╗
echo.                                             %p%██║░░░░░░░░       ╚████████╔╝       ░░╚██╔╝░╚██╔╝░      ██████████╗      ██║░░░░░██║
echo.                                             %p%╚═╝░░░░░░░░       ░╚═══════╝░       ░░░╚═╝░░░╚═╝░░      ╚═════════╝      ╚═╝░░░░░╚═╝
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                          %p%[%w%1%p%]%w% Plano de Energia Desempenho Maximo (nativo)
echo.
echo.                                                          %p%[%w%2%p%]%w% Desativar Power Throttling, Link State e mais
echo.
echo.                                                          %p%[%w%3%p%]%w% Desativar Telemetria de Energia
echo.
echo.                                                          %p%[%w%4%p%]%w% Desativar Hibernacao, Inicializacao Rapida e mais
echo.
echo.
echo.                                                          %p%[%w%R%p%]%w% Reverter ajustes de energia (exceto plano de energia)
echo.
echo.
echo.                                                          %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════════
echo.                                                       %w%Pode aumentar a temperatura da CPU em PCs com refrigeracao fraca
echo.                                                        %W%Desativa varios recursos inuteis de economia de energia e mais
echo.                                             %b%════════════════════════════════════════════════════════════════════════════════════
echo.
echo.

set /p input=:
if /i %input% == 1 goto p1
if /i %input% == 2 goto p2
if /i %input% == 3 goto p3
if /i %input% == 4 goto p5
if /i %input% == R goto r16
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect15

:MisspellRedirect15
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu15


:RedirectMenu15
cls
goto :power



:p1
cls
echo %w% - Aplicando Ultimate Performance power plan%b%
chcp 437 >nul 2>&1
powershell -NoProfile -Command "$l = powercfg /list | Out-String; if ($l -match '([0-9a-fA-F-]{36})\s+\(ART Ultimate Performance\)') { $g = $Matches[1] } else { $o = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-String; if ($o -match '([0-9a-fA-F-]{36})') { $g = $Matches[1]; powercfg /changename $g 'ART Ultimate Performance' | Out-Null } }; if ($g) { powercfg /setactive $g; Write-Host ' Ultimate Performance plan is now active' } else { powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null; if ($LASTEXITCODE -eq 0) { Write-Host ' Ultimate Performance is not available here, High Performance is active' } else { Write-Host ' No performance power plan is available on this PC' } }"
chcp 65001 >nul 2>&1
powercfg.cpl
timeout /t 1 /nobreak > NUL
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power

:p5
cls
echo %w% - Desativando Inicializacao Rapida (prejudica o PC, mesmo acelerando o boot em poucos segundos) %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Hibernacao%b%
powercfg /h off
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Sleep Study (prefira desligar o PC em vez de suspender) %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power

:p3
echo %w% - Desativando Log de Energia + Telemetria de Energia%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power

:P2
cls
echo %w%- Desativando Link State Power Management %b%
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\System\CurrentControlSet\Services" /s "EnableHIPM"^| FINDSTR /V "EnableHIPM"') DO (
echo %w%- Desativando HIPM %b%
Reg.exe add "%%a" /v "EnableHIPM" /t REG_DWORD /d "0" /f  > nul 
echo %w%- Desativando DIPM %b%
Reg.exe add "%%a" /v "EnableDIPM" /t REG_DWORD /d "0" /f > nul 
echo %w%- Desativando HDD Parking %b%
Reg.exe add "%%a" /v "EnableHDDParking" /t REG_DWORD /d "0" /f > nul 
FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKLM\System\CurrentControlSet\Services\=!
) > nul 
)	
echo %w% - Desativando GPU Energy Driver%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f 

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Power Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power


:5
:RAM
cls
echo.
echo.
echo.                                             %p%███╗░░░███╗   ██████████╗   ███╗░░░███╗   ░████████╗░   █████████╗░  ██╗░░░██╗
echo.                                             %p%████╗░████║   ██╔═══════╝   ████╗░████║   ██╔═════██╗   ██╔═════██╗  ╚██╗░██╔╝
echo.                                             %p%██╔████╔██║   ████████╗░░   ██╔████╔██║   ██║░░░░░██║   █████████╔╝  ░╚████╔╝░
echo.                                             %p%██║╚██╔╝██║   ██╔═════╝░░   ██║╚██╔╝██║   ██║░░░░░██║   ██╔═════██╗  ░░╚██╔╝░░
echo.                                             %p%██║░╚═╝░██║   ██████████╗   ██║░╚═╝░██║   ╚████████╔╝   ██║░░░░░██║  ░░░██║░░░
echo.                                             %p%╚═╝░░░░░╚═╝   ╚═════════╝   ╚═╝░░░░░╚═╝   ░╚═══════╝░   ╚═╝░░░░░╚═╝  ░░░╚═╝░░░
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════%w%
echo.                                                                     Selecione quanta RAM voce tem:
echo.
echo.                                                                 %p%[%w%1%p%]%w% 4GB       %p%[%w%2%p%]%w% 8GB       %p%[%w%3%p%]%w% 12GB
echo.
echo.                                                                 %p%[%w%4%p%]%w% 16GB      %p%[%w%5%p%]%w% 24GB      %p%[%w%6%p%]%w% 32GB
echo.
echo.                                                                 %p%[%w%7%p%]%w% 48GB      %p%[%w%8%p%]%w% 64GB      %p%[%w%9%p%]%w% 128GB
echo.
echo.
echo.
echo.                                                                 %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════%w%
echo.                                                   %w%Otimiza varios valores de registro da RAM para o melhor desempenho
echo.                                                      %W%Desativa varios recursos inuteis que atrapalham o desempenho
echo.                                             %b%══════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.

set /p input=:
if /i %input% == 1 goto 4GB
if /i %input% == 2 goto 8GB
if /i %input% == 3 goto 12GB
if /i %input% == 4 goto 16GB
if /i %input% == 5 goto 24GB
if /i %input% == 6 goto 32GB
if /i %input% == 7 goto 48GB
if /i %input% == 8 goto 64GB
if /i %input% == 9 goto 128GB
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect16

:MisspellRedirect16
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu16

:RedirectMenu16
cls
goto :5

:4GB
chcp 437 >nul 2>&1
echo %w% - Ativando Compressao de Memoria%b%
PowerShell -Command "Enable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4194304" /f 


goto rest

:8GB
chcp 437 >nul 2>&1
echo %w% - Ativando Compressao de Memoria%b%
PowerShell -Command "Enable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "8388608" /f 


goto rest

:12GB
chcp 437 >nul 2>&1
echo %w% - Ativando Compressao de Memoria%b%
PowerShell -Command "Enable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "12582912" /f 


goto rest

:16GB

chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "16777216" /f 


goto rest

:24GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "25165824" /f 


goto rest

:32GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "33554432" /f 


goto rest

:48GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "50331648" /f 


goto rest

:64GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "67108864" /f 


goto rest

:128GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "134217728" /f 


goto rest

:rest

echo %w% - Desativando Combinacao de Paginas%b%
chcp 437 >nul 2>&1
PowerShell -Command "Disable-MMAgent -PageCombining" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Desativando Paging Executive%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f 



echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu




:g1
cls
echo.
echo.
echo.
echo.                                                              %p%███╗░░██╗██╗░░░██╗██╗██████╗░██╗░█████╗░   ░██████╗░██████╗░██╗░░░██╗
echo.                                                              %p%████╗░██║██║░░░██║██║██╔══██╗██║██╔══██╗   ██╔════╝░██╔══██╗██║░░░██║
echo.                                                              %p%██╔██╗██║╚██╗░██╔╝██║██║░░██║██║███████║   ██║░░██╗░██████╔╝██║░░░██║
echo.                                                              %p%██║╚████║░╚████╔╝░██║██║░░██║██║██╔══██║   ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                              %p%██║░╚███║░░╚██╔╝░░██║██████╔╝██║██║░░██║   ╚██████╔╝██║░░░░░╚██████╔╝
echo.                                                              %p%╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═╝░░╚═╝   ░╚═════╝░╚═╝░░░░░░╚═════╝░
timeout 1 /nobreak > NUL
set "GPUFOUND="
for /f "usebackq delims=" %%k in (`powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}' | Where-Object { $_.PSChildName -match '[0-9]{4}$' -and ((Get-ItemProperty -LiteralPath $_.PSPath).MatchingDeviceId -match 'ven_10de') } | ForEach-Object { $_.Name }"`) do call :nv_class "%%k"
if not defined GPUFOUND echo %w% - Nenhuma GPU NVIDIA encontrada. Ajustes do driver ignorados.%b%




for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_10DE"') do (
echo %w%- Excluindo GPU Device Priority %b%
Reg.exe delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1

echo %w%- Removendo Msi GPU Limits %b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /f >nul 2>&1

echo %w%- Ativando MSI Mode on GPU if supported %b%
Reg.exe add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)

echo %w%- Ajustando cache de memoria do NTFS%b%
fsutil behavior set memoryusage 2 >nul 2>&1



echo %w% - Desativando NVIDIA Telemetria%b%
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f 
schtasks /change /Disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /Disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1

echo %w%- Desativando GpuEnergy Driver %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f


echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:nv_class
set "GPUFOUND=1"
echo %w% - Configurando NVIDIA Latency Tolerance%b%
Reg.exe add "%~1" /v "D3PCLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "F1TransitionLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "LOWLATENCY" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "Node3DLowLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f 
Reg.exe add "%~1" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "RmGspcMaxFtuS" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "RmGspcMinFtuS" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "RmGspcPerioduS" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "VRDirectFlipDPCDelayUs" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "VRDirectFlipTimingMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "VRDirectJITFlipMsHybridFlipDelayUs" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "vrrCursorMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "vrrDeflickerMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "vrrDeflickerMaxUs" /t REG_DWORD /d "1" /f 

exit /b



:g2
cls
echo.
echo.
echo.
echo.                                                              %p%░█████╗░███╗░░░███╗██████╗░   ░██████╗░██████╗░██╗░░░██╗
echo.                                                              %p%██╔══██╗████╗░████║██╔══██╗   ██╔════╝░██╔══██╗██║░░░██║
echo.                                                              %p%███████║██╔████╔██║██║░░██║   ██║░░██╗░██████╔╝██║░░░██║
echo.                                                              %p%██╔══██║██║╚██╔╝██║██║░░██║   ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                              %p%██║░░██║██║░╚═╝░██║██████╔╝   ╚██████╔╝██║░░░░░╚██████╔╝
echo.                                                              %p%╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═════╝░   ░╚═════╝░╚═╝░░░░░░╚═════╝░
timeout 1 /nobreak > NUL
set "GPUFOUND="
for /f "usebackq delims=" %%k in (`powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}' | Where-Object { $_.PSChildName -match '[0-9]{4}$' -and ((Get-ItemProperty -LiteralPath $_.PSPath).MatchingDeviceId -match 'ven_1002') } | ForEach-Object { $_.Name }"`) do call :amd_class "%%k"
if not defined GPUFOUND echo %w% - Nenhuma GPU AMD encontrada. Ajustes do driver ignorados.%b%


for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_1002"') do (
echo %w%- Excluindo GPU Device Priority %b%
Reg.exe delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1

echo %w%- Removendo Msi GPU Limits %b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /f >nul 2>&1

echo %w%- Ativando MSI Mode on GPU if supported %b%
Reg.exe add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)

echo %w%- Desativando GpuEnergy Driver %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f





























echo %w% - Desativando AMD Logging%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f 

echo %w%- Ajustes de energia e interrupcoes (AMD)%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
timeout /t 1 /nobreak > NUL


echo %w%- Ajustando cache de memoria do NTFS%b%
fsutil behavior set memoryusage 2 >nul 2>&1


echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:amd_class
set "GPUFOUND=1"
echo %w% - Desativando Display Refresh Rate Override%b%
Reg.exe add "%~1" /v "3D_Refresh_Rate_Override_DEF" /t REG_DWORD /d "0" /f 

echo %w% - Desativando SnapShot%b%
Reg.exe add "%~1" /v "AllowSnapshot" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Subscriptions%b%
Reg.exe add "%~1" /v "AllowSubscription" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Radeon Overlay%b%
Reg.exe add "%~1" /v "AllowRSOverlay" /t REG_SZ /d "false" /f  

echo %w% - Ativando Adaptive De-Interlacing%b%
Reg.exe add "%~1" /v "Adaptive De-interlacing" /t REG_DWORD /d "1" /f 

echo %w% - Desativando Skins%b%
Reg.exe add "%~1" /v "AllowSkins" /t REG_SZ /d "false" /f  

echo %w% - Desativando Power Gating%b%
Reg.exe add "%~1" /v "DisableSAMUPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "DisableUVDPowerGatingDynamic" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "DisableVCEPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "DisablePowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "%~1" /v "DisabledrmdmaPowerGating" /t REG_DWORD /d "1" /f 

echo %w% - Desativando VCESW Clock Gating%b%
Reg.exe add "%~1" /v "EnableVceSwClockGating" /t REG_DWORD /d "0" /f 

echo %w% - Desativando UVD Clock Gating%b%
Reg.exe add "%~1" /v "EnableUvdClockGating" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Active State Power Management (ASPM)%b%
Reg.exe add "%~1" /v "EnableAspmL0s" /t REG_DWORD /d "0" /f 
Reg.exe add "%~1" /v "EnableAspmL1" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Ultra Low Power States (ULPS) %b%
Reg.exe add "%~1" /v "EnableUlps" /t REG_DWORD /d "0" /f 
Reg.exe add "%~1" /v "EnableUlps_NA" /t REG_SZ /d "0" /f 

echo %w% - Ativando BlockWrite%b%
Reg.exe add "%~1" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Stutter Mode%b%
Reg.exe add "%~1" /v "StutterMode" /t REG_DWORD /d "0" /f 

echo %w% - Desativando GPU Memory Clock Sleep State%b%
Reg.exe add "%~1" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f 

echo %w% - Configurando Main3D%b%
Reg.exe add "%~1\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f 
Reg.exe add "%~1\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f 

echo %w% - Configurando FlipQueueSize%b%
Reg.exe add "%~1\UMD" /v "FlipQueueSize" /t REG_BINARY /d "3100" /f 

echo %w% - Configurando Shader Cache Size%b%
Reg.exe add "%~1\UMD" /v "ShaderCache" /t REG_BINARY /d "3200" /f 

echo %w% - Configurando TFQ%b%
Reg.exe add "%~1\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f 

echo %w% - Desativando GPU Power Down%b%
Reg.exe add "%~1" /v "PP_GPUPowerDownEnabled" /t REG_DWORD /d "0" /f 

exit /b



:9
cls
echo.  
echo.  
echo.  
echo.                                                                           %p%██╗░░░██╗░██████╗██████╗░   ████████╗░██╗░░░░░░░██╗███████╗░█████╗░██╗░░██╗░██████╗
echo.                                                                           %p%██║░░░██║██╔════╝██╔══██╗   ╚══██╔══╝░██║░░██╗░░██║██╔════╝██╔══██╗██║░██╔╝██╔════╝
echo.                                                                           %p%██║░░░██║╚█████╗░██████╦╝   ░░░██║░░░░╚██╗████╗██╔╝█████╗░░███████║█████═╝░╚█████╗░
echo.                                                                           %p%██║░░░██║░╚═══██╗██╔══██╗   ░░░██║░░░░░████╔═████║░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
echo.                                                                           %p%╚██████╔╝██████╔╝██████╦╝   ░░░██║░░░░░╚██╔╝░╚██╔╝░███████╗██║░░██║██║░╚██╗██████╔╝
echo.                                                                           %p%░╚═════╝░╚═════╝░╚═════╝░   ░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
timeout 1 /nobreak > NUL
echo %w% - Desativando Economia de Energia do USB%b%
for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_USBController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f 
)

echo %w% - Desativando Suspensao Seletiva de USB%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d "1" /f >nul 2>&1

echo %w% - Reinicie o PC para que os ajustes de USB sejam aplicados.%b%
echo.
echo.
echo.
echo.                                              %b%"═══════════════════════════════════════════════════════"
echo.                                                %w%  Concluido, pressione qualquer tecla para continuar...
echo.                                              %b%"═══════════════════════════════════════════════════════"
pause > nul
cls
goto menu

:k1
cls
echo.
echo.
echo.
echo.
echo %w% - Desativando Teclas de Filtro (recurso inutil, um placebo)%b%
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f
echo %w% - Desativando Teclas de Alternancia%b%
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f
echo %w% - Desativando Teclas de Aderencia%b%
Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
echo %w% - Desativando Teclas do Mouse%b%
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f

echo %w% - Desativando Aceleracao do Mouse%b%
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f

echo %w% - Ativando 1:1 Pixel Mouse Movements%b%
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f

echo %w% - Reduzindo Atraso de Repeticao do Teclado%b%
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f

echo %w% - Aumentando Taxa de Repeticao do Teclado%b%
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto kbm

:2
:kbm
cls
echo.
echo.
echo.                                             %p%██╗░░██╗                 █████████╗░                 ███╗░░░███╗
echo.                                             %p%██║░██╔╝                 ██╔═════██╗                 ████╗░████║
echo.                                             %p%█████═╝░                 █████████╦╝                 ██╔████╔██║
echo.                                             %p%██╔═██╗░                 ██╔═════██╗                 ██║╚██╔╝██║
echo.                                             %p%██║░╚██╗                 █████████╦╝                 ██║░╚═╝░██║
echo.                                             %p%╚═╝░░╚═╝                 ╚════════╝░                 ╚═╝░░░░░╚═╝
echo.                                             %b%════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                   %p%[%w%1%p%]%w% Aplicar Otimizacoes de Registro (Mouse/Teclado)
echo.
echo.                                                   %p%[%w%2%p%]%w% Definir Tamanho da Fila de Dados
echo.
echo.
echo.                                                   %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.
echo.                                                                %p%%w%%w%%w%Feito por ART TWEAKS® 2026
echo.                                             %b%════════════════════════════════════════════════════════════════
echo.                                                   %w%Otimiza varias configuracoes de registro de mouse e
echo.                                                                         teclado
echo.                                             %b%════════════════════════════════════════════════════════════════
echo.

set /p input=:
if /i %input% == 1 goto k1
if /i %input% == 2 goto k2
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect17

:MisspellRedirect17
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu17


:RedirectMenu17
cls
goto :kbm

:k2
cls
echo.
echo.
echo.

echo.                                             %p%██╗░░██╗                                   █████████╗░                                  ███╗░░░███╗
echo.                                             %p%██║░██╔╝                                   ██╔═════██╗                                  ████╗░████║
echo.                                             %p%█████═╝░                                   █████████╦╝                                  ██╔████╔██║
echo.                                             %p%██╔═██╗░                                   ██╔═════██╗                                  ██║╚██╔╝██║
echo.                                             %p%██║░╚██╗                                   █████████╦╝                                  ██║░╚═╝░██║
echo.                                             %p%╚═╝░░╚═╝                                   ╚════════╝░                                  ╚═╝░░░░░╚═╝
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════════════════════════
echo.
echo.                                                             %p%[%w%1%p%]%w% 14 (CPU topo)      %p%[%w%2%p%]%w% 17 (CPU media)      %p%[%w%3%p%]%w% 20 (CPU basica)
echo.
echo.
echo.                                                             %p%[%w%R%p%]%w% Revert
echo.
echo.                                                             %p%[%w%X%p%]%w% Voltar
echo.
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                                   %w%Quanto menor o valor, menor a latencia dos perifericos
echo.                                                      %w%Mas pode causar travadas de mouse/teclado em PCs mais fracos se o valor for alto
echo.
echo.                                                             %w%Em caso de duvida, escolha o valor conforme o desempenho da sua CPU
echo.                                             %b%═══════════════════════════════════════════════════════════════════════════════════════════════════
echo.
set /p input=: 
if /i %input% == 1 goto 14v
if /i %input% == 2 goto 17v
if /i %input% == 3 goto 20v
if /i %input% == R goto Revertm
if /i %input% == X cls & goto kbm

) ELSE (
echo Entrada invalida & goto MisspellRedirect18

:MisspellRedirect18
cls
echo Erro de digitacao detectado
timeout 2 
goto Redirectmouse


:Redirectmouse
cls
goto :kbm

:14v
echo %w% - 14 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "20" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "20" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:17v
echo %w% - 17 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "23" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "23" /f

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:20v
echo %w% - 20 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "32" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:revertm
echo %w% - Restaurando fila de dados ao padrao do Windows%b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /f >nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu



:4
:clean
cls
echo.
echo.
echo.                       %p%░████████╗░                  ██╗░░░░░░░░                  ██████████╗                  ░████████╗░                 ███╗░░██╗
echo.                       %p%██╔═════██╗                  ██║░░░░░░░░                  ██╔═══════╝                  ██╔═════██╗                 ████╗░██║
echo.                       %p%██║░░░░░╚═╝                  ██║░░░░░░░░                  ████████╗░░                  ██████████║                 ██╔██╗██║
echo.                       %p%██║░░░░░██╗                  ██║░░░░░░░░                  ██╔═════╝░░                  ██╔═════██║                 ██║╚████║
echo.                       %p%╚████████╔╝                  ██████████╗                  ██████████╗                  ██║░░░░░██║                 ██║░╚███║
echo.                       %p%░╚═══════╝░                  ╚═════════╝                  ╚═════════╝                  ╚═╝░░░░░╚═╝                 ╚═╝░░╚══╝
echo.                       %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                           %p%[%w%1%p%]%w% Limpar Dados Temporarios                                                         %p%[%w%2%p%]%w% Limpeza de Disco do Windows
echo.
echo.                           %p%[%w%3%p%]%w% Limpeza Completa: temp, cache do Update, shaders, navegadores, lixeira, DNS
echo.
echo.
echo.                           %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                       %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo.                                                                 %W%Limpa varios dados temporarios do seu PC
echo.                                                             %W%Exclui drivers antigos, cache, logs e muito mais
echo.                       %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo. 
set /p input=:
if /i %input% == 1 goto c1
if /i %input% == 2 goto c2
if /i %input% == 3 goto c3

if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect19

:MisspellRedirect19
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu18


:RedirectMenu18
cls
goto :4


:c1
cls
echo %w% - Limpando arquivos temporarios do usuario...%b%
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%d in ("%TEMP%\*") do rd /s /q "%%d" >nul 2>&1
echo %w% - Limpando arquivos temporarios do Windows...%b%
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
for /d %%d in ("%SystemRoot%\Temp\*") do rd /s /q "%%d" >nul 2>&1
echo %w% -  Limpando Useless Device Data...%b%
chcp 437 > nul
@echo on
POWERSHELL "$Devices = Get-PnpDevice | ? Status -eq Unknown;foreach ($Device in $Devices) { &\"pnputil\" /remove-device $Device.InstanceId }"
@echo off
chcp 65001 > nul
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :4

:c2
cls
start /wait cleanmgr.exe
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :4


:6
cls
call :artps startup
cls
goto menu


:backupmenu
cls
echo.
echo.
echo.
echo.                                %p%██████╗░░█████╗░░█████╗░██╗░░██╗██╗░░░██╗██████╗░   ░░░░░░██╗   ██████╗░███████╗░██████╗████████╗░█████╗░██████╗░███████╗
echo.                                %p%██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██║░░░██║██╔══██╗   ░░░░░██╔╝   ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝
echo.                                %p%██████╦╝███████║██║░░╚═╝█████═╝░██║░░░██║██████╔╝   ░░░░██╔╝░   ██████╔╝█████╗░░╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░
echo.                                %p%██╔══██╗██╔══██║██║░░██╗██╔═██╗░██║░░░██║██╔═══╝░   ░░░██╔╝░░   ██╔══██╗██╔══╝░░░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░
echo.                                %p%██████╦╝██║░░██║╚█████╔╝██║░╚██╗╚██████╔╝██║░░░░░   ░░██╔╝░░░   ██║░░██║███████╗██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗
echo.                                %p%╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚═════╝░╚═╝░░░░░   ░░╚═╝░░░░   ╚═╝░░╚═╝╚══════╝╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝
echo.                                %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                       %p%[%w%1%p%]%w% Criar um Ponto de Restauracao agora
echo.
echo.                                                       %p%[%w%2%p%]%w% Fazer backup das configuracoes: registro, servicos e tarefas agendadas
echo.
echo.                                                       %p%[%w%3%p%]%w% Restaurar um backup de configuracoes
echo.
echo.                                                       %p%[%w%4%p%]%w% Abrir Restauracao do Sistema do Windows
echo.
echo.                                                       %p%[%w%5%p%]%w% Abrir a pasta de backups
echo.
echo.
echo.                                                       %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                                %W%Os backups ficam na sua pasta de usuario, em ART_Backups
echo.                                              %W%Restaurar traz de volta os valores antigos. Valores criados do zero pelos ajustes permanecem
echo.                                               %W%Nao coberto: bcdedit, planos de energia, opcoes NTFS. Use um Ponto de Restauracao para isso
echo.                                %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
set "input="
set /p input=:
if /i "%input%"=="1" goto bk_rp
if /i "%input%"=="2" goto bk_export
if /i "%input%"=="3" goto bk_restore
if /i "%input%"=="4" goto restore
if /i "%input%"=="5" goto bk_open
if /i "%input%"=="M" goto menu
goto backupmenu

:bk_rp
cls
echo %w% - Creating a restore point...%b%
chcp 437 >nul
powershell -NoProfile -Command "Checkpoint-Computer -Description 'ART Tweaks Restore Point' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
chcp 65001 >nul
echo %w% - Concluido. Se falhou, ative a Protecao do Sistema da unidade C: no Windows.%b%
pause > nul
goto backupmenu

:bk_export
cls
call :artps backup
echo.
echo %w% Pressione qualquer tecla para continuar...%b%
pause > nul
goto backupmenu

:bk_restore
cls
call :artps restore
echo.
echo %w% Pressione qualquer tecla para continuar...%b%
pause > nul
goto backupmenu

:bk_open
if not exist "%USERPROFILE%\ART_Backups" md "%USERPROFILE%\ART_Backups"
start "" explorer "%USERPROFILE%\ART_Backups"
goto backupmenu


:win11menu
if %WINBUILD% LSS 22000 goto w11_notsupported
cls
echo.
echo.
echo.
echo.                      %p%░██╗░░░░░░░██╗██╗███╗░░██╗██████╗░░█████╗░░██╗░░░░░░░██╗░██████╗   ░░███╗░░░░███╗░░   ████████╗░██╗░░░░░░░██╗███████╗░█████╗░██╗░░██╗░██████╗
echo.                      %p%░██║░░██╗░░██║██║████╗░██║██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝   ░████║░░░████║░░   ╚══██╔══╝░██║░░██╗░░██║██╔════╝██╔══██╗██║░██╔╝██╔════╝
echo.                      %p%░╚██╗████╗██╔╝██║██╔██╗██║██║░░██║██║░░██║░╚██╗████╗██╔╝╚█████╗░   ██╔██║░░██╔██║░░   ░░░██║░░░░╚██╗████╗██╔╝█████╗░░███████║█████═╝░╚█████╗░
echo.                      %p%░░████╔═████║░██║██║╚████║██║░░██║██║░░██║░░████╔═████║░░╚═══██╗   ╚═╝██║░░╚═╝██║░░   ░░░██║░░░░░████╔═████║░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
echo.                      %p%░░╚██╔╝░╚██╔╝░██║██║░╚███║██████╔╝╚█████╔╝░░╚██╔╝░╚██╔╝░██████╔╝   ███████╗███████╗   ░░░██║░░░░░╚██╔╝░╚██╔╝░███████╗██║░░██║██║░╚██╗██████╔╝
echo.                      %p%░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░░╚═════╝░   ╚══════╝╚══════╝   ░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
echo.                      %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                                     %p%[%w%A%p%]%w% Aplicar todos os ajustes do Windows 11
echo.
echo.                                                                     %p%[%w%1%p%]%w% Desativar Copilot
echo.
echo.                                                                     %p%[%w%2%p%]%w% Desativar Recall e analise de dados por IA
echo.
echo.                                                                     %p%[%w%3%p%]%w% Desativar Widgets
echo.
echo.                                                                     %p%[%w%4%p%]%w% Menu classico do botao direito
echo.
echo.
echo.                                                                     %p%[%w%R%p%]%w% Reverter estes ajustes
echo.
echo.                                                                     %p%[%w%M%p%]%w% Voltar aos Ajustes do Windows
echo.
echo.                      %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.                                                        %W%Baseado em politicas, resiste melhor a atualizacoes do que remover o app
echo.                                                      %W%O menu classico reinicia o Explorer, a barra de tarefas pisca por um segundo
echo.                      %b%═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
set "input="
set /p input=:
if /i "%input%"=="A" goto w11_all
if /i "%input%"=="1" goto w11_1
if /i "%input%"=="2" goto w11_2
if /i "%input%"=="3" goto w11_3
if /i "%input%"=="4" goto w11_4
if /i "%input%"=="R" goto r12
if /i "%input%"=="M" goto windows
goto win11menu

:w11_notsupported
cls
echo.
echo %w% Estes ajustes sao so para Windows 11. Sua build do Windows e %WINBUILD%.%b%
timeout /t 3 /nobreak > nul
cls
goto windows

:w11_1
call :w11_copilot
goto w11_done
:w11_2
call :w11_recall
goto w11_done
:w11_3
call :w11_widgets
goto w11_done
:w11_4
call :w11_ctx
goto w11_done
:w11_all
call :w11_copilot
call :w11_recall
call :w11_widgets
call :w11_ctx
goto w11_done

:w11_done
echo.
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto win11menu

:w11_copilot
echo %w% - Desativando Windows Copilot%b%
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d "0" /f >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers -Name Microsoft.Copilot | Remove-AppxPackage -AllUsers" >nul 2>&1
exit /b

:w11_recall
echo %w% - Desativando Recall and AI data analysis%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d "1" /f >nul 2>&1
Dism /Online /Disable-Feature /FeatureName:Recall /NoRestart >nul 2>&1
exit /b

:w11_widgets
echo %w% - Desativando Widgets%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "0" /f >nul 2>&1
taskkill /f /im Widgets.exe >nul 2>&1
taskkill /f /im WidgetService.exe >nul 2>&1
exit /b

:w11_ctx
echo %w% - Ativando the classic right-click menu%b%
Reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
exit /b

:r12
cls
echo %w% - Revertendo Windows 11 tweaks%b%
Reg.exe delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
echo %w% - O app Copilot e o Recall podem ser reinstalados pela Store e pelos Recursos do Windows%b%
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :e


:c3
cls
echo.
echo.
echo.
echo.                                    %p%░█████╗░░█████╗░███╗░░░███╗██████╗░██╗░░░░░███████╗████████╗███████╗   ░█████╗░██╗░░░░░███████╗░█████╗░███╗░░██╗
echo.                                    %p%██╔══██╗██╔══██╗████╗░████║██╔══██╗██║░░░░░██╔════╝╚══██╔══╝██╔════╝   ██╔══██╗██║░░░░░██╔════╝██╔══██╗████╗░██║
echo.                                    %p%██║░░╚═╝██║░░██║██╔████╔██║██████╔╝██║░░░░░█████╗░░░░░██║░░░█████╗░░   ██║░░╚═╝██║░░░░░█████╗░░███████║██╔██╗██║
echo.                                    %p%██║░░██╗██║░░██║██║╚██╔╝██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░██╔══╝░░   ██║░░██╗██║░░░░░██╔══╝░░██╔══██║██║╚████║
echo.                                    %p%╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░░░░░███████╗███████╗░░░██║░░░███████╗   ╚█████╔╝███████╗███████╗██║░░██║██║░╚███║
echo.                                    %p%░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░╚══════╝   ░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝
echo.                                    %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
echo.
echo.                                                Isto vai excluir:
echo.                                                  - Arquivos temporarios e o cache de download do Windows Update
echo.                                                  - Caches de shader: NVIDIA, AMD e DirectX. Os jogos recriam no proximo inicio
echo.                                                  - Caches de navegadores: Chrome, Edge, Brave e Firefox. Logins e favoritos sao mantidos
echo.                                                  - Cache de miniaturas, relatorios de erro e crash dumps
echo.                                                  - Cache DNS e a Lixeira
echo.                                                  - Limpeza de Disco (cleanmgr). A pasta Downloads e a Windows.old nao sao tocadas
echo.
echo.                                                Feche seus navegadores e jogos antes. A ultima etapa pode levar alguns minutos.
echo.
echo.                                    %b%════════════════════════════════════════════════════════════════════════════════════════════════════════════════%w%
choice /c SN /n /m "                                                          Continuar? [S] Sim  [N] Nao "
if errorlevel 2 goto c3_cancel
cls
set "FREE_BEFORE=0"
set "FREE_AFTER=0"
for /f %%f in ('powershell -NoProfile -Command "[math]::Round(([IO.DriveInfo]$env:SystemDrive).AvailableFreeSpace/1MB)"') do set "FREE_BEFORE=%%f"
echo %w% - Limpando temp files...%b%
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%d in ("%TEMP%\*") do rd /s /q "%%d" >nul 2>&1
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
for /d %%d in ("%SystemRoot%\Temp\*") do rd /s /q "%%d" >nul 2>&1
echo %w% - Limpando Windows Update cache...%b%
set "WU_WAS="
sc query wuauserv | find "RUNNING" >nul 2>&1 && set "WU_WAS=1"
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%d in ("%SystemRoot%\SoftwareDistribution\Download\*") do rd /s /q "%%d" >nul 2>&1
if defined WU_WAS net start wuauserv >nul 2>&1
echo %w% - Limpando shader caches...%b%
rd /s /q "%LocalAppData%\NVIDIA\DXCache" >nul 2>&1
rd /s /q "%LocalAppData%\NVIDIA\GLCache" >nul 2>&1
rd /s /q "%LocalAppData%\AMD\DxCache" >nul 2>&1
rd /s /q "%LocalAppData%\D3DSCache" >nul 2>&1
echo %w% - Limpando browser caches...%b%
for %%b in ("%LocalAppData%\Google\Chrome\User Data" "%LocalAppData%\Microsoft\Edge\User Data" "%LocalAppData%\BraveSoftware\Brave-Browser\User Data") do (
    for /d %%p in ("%%~b\Default" "%%~b\Profile *") do (
        rd /s /q "%%~p\Cache" >nul 2>&1
        rd /s /q "%%~p\Code Cache" >nul 2>&1
        rd /s /q "%%~p\GPUCache" >nul 2>&1
    )
)
for /d %%p in ("%LocalAppData%\Mozilla\Firefox\Profiles\*") do rd /s /q "%%p\cache2" >nul 2>&1
echo %w% - Limpando thumbnails, error reports and crash dumps...%b%
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "%LocalAppData%\CrashDumps" >nul 2>&1
del /f /q "%SystemRoot%\MEMORY.DMP" >nul 2>&1
del /f /q "%SystemRoot%\Minidump\*" >nul 2>&1
echo %w% - Limpando DNS and emptying the Recycle Bin...%b%
ipconfig /flushdns >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo %w% - Executando Disk Cleanup (cleanmgr /sagerun), this can take a few minutes...%b%
powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches' | Where-Object { $_.PSChildName -notin 'DownloadsFolder','Previous Installations' } | ForEach-Object { New-ItemProperty -Path $_.PSPath -Name StateFlags0099 -PropertyType DWord -Value 2 -Force | Out-Null }" >nul 2>&1
cleanmgr /sagerun:99
powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches' | ForEach-Object { Remove-ItemProperty -Path $_.PSPath -Name StateFlags0099 -ErrorAction SilentlyContinue }" >nul 2>&1
echo %w% - Limpando old Windows components, this can take a few minutes...%b%
Dism /Online /Cleanup-Image /StartComponentCleanup >nul 2>&1
for /f %%f in ('powershell -NoProfile -Command "[math]::Round(([IO.DriveInfo]$env:SystemDrive).AvailableFreeSpace/1MB)"') do set "FREE_AFTER=%%f"
set /a FREED=FREE_AFTER-FREE_BEFORE
if %FREED% LSS 0 set "FREED=0"
echo.
echo %w% Limpeza Completa concluida. Espaco liberado: cerca de %FREED% MB%b%
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║  %w% * Concluido * Pressione qualquer tecla para continuar...  %b%  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :4

:c3_cancel
cls
goto :4

exit /b

#PS_ART_BEGIN
$ErrorActionPreference = 'SilentlyContinue'
$mode = $env:ART_MODE
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ===================== STARTUP MANAGER =====================
function Get-StartupEntries {
    $list = New-Object System.Collections.ArrayList
    $adv = 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved'
    $runDefs = @(
        @{ Scope = 'User';             Hive = 'HKCU:'; Run = 'Software\Microsoft\Windows\CurrentVersion\Run';             App = ($adv + '\Run') },
        @{ Scope = 'Machine';          Hive = 'HKLM:'; Run = 'Software\Microsoft\Windows\CurrentVersion\Run';             App = ($adv + '\Run') },
        @{ Scope = 'Machine 32-bit';   Hive = 'HKLM:'; Run = 'Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run'; App = ($adv + '\Run32') }
    )
    foreach ($d in $runDefs) {
        $key = Get-Item -LiteralPath ($d.Hive + '\' + $d.Run)
        if ($key) {
            foreach ($n in $key.GetValueNames()) {
                if ($n) {
                    [void]$list.Add([pscustomobject]@{ Name = $n; Cmd = [string]$key.GetValue($n); Scope = $d.Scope; AppKey = ($d.Hive + '\' + $d.App); Enabled = $true })
                }
            }
        }
    }
    $dirDefs = @(
        @{ Scope = 'User folder';    Dir = [Environment]::GetFolderPath('Startup');       Hive = 'HKCU:' },
        @{ Scope = 'Machine folder'; Dir = [Environment]::GetFolderPath('CommonStartup'); Hive = 'HKLM:' }
    )
    foreach ($f in $dirDefs) {
        if ($f.Dir -and (Test-Path -LiteralPath $f.Dir)) {
            Get-ChildItem -LiteralPath $f.Dir -File -Force | Where-Object { $_.Name -ne 'desktop.ini' } | ForEach-Object {
                [void]$list.Add([pscustomobject]@{ Name = $_.Name; Cmd = $_.FullName; Scope = $f.Scope; AppKey = ($f.Hive + '\' + $adv + '\StartupFolder'); Enabled = $true })
            }
        }
    }
    foreach ($e in $list) {
        $p = Get-ItemProperty -LiteralPath $e.AppKey -Name $e.Name
        if ($p) {
            $v = $p.($e.Name)
            if (($v -is [byte[]]) -and ($v.Length -gt 0) -and (($v[0] -band 1) -eq 1)) { $e.Enabled = $false }
        }
    }
    return $list
}

function Test-ARTAdmin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    return ([Security.Principal.WindowsPrincipal]$id).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Itens criticos: nao podem ser DESATIVADOS por aqui (ativar sempre e permitido).
$script:ProtectedPatterns = @(
    'SecurityHealth', 'Windows ?Defender', 'MsMpEng', 'Windows Security',
    'Avast', '\bAVG\b', 'Avira', 'Kaspersky', 'Norton', 'McAfee', 'Bitdefender', '\bESET\b', 'Malwarebytes', 'Sophos', 'TrendMicro', 'Trend Micro', 'Webroot',
    'Realtek', 'RtkAud', 'RtkNGUI', 'RAVBg', 'RAVCpl', 'Conexant', 'Dolby',
    'Synaptics', 'SynTP', 'ETDCtrl', 'ETDService', 'Touchpad', 'ApntEx', 'Apoint',
    'igfx', 'Intel.*Graphics', 'Radeon', 'AMDRSServ', 'AMD External Events', 'NvCplDaemon', 'nvtray',
    'ctfmon'
)

# Estimativa por nome (usada quando o Windows nao tem medicao do boot para o item).
$script:HeavyPatterns = @('Teams', 'Discord', 'Spotify', '\bSteam', 'Epic ?Games', 'Skype', 'Zoom', 'Slack', 'Adobe', 'Creative Cloud', 'CCXProcess', 'iTunes', 'Dropbox', 'OneDrive', 'Battle\.net', 'EADesktop', 'EA Desktop', 'Origin', 'Cortana', 'Copilot')
$script:MediumPatterns = @('Edge', 'Chrome', 'GoogleUpdate', 'jusched', 'Logitech', 'LGHUB', 'Razer', 'iCUE', 'Corsair', 'Overwolf', 'WhatsApp', 'Telegram', 'Notion')

function Test-ProtectedStartup($e) {
    $text = ([string]$e.Name) + ' ' + ([string]$e.Cmd)
    foreach ($p in $script:ProtectedPatterns) {
        if ($text -match ('(?i)' + $p)) { return $true }
    }
    return $false
}

function Get-CmdLeaf($cmd) {
    $s = [string]$cmd
    $p = $null
    if ($s -match '^\s*"([^"]+)"') { $p = $matches[1] }
    elseif ($s -match '(?i)^\s*(.+?\.(?:exe|lnk|bat|cmd|vbs|ps1))(\s|$)') { $p = $matches[1] }
    else { $p = $s.Trim() }
    try { return [IO.Path]::GetFileNameWithoutExtension($p) } catch { return '' }
}

# Tempo medido pelo proprio Windows no boot (evento 101 do Diagnostics-Performance).
# So existe para apps que atrasaram o boot; apps rapidos nao geram evento.
function Get-MeasuredImpact {
    $map = @{}
    $evs = @(Get-WinEvent -FilterHashtable @{ LogName = 'Microsoft-Windows-Diagnostics-Performance/Operational'; Id = 101 } -MaxEvents 300 -ErrorAction SilentlyContinue)
    foreach ($ev in $evs) {
        try {
            $x = [xml]$ev.ToXml()
            $d = @{}
            foreach ($n in $x.Event.EventData.Data) { $d[[string]$n.Name] = [string]$n.'#text' }
            $t = 0
            if ($d.ContainsKey('TotalTime')) { $t = [int64]$d['TotalTime'] }
            foreach ($f in @('Name', 'FriendlyName')) {
                if ($d.ContainsKey($f) -and $d[$f]) {
                    $k = ([IO.Path]::GetFileNameWithoutExtension($d[$f])).ToLower()
                    if ($k -and ((-not $map.ContainsKey($k)) -or ($map[$k] -lt $t))) { $map[$k] = $t }
                }
            }
        } catch { }
    }
    return $map
}

function Get-ImpactLabel($e, $measured) {
    $leaf = (Get-CmdLeaf $e.Cmd).ToLower()
    $best = $null
    if ($leaf.Length -ge 3) {
        foreach ($k in $measured.Keys) {
            if ($k.Contains($leaf) -or ($k.Length -ge 3 -and $leaf.Contains($k))) {
                if (($best -eq $null) -or ($measured[$k] -gt $best)) { $best = $measured[$k] }
            }
        }
    }
    if ($best -ne $null) {
        if ($best -ge 3000) { return 'ALTO (m)' }
        if ($best -ge 1000) { return 'MEDIO (m)' }
        return 'BAIXO (m)'
    }
    $text = ([string]$e.Name) + ' ' + ([string]$e.Cmd)
    foreach ($p in $script:HeavyPatterns) { if ($text -match ('(?i)' + $p)) { return 'ALTO (e)' } }
    foreach ($p in $script:MediumPatterns) { if ($text -match ('(?i)' + $p)) { return 'MEDIO (e)' } }
    return '?'
}

function Set-StartupState($e, [bool]$enable) {
    $script:StartupErr = ''
    try {
        if (($e.AppKey -like 'HKLM:*') -and -not (Test-ARTAdmin)) {
            throw 'Este item e da maquina (HKLM) e precisa de administrador. Abra o utilitario como administrador.'
        }
        if (-not (Test-Path -LiteralPath $e.AppKey)) { New-Item -Path $e.AppKey -Force -ErrorAction Stop | Out-Null }
        if ($enable) {
            $bytes = [byte[]](2,0,0,0,0,0,0,0,0,0,0,0)
        } else {
            $bytes = [byte[]]((3,0,0,0) + [BitConverter]::GetBytes([DateTime]::Now.ToFileTime()))
        }
        New-ItemProperty -LiteralPath $e.AppKey -Name $e.Name -PropertyType Binary -Value $bytes -Force -ErrorAction Stop | Out-Null
        $p = Get-ItemProperty -LiteralPath $e.AppKey -Name $e.Name -ErrorAction Stop
        $v = $p.($e.Name)
        $isOff = ($v -is [byte[]]) -and ($v.Length -gt 0) -and (($v[0] -band 1) -eq 1)
        if ($isOff -eq $enable) { throw 'O Windows nao aceitou a alteracao (o valor nao mudou).' }
        return $true
    } catch {
        $script:StartupErr = $_.Exception.Message
        return $false
    }
}

function Show-StartupManager {
    Clear-Host
    Write-Host ''
    Write-Host '   Lendo dados de inicializacao do Windows...' -ForegroundColor Gray
    $measured = Get-MeasuredImpact
    $msg = ''
    $msgColor = 'Gray'
    while ($true) {
        Clear-Host
        $items = @(Get-StartupEntries)
        Write-Host ''
        Write-Host '   GERENCIADOR DE INICIALIZACAO' -ForegroundColor Green
        Write-Host '   Programas que iniciam com o Windows. Mesmo interruptor do Gerenciador de Tarefas > Aplicativos de inicializacao (nada e excluido).' -ForegroundColor Gray
        Write-Host '   Impacto: (m) = medido pelo Windows no boot | (e) = estimado pelo nome | ? = sem dados. [P] = item protegido.' -ForegroundColor Gray
        Write-Host ''
        if ($items.Count -eq 0) { Write-Host '   Nenhum item de inicializacao encontrado.' -ForegroundColor Yellow }
        $i = 0
        foreach ($e in $items) {
            $i++
            $prot = Test-ProtectedStartup $e
            $imp = Get-ImpactLabel $e $measured
            if ($e.Enabled) { $state = 'LIG'; $color = 'Green' } else { $state = 'DES'; $color = 'DarkGray' }
            if ($prot -and $e.Enabled) { $color = 'Cyan' }
            $name = $e.Name
            if ($name.Length -gt 26) { $name = $name.Substring(0, 23) + '...' }
            if ($prot) { $name = $name + ' [P]' }
            $cmd = $e.Cmd
            if ($cmd.Length -gt 40) { $cmd = $cmd.Substring(0, 37) + '...' }
            Write-Host ('   [{0,2}] {1}  {2,-9} {3,-30} {4,-14} {5}' -f $i, $state, $imp, $name, $e.Scope, $cmd) -ForegroundColor $color
        }
        Write-Host ''
        if ($msg) { Write-Host ('   ' + $msg) -ForegroundColor $msgColor; Write-Host '' }
        Write-Host '   Digite um numero para LIGAR/DESLIGAR, R para atualizar, M para voltar ao menu.' -ForegroundColor White
        Write-Host '   Itens [P] (antivirus, audio, touchpad, video) nao podem ser desativados aqui. A mudanca vale no proximo boot.' -ForegroundColor Yellow
        Write-Host ''
        $in = (Read-Host '   >').Trim()
        if ($in -match '^[Mm]$') { break }
        $msg = ''
        if ($in -match '^\d+$') {
            $num = [int]$in
            if ($num -ge 1 -and $num -le $items.Count) {
                $sel = $items[$num - 1]
                $enable = -not $sel.Enabled
                if ((-not $enable) -and (Test-ProtectedStartup $sel)) {
                    $msg = 'BLOQUEADO: "' + $sel.Name + '" e um item critico e nao pode ser desativado por aqui.'
                    $msgColor = 'Red'
                } elseif (Set-StartupState $sel $enable) {
                    if ($enable) { $msg = 'OK: "' + $sel.Name + '" ligado.' } else { $msg = 'OK: "' + $sel.Name + '" desligado.' }
                    $msgColor = 'Green'
                } else {
                    $msg = 'ERRO ao alterar "' + $sel.Name + '": ' + $script:StartupErr
                    $msgColor = 'Red'
                }
            } else {
                $msg = 'Numero fora da lista.'
                $msgColor = 'Yellow'
            }
        } elseif ($in -ne '' -and $in -notmatch '^[Rr]$') {
            $msg = 'Entrada invalida.'
            $msgColor = 'Yellow'
        }
    }
}

# ===================== BACKUP =====================
function Invoke-ARTBackup {
    $root = Join-Path $env:USERPROFILE 'ART_Backups'
    $dir = Join-Path $root (Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')
    $regDir = Join-Path $dir 'registry'
    New-Item -ItemType Directory -Path $regDir -Force | Out-Null
    Write-Host ''
    Write-Host '   Salvando as chaves de registro usadas por esta ferramenta...' -ForegroundColor Cyan
    $keys = @([regex]::Matches($c, '(?m)^#BKEY (.+?)\s*$') | ForEach-Object { $_.Groups[1].Value })
    $n = 0
    $saved = 0
    foreach ($k in $keys) {
        $n++
        $f = Join-Path $regDir ('{0:000}.reg' -f $n)
        & reg.exe export $k $f /y 2>$null | Out-Null
        if (($LASTEXITCODE -eq 0) -and (Test-Path -LiteralPath $f)) { $saved++ }
    }
    Write-Host '   Salvando o tipo de inicializacao dos servicos...' -ForegroundColor Cyan
    Get-CimInstance Win32_Service | Select-Object Name, StartMode | Export-Csv -LiteralPath (Join-Path $dir 'services.csv') -NoTypeInformation
    Write-Host '   Salvando o estado das tarefas agendadas...' -ForegroundColor Cyan
    Get-ScheduledTask | Select-Object TaskPath, TaskName, State | Export-Csv -LiteralPath (Join-Path $dir 'tasks.csv') -NoTypeInformation
    Write-Host ''
    Write-Host ('   Backup salvo em: ' + $dir) -ForegroundColor Green
    Write-Host ('   Chaves de registro salvas: {0} de {1} (chaves que nao existem neste PC sao ignoradas)' -f $saved, $keys.Count) -ForegroundColor Green
}

# ===================== RESTORE =====================
function Invoke-ARTRestore {
    $root = Join-Path $env:USERPROFILE 'ART_Backups'
    $dirs = @(Get-ChildItem -LiteralPath $root -Directory | Sort-Object Name -Descending)
    Write-Host ''
    if ($dirs.Count -eq 0) { Write-Host '   Nenhum backup encontrado. Crie um primeiro (opcao 2).' -ForegroundColor Yellow; return }
    Write-Host '   Backups disponiveis (mais recentes primeiro):' -ForegroundColor Cyan
    $i = 0
    foreach ($d in $dirs) { $i++; Write-Host ('   [{0}] {1}' -f $i, $d.Name) }
    Write-Host ''
    $in = (Read-Host '   Numero do backup a restaurar (Enter para cancelar)').Trim()
    if ($in -notmatch '^\d+$') { Write-Host '   Cancelado.' -ForegroundColor Yellow; return }
    $num = [int]$in
    if ($num -lt 1 -or $num -gt $dirs.Count) { Write-Host '   Cancelado.' -ForegroundColor Yellow; return }
    $sel = $dirs[$num - 1]
    $sure = (Read-Host ('   Restaurar as configuracoes salvas em ' + $sel.Name + '? Digite S para confirmar')).Trim()
    if ($sure -notmatch '^[SsYy]$') { Write-Host '   Cancelado.' -ForegroundColor Yellow; return }

    Write-Host '   Restaurando valores do registro...' -ForegroundColor Cyan
    $regCount = 0
    foreach ($r in @(Get-ChildItem -LiteralPath (Join-Path $sel.FullName 'registry') -Filter '*.reg')) {
        & reg.exe import $r.FullName 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) { $regCount++ }
    }

    Write-Host '   Restaurando o tipo de inicializacao dos servicos...' -ForegroundColor Cyan
    $svcFixed = 0
    $svcCsv = Join-Path $sel.FullName 'services.csv'
    if (Test-Path -LiteralPath $svcCsv) {
        $map = @{ 'Auto' = 'auto'; 'Manual' = 'demand'; 'Disabled' = 'disabled' }
        $now = @{}
        Get-CimInstance Win32_Service | ForEach-Object { $now[$_.Name] = $_.StartMode }
        foreach ($s in @(Import-Csv -LiteralPath $svcCsv)) {
            if ($map.ContainsKey($s.StartMode) -and $now.ContainsKey($s.Name) -and ($now[$s.Name] -ne $s.StartMode)) {
                & sc.exe config $s.Name start= $map[$s.StartMode] 2>$null | Out-Null
                $svcFixed++
            }
        }
    }

    Write-Host '   Restaurando tarefas agendadas...' -ForegroundColor Cyan
    $taskFixed = 0
    $taskCsv = Join-Path $sel.FullName 'tasks.csv'
    if (Test-Path -LiteralPath $taskCsv) {
        $off = @{}
        Get-ScheduledTask | Where-Object { $_.State -eq 'Disabled' } | ForEach-Object { $off[$_.TaskPath + $_.TaskName] = $true }
        foreach ($t in @(Import-Csv -LiteralPath $taskCsv)) {
            if (($t.State -ne 'Disabled') -and $off.ContainsKey($t.TaskPath + $t.TaskName)) {
                Enable-ScheduledTask -TaskPath $t.TaskPath -TaskName $t.TaskName | Out-Null
                $taskFixed++
            }
        }
    }
    Write-Host ''
    Write-Host ('   Concluido. Arquivos de registro importados: {0} | servicos corrigidos: {1} | tarefas reativadas: {2}' -f $regCount, $svcFixed, $taskFixed) -ForegroundColor Green
    Write-Host '   Valores que nao existiam antes dos ajustes permanecem como estao. Reinicie o PC para finalizar.' -ForegroundColor Yellow
}


# ===================== PC REPORT / METER / CHECKS =====================
function Write-Title($s) { Write-Host ''; Write-Host ('   ' + $s) -ForegroundColor Green; Write-Host '' }
function Write-Line($k, $v) { Write-Host ('   {0,-16} {1}' -f $k, $v) -ForegroundColor White }
function Write-Ok($s)   { Write-Host ('   [OK]    ' + $s) -ForegroundColor Green }
function Write-Warn2($s){ Write-Host ('   [CHECK] ' + $s) -ForegroundColor Yellow }

function Get-MaxRefresh {
    try {
        Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
public class ARTDisp {
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct DEVMODE {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string dmDeviceName;
        public short dmSpecVersion; public short dmDriverVersion; public short dmSize; public short dmDriverExtra;
        public int dmFields;
        public int dmPositionX; public int dmPositionY; public int dmDisplayOrientation; public int dmDisplayFixedOutput;
        public short dmColor; public short dmDuplex; public short dmYResolution; public short dmTTOption; public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string dmFormName;
        public short dmLogPixels; public int dmBitsPerPel; public int dmPelsWidth; public int dmPelsHeight;
        public int dmDisplayFlags; public int dmDisplayFrequency;
        public int dmICMMethod; public int dmICMIntent; public int dmMediaType; public int dmDitherType;
        public int dmReserved1; public int dmReserved2; public int dmPanningWidth; public int dmPanningHeight;
    }
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct DISPLAY_DEVICE {
        public int cb;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string DeviceName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)] public string DeviceString;
        public int StateFlags;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)] public string DeviceID;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)] public string DeviceKey;
    }
    [DllImport("user32.dll", CharSet = CharSet.Ansi)]
    public static extern bool EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE devMode);
    [DllImport("user32.dll", CharSet = CharSet.Ansi)]
    public static extern bool EnumDisplayDevices(string lpDevice, uint iDevNum, ref DISPLAY_DEVICE lpDisplayDevice, uint dwFlags);
    // Um texto por monitor ligado: nome;largura;altura;taxa atual;maior taxa nessa resolucao
    public static string[] Info() {
        List<string> res = new List<string>();
        uint n = 0;
        while (true) {
            DISPLAY_DEVICE dd = new DISPLAY_DEVICE();
            dd.cb = Marshal.SizeOf(typeof(DISPLAY_DEVICE));
            if (!EnumDisplayDevices(null, n, ref dd, 0)) break;
            n++;
            if ((dd.StateFlags & 1) == 0) continue;
            DEVMODE cur = new DEVMODE(); cur.dmSize = (short)Marshal.SizeOf(typeof(DEVMODE));
            if (!EnumDisplaySettings(dd.DeviceName, -1, ref cur)) continue;
            int max = 0; int i = 0;
            DEVMODE m = new DEVMODE(); m.dmSize = (short)Marshal.SizeOf(typeof(DEVMODE));
            while (EnumDisplaySettings(dd.DeviceName, i, ref m)) {
                if (m.dmPelsWidth == cur.dmPelsWidth && m.dmPelsHeight == cur.dmPelsHeight && m.dmDisplayFrequency > max) max = m.dmDisplayFrequency;
                i++;
            }
            res.Add(dd.DeviceName + ";" + cur.dmPelsWidth + ";" + cur.dmPelsHeight + ";" + cur.dmDisplayFrequency + ";" + max);
        }
        return res.ToArray();
    }
}
'@
        return [ARTDisp]::Info()
    } catch { return @() }
}

function Show-Report {
    Write-Title 'RELATORIO DO PC'
    $cs = Get-CimInstance Win32_ComputerSystem
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    # Tipos de chassi SMBIOS: 8 portatil, 9 laptop, 10 notebook, 14 sub notebook, 30 tablet, 31 conversivel, 32 destacavel
    $laptopTypes = @(8, 9, 10, 14, 30, 31, 32)
    $desktopTypes = @(3, 4, 5, 6, 7, 13, 15, 16, 17, 23, 24, 34, 35, 36)
    $types = @((Get-CimInstance Win32_SystemEnclosure).ChassisTypes | ForEach-Object { [int]$_ })
    # Se o chassi nao for conclusivo, a bateria decide. Nobreak ligado por USB nao conta quando o chassi e de desktop.
    if ($types | Where-Object { $laptopTypes -contains $_ }) { $isLaptop = $true }
    elseif ($types | Where-Object { $desktopTypes -contains $_ }) { $isLaptop = $false }
    else { $isLaptop = [bool](Get-CimInstance Win32_Battery) }
    if ($isLaptop) { $kind = 'Notebook' } else { $kind = 'Desktop' }
    Write-Line 'Tipo' $kind
    Write-Line 'Modelo' (($cs.Manufacturer + ' ' + $cs.Model).Trim())
    Write-Line 'Windows' ($os.Caption + ' (compilacao ' + $os.BuildNumber + ')')
    Write-Line 'CPU' ($cpu.Name.Trim() + ' | ' + $cpu.NumberOfCores + ' nucleos / ' + $cpu.NumberOfLogicalProcessors + ' threads')
    foreach ($gpu in @(Get-CimInstance Win32_VideoController)) {
        $d = ''
        if ($gpu.DriverDate) { $d = $gpu.DriverDate.ToString('yyyy-MM-dd') }
        Write-Line 'GPU' ($gpu.Name + ' | driver ' + $gpu.DriverVersion + ' (' + $d + ')')
    }
    $totalGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
    $freeGB = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
    Write-Line 'RAM' ('' + $totalGB + ' GB total | ' + $freeGB + ' GB livres agora')
    foreach ($m in @(Get-CimInstance Win32_PhysicalMemory)) {
        Write-Line '  modulo' ('' + [math]::Round($m.Capacity / 1GB) + ' GB | nominal ' + $m.Speed + ' MT/s | atual ' + $m.ConfiguredClockSpeed + ' MT/s | ' + $m.Manufacturer)
    }
    Write-Host ''
    foreach ($pd in @(Get-PhysicalDisk)) {
        Write-Line 'Disco' ($pd.FriendlyName + ' | ' + $pd.MediaType + ' | ' + $pd.BusType + ' | ' + [math]::Round($pd.Size / 1GB) + ' GB | ' + $pd.HealthStatus)
    }
    foreach ($v in @(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3')) {
        Write-Line ('Unidade ' + $v.DeviceID) ('' + [math]::Round($v.FreeSpace / 1GB, 1) + ' GB livres de ' + [math]::Round($v.Size / 1GB, 1) + ' GB')
    }
    Write-Host ''
}

function Get-BootMs {
    $ev = Get-WinEvent -FilterHashtable @{ LogName = 'Microsoft-Windows-Diagnostics-Performance/Operational'; Id = 100 } -MaxEvents 1
    if ($ev) {
        $x = [xml]$ev.ToXml()
        $n = $x.Event.EventData.Data | Where-Object { $_.Name -eq 'BootTime' }
        if ($n) { return [int]$n.'#text' }
    }
    return 0
}

function Get-Snapshot {
    $os = Get-CimInstance Win32_OperatingSystem
    $totalMB = [math]::Round($os.TotalVisibleMemorySize / 1KB)
    $freeMB = [math]::Round($os.FreePhysicalMemory / 1KB)
    $svc = @(Get-Service | Where-Object { $_.Status -eq 'Running' }).Count
    $startup = @(Get-StartupEntries | Where-Object { $_.Enabled }).Count
    $dp = Get-DpcSample
    $dpcV = $null
    $intV = $null
    if ($dp) { $dpcV = $dp.Dpc; $intV = $dp.Int }
    [pscustomobject]@{
        Date      = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        RamUsedMB = ($totalMB - $freeMB)
        Processes = @(Get-Process).Count
        Services  = $svc
        Startup   = $startup
        BootMs    = (Get-BootMs)
        DpcPct    = $dpcV
        IntPct    = $intV
        LastBoot  = $os.LastBootUpTime.ToString('yyyy-MM-dd HH:mm:ss')
    }
}

function Get-SnapPath {
    $dir = Join-Path (Join-Path $env:USERPROFILE 'ART_Backups') 'Measurements'
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    return $dir
}

function Show-Snapshot($s) {
    Write-Line 'Medido em' $s.Date
    Write-Line 'RAM em uso' ('' + $s.RamUsedMB + ' MB')
    Write-Line 'Processos' $s.Processes
    Write-Line 'Servicos ativos' $s.Services
    Write-Line 'Apps no inicio' $s.Startup
    if ($null -ne $s.DpcPct) { Write-Line 'Tempo em DPC' ('' + $s.DpcPct + ' %'); Write-Line 'Interrupcoes' ('' + $s.IntPct + ' %') } else { Write-Line 'Tempo em DPC' 'indisponivel' }
    if ($s.BootMs -gt 0) { Write-Line 'Ultimo boot' ('' + [math]::Round($s.BootMs / 1000, 1) + ' s') } else { Write-Line 'Ultimo boot' 'indisponivel no log de eventos' }
}

function Save-Before {
    Write-Title 'MEDIDOR ANTES/DEPOIS: salvando ANTES'
    Write-Host '   Dica: meca logo apos reiniciar, sem apps abertos, para os numeros serem comparaveis.' -ForegroundColor Gray
    Write-Host '   A medicao de DPC leva uns 5 segundos, deixe o PC parado enquanto ela roda.' -ForegroundColor Gray
    Write-Host ''
    $s = Get-Snapshot
    $f = Join-Path (Get-SnapPath) 'before.json'
    if (Test-Path -LiteralPath $f) {
        Copy-Item -LiteralPath $f -Destination (Join-Path (Get-SnapPath) 'before_anterior.json') -Force
        Write-Warn2 'Ja existia uma medicao ANTES. Ela foi substituida e a antiga ficou em before_anterior.json.'
        Write-Host ''
    }
    $s | ConvertTo-Json | Set-Content -LiteralPath $f -Encoding UTF8
    Show-Snapshot $s
    if ($s.BootMs -le 0) {
        Write-Host ''
        Write-Warn2 'O Windows nao registrou o tempo de boot (evento 100). Ele nao entrara na comparacao. Isso pode acontecer quando os diagnosticos do Windows estao desativados.'
    }
    Write-Host ''
    Write-Host '   Salvo. Agora aplique seus ajustes, reinicie o PC e use a opcao 3 (DEPOIS).' -ForegroundColor Green
}

function Save-After {
    Write-Title 'MEDIDOR ANTES/DEPOIS: salvando DEPOIS e comparando'
    $f = Join-Path (Get-SnapPath) 'before.json'
    if (-not (Test-Path -LiteralPath $f)) { Write-Host '   Nenhuma medicao ANTES encontrada. Use a opcao 2 primeiro.' -ForegroundColor Yellow; return }
    $b = Get-Content -LiteralPath $f -Raw | ConvertFrom-Json
    $a = Get-Snapshot
    $a | ConvertTo-Json | Set-Content -LiteralPath (Join-Path (Get-SnapPath) 'after.json') -Encoding UTF8
    if ($b.LastBoot -eq $a.LastBoot) { Write-Warn2 'Voce nao reiniciou desde a medicao ANTES, o tempo de boot ainda nao e comparavel.'; Write-Host '' }
    Write-Host ('   {0,-18} {1,10} {2,10} {3,12}' -f '', 'ANTES', 'DEPOIS', 'DIFERENCA') -ForegroundColor Cyan
    $rows = @(
        @('RAM em uso (MB)', $b.RamUsedMB, $a.RamUsedMB),
        @('Processos', $b.Processes, $a.Processes),
        @('Servicos ativos', $b.Services, $a.Services),
        @('Apps no inicio', $b.Startup, $a.Startup)
    )
    $bootOk = (($b.BootMs -gt 0) -and ($a.BootMs -gt 0))
    if (($null -ne $b.DpcPct) -and ($null -ne $a.DpcPct)) { $rows += ,@('Tempo em DPC (%)', $b.DpcPct, $a.DpcPct); $rows += ,@('Interrupcoes (%)', $b.IntPct, $a.IntPct) }
    if ($bootOk) { $rows += ,@('Tempo de boot (s)', [math]::Round($b.BootMs / 1000, 1), [math]::Round($a.BootMs / 1000, 1)) }
    foreach ($r in $rows) {
        $d = [math]::Round($r[2] - $r[1], 2)
        if ($d -le 0) { $c = 'Green' } else { $c = 'Yellow' }
        Write-Host ('   {0,-18} {1,10} {2,10} {3,12}' -f $r[0], $r[1], $r[2], $d) -ForegroundColor $c
    }
    if (-not $bootOk) {
        Write-Host ''
        Write-Warn2 'O tempo de boot nao entrou na comparacao porque o Windows nao registrou um dos dois boots (evento 100). Os outros numeros continuam validos.'
    }
    Write-Host ''
    $ram = $b.RamUsedMB - $a.RamUsedMB
    $pr = $b.Processes - $a.Processes
    if ($ram -gt 0 -and $pr -gt 0) {
        Write-Host ('   Voce economizou ' + $ram + ' MB de RAM e ' + $pr + ' processos.') -ForegroundColor Green
    } elseif ($ram -gt 0) {
        Write-Host ('   Voce economizou ' + $ram + ' MB de RAM.') -ForegroundColor Green
    } elseif ($pr -gt 0) {
        Write-Host ('   Voce tem ' + $pr + ' processos a menos rodando.') -ForegroundColor Green
    } else {
        Write-Host '   Nenhuma economia de RAM ou processos foi medida desta vez.' -ForegroundColor Yellow
    }
}

function Show-Checks {
    Write-Title 'VERIFICACOES DE HARDWARE (coisas que nenhum script resolve)'
    Write-Host '   Sao configuracoes da BIOS, das opcoes de video do Windows ou do seu hardware.' -ForegroundColor Gray
    Write-Host ''
    $mods = @(Get-CimInstance Win32_PhysicalMemory)
    $slow = $false
    foreach ($m in $mods) {
        if ($m.Speed -and $m.ConfiguredClockSpeed -and ($m.ConfiguredClockSpeed -lt ($m.Speed - 50))) {
            # Atual perto da metade do nominal e so diferenca de unidade (MHz contra MT/s), nao e XMP desligado.
            if ([math]::Abs(($m.ConfiguredClockSpeed * 2) - $m.Speed) -gt 100) { $slow = $true }
        }
    }
    if ($mods.Count -eq 0) {
        Write-Warn2 'Nao foi possivel ler os modulos de RAM.'
    } elseif ($slow) {
        $m0 = $mods | Select-Object -First 1
        Write-Warn2 ('A RAM e de ' + $m0.Speed + ' MT/s mas esta rodando a ' + $m0.ConfiguredClockSpeed + ' MT/s. O XMP/EXPO provavelmente esta DESLIGADO. Entre na BIOS e ative o XMP (Intel) ou EXPO (AMD). Isso costuma dar mais FPS do que qualquer ajuste de registro.')
    } else {
        Write-Ok 'A RAM esta rodando na velocidade informada pelo modulo. Se o kit anuncia uma velocidade maior (XMP/EXPO), confirme na BIOS.'
    }
    $displays = @(Get-MaxRefresh)
    if ($displays.Count -eq 0) { Write-Warn2 'Nao foi possivel ler a taxa de atualizacao dos monitores.' }
    foreach ($row in $displays) {
        $di = ([string]$row) -split ';'
        $cur = [int]$di[3]; $max = [int]$di[4]
        # Diferencas de 1 a 4 Hz (59 contra 60) sao so arredondamento do Windows
        if (($cur -gt 1) -and (($max - $cur) -ge 5)) {
            Write-Warn2 ('O monitor ' + $di[0] + ' esta a ' + $cur + ' Hz em ' + $di[1] + 'x' + $di[2] + ' mas ' + $max + ' Hz esta disponivel. Configuracoes > Sistema > Video > Video avancado > Taxa de atualizacao. Use tambem um cabo DisplayPort/HDMI compativel.')
        } else {
            Write-Ok ('O monitor ' + $di[0] + ' esta na maior taxa de atualizacao para esta resolucao: ' + $cur + ' Hz.')
        }
    }
    foreach ($pd in @(Get-PhysicalDisk)) {
        $line = $pd.FriendlyName + ' (' + $pd.MediaType + ')'
        if ($pd.HealthStatus -ne 'Healthy') {
            Write-Warn2 ('O disco ' + $line + ' informa ' + $pd.HealthStatus + '. Faca backup dos seus dados e verifique a unidade.')
        } else {
            $rel = $pd | Get-StorageReliabilityCounter
            $extra = ''
            if ($rel -and $null -ne $rel.Wear) { $extra = ' | desgaste ' + $rel.Wear + '%' }
            if ($rel -and $rel.Temperature) { $extra += ' | ' + $rel.Temperature + ' C' }
            if ($rel -and $null -ne $rel.Wear -and $rel.Wear -ge 80) {
                Write-Warn2 ('O disco ' + $line + ' esta muito desgastado' + $extra + '. Planeje a troca.')
            } else {
                if (($null -eq $rel) -or ($null -eq $rel.Wear)) { $extra += ' | este disco nao informa desgaste (so a saude geral foi checada)' }
                Write-Ok ('O disco ' + $line + ' esta saudavel' + $extra + '.')
            }
        }
    }
    foreach ($gpu in @(Get-CimInstance Win32_VideoController)) {
        if ($gpu.Name -match 'Basic|Remote|Virtual|Hyper-V') { continue }
        if ($gpu.DriverDate -and ($gpu.DriverDate.Year -lt 2015)) {
            Write-Warn2 ('O driver de video de ' + $gpu.Name + ' e de ' + $gpu.DriverDate.ToString('yyyy-MM-dd') + ', provavelmente o generico do Windows. Instale o driver do fabricante (NVIDIA, AMD ou Intel).')
            continue
        }
        if ($gpu.DriverDate) {
            $age = [int]((Get-Date) - $gpu.DriverDate).TotalDays
            if ($age -gt 180) {
                Write-Warn2 ('O driver de video de ' + $gpu.Name + ' tem ' + $age + ' dias (' + $gpu.DriverDate.ToString('yyyy-MM-dd') + '). Confira no site do fabricante (NVIDIA, AMD ou Intel) se existe versao mais nova.')
            } else {
                Write-Ok ('O driver de video de ' + $gpu.Name + ' e recente (' + $gpu.DriverDate.ToString('yyyy-MM-dd') + ').')
            }
        }
    }
    Write-Host ''
}

function Open-GpuDrivers {
    $names = (@(Get-CimInstance Win32_VideoController) | ForEach-Object { $_.Name }) -join ' '
    $opened = $false
    if ($names -match 'NVIDIA|GeForce|RTX|GTX') { Start-Process 'https://www.nvidia.com/Download/index.aspx'; $opened = $true }
    if ($names -match 'AMD|Radeon') { Start-Process 'https://www.amd.com/en/support/download/drivers.html'; $opened = $true }
    if (-not $opened) { Start-Process 'https://www.nvidia.com/Download/index.aspx'; Start-Process 'https://www.amd.com/en/support/download/drivers.html' }
}

function Show-UsedPc {
    Write-Title 'PC EM USO: o que esta pesando no seu sistema'
    Write-Host '   Top 15 processos por RAM privada (agrupados por nome, memoria compartilhada nao e contada em dobro):' -ForegroundColor Cyan
    $perf = @(Get-CimInstance Win32_PerfFormattedData_PerfProc_Process | Where-Object { $_.Name -ne '_Total' -and $_.Name -ne 'Idle' })
    if ($perf.Count -gt 0) {
        $grouped = $perf | Group-Object { $_.Name -replace '#\d+$', '' } | ForEach-Object {
            [pscustomobject]@{ Name = $_.Name; Count = $_.Count; MB = [math]::Round((($_.Group | Measure-Object WorkingSetPrivate -Sum).Sum) / 1MB) }
        }
    } else {
        $grouped = Get-Process | Group-Object ProcessName | ForEach-Object {
            [pscustomobject]@{ Name = $_.Name; Count = $_.Count; MB = [math]::Round((($_.Group | Measure-Object WorkingSet64 -Sum).Sum) / 1MB) }
        }
    }
    $grouped | Sort-Object MB -Descending | Select-Object -First 15 | ForEach-Object {
        Write-Host ('   {0,-32} x{1,-3} {2,8} MB' -f $_.Name, $_.Count, $_.MB) -ForegroundColor White
    }
    Write-Host ''
    $items = @(Get-StartupEntries)
    $on = @($items | Where-Object { $_.Enabled })
    Write-Host ('   Itens de inicializacao: ' + $on.Count + ' ativados de ' + $items.Count) -ForegroundColor Cyan
    foreach ($e in $on) { Write-Host ('   - ' + $e.Name + ' (' + $e.Scope + ')') -ForegroundColor White }
    Write-Host ''
    Write-Host '   Servicos de terceiros em inicio automatico e rodando agora:' -ForegroundColor Cyan
    $svcs = @(Get-CimInstance Win32_Service | Where-Object { $_.StartMode -eq 'Auto' -and $_.State -eq 'Running' -and $_.PathName -and ($_.PathName -notmatch '(?i)\\windows\\') -and ($_.PathName -notmatch '(?i)Windows Defender|Microsoft') })
    if ($svcs.Count -eq 0) { Write-Host '   Nenhum encontrado.' -ForegroundColor Gray }
    foreach ($s in ($svcs | Sort-Object DisplayName)) {
        $dn = $s.DisplayName
        if ($dn.Length -gt 50) { $dn = $dn.Substring(0, 47) + '...' }
        Write-Host ('   - {0,-50} [{1}]' -f $dn, $s.Name) -ForegroundColor White
    }
    Write-Host ''
    Write-Host '   Nada foi alterado. Voce decide o que desligar.' -ForegroundColor Green
    Write-Host ''
    if ($svcs.Count -gt 0) {
        $ans2 = (Read-Host '   Abrir a janela de Servicos do Windows para revisar esses servicos? (S/N)').Trim()
        if ($ans2 -match '^[SsYy]') { Start-Process services.msc }
    }
}


# ===================== ART NEW TWEAKS: REDE, JOGOS, SERVICOS, DISCO, CPU =====================
$global:ArtStateFile = Join-Path (Join-Path $env:USERPROFILE 'ART_Backups') 'ART_Tweaks_State.json'

function Get-ArtState {
    if (Test-Path -LiteralPath $global:ArtStateFile) {
        try {
            $o = Get-Content -LiteralPath $global:ArtStateFile -Raw | ConvertFrom-Json
            if ($o) { return @($o) }
        } catch { }
    }
    return @()
}

function Save-ArtState($list) {
    $dir = Split-Path -Parent $global:ArtStateFile
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    $json = ConvertTo-Json -InputObject @($list) -Depth 6
    Set-Content -LiteralPath $global:ArtStateFile -Value $json -Encoding UTF8
}

# Guarda o valor ORIGINAL uma unica vez (aplicar de novo nao apaga o original)
function Add-ArtState($g, $t, $p, $n, $e, $v, $k) {
    $s = New-Object System.Collections.ArrayList
    foreach ($x in @(Get-ArtState)) { [void]$s.Add($x) }
    foreach ($x in $s) {
        if (($x.G -eq $g) -and ($x.T -eq $t) -and ($x.P -eq $p) -and ($x.N -eq $n)) { return }
    }
    [void]$s.Add([pscustomobject]@{ G = $g; T = $t; P = $p; N = $n; E = $e; V = $v; K = $k })
    Save-ArtState $s
}

function Set-RegVal($g, $path, $name, $value, $kind) {
    $existed = $false
    $old = $null
    $oldKind = ''
    if (Test-Path -LiteralPath $path) {
        $item = Get-Item -LiteralPath $path
        if ($item.GetValueNames() -contains $name) {
            $existed = $true
            $old = $item.GetValue($name, $null, [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
            $oldKind = $item.GetValueKind($name).ToString()
        }
    }
    Add-ArtState $g 'reg' $path $name $existed $old $oldKind
    if (-not (Test-Path -LiteralPath $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -LiteralPath $path -Name $name -Value $value -Type $kind -Force
}

function Remove-EmptyKey($path) {
    if (Test-Path -LiteralPath $path) {
        $it = Get-Item -LiteralPath $path
        if (($it.ValueCount -eq 0) -and ($it.SubKeyCount -eq 0)) { Remove-Item -LiteralPath $path -Force }
    }
}

function Restore-ArtState($groups) {
    $all = @(Get-ArtState)
    $keep = @()
    $n = 0
    foreach ($x in $all) {
        if ($groups -notcontains $x.G) { $keep += $x; continue }
        switch ($x.T) {
            'reg' {
                if ($x.E) {
                    $v = $x.V
                    if ($x.K -eq 'Binary') { $v = [byte[]]@($v) }
                    elseif ($x.K -eq 'DWord') { $v = [int]$v }
                    if (-not (Test-Path -LiteralPath $x.P)) { New-Item -Path $x.P -Force | Out-Null }
                    Set-ItemProperty -LiteralPath $x.P -Name $x.N -Value $v -Type $x.K -Force
                    if (($x.P -match '\\Services\\[^\\]+$') -and ($x.N -eq 'Start') -and ([int]$x.V -eq 2)) {
                        Start-Service -Name (Split-Path -Leaf $x.P)
                    }
                } else {
                    Remove-ItemProperty -LiteralPath $x.P -Name $x.N -Force
                    if ($x.P -match 'Image File Execution Options') {
                        Remove-EmptyKey $x.P
                        Remove-EmptyKey (Split-Path -Parent $x.P)
                    }
                }
                $n++
            }
            'adv' {
                Set-NetAdapterAdvancedProperty -Name $x.P -RegistryKeyword $x.N -RegistryValue ([string]$x.V) -NoRestart
                $n++
            }
            'rss' {
                if ($x.V -eq 'False') { Disable-NetAdapterRss -Name $x.P }
                $n++
            }
            'dns' {
                $idx = (Get-NetAdapter -Name $x.P).ifIndex
                if ($idx) {
                    if ([string]::IsNullOrEmpty([string]$x.V)) { Set-DnsClientServerAddress -InterfaceIndex $idx -ResetServerAddresses }
                    else { Set-DnsClientServerAddress -InterfaceIndex $idx -ServerAddresses (([string]$x.V) -split ',') }
                }
                $n++
            }
            'idx' {
                $vol = Get-CimInstance Win32_Volume -Filter ("DriveLetter='" + $x.P + ":'")
                if ($vol) { Set-CimInstance -InputObject $vol -Property @{ IndexingEnabled = $true } }
                $n++
            }
            'task' {
                Enable-ScheduledTask -TaskPath $x.P -TaskName $x.N | Out-Null
                $n++
            }
            'pcfg' {
                $parts = ([string]$x.N) -split '\|'
                $vals = ([string]$x.V) -split ','
                & powercfg /setacvalueindex $x.P $parts[0] $parts[1] ([int]$vals[0]) | Out-Null
                & powercfg /setdcvalueindex $x.P $parts[0] $parts[1] ([int]$vals[1]) | Out-Null
                & powercfg /setactive $x.P | Out-Null
                $n++
            }
        }
    }
    Save-ArtState $keep
    return $n
}

# ---------- REDE ----------
$global:NetOffKw = @('GigaLite', 'EEE', '*EEE', 'EEELinkAdvertisement', 'AdvancedEEE', 'EnableGreenEthernet', 'GreenEthernet', 'PowerSavingMode', 'PowerSaving', 'ULPMode', 'ReduceSpeedOnPowerDown', 'EnablePME', 'AutoPowerSaveModeEnabled', 'EnableSavePowerNow', 'EnableDynamicPowerGating', 'S5WakeOnLan', '*WakeOnMagicPacket', '*WakeOnPattern', 'WakeOnLink', '*SelectiveSuspend')
$global:NetOffName = 'Gigabit Lite|Giga Lite|Green Ethernet|Ethernet Verde|Energy.Efficient|Energia Eficiente|Efici.ncia.*Energ|Power Saving|Economia de energia|Wake on|Wake-on|Pacote Wake|Ativar na LAN'

function Wait-LinkUp($name, $minBps, $seconds) {
    $end = (Get-Date).AddSeconds($seconds)
    while ((Get-Date) -lt $end) {
        Start-Sleep -Milliseconds 1000
        $a = Get-NetAdapter -Name $name
        if ($a -and ($a.Status -eq 'Up') -and ([double]$a.Speed -ge $minBps)) { return $a }
    }
    return $null
}

function Set-BestLink($a) {
    $p = Get-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword '*SpeedDuplex' -AllProperties
    if (-not $p) { return 'sem opcao de velocidade e duplex neste adaptador (mantido como esta)' }
    if ($a.Status -ne 'Up') { return 'cabo desconectado, velocidade nao alterada' }
    $dv = @($p.ValidDisplayValues)
    $rv = @($p.ValidRegistryValues)
    $cands = @()
    for ($i = 0; $i -lt $dv.Count; $i++) {
        $d = [string]$dv[$i]
        if (($d -match '(\d+(?:[.,]\d+)?)\s*Gbps') -and ($d -notmatch 'Half|Meio|Master|Slave|Mestre|Escravo')) {
            $sp = [double](($Matches[1]) -replace ',', '.')
            $cands += [pscustomobject]@{ Speed = $sp; Reg = [string]$rv[$i]; Name = $d }
        }
    }
    if ($cands.Count -eq 0) { return 'este adaptador so tem Auto Negotiation ou ate 100 Mbps (mantido em Auto)' }
    $orig = [string]$p.RegistryValue
    Add-ArtState 'net' 'adv' $a.Name '*SpeedDuplex' $true $orig ''
    foreach ($c in ($cands | Sort-Object Speed -Descending)) {
        Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword '*SpeedDuplex' -RegistryValue $c.Reg -NoRestart
        Restart-NetAdapter -Name $a.Name
        $up = Wait-LinkUp $a.Name ($c.Speed * 1000000000 * 0.9) 20
        if ($up) { return ('fixado em ' + $c.Name + ' (link ativo a ' + $up.LinkSpeed + ')') }
    }
    Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword '*SpeedDuplex' -RegistryValue $orig -NoRestart
    Restart-NetAdapter -Name $a.Name
    Wait-LinkUp $a.Name 1 20 | Out-Null
    return 'nenhuma velocidade fixa subiu o link (roteador/cabo nao suportam), voltei ao valor anterior'
}

function Invoke-NetApply {
    Write-Title 'REDE: aplicando ajustes na placa e no TCP'
    $ads = @(Get-NetAdapter -Physical)
    if ($ads.Count -eq 0) { Write-Warn2 'Nenhum adaptador de rede fisico encontrado.'; return }
    Write-Host '   A conexao pode cair alguns segundos enquanto a placa reinicia.' -ForegroundColor Gray
    foreach ($a in $ads) {
        Write-Host ''
        Write-Host ('   Adaptador: ' + $a.Name + ' (' + $a.InterfaceDescription + ')') -ForegroundColor Cyan
        $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -AllProperties)
        $off = 0
        foreach ($p in $props) {
            $kw = [string]$p.RegistryKeyword
            $dn = [string]$p.DisplayName
            if (($global:NetOffKw -contains $kw) -or ($dn -match $global:NetOffName)) {
                $dvals = @($p.ValidDisplayValues)
                $rvals = @($p.ValidRegistryValues)
                $target = $null
                for ($j = 0; $j -lt $dvals.Count; $j++) {
                    if (([string]$dvals[$j] -match '^(Disabled|Disable|Desativad|Desligad|Off)') -and ($j -lt $rvals.Count)) { $target = [string]$rvals[$j] }
                }
                if (($null -eq $target) -and ($rvals -contains '0')) { $target = '0' }
                if ($null -eq $target) {
                    Write-Warn2 ('Nao consegui desativar (valor "desligado" desconhecido): ' + $dn)
                } elseif ([string]$p.RegistryValue -ne $target) {
                    Add-ArtState 'net' 'adv' $a.Name $kw $true ([string]$p.RegistryValue) ''
                    Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword $kw -RegistryValue $target -NoRestart
                    Write-Ok ('Desativado: ' + $dn)
                    $off++
                } else {
                    Write-Host ('   Ja estava desativado: ' + $dn) -ForegroundColor Gray
                }
            }
        }
        if ($off -eq 0) { Write-Host '   Economia de energia da placa: nada para desativar (ja desativada ou o driver nao tem essas opcoes).' -ForegroundColor Gray }

        # RSS e filas
        $rssP = $props | Where-Object { $_.RegistryKeyword -eq '*RSS' } | Select-Object -First 1
        if ($rssP -and ([string]$rssP.RegistryValue -ne '1') -and (@($rssP.ValidRegistryValues) -contains '1')) {
            Add-ArtState 'net' 'adv' $a.Name '*RSS' $true ([string]$rssP.RegistryValue) ''
            Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword '*RSS' -RegistryValue '1' -NoRestart
            Write-Ok 'RSS (Receive Side Scaling) ativado'
            $off++
        }
        $qP = $props | Where-Object { $_.RegistryKeyword -eq '*NumRssQueues' } | Select-Object -First 1
        if ($qP) {
            $valid = @(@($qP.ValidRegistryValues) | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ } | Where-Object { $_ -le 4 } | Sort-Object -Descending)
            if (($valid.Count -gt 0) -and ([string]$qP.RegistryValue -ne [string]$valid[0])) {
                Add-ArtState 'net' 'adv' $a.Name '*NumRssQueues' $true ([string]$qP.RegistryValue) ''
                Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword '*NumRssQueues' -RegistryValue ([string]$valid[0]) -NoRestart
                Write-Ok ('Filas RSS: ' + $valid[0])
                $off++
            }
        }
        $rss = Get-NetAdapterRss -Name $a.Name
        if ($rss -and (-not $rss.Enabled)) {
            Add-ArtState 'net' 'rss' $a.Name 'Enabled' $true 'False' ''
            Enable-NetAdapterRss -Name $a.Name
            Write-Ok 'RSS habilitado no adaptador'
        }

        # Gerenciamento de energia do Windows: nao desligar a placa para economizar energia
        $cls = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}'
        foreach ($k in @(Get-ChildItem -LiteralPath $cls | Where-Object { $_.PSChildName -match '^\d{4}$' })) {
            if ($k.GetValue('NetCfgInstanceId') -eq $a.InterfaceGuid) {
                Set-RegVal 'net' $k.PSPath 'PnPCapabilities' 24 'DWord'
                Write-Ok 'Windows nao pode mais desligar a placa para economizar energia'
            }
        }

        # Nagle
        $ifk = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + $a.InterfaceGuid
        if (Test-Path -LiteralPath $ifk) {
            Set-RegVal 'net' $ifk 'TcpAckFrequency' 1 'DWord'
            Set-RegVal 'net' $ifk 'TCPNoDelay' 1 'DWord'
            Set-RegVal 'net' $ifk 'TcpDelAckTicks' 0 'DWord'
            Write-Ok 'Algoritmo de Nagle desativado (TcpAckFrequency, TCPNoDelay)'
        }

        # Velocidade e duplex no maximo (testa o link e volta se nao subir)
        $res = Set-BestLink $a
        Write-Host ('   Velocidade e duplex: ' + $res) -ForegroundColor White
        if (($off -gt 0) -and ($res -like 'sem opcao*' -or $res -like 'cabo*' -or $res -like 'este adaptador*')) {
            if ($a.Status -eq 'Up') { Restart-NetAdapter -Name $a.Name }
        }
    }
    Write-Host ''
    & netsh int tcp set global autotuninglevel=normal | Out-Null
    & netsh int tcp set global ecncapability=enabled | Out-Null
    & netsh int tcp set global rss=enabled | Out-Null
    & netsh int tcp set global rsc=disabled | Out-Null
    Write-Ok 'TCP global: autotuning normal, ECN ativado, RSS ativado, RSC desativado'
    & ipconfig /flushdns | Out-Null
    Write-Ok 'Cache de DNS limpo'
    Write-Host ''
    Write-Host '   Para escolher o DNS mais rapido use a opcao 2 deste menu. Reinicie o PC para finalizar.' -ForegroundColor Yellow
}

function Invoke-DnsTest {
    Write-Title 'REDE: teste de DNS (menor tempo de resposta)'
    $ads = @(Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' })
    if ($ads.Count -eq 0) { Write-Warn2 'Nenhum adaptador conectado.'; return }
    $cur = @()
    foreach ($a in $ads) { $cur += @((Get-DnsClientServerAddress -InterfaceIndex $a.ifIndex -AddressFamily IPv4).ServerAddresses) }
    $curIp = $cur | Where-Object { $_ } | Select-Object -First 1
    $list = @(
        [pscustomobject]@{ Name = 'Cloudflare'; Ips = @('1.1.1.1', '1.0.0.1') },
        [pscustomobject]@{ Name = 'Google'; Ips = @('8.8.8.8', '8.8.4.4') },
        [pscustomobject]@{ Name = 'Quad9'; Ips = @('9.9.9.9', '149.112.112.112') }
    )
    if ($curIp -and ($curIp -notin @('1.1.1.1', '8.8.8.8', '9.9.9.9'))) {
        $list = @([pscustomobject]@{ Name = 'Atual'; Ips = @($curIp) }) + $list
    }
    $sites = @('google.com', 'youtube.com', 'facebook.com', 'amazon.com', 'wikipedia.org', 'microsoft.com', 'steampowered.com', 'netflix.com')
    Write-Host '   Medindo, isso leva uns segundos...' -ForegroundColor Gray
    $rows = @()
    foreach ($s in $list) {
        $times = @()
        $fail = 0
        foreach ($round in 1, 2) {
            foreach ($site in $sites) {
                $sw = [Diagnostics.Stopwatch]::StartNew()
                $r = Resolve-DnsName -Name $site -Server $s.Ips[0] -Type A -DnsOnly -QuickTimeout
                $sw.Stop()
                if ($round -eq 2) {
                    if ($r) { $times += $sw.Elapsed.TotalMilliseconds } else { $fail++ }
                }
            }
        }
        $avg = 9999
        if ($times.Count -gt 0) { $avg = [math]::Round(($times | Measure-Object -Average).Average, 1) }
        $rows += [pscustomobject]@{ Name = $s.Name; Ips = $s.Ips; Avg = $avg; Fail = $fail }
    }
    Write-Host ''
    foreach ($r in ($rows | Sort-Object Avg)) {
        $c = 'White'
        if ($r.Fail -gt 0) { $c = 'Yellow' }
        Write-Host ('   {0,-12} {1,-18} {2,8} ms   falhas: {3}' -f $r.Name, ($r.Ips -join ' / '), $r.Avg, $r.Fail) -ForegroundColor $c
    }
    $best = $rows | Where-Object { $_.Fail -eq 0 } | Sort-Object Avg | Select-Object -First 1
    Write-Host ''
    if (-not $best) { Write-Warn2 'Nenhum servidor respondeu sem falhas, DNS nao alterado.'; return }
    if ($best.Name -eq 'Atual') { Write-Ok 'Seu DNS atual ja e o mais rapido, nada a fazer.'; return }
    $ans = (Read-Host ('   Aplicar ' + $best.Name + ' (' + ($best.Ips -join ', ') + ') nos adaptadores conectados? Digite S para confirmar')).Trim()
    if ($ans -notmatch '^[SsYy]$') { Write-Host '   DNS nao alterado.' -ForegroundColor Yellow; return }
    foreach ($a in $ads) {
        $ifk = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + $a.InterfaceGuid
        $ns = ''
        if (Test-Path -LiteralPath $ifk) { $ns = [string](Get-ItemProperty -LiteralPath $ifk).NameServer }
        Add-ArtState 'net' 'dns' $a.Name 'DNS' $true $ns ''
        Set-DnsClientServerAddress -InterfaceIndex $a.ifIndex -ServerAddresses $best.Ips
        Write-Ok ('DNS aplicado em ' + $a.Name)
    }
    & ipconfig /flushdns | Out-Null
}

function Invoke-NetRevert {
    Write-Title 'REDE: revertendo ajustes'
    $n = @(Restore-ArtState @('net', 'wifi'))[-1]
    & netsh int tcp set global autotuninglevel=normal | Out-Null
    & netsh int tcp set global ecncapability=disabled | Out-Null
    & netsh int tcp set global rss=enabled | Out-Null
    & netsh int tcp set global rsc=enabled | Out-Null
    foreach ($a in @(Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' })) { Restart-NetAdapter -Name $a.Name }
    & ipconfig /flushdns | Out-Null
    Write-Ok ('Itens restaurados: ' + $n + ' (e TCP global voltou ao padrao do Windows)')
}

# ---------- WI-FI ----------
function Set-PowerIdxBoth($scheme, $sub, $setting, $val, $group) {
    $o = (& powercfg /q $scheme $sub $setting) | Out-String
    $m = [regex]::Matches($o, '0x[0-9a-fA-F]{8}')
    if ($m.Count -lt 2) { return $false }
    $ac = [Convert]::ToInt32($m[$m.Count - 2].Value, 16)
    $dc = [Convert]::ToInt32($m[$m.Count - 1].Value, 16)
    Add-ArtState $group 'pcfg' $scheme ($sub + '|' + $setting) $true ([string]$ac + ',' + [string]$dc) ''
    & powercfg /setacvalueindex $scheme $sub $setting $val | Out-Null
    & powercfg /setdcvalueindex $scheme $sub $setting $val | Out-Null
    & powercfg /setactive $scheme | Out-Null
    return $true
}

function Find-OptionReg($p, $pattern) {
    $dv = @($p.ValidDisplayValues)
    $rv = @($p.ValidRegistryValues)
    for ($i = 0; $i -lt $dv.Count; $i++) {
        if (([string]$dv[$i] -match $pattern) -and ($i -lt $rv.Count)) { return [string]$rv[$i] }
    }
    return $null
}

function Set-AdvOption($a, $p, $target) {
    if ([string]$p.RegistryValue -eq [string]$target) { return $false }
    Add-ArtState 'wifi' 'adv' $a.Name ([string]$p.RegistryKeyword) $true ([string]$p.RegistryValue) ''
    Set-NetAdapterAdvancedProperty -Name $a.Name -RegistryKeyword ([string]$p.RegistryKeyword) -RegistryValue ([string]$target) -NoRestart
    return $true
}

$global:WifiRules = @(
    @{ Name = 'MIMO|SMPS'; Opt = 'No SMPS|Disabled|Desativ|Off|Nenhum'; Label = 'Economia MIMO desativada' },
    @{ Name = 'U-?APSD|Power Sav|Powersav|Economia de energia|Energy Sav'; Opt = 'Disabled|Desativ|Off|Max.*Perf|Maximum'; Label = 'Economia de energia do Wi-Fi desativada' },
    @{ Name = 'Roam.*(Aggress|Agress|Sensitiv|Tend)|(Aggress|Agress).*Roam'; Opt = 'Lowest|Minimum|Minimo|Mais baixo|^Baixo|^Low$|^1\.'; Label = 'Roaming no minimo' },
    @{ Name = '802\.11ax|Wi-?Fi ?6|802\.11be|Wi-?Fi ?7|HE ?Mode|EHT'; Opt = '^(Enabled|Ativad|Habilitad|On)'; Label = 'Modo Wi-Fi 6/7 ativado' }
)

function Show-WifiLink {
    Write-Title 'WI-FI: status do link'
    $txt = (& netsh wlan show interfaces) | Out-String
    foreach ($ln in ($txt -split "`n")) {
        $s = $ln.Trim()
        if ($s -match '^(Name|Nome|Description|Descri|SSID|BSSID|Network type|Radio|Band|Banda|Channel|Canal|Receive rate|Transmit rate|Taxa|Signal|Sinal)') { Write-Host ('   ' + $s) -ForegroundColor White }
    }
    $ch = [regex]::Match($txt, '(?im)^\s*(Channel|Canal)\s*:\s*(\d+)')
    if ($ch.Success -and ([int]$ch.Groups[2].Value -le 14)) {
        Write-Host ''
        Write-Warn2 'Voce esta na banda de 2.4 GHz. Se seu roteador tem 5 GHz, conecte nela (rede com final 5G) para menos interferencia.'
    }
    return $(if ($ch.Success) { [int]$ch.Groups[2].Value } else { 0 })
}

function Show-WifiChannels($myChan) {
    Write-Title 'WI-FI: redes vizinhas por canal'
    $txt = (& netsh wlan show networks mode=bssid) | Out-String
    $blocks = [regex]::Split($txt, '(?im)^\s*BSSID\s+\d+')
    $rows = @()
    for ($i = 1; $i -lt $blocks.Count; $i++) {
        $ch = [regex]::Match($blocks[$i], '(?im)^\s*(Channel|Canal)\s*:\s*(\d+)')
        $sg = [regex]::Match($blocks[$i], '(?im)^\s*(Signal|Sinal)\s*:\s*(\d+)')
        if ($ch.Success -and $sg.Success) { $rows += [pscustomobject]@{ Ch = [int]$ch.Groups[2].Value; Sig = [int]$sg.Groups[2].Value } }
    }
    if ($rows.Count -eq 0) { Write-Warn2 'Nao consegui listar as redes vizinhas (ative a Localizacao do Windows e tente de novo).'; return }
    foreach ($g in ($rows | Group-Object Ch | Sort-Object { [int]$_.Name })) {
        $best = ($g.Group | Measure-Object -Property Sig -Maximum).Maximum
        $mark = ''
        if ([int]$g.Name -eq $myChan) { $mark = '  <- seu canal' }
        Write-Host ('   Canal {0,3}: {1,2} rede(s), mais forte {2,3}%{3}' -f $g.Name, $g.Count, $best, $mark) -ForegroundColor White
    }
    Write-Host ''
    if (@($rows | Where-Object { $_.Ch -le 14 }).Count -gt 0) {
        $c24 = foreach ($c in 1, 6, 11) { [pscustomobject]@{ Ch = $c; N = @($rows | Where-Object { [math]::Abs($_.Ch - $c) -le 4 }).Count } }
        $b24 = $c24 | Sort-Object N | Select-Object -First 1
        Write-Ok ('2.4 GHz: o canal menos congestionado e o ' + $b24.Ch + ' (troque no roteador se o seu for outro)')
    }
    if (@($rows | Where-Object { $_.Ch -gt 14 }).Count -gt 0) {
        $c5 = foreach ($c in 36, 40, 44, 48, 149, 153, 157, 161) { [pscustomobject]@{ Ch = $c; N = @($rows | Where-Object { $_.Ch -eq $c }).Count } }
        $b5 = $c5 | Sort-Object N | Select-Object -First 1
        Write-Ok ('5 GHz: o canal menos congestionado e o ' + $b5.Ch)
    }
}

function Test-WifiStability {
    Write-Title 'WI-FI: teste de estabilidade (cerca de 15 segundos)'
    $gw = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway } | Select-Object -First 1).IPv4DefaultGateway.NextHop
    $targets = @()
    if ($gw) { $targets += [pscustomobject]@{ Name = 'Roteador'; Ip = [string]$gw; T = @(); Lost = 0 } }
    $targets += [pscustomobject]@{ Name = 'Internet'; Ip = '1.1.1.1'; T = @(); Lost = 0 }
    $ping = New-Object System.Net.NetworkInformation.Ping
    for ($i = 0; $i -lt 30; $i++) {
        foreach ($t in $targets) {
            $r = $null
            try { $r = $ping.Send($t.Ip, 1000) } catch { }
            if ($r -and ($r.Status -eq 'Success')) { $t.T += [double]$r.RoundtripTime } else { $t.Lost++ }
        }
        Start-Sleep -Milliseconds 500
    }
    foreach ($t in $targets) {
        if ($t.T.Count -eq 0) { Write-Warn2 ($t.Name + ' (' + $t.Ip + '): sem resposta'); continue }
        $avg = [math]::Round(($t.T | Measure-Object -Average).Average, 1)
        $max = ($t.T | Measure-Object -Maximum).Maximum
        $jit = 0
        for ($k = 1; $k -lt $t.T.Count; $k++) { $jit += [math]::Abs($t.T[$k] - $t.T[$k - 1]) }
        if ($t.T.Count -gt 1) { $jit = [math]::Round($jit / ($t.T.Count - 1), 1) }
        $loss = [math]::Round(100 * $t.Lost / 30, 1)
        $c = 'Green'
        if (($loss -gt 0) -or ($max -gt 100) -or ($jit -gt 15)) { $c = 'Yellow' }
        Write-Host ('   {0,-9} {1,-15} media {2} ms | pico {3} ms | jitter {4} ms | perda {5}%' -f $t.Name, $t.Ip, $avg, $max, $jit, $loss) -ForegroundColor $c
    }
    Write-Host '   Perda acima de 0 por cento ou picos acima de 100 ms indicam Wi-Fi instavel (distancia, interferencia ou canal ruim).' -ForegroundColor Gray
}

function Invoke-WifiApply {
    Write-Title 'WI-FI: aprimorando a conexao sem fio'
    $wifi = @(Get-NetAdapter -Physical | Where-Object { ([string]$_.PhysicalMediaType -match '802\.11') -or ([string]$_.InterfaceDescription -match 'Wi-?Fi|Wireless|WLAN|802\.11') })
    if ($wifi.Count -eq 0) { Write-Warn2 'Nenhum adaptador Wi-Fi encontrado neste PC.'; return }
    $scheme = [regex]::Match(((& powercfg /getactivescheme) | Out-String), '[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}').Value
    foreach ($a in $wifi) {
        Write-Host ''
        Write-Host ('   Adaptador: ' + $a.Name + ' (' + $a.InterfaceDescription + ')') -ForegroundColor Cyan
        $n = 0
        foreach ($p in @(Get-NetAdapterAdvancedProperty -Name $a.Name -AllProperties)) {
            $dn = [string]$p.DisplayName
            if ($dn -match 'Wake|Preferred Band|Preferred band|Banda preferida') { continue }
            $target = $null
            $label = $null
            $matched = $false
            foreach ($r in $global:WifiRules) {
                if ($dn -match $r.Name) { $matched = $true; $label = $r.Label; $target = Find-OptionReg $p $r.Opt; break }
            }
            if ((-not $matched) -and ($dn -match 'Wireless Mode|Modo sem fio|Modo Wireless')) {
                $matched = $true
                $label = 'Modo sem fio com 802.11ax'
                $dv = @($p.ValidDisplayValues)
                $rv = @($p.ValidRegistryValues)
                $len = 0
                for ($i = 0; $i -lt $dv.Count; $i++) {
                    if (([string]$dv[$i] -match 'ax') -and (([string]$dv[$i]).Length -gt $len) -and ($i -lt $rv.Count)) { $target = [string]$rv[$i]; $len = ([string]$dv[$i]).Length }
                }
            }
            if ((-not $matched) -and ($dn -match 'Channel Width|Largura.*canal') -and ($dn -match '(5|6)\s?GHz')) {
                $matched = $true
                $label = 'Largura de canal 5/6 GHz no maximo'
                $target = Find-OptionReg $p '^Auto'
                if ($null -eq $target) {
                    $dv = @($p.ValidDisplayValues)
                    $rv = @($p.ValidRegistryValues)
                    $mx = 0
                    for ($i = 0; $i -lt $dv.Count; $i++) {
                        $mm = [regex]::Matches([string]$dv[$i], '(\d+)\s?MHz')
                        if ($mm.Count -gt 0) {
                            $v = [int]$mm[$mm.Count - 1].Groups[1].Value
                            if (($v -gt $mx) -and ($i -lt $rv.Count)) { $mx = $v; $target = [string]$rv[$i] }
                        }
                    }
                }
            }
            if ($matched) {
                if ($null -eq $target) { Write-Host ('   Sem opcao compativel em: ' + $dn) -ForegroundColor Gray }
                elseif (Set-AdvOption $a $p $target) { Write-Ok ($label + ' (' + $dn + ')'); $n++ }
                else { Write-Host ('   Ja estava ajustado: ' + $dn) -ForegroundColor Gray }
            }
        }
        $cls = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}'
        foreach ($k in @(Get-ChildItem -LiteralPath $cls | Where-Object { $_.PSChildName -match '^\d{4}$' })) {
            if ($k.GetValue('NetCfgInstanceId') -eq $a.InterfaceGuid) {
                Set-RegVal 'wifi' $k.PSPath 'PnPCapabilities' 24 'DWord'
                Write-Ok 'Windows nao pode mais desligar o adaptador Wi-Fi para economizar energia'
            }
        }
        if ($scheme -and (Set-PowerIdxBoth $scheme '19cbb8fa-5279-450e-9fac-8a3d5fedd0c1' '12bbebe6-58d6-4636-95bb-3217ef867c1a' 0 'wifi')) {
            Write-Ok 'Plano de energia: adaptador sem fio em Desempenho Maximo'
        }
        if (($n -gt 0) -and ($a.Status -eq 'Up')) {
            Write-Host '   Reiniciando o adaptador para aplicar...' -ForegroundColor Gray
            Restart-NetAdapter -Name $a.Name
            Wait-LinkUp $a.Name 1 25 | Out-Null
        }
    }
    Start-Sleep -Seconds 3
    $chan = Show-WifiLink
    Show-WifiChannels $chan
    Test-WifiStability
    Write-Host ''
    Write-Host '   A banda preferida nao foi alterada. Reverter: opcao R deste menu.' -ForegroundColor Yellow
}

# ---------- GPU INTEGRADA INTEL ----------
$global:DiscreteGpuPattern = 'NVIDIA|GeForce|Quadro|\bRTX\b|\bGTX\b|Radeon\(TM\) RX|Radeon RX|Radeon Pro|Arc\(TM\) ?[AB]\d{3}|Arc ?[AB]\d{3}'

function Test-DiscreteGpu {
    foreach ($x in @(Get-CimInstance Win32_VideoController | Where-Object { [string]$_.PNPDeviceID -like 'PCI\*' })) {
        if ([string]$x.Name -match $global:DiscreteGpuPattern) { return $true }
    }
    return $false
}

function Get-IntelIgpu {
    return (Get-CimInstance Win32_VideoController | Where-Object { ([string]$_.PNPDeviceID -like 'PCI\VEN_8086*') -and ([string]$_.Name -notmatch 'Arc\(TM\) ?[AB]\d{3}|Arc ?[AB]\d{3}') } | Select-Object -First 1)
}

function Set-PowerIdxAc($scheme, $sub, $setting, $val, $group) {
    $o = (& powercfg /q $scheme $sub $setting) | Out-String
    $m = [regex]::Matches($o, '0x[0-9a-fA-F]{8}')
    if ($m.Count -lt 2) { return $false }
    $ac = [Convert]::ToInt32($m[$m.Count - 2].Value, 16)
    $dc = [Convert]::ToInt32($m[$m.Count - 1].Value, 16)
    Add-ArtState $group 'pcfg' $scheme ($sub + '|' + $setting) $true ([string]$ac + ',' + [string]$dc) ''
    & powercfg /setacvalueindex $scheme $sub $setting $val | Out-Null
    & powercfg /setactive $scheme | Out-Null
    return $true
}

function Invoke-IgpuVram {
    $gb = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    $mb = 512
    if ($gb -ge 28) { $mb = 2048 } elseif ($gb -ge 14) { $mb = 1024 }
    Set-RegVal 'igpu' 'HKLM:\SOFTWARE\Intel\GMM' 'DedicatedSegmentSize' $mb 'DWord'
    Write-Ok ('Memoria de video reportada: ' + $mb + ' MB (RAM do PC: ' + $gb + ' GB). Nao aloca nada, so muda o que o Windows informa aos jogos')
}

function Invoke-IgpuVisual {
    $adv = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-RegVal 'igpu' 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' 'EnableTransparency' 0 'DWord'
    Set-RegVal 'igpu' 'HKCU:\Control Panel\Desktop\WindowMetrics' 'MinAnimate' '0' 'String'
    Set-RegVal 'igpu' $adv 'TaskbarAnimations' 0 'DWord'
    Set-RegVal 'igpu' $adv 'ListviewShadow' 0 'DWord'
    Set-RegVal 'igpu' $adv 'ListviewAlphaSelect' 0 'DWord'
    Set-RegVal 'igpu' 'HKCU:\SOFTWARE\Microsoft\Windows\DWM' 'EnableAeroPeek' 0 'DWord'
    Set-RegVal 'igpu' 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' 'VisualFXSetting' 3 'DWord'
    Write-Ok 'Efeitos visuais leves: sem transparencia, animacoes de janelas e da barra, sombras de lista e Aero Peek'
    Write-Host '   Faca logoff ou reinicie o Explorer para ver tudo valendo.' -ForegroundColor Gray
}

function Show-IgpuDiag($ig) {
    Write-Title 'GPU INTEGRADA: diagnostico'
    Write-Line 'GPU' ([string]$ig.Name)
    Write-Line 'Driver' ([string]$ig.DriverVersion)
    if ($ig.DriverDate) {
        $age = [int]((Get-Date) - [datetime]$ig.DriverDate).TotalDays
        Write-Line 'Data do driver' (([datetime]$ig.DriverDate).ToString('yyyy-MM-dd') + ' (' + $age + ' dias)')
        if ($age -gt 365) { Write-Warn2 'Driver com mais de 1 ano. Em iGPU, drivers novos costumam trazer ganho real (Relatorio > Drivers).' }
    }
    if (Test-DiscreteGpu) { Write-Host '   Este PC tambem tem GPU dedicada (notebook hibrido ou desktop).' -ForegroundColor Gray }
    Write-Host ''
    $mods = @(Get-CimInstance Win32_PhysicalMemory)
    foreach ($m in $mods) {
        Write-Line ([string]$m.DeviceLocator) (([math]::Round($m.Capacity / 1GB)).ToString() + ' GB | nominal ' + $m.Speed + ' MT/s | em uso ' + $m.ConfiguredClockSpeed + ' MT/s')
    }
    $caps = @($mods | ForEach-Object { $_.Capacity } | Select-Object -Unique)
    if ($mods.Count -eq 1) {
        Write-Warn2 'Apenas 1 pente de memoria: single-channel. A iGPU perde bastante desempenho, dois pentes iguais costumam dar de 30 a 50 por cento mais FPS.'
    } elseif (($mods.Count -ge 2) -and ($caps.Count -eq 1)) {
        Write-Ok 'Pentes iguais: provavel dual-channel (estimativa pelos slots e capacidades).'
    } elseif ($mods.Count -ge 2) {
        Write-Warn2 'Pentes de tamanhos diferentes: parte da memoria pode rodar em single-channel.'
    }
    $rated = ($mods | Measure-Object -Property Speed -Minimum).Minimum
    $conf = ($mods | Measure-Object -Property ConfiguredClockSpeed -Minimum).Minimum
    if ($rated -and $conf -and ($conf -lt ($rated * 0.9))) {
        Write-Warn2 ('A RAM roda a ' + $conf + ' MT/s, abaixo dos ' + $rated + ' nominais. Ligue XMP/EXPO na BIOS.')
    }
    $mem = @(Get-CimInstance -ClassName Win32_PerfFormattedData_GPUPerformanceCounters_GPUAdapterMemory)
    if ($mem.Count -gt 0) {
        $sh = [math]::Round((($mem | Measure-Object -Property SharedUsage -Sum).Sum) / 1MB)
        $dd = [math]::Round((($mem | Measure-Object -Property DedicatedUsage -Sum).Sum) / 1MB)
        Write-Line 'Memoria de video' ('compartilhada em uso: ' + $sh + ' MB | dedicada em uso: ' + $dd + ' MB (agora)')
    }
}

function Invoke-IgpuApply {
    Write-Title 'GPU INTEGRADA INTEL'
    $ig = Get-IntelIgpu
    if (-not $ig) { Write-Warn2 'Nenhuma GPU integrada Intel encontrada neste PC, nada foi alterado.'; return }
    Show-IgpuDiag $ig
    Write-Host ''
    Write-Host '   Aplicando ajustes:' -ForegroundColor Cyan
    $scheme = [regex]::Match(((& powercfg /getactivescheme) | Out-String), '[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}').Value
    $any = $false
    if ($scheme) {
        if (Set-PowerIdxAc $scheme '44f3beca-a7c0-460e-9df2-bb8b99e0cba6' '3619c3f2-afb2-4afc-b0e0-e4f4b8d3ee0e' 2 'igpu') { Write-Ok 'Intel Graphics Power Plan: Desempenho Maximo (na tomada)'; $any = $true }
        if (Set-PowerIdxAc $scheme 'e276e160-7cb0-43c6-b20b-73f5dce39954' 'a1662ab2-9d34-4e53-ba8b-2639b9e20857' 3 'igpu') { Write-Ok 'Switchable Dynamic Graphics: Maximizar Desempenho (na tomada)'; $any = $true }
    }
    if (-not $any) { Write-Host '   O driver nao expoe o plano grafico da Intel neste PC, esse ajuste foi pulado.' -ForegroundColor Gray }
    Invoke-IgpuVisual
    Invoke-IgpuVram
    Write-Host ''
    Write-Host '   Reinicie o PC. Para desfazer: Reversoes (R) > GPU integrada.' -ForegroundColor Yellow
}

function Invoke-IgpuRevert {
    Write-Title 'GPU INTEGRADA: revertendo ajustes'
    $n = @(Restore-ArtState @('igpu'))[-1]
    Write-Ok ('Itens restaurados: ' + $n + '. Faca logoff ou reinicie.')
}

# ---------- JOGOS E TELA ----------
function Invoke-GameApply {
    Write-Title 'JOGOS E TELA: aplicando ajustes'
    $build = [int](Get-CimInstance Win32_OperatingSystem).BuildNumber
    if (($build -ge 19041) -and (-not (Test-DiscreteGpu))) {
        Write-Host '   HAGS mantido como esta: este PC so tem GPU integrada, onde o ganho e pequeno e pode travar em drivers antigos.' -ForegroundColor Gray
    } elseif ($build -ge 19041) {
        Set-RegVal 'game' 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' 'HwSchMode' 2 'DWord'
        Write-Ok 'HAGS ativado (agendamento de GPU por hardware). So funciona com GPU e driver compativeis'
    } else {
        Write-Warn2 'HAGS exige Windows 10 versao 2004 ou mais novo, pulado.'
    }
    Set-RegVal 'game' 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm' 'OverlayTestMode' 5 'DWord'
    Write-Ok 'MPO (Multiplane Overlay) desativado'
    $fse = 'HKCU:\System\GameConfigStore'
    Set-RegVal 'game' $fse 'GameDVR_FSEBehaviorMode' 2 'DWord'
    Set-RegVal 'game' $fse 'GameDVR_HonorUserFSEBehaviorMode' 1 'DWord'
    Set-RegVal 'game' $fse 'GameDVR_DXGIHonorFSEWindowsCompatible' 1 'DWord'
    Set-RegVal 'game' $fse 'GameDVR_EFSEFeatureFlags' 0 'DWord'
    Write-Ok 'Otimizacoes de tela cheia desativadas (tela cheia exclusiva de verdade)'
    Write-Host ''
    Write-Host '   Reinicie o PC. Se algum jogo ou monitor der problema, use Reversoes (R) > Jogos e Tela.' -ForegroundColor Yellow
}

function Invoke-DvrApply {
    Write-Title 'DEBLOAT: desativando Game DVR e Game Bar'
    $dvr = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR'
    Set-RegVal 'dvr' $dvr 'AppCaptureEnabled' 0 'DWord'
    Set-RegVal 'dvr' $dvr 'HistoricalCaptureEnabled' 0 'DWord'
    Set-RegVal 'dvr' 'HKCU:\System\GameConfigStore' 'GameDVR_Enabled' 0 'DWord'
    Set-RegVal 'dvr' 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' 'AllowGameDVR' 0 'DWord'
    Set-RegVal 'dvr' 'HKCU:\SOFTWARE\Microsoft\GameBar' 'UseNexusForGameBarEnabled' 0 'DWord'
    Set-RegVal 'dvr' 'HKCU:\SOFTWARE\Microsoft\GameBar' 'ShowStartupPanel' 0 'DWord'
    Write-Ok 'Game DVR e capturas em segundo plano desativados (Modo Jogo e servicos do Xbox continuam intactos)'
}

function Invoke-DvrRevert {
    Write-Title 'DEBLOAT: reativando Game DVR e Game Bar'
    $n = @(Restore-ArtState @('dvr'))[-1]
    Write-Ok ('Itens restaurados: ' + $n)
}

function Get-GameSearchRoots {
    $roots = @()
    foreach ($d in @(Get-PSDrive -PSProvider FileSystem | Where-Object { $null -ne $_.Free })) {
        foreach ($sub in 'SteamLibrary\steamapps\common', 'Program Files (x86)\Steam\steamapps\common', 'Program Files\Steam\steamapps\common', 'Steam\steamapps\common', 'Games', 'Jogos', 'Program Files\Epic Games', 'Epic Games', 'XboxGames', 'GOG Games', 'Program Files (x86)\GOG Galaxy\Games') {
            $p = Join-Path $d.Root $sub
            if (Test-Path -LiteralPath $p) { $roots += $p }
        }
    }
    $steam = [string](Get-ItemProperty -Path 'HKCU:\Software\Valve\Steam').SteamPath
    if ($steam) {
        $vdf = Join-Path $steam 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $vdf) {
            foreach ($m in [regex]::Matches((Get-Content -LiteralPath $vdf -Raw), '"path"\s+"([^"]+)"')) {
                $p = Join-Path ($m.Groups[1].Value -replace '\\\\', '\') 'steamapps\common'
                if (Test-Path -LiteralPath $p) { $roots += $p }
            }
        }
    }
    return @($roots | Select-Object -Unique)
}

function Select-GameExe($exes) {
    $exes = @($exes)
    if ($exes.Count -eq 0) { return $null }
    if ($exes.Count -eq 1) { return $exes[0].FullName }
    Write-Host ''
    Write-Host '   Executaveis encontrados (o jogo de verdade costuma ter Shipping no nome ou ser o maior):' -ForegroundColor Cyan
    $i = 0
    foreach ($x in $exes) { $i++; Write-Host ('   [{0}] {1}  ({2} MB)' -f $i, $x.FullName, [math]::Round($x.Length / 1MB, 1)) }
    Write-Host ''
    $n = (Read-Host '   Numero do .exe (vazio cancela)').Trim()
    if (($n -match '^\d+$') -and ([int]$n -ge 1) -and ([int]$n -le $exes.Count)) { return $exes[[int]$n - 1].FullName }
    return $null
}

function Find-ExesIn($folder, $filter) {
    $bad = 'unins|crash|report|redist|setup|install|easyanticheat|battleye|helper|webview|prereq|updater'
    return @(Get-ChildItem -LiteralPath $folder -Filter $filter -Recurse -Depth 6 -File | Where-Object { $_.Name -notmatch $bad } | Sort-Object @{ Expression = { $_.Name -match 'Shipping' }; Descending = $true }, @{ Expression = 'Length'; Descending = $true } | Select-Object -First 8)
}

function Resolve-GamePath($p) {
    $p = ([string]$p).Trim().Trim('"')
    if (Test-Path -LiteralPath $p -PathType Leaf) { return $p }
    if (Test-Path -LiteralPath ($p + '.exe') -PathType Leaf) { return ($p + '.exe') }
    if (Test-Path -LiteralPath $p -PathType Container) {
        $exes = Find-ExesIn $p '*.exe'
        if ($exes.Count -eq 0) { Write-Warn2 'Nao achei nenhum .exe dentro dessa pasta.'; return $null }
        return (Select-GameExe $exes)
    }
    if ($p -notmatch '[\\/]') {
        $name = [IO.Path]::GetFileNameWithoutExtension($p)
        Write-Host ('   Procurando "' + $name + '" nas pastas de jogos (Steam, Epic, Games)...') -ForegroundColor Gray
        $found = @()
        foreach ($r in (Get-GameSearchRoots)) { $found += @(Find-ExesIn $r ($name + '*.exe')) }
        if ($found.Count -eq 0) { Write-Warn2 'Nao encontrei esse jogo. Use a opcao 1 (janela de arquivos) ou a 2 (jogo aberto).'; return $null }
        return (Select-GameExe ($found | Select-Object -First 8))
    }
    $q = $p
    $up = 0
    while ($q -and (-not (Test-Path -LiteralPath $q -PathType Container))) {
        $parent = Split-Path -Parent $q
        if ((-not $parent) -or ($parent -eq $q)) { $q = $null; break }
        $q = $parent
        $up++
    }
    if ($q -and ($up -eq 1)) {
        Write-Warn2 ('O arquivo nao existe nessa pasta, mas a pasta existe: ' + $q + '. Procurando os executaveis dela...')
        $exes = Find-ExesIn $q '*.exe'
        if ($exes.Count -eq 0) { Write-Warn2 'Nao achei nenhum .exe nela.'; return $null }
        return (Select-GameExe $exes)
    }
    if ($q) {
        Write-Warn2 ('Esse caminho nao existe. A pasta mais proxima que existe e: ' + $q)
        $subs = @(Get-ChildItem -LiteralPath $q -Directory | Select-Object -First 25)
        foreach ($s2 in $subs) { Write-Host ('      ' + $s2.Name) -ForegroundColor Gray }
        Write-Host '   Confira o nome da pasta do jogo ou use a opcao 1 ou 2.' -ForegroundColor Gray
        return $null
    }
    Write-Warn2 'Caminho nao encontrado. Use a opcao 1 (janela de arquivos) ou a 2 (jogo aberto).'
    return $null
}

function Get-GameExePath {
    Write-Host '   Como escolher o jogo:' -ForegroundColor Cyan
    Write-Host '   [1] Procurar o .exe numa janela de arquivos (recomendado)'
    Write-Host '   [2] Escolher entre os programas abertos agora (abra o jogo antes, e o mais certeiro)'
    Write-Host '   [3] Digitar o caminho completo do .exe'
    Write-Host '   Ou cole/arraste aqui o .exe ou a pasta do jogo, ou digite so o nome (ex: InfinityNikki).'
    Write-Host ''
    $o = (Read-Host '   Opcao (vazio cancela)').Trim().Trim('"')
    if ($o -and ($o -notmatch '^[123]$')) { return (Resolve-GamePath $o) }
    if ($o -eq '1') {
        Add-Type -AssemblyName System.Windows.Forms
        $dlg = New-Object System.Windows.Forms.OpenFileDialog
        $dlg.Title = 'Escolha o .exe do jogo'
        $dlg.Filter = 'Programas (*.exe)|*.exe'
        $owner = New-Object System.Windows.Forms.Form
        $owner.TopMost = $true
        $owner.ShowInTaskbar = $false
        $owner.StartPosition = 'CenterScreen'
        $owner.Size = New-Object System.Drawing.Size(1, 1)
        $owner.Show()
        $res = $dlg.ShowDialog($owner)
        $owner.Close()
        if ($res -eq [System.Windows.Forms.DialogResult]::OK) { return $dlg.FileName }
        return $null
    }
    if ($o -eq '2') {
        $procs = @(Get-Process | Where-Object { $_.MainWindowTitle -and $_.Path -and ($_.Path -notlike ($env:WINDIR + '\*')) } | Sort-Object ProcessName)
        if ($procs.Count -eq 0) { Write-Warn2 'Nenhum programa com janela encontrado. Abra o jogo e tente de novo.'; return $null }
        Write-Host ''
        $i = 0
        foreach ($p in $procs) {
            $i++
            Write-Host ('   [{0}] {1}  ({2})' -f $i, $p.ProcessName, $p.MainWindowTitle)
        }
        Write-Host ''
        $n = (Read-Host '   Numero do jogo (vazio cancela)').Trim()
        if (($n -match '^\d+$') -and ([int]$n -ge 1) -and ([int]$n -le $procs.Count)) { return $procs[[int]$n - 1].Path }
        return $null
    }
    if ($o -eq '3') {
        $p = (Read-Host '   Caminho completo do .exe ou da pasta').Trim().Trim('"')
        if ($p) { return (Resolve-GamePath $p) }
    }
    return $null
}

function Invoke-GameProfile {
    Write-Title 'JOGOS: perfil por jogo (prioridade de CPU e GPU)'
    Write-Host '   Define CPU em Alta e a GPU de alto desempenho SO para o jogo que voce escolher.' -ForegroundColor Gray
    Write-Host '   Evite em jogos com anti-cheat muito agressivo (ex: Vanguard).' -ForegroundColor Yellow
    Write-Host ''
    $in = Get-GameExePath
    if (-not $in) { Write-Host '   Cancelado.' -ForegroundColor Yellow; return }
    if ($in -notmatch '\.exe$') { Write-Warn2 'O arquivo precisa ser um .exe'; return }
    $exe = Split-Path -Leaf $in
    $ifeo = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\' + $exe + '\PerfOptions'
    Set-RegVal 'gameprof' $ifeo 'CpuPriorityClass' 3 'DWord'
    Set-RegVal 'gameprof' $ifeo 'IoPriority' 3 'DWord'
    Write-Ok ('Prioridade de CPU e disco Alta para ' + $exe)
    if (Test-Path -LiteralPath $in) {
        Set-RegVal 'gameprof' 'HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences' $in 'GpuPreference=2;' 'String'
        Write-Ok 'GPU de alto desempenho definida para este jogo'
    } else {
        Write-Warn2 'Caminho nao encontrado, so a prioridade de CPU foi aplicada (a GPU precisa do caminho completo).'
    }
    Write-Host '   Vale na proxima vez que o jogo abrir. Para desfazer: Reversoes (R) > Jogos e Tela.' -ForegroundColor Yellow
}

function Invoke-GameRevert {
    Write-Title 'JOGOS E TELA: revertendo ajustes'
    $n = @(Restore-ArtState @('game', 'gameprof'))[-1]
    Write-Ok ('Itens restaurados: ' + $n + '. Reinicie o PC.')
}

# ---------- SERVICOS ----------
function Test-SystemSsd {
    try {
        $letter = $env:SystemDrive.Substring(0, 1)
        $part = Get-Partition -DriveLetter $letter
        $pd = Get-PhysicalDisk | Where-Object { $_.DeviceId -eq [string]$part.DiskNumber } | Select-Object -First 1
        if ($pd -and (($pd.BusType -eq 'NVMe') -or ($pd.MediaType -eq 'SSD'))) { return $true }
    } catch { }
    return $false
}

function Invoke-SvcApply {
    Write-Title 'SERVICOS: preset seguro'
    $list = @('Fax', 'RemoteRegistry', 'WerSvc', 'DiagTrack', 'WMPNetworkSvc', 'RetailDemo')
    if (Test-SystemSsd) { $list += 'SysMain' } else { Write-Host '   SysMain (Superfetch) mantido: o sistema nao esta em SSD.' -ForegroundColor Gray }
    foreach ($n in $list) {
        $s = Get-Service -Name $n
        if (-not $s) { continue }
        $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\' + $n
        Set-RegVal 'svc' $path 'Start' 4 'DWord'
        Stop-Service -Name $n -Force
        Write-Ok ('Desativado: ' + $n)
    }
    Write-Host '   Servicos do Xbox, audio, rede e Bluetooth nao foram tocados.' -ForegroundColor Gray
}

function Invoke-SvcRevert {
    Write-Title 'SERVICOS: revertendo preset'
    $n = @(Restore-ArtState @('svc'))[-1]
    Write-Ok ('Servicos restaurados: ' + $n)
}

$global:GameModeFile = Join-Path (Join-Path $env:USERPROFILE 'ART_Backups') 'ART_GameMode.json'

function Invoke-GameModeOn {
    Write-Title 'MODO JOGO: pausando servicos pesados'
    $list = @('WSearch', 'SysMain', 'DiagTrack', 'DoSvc', 'WerSvc', 'MapsBroker', 'wuauserv', 'UsoSvc')
    if (Get-Process -Name 'TiWorker', 'TrustedInstaller' -ErrorAction SilentlyContinue) {
        Write-Warn2 'O Windows esta instalando atualizacoes, Windows Update nao sera pausado.'
        $list = $list | Where-Object { $_ -notin @('wuauserv', 'UsoSvc') }
    }
    $stopped = @()
    if (Test-Path -LiteralPath $global:GameModeFile) {
        try { $stopped = @(Get-Content -LiteralPath $global:GameModeFile -Raw | ConvertFrom-Json) } catch { }
    }
    foreach ($n in $list) {
        $s = Get-Service -Name $n
        if ($s -and ($s.Status -eq 'Running')) {
            Stop-Service -Name $n -Force
            $s.Refresh()
            if ($s.Status -eq 'Stopped') {
                if ($stopped -notcontains $n) { $stopped += $n }
                Write-Ok ('Pausado: ' + $n)
            }
        }
    }
    New-Item -ItemType Directory -Path (Split-Path -Parent $global:GameModeFile) -Force | Out-Null
    ConvertTo-Json -InputObject @($stopped) | Set-Content -LiteralPath $global:GameModeFile -Encoding UTF8
    Write-Host ''
    Write-Host '   Quando terminar de jogar, use a opcao 9 > Retomar para ligar tudo de volta.' -ForegroundColor Yellow
}

function Invoke-GameModeOff {
    Write-Title 'MODO JOGO: retomando servicos'
    if (-not (Test-Path -LiteralPath $global:GameModeFile)) { Write-Host '   Nada para retomar.' -ForegroundColor Yellow; return }
    $stopped = @()
    try { $stopped = @(Get-Content -LiteralPath $global:GameModeFile -Raw | ConvertFrom-Json) } catch { }
    foreach ($n in $stopped) {
        $reg = Get-ItemProperty -LiteralPath ('HKLM:\SYSTEM\CurrentControlSet\Services\' + $n)
        if ($reg -and ($reg.Start -ne 4)) {
            Start-Service -Name $n
            Write-Ok ('Retomado: ' + $n)
        }
    }
    Remove-Item -LiteralPath $global:GameModeFile -Force
}

# ---------- DISCO ----------
function Get-DiskMap {
    $res = @()
    $pds = @(Get-PhysicalDisk)
    foreach ($v in @(Get-Volume | Where-Object { ($_.DriveType -eq 'Fixed') -and $_.DriveLetter })) {
        $part = Get-Partition -DriveLetter $v.DriveLetter | Select-Object -First 1
        $pd = $pds | Where-Object { $_.DeviceId -eq [string]$part.DiskNumber } | Select-Object -First 1
        $kind = 'Desconhecido'
        if ($pd) {
            if ($pd.BusType -eq 'NVMe') { $kind = 'NVMe' }
            elseif ($pd.MediaType -eq 'SSD') { $kind = 'SSD' }
            elseif ($pd.MediaType -eq 'HDD') { $kind = 'HDD' }
        }
        $res += [pscustomobject]@{ Letter = [string]$v.DriveLetter; Kind = $kind; FreeGB = [math]::Round($v.SizeRemaining / 1GB, 1); Model = [string]$pd.FriendlyName }
    }
    return $res
}

function Invoke-DiskCheck {
    Write-Title 'DISCO: TRIM e modo do controlador'
    $map = @(Get-DiskMap)
    foreach ($d in $map) { Write-Line ($d.Letter + ':') ($d.Kind + ' | ' + $d.Model + ' | livre ' + $d.FreeGB + ' GB') }
    Write-Host ''
    $hasSsd = @($map | Where-Object { $_.Kind -in @('SSD', 'NVMe') }).Count -gt 0
    $out = (& fsutil behavior query DisableDeleteNotify) | Out-String
    $m = [regex]::Match($out, '=\s*(\d)')
    if ($m.Success -and ($m.Groups[1].Value -eq '0')) {
        Write-Ok 'TRIM esta ATIVO'
    } elseif ($m.Success) {
        if ($hasSsd) {
            & fsutil behavior set DisableDeleteNotify 0 | Out-Null
            Write-Ok 'TRIM estava DESATIVADO, ativei agora'
        } else {
            Write-Warn2 'TRIM desativado, mas voce nao tem SSD (nao faz diferenca em HD).'
        }
    } else {
        Write-Warn2 'Nao consegui ler o estado do TRIM.'
    }
    Write-Host ''
    $ide = @(Get-CimInstance Win32_IDEController | ForEach-Object { [string]$_.Name })
    $scsi = @(Get-CimInstance Win32_SCSIController | ForEach-Object { [string]$_.Name })
    foreach ($c in ($ide + $scsi)) { Write-Line 'Controlador' $c }
    Write-Host ''
    $isAhci = @($ide | Where-Object { $_ -match 'AHCI' }).Count -gt 0
    $isIde = @($ide | Where-Object { ($_ -match 'IDE') -and ($_ -notmatch 'AHCI') }).Count -gt 0
    $isNvme = @($scsi | Where-Object { $_ -match 'NVM Express|NVMe' }).Count -gt 0
    $isRaid = @(($ide + $scsi) | Where-Object { $_ -match 'RAID|Rapid Storage|VMD' }).Count -gt 0
    if ($isIde) { Write-Warn2 'A BIOS parece estar em modo IDE/Legacy. Mude para AHCI na BIOS, mas prepare o Windows antes (modo seguro) senao ele nao inicia. Nao altero isso automaticamente.' }
    if ($isAhci) { Write-Ok 'Controlador SATA em modo AHCI' }
    if ($isNvme) { Write-Ok 'Driver NVMe nativo do Windows em uso' }
    if ($isRaid) { Write-Warn2 'Controlador em modo RAID/Intel RST/VMD. Funciona, mas se voce nao usa RAID, AHCI/NVMe nativo costuma ser um pouco mais rapido.' }
    if ((-not $isIde) -and (-not $isAhci) -and (-not $isNvme) -and (-not $isRaid)) { Write-Host '   Nao foi possivel identificar o modo do controlador.' -ForegroundColor Gray }
}

function Invoke-DiskSsdOpt {
    Write-Title 'DISCO: otimizacoes para SSD'
    $map = @(Get-DiskMap)
    $ssds = @($map | Where-Object { $_.Kind -in @('SSD', 'NVMe') })
    $hdds = @($map | Where-Object { $_.Kind -eq 'HDD' })
    if ($ssds.Count -eq 0) { Write-Warn2 'Nenhum SSD detectado, nada foi alterado.'; return }
    foreach ($d in $ssds) {
        $vol = Get-CimInstance Win32_Volume -Filter ("DriveLetter='" + $d.Letter + ":'")
        if ($vol -and $vol.IndexingEnabled) {
            Add-ArtState 'disk' 'idx' $d.Letter 'IndexingEnabled' $true 'True' ''
            Set-CimInstance -InputObject $vol -Property @{ IndexingEnabled = $false }
            Write-Ok ('Indexacao desativada na unidade ' + $d.Letter + ': (' + $d.Kind + ')')
        }
    }
    if (Test-SystemSsd) {
        Set-RegVal 'disk' 'HKLM:\SYSTEM\CurrentControlSet\Services\WSearch' 'Start' 4 'DWord'
        Stop-Service -Name 'WSearch' -Force
        Write-Ok 'Servico de indexacao (WSearch) desativado. A busca do Explorer fica um pouco mais lenta'
    }
    $t = Get-ScheduledTask -TaskPath '\Microsoft\Windows\Defrag\' -TaskName 'ScheduledDefrag'
    if ($hdds.Count -gt 0) {
        Write-Host '   Desfragmentacao agendada mantida: voce tem HD, ele precisa dela.' -ForegroundColor Gray
    } elseif ($t -and ($t.State -ne 'Disabled')) {
        Add-ArtState 'disk' 'task' '\Microsoft\Windows\Defrag\' 'ScheduledDefrag' $true ([string]$t.State) ''
        Disable-ScheduledTask -TaskPath '\Microsoft\Windows\Defrag\' -TaskName 'ScheduledDefrag' | Out-Null
        Write-Ok 'Desfragmentacao agendada desativada (so tem SSD). O TRIM continua automatico'
    }
    & fsutil behavior set DisableDeleteNotify 0 | Out-Null
    Write-Ok 'TRIM garantido como ativo'
}

function Invoke-DiskTemp {
    Write-Title 'DISCO: mover a pasta Temp para a unidade mais rapida'
    $map = @(Get-DiskMap)
    $sys = $env:SystemDrive.Substring(0, 1)
    $rank = @{ 'NVMe' = 2; 'SSD' = 1; 'HDD' = 0; 'Desconhecido' = 0 }
    $sysDisk = $map | Where-Object { $_.Letter -eq $sys } | Select-Object -First 1
    $sysRank = 0
    if ($sysDisk) { $sysRank = $rank[$sysDisk.Kind] }
    $best = $map | Where-Object { ($_.Letter -ne $sys) -and ($_.FreeGB -ge 20) -and ($rank[$_.Kind] -gt $sysRank) } | Sort-Object { $rank[$_.Kind] }, FreeGB -Descending | Select-Object -First 1
    if (-not $best) {
        Write-Ok 'A unidade do sistema ja e a mais rapida (ou nao ha outra unidade rapida com 20 GB livres). Mover o Temp nao traria ganho.'
        return
    }
    Write-Line 'Melhor destino' ($best.Letter + ': (' + $best.Kind + ', ' + $best.FreeGB + ' GB livres)')
    $ans = (Read-Host '   Mover o Temp do seu usuario para essa unidade? Digite S para confirmar').Trim()
    if ($ans -notmatch '^[SsYy]$') { Write-Host '   Cancelado.' -ForegroundColor Yellow; return }
    $dir = $best.Letter + ':\ART_Temp'
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    & icacls $dir /grant '*S-1-5-32-545:(OI)(CI)M' | Out-Null
    Set-RegVal 'disk' 'HKCU:\Environment' 'TEMP' $dir 'ExpandString'
    Set-RegVal 'disk' 'HKCU:\Environment' 'TMP' $dir 'ExpandString'
    Write-Ok ('Temp e TMP agora apontam para ' + $dir)
    Write-Host '   Faca logoff ou reinicie o PC para valer. Para desfazer: Reversoes (R) > Disco.' -ForegroundColor Yellow
}

function Invoke-DiskRevert {
    Write-Title 'DISCO: revertendo ajustes'
    $n = @(Restore-ArtState @('disk'))[-1]
    Write-Ok ('Itens restaurados: ' + $n + '. Se o Temp foi movido, faca logoff ou reinicie.')
}

# ---------- CPU ----------
function Set-PowerIdx($scheme, $sub, $setting, $val) {
    $o = (& powercfg /q $scheme $sub $setting) | Out-String
    $m = [regex]::Matches($o, '0x[0-9a-fA-F]{8}')
    if ($m.Count -lt 2) { return $false }
    $ac = [Convert]::ToInt32($m[$m.Count - 2].Value, 16)
    $dc = [Convert]::ToInt32($m[$m.Count - 1].Value, 16)
    Add-ArtState 'cpu' 'pcfg' $scheme ($sub + '|' + $setting) $true ([string]$ac + ',' + [string]$dc) ''
    & powercfg /setacvalueindex $scheme $sub $setting $val | Out-Null
    & powercfg /setactive $scheme | Out-Null
    return $true
}

function Set-IrqAffinity($pnpId, $cpuIndex) {
    $base = 'HKLM:\SYSTEM\CurrentControlSet\Enum\' + $pnpId + '\Device Parameters\Interrupt Management\Affinity Policy'
    $mask = [BitConverter]::GetBytes(([uint64]1) -shl $cpuIndex)
    Set-RegVal 'cpu' $base 'DevicePolicy' 4 'DWord'
    Set-RegVal 'cpu' $base 'AssignmentSetOverride' $mask 'Binary'
}

function Invoke-CpuExtra {
    Write-Title 'CPU: boost agressivo, CPU hibrida e afinidade de interrupcoes'
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $cores = [int](Get-CimInstance Win32_Processor | Measure-Object -Property NumberOfCores -Sum).Sum
    $logical = [int](Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
    $scheme = [regex]::Match(((& powercfg /getactivescheme) | Out-String), '[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}').Value
    if (-not $scheme) { Write-Warn2 'Nao achei o plano de energia ativo.'; return }
    Write-Line 'CPU' ([string]$cpu.Name)
    Write-Host ''
    $sub = 'SUB_PROCESSOR'
    if (Test-DiscreteGpu) {
        if (Set-PowerIdx $scheme $sub 'PERFBOOSTMODE' 2) { Write-Ok 'Modo de boost: Agressivo' } else { Write-Host '   PERFBOOSTMODE indisponivel neste PC.' -ForegroundColor Gray }
        if (Set-PowerIdx $scheme $sub 'PERFBOOSTPOL' 100) { Write-Ok 'Politica de boost: 100' }
        if (Set-PowerIdx $scheme $sub 'PERFEPP' 0) { Write-Ok 'EPP (preferencia de energia/desempenho): 0, maximo desempenho' } else { Write-Host '   PERFEPP indisponivel (CPU sem HWP).' -ForegroundColor Gray }
    } else {
        Write-Host '   Boost agressivo e EPP 0 pulados: so ha GPU integrada, e CPU e iGPU dividem o mesmo limite de energia e temperatura.' -ForegroundColor Gray
    }
    if ([string]$cpu.Name -match 'Core\(TM\) (Ultra|i[3579]-1[2-9]\d{3})') {
        Write-Host ''
        Write-Host '   CPU hibrida Intel (P-cores e E-cores) detectada.' -ForegroundColor Cyan
        $a = Set-PowerIdx $scheme $sub 'SCHEDPOLICY' 2
        $b = Set-PowerIdx $scheme $sub 'SHORTSCHEDPOLICY' 2
        if ($a -or $b) { Write-Ok 'Agendamento de threads: preferir nucleos de desempenho (P-cores)' } else { Write-Host '   Politica de agendamento hibrido indisponivel neste Windows.' -ForegroundColor Gray }
    } else {
        Write-Host '   CPU nao e hibrida Intel, ajuste de P/E-cores nao se aplica.' -ForegroundColor Gray
    }
    Write-Host ''
    if ($logical -ge 6) {
        $ht = $logical -gt $cores
        $gpuCpu = 2
        $nicCpu = 3
        if ($ht) { $nicCpu = 4 }
        $gpu = Get-CimInstance Win32_VideoController | Where-Object { ([string]$_.PNPDeviceID -like 'PCI\*') -and ([string]$_.Name -notmatch 'Basic|Microsoft') } | Sort-Object AdapterRAM -Descending | Select-Object -First 1
        if ($gpu) {
            Set-IrqAffinity $gpu.PNPDeviceID $gpuCpu
            Write-Ok ('Interrupcoes da GPU fixadas no CPU ' + $gpuCpu)
        }
        $nic = Get-NetAdapter -Physical | Where-Object { ($_.Status -eq 'Up') -and ([string]$_.PnPDeviceID -like 'PCI\*') } | Select-Object -First 1
        if ($nic) {
            Set-IrqAffinity $nic.PnPDeviceID $nicCpu
            Write-Ok ('Interrupcoes da rede fixadas no CPU ' + $nicCpu)
        }
        if ((-not $gpu) -and (-not $nic)) { Write-Host '   Nenhuma GPU ou placa de rede PCI encontrada para fixar.' -ForegroundColor Gray }
        Write-Host '   Reinicie o PC. Se rodar os ajustes de GPU (NVIDIA/AMD/Intel) depois, rode este de novo.' -ForegroundColor Yellow
    } else {
        Write-Host '   Menos de 6 processadores logicos: separar interrupcoes nao traz ganho, pulado.' -ForegroundColor Gray
    }
}

function Invoke-CpuRevert {
    Write-Title 'CPU: revertendo boost, EPP e afinidade'
    $n = @(Restore-ArtState @('cpu'))[-1]
    Write-Ok ('Itens restaurados: ' + $n + '. Reinicie o PC.')
}

# ---------- DPC (usado no medidor antes/depois) ----------
function Get-DpcSample {
    $dpc = @()
    $int = @()
    for ($i = 0; $i -lt 6; $i++) {
        $c = Get-CimInstance -ClassName Win32_PerfFormattedData_Counters_ProcessorInformation -Filter "Name='_Total'"
        if (($i -gt 0) -and $c) {
            $dpc += [double]$c.PercentDPCTime
            $int += [double]$c.PercentInterruptTime
        }
        Start-Sleep -Milliseconds 1000
    }
    if ($dpc.Count -eq 0) { return $null }
    return [pscustomobject]@{
        Dpc = [math]::Round(($dpc | Measure-Object -Average).Average, 2)
        Int = [math]::Round(($int | Measure-Object -Average).Average, 2)
    }
}


switch ($mode) {
    'startup' { Show-StartupManager }
    'backup'  { Invoke-ARTBackup }
    'restore' { Invoke-ARTRestore }
    'report'    { Show-Report }
    'before'    { Save-Before }
    'after'     { Save-After }
    'checks'    { Show-Checks }
    'gpudrivers' { Open-GpuDrivers }
    'usedpc'    { Show-UsedPc }
    'net_apply' { Invoke-NetApply }
    'wifi_apply' { Invoke-WifiApply }
    'net_dns' { Invoke-DnsTest }
    'net_revert' { Invoke-NetRevert }
    'game_apply' { Invoke-GameApply }
    'igpu_apply' { Invoke-IgpuApply }
    'igpu_vram' { Invoke-IgpuVram }
    'igpu_revert' { Invoke-IgpuRevert }
    'dvr_apply' { Invoke-DvrApply }
    'dvr_revert' { Invoke-DvrRevert }
    'game_profile' { Invoke-GameProfile }
    'game_revert' { Invoke-GameRevert }
    'svc_apply' { Invoke-SvcApply }
    'svc_revert' { Invoke-SvcRevert }
    'gm_on' { Invoke-GameModeOn }
    'gm_off' { Invoke-GameModeOff }
    'disk_check' { Invoke-DiskCheck }
    'disk_ssd' { Invoke-DiskSsdOpt }
    'disk_temp' { Invoke-DiskTemp }
    'disk_revert' { Invoke-DiskRevert }
    'cpu_extra' { Invoke-CpuExtra }
    'cpu_revert' { Invoke-CpuRevert }
}
#PS_ART_END
#BKEY HKCU\CONSOLE
#BKEY HKCU\Control Panel\Accessibility\Keyboard Response
#BKEY HKCU\Control Panel\Accessibility\MouseKeys
#BKEY HKCU\Control Panel\Accessibility\StickyKeys
#BKEY HKCU\Control Panel\Accessibility\ToggleKeys
#BKEY HKCU\Control Panel\Desktop
#BKEY HKCU\Control Panel\International\User Profile
#BKEY HKCU\Control Panel\Keyboard
#BKEY HKCU\Control Panel\Mouse
#BKEY HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
#BKEY HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences
#BKEY HKCU\Software\Microsoft\GameBar
#BKEY HKCU\SOFTWARE\Microsoft\Games
#BKEY HKCU\Software\Microsoft\Input\TIPC
#BKEY HKCU\Software\Microsoft\InputPersonalization
#BKEY HKCU\Software\Microsoft\Office\16.0\Common
#BKEY HKCU\Software\Microsoft\Office\16.0\Firstrun
#BKEY HKCU\Software\Microsoft\Office\16.0\OSM
#BKEY HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Mail
#BKEY HKCU\Software\Microsoft\Office\16.0\Word\Options
#BKEY HKCU\Software\Microsoft\Office\Common\ClientTelemetry
#BKEY HKCU\Software\Microsoft\Personalization\Settings
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize
#BKEY HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer
#BKEY HKCU\Software\Policies\Microsoft\Windows\WindowsAI
#BKEY HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot
#BKEY HKCU\System\GameConfigStore
#BKEY HKLM\Software\Intel\GMM
#BKEY HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System
#BKEY HKLM\Software\Microsoft\PolicyManager\default\Experience\AllowCortana
#BKEY HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation
#BKEY HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions
#BKEY HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile
#BKEY HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance
#BKEY HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore
#BKEY HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF
#BKEY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener
#BKEY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer
#BKEY HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments
#BKEY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability
#BKEY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
#BKEY HKLM\SOFTWARE\Microsoft\Windows\Dwm
#BKEY HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting
#BKEY HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS
#BKEY HKLM\SOFTWARE\Policies\Microsoft
#BKEY HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583
#BKEY HKLM\SYSTEM\ControlSet001\Control\PriorityControl
#BKEY HKLM\SYSTEM\ControlSet001\Services\BluetoothUserService
#BKEY HKLM\SYSTEM\ControlSet001\Services\BTAGService
#BKEY HKLM\SYSTEM\ControlSet001\Services\BthAvctpSvc
#BKEY HKLM\SYSTEM\ControlSet001\Services\bthserv
#BKEY HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity
#BKEY HKLM\System\CurrentControlSet\Control\Diagnostics\Performance
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Power
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Session Manager
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel
#BKEY HKLM\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog
#BKEY HKLM\System\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\amdlog
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\bam
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\dam
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\Spooler
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\USB
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters
#BKEY HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
#BKEY HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
#BKEY HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\WSearch
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\SysMain
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\Fax
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\WerSvc
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc
#BKEY HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo
#BKEY HKCU\SOFTWARE\Microsoft\DirectX
#BKEY HKCU\SOFTWARE\Microsoft\GameBar
#BKEY HKCU\Environment
@echo off
Set Version=0.1

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
stART "" /max cmd /c ""%~f0" big"
exit /b
:ART_big_done
cls 

::Verificando privilegios de administrador (isso garante que as alterações sejam aplicadas corretamente)
chcp 65001 >nul 2>&1
cls 
echo.
echo.
echo.       %w%   ART TWEAKING UTILITY V0.1 %B%
echo. ╔════════════════════════════════════════════════════╗
echo. ║                                                    ║
echo. ║     %w% Verificando privilegios de administrador... %b%  ║
echo. ║                                                    ║
echo. ╚════════════════════════════════════════════════════╝
timeout /t 1 /nobreak > NUL

rmdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
mkdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
if %errorlevel% neq 0 (   
cls 
echo.
echo.
echo. ╔════════════════════════════════════════════════════╗
echo. ║                                                    ║
echo. ║  %w% Executando como administrador...      %b% ║
echo. ║                                                    ║
echo. ╚════════════════════════════════════════════════════╝
timeout /t 1 /nobreak > NUL
chcp 437 >nul 2>&1
powershell -NoProfile -NonInteractive -Command stART -verb runas -WindowStyle Maximized "'%~s0'" big >nul 2>&1
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
echo.                                                                                                  %W% ART TWEAKING UTILITY VERSION 0.1                            
echo.
echo.                                                                                    %p%░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗░
echo.                                                                                    %p%░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝░
echo.                                                                                    %p%░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░░
echo.                                                                                    %p%░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░░
echo.                                                                                    %p%░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗░
echo.                                                                                    %p%░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝░ 
echo.                                          %b%"════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                                                Aviso
echo.
echo.                                              Nao nos responsabilizamos por problemas/danos que isto possa causar ao seu PC. Se ocorrer algum, use Backup / Restauracao, tecla P no menu principal
echo.
echo.                                              
echo.  
echo.                                          %b%"════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                                          Instrucoes * Perguntas frequentes
echo.
echo.                                               Digite um NUMERO no teclado e pressione ENTER para escolher uma opcao. Leia todos os avisos, nao aperte botoes sem ler.
echo.
echo.                                                      Voce pode desfazer a maioria das alteracoes com Reversoes / Correcoes [R] e Backup / Restauracao [P] no menu principal.
echo.  
echo.                                                                       %w%  Feito e distribuido por ART TWEAKS, 2026 * Versao 0.1 * Atualizado em 19 de Novembro de 2026
echo.                                          %b%"════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║             %w% Pressione qualquer tecla para continuar...      %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
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
echo.                                                                                           %W% ART TWEAKING UTILITY VERSION 0.1                            
echo.                                                  
echo.                                                          %p%██████╗░███████╗░██████╗████████╗░█████╗░██████╗░███████╗  ██████╗░░█████╗░██╗███╗░░██╗████████╗         
echo.                                                          %p%██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝  ██╔══██╗██╔══██╗██║████╗░██║╚══██╔══╝        
echo.                                                          %p%██████╔╝█████╗░░╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░  ██████╔╝██║░░██║██║██╔██╗██║░░░██║░░░         
echo.                                                          %p%██╔══██╗██╔══╝░░░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░  ██╔═══╝░██║░░██║██║██║╚████║░░░██║░░░        
echo.                                                          %p%██║░░██║███████╗██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗  ██║░░░░░╚█████╔╝██║██║░╚███║░░░██║░░░        
echo.                                                          %p%╚═╝░░╚═╝╚══════╝╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝  ╚═╝░░░░░░╚════╝░╚═╝╚═╝░░╚══╝░░░╚═╝░░░        
echo.                                                   %b%╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.                                                   %b%║                                      %w% Deseja criar um ponto de restauracao?                                  %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║                           %p%[%w%1%p%]%w% Criar ponto de restauracao       %p%[%w%2%p%]%w% Pular                                     %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║══════════════════════════════════════════════════════════════════════════════════════════════════════════════║
echo.                                                   %b%║           %W% Permite restaurar seu PC as mesmas configuracoes de quando o ponto foi criado                     %b%║
echo.                                                   %b%║                    %W% Voce pode usar um ponto de restauracao depois, dentro do utilitario, se quiser           %b%║
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
echo.                                                                  %p%██████╗░███████╗░██████╗████████╗░█████╗░██████╗░███████╗  ██████╗░░█████╗░██╗███╗░░██╗████████╗
echo.                                                                  %p%██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝  ██╔══██╗██╔══██╗██║████╗░██║╚══██╔══╝
echo.                                                                  %p%██████╔╝█████╗░░╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░  ██████╔╝██║░░██║██║██╔██╗██║░░░██║░░░
echo.                                                                  %p%██╔══██╗██╔══╝░░░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░  ██╔═══╝░██║░░██║██║██║╚████║░░░██║░░░
echo.                                                                  %p%██║░░██║███████╗██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗  ██║░░░░░╚█████╔╝██║██║░╚███║░░░██║░░░
echo.                                                                  %p%╚═╝░░╚═╝╚══════╝╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝  ╚═╝░░░░░░╚════╝░╚═╝╚═╝░░╚══╝░░░╚═╝░░░
echo.
echo. %w% Criando ponto de restauracao... %b%
chcp 437 >nul
powershell -NoProfile -Command "Checkpoint-Computer -Description 'ART Tweaks Restore Point' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
echo. %w% Salvando backup do registro, servicos e tarefas agendadas... %b%
call :ARTps backup
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
echo.                                                                  %p%██████╗░██████╗░░█████╗░███████╗██╗██╗░░░░░███████╗
echo.                                                                  %p%██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║░░░░░██╔════╝
echo.                                                                  %p%██████╔╝██████╔╝██║░░██║█████╗░░██║██║░░░░░█████╗░░
echo.                                                                  %p%██╔═══╝░██╔══██╗██║░░██║██╔══╝░░██║██║░░░░░██╔══╝░░
echo.                                                                  %p%██║░░░░░██║░░██║╚█████╔╝██║░░░░░██║███████╗███████╗
echo.                                                                  %p%╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚══════╝
echo.                                                   %b%╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.                                                   %b%║                                      %w% Qual perfil descreve o seu PC?                                         %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║                              %p%[%w%1%p%]%w% PC recem-formatado              %p%[%w%2%p%]%w% PC em uso                               %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║══════════════════════════════════════════════════════════════════════════════════════════════════════════════║
echo.                                                   %b%║   %w%[1] Instala VC++, DirectX e .NET via winget e abre a pagina de driver NVIDIA/AMD,                          %b%║
echo.                                                   %b%║   %w%    impede o Windows Update de trocar o driver de video e desliga Delivery                                 %b%║
echo.                                                   %b%║   %w%    Optimization, Inicializacao Rapida e apps em segundo plano.                                            %b%║
echo.                                                   %b%║                                                                                                              %b%║
echo.                                                   %b%║   %w%[2] Foco em limpeza: mostra o que pesa (processos com mais RAM, itens de inicializacao,                    %b%║
echo.                                                   %b%║   %w%    servicos de terceiros) e deixa VOCE decidir o que desligar.                                            %b%║
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
call :ARTps gpudrivers
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
pause > nul
cls
goto menu

:15
cls
echo.
echo.
echo.
echo.                                                                  %p%██████╗░███████╗██████╗░░█████╗░██████╗░████████╗
echo.                                                                  %p%██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
echo.                                                                  %p%██████╔╝█████╗░░██████╔╝██║░░██║██████╔╝░░░██║░░░
echo.                                                                  %p%██╔══██╗██╔══╝░░██╔═══╝░██║░░██║██╔══██╗░░░██║░░░
echo.                                                                  %p%██║░░██║███████╗██║░░░░░╚█████╔╝██║░░██║░░░██║░░░
echo.                                                                  %p%╚═╝░░╚═╝╚══════╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                  %p%[%w%1%p%]%w% Relatorio do PC                 %p%[%w%4%p%]%w% Verificacoes de Hardware
echo.
echo.                                                  %p%[%w%2%p%]%w% Antes/Depois: salvar ANTES      %p%[%w%3%p%]%w% Antes/Depois: salvar DEPOIS e comparar
echo.
echo.                                                  %p%[%w%5%p%]%w% PC em uso: o que esta pesando
echo.
echo.                                                                          %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo.                              %W% Relatorio do PC: CPU, GPU, RAM, tipo de disco, notebook ou desktop, driver de video e espaco livre
echo.                      %W% Antes/Depois: processos, servicos, RAM em uso e tempo de boot. Salve ANTES, aplique os ajustes, reinicie e salve DEPOIS
echo.                   %W% Verificacoes: RAM abaixo da velocidade nominal, taxa de atualizacao do monitor, saude do SSD e driver de video antigo
echo.                      %W% PC em uso: top processos por RAM, itens de inicializacao e servicos de terceiros. So mostra, voce decide
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
set "input="
set /p input=:
if /i "!input!"=="1" goto t15_1
if /i "!input!"=="2" goto t15_2
if /i "!input!"=="3" goto t15_3
if /i "!input!"=="4" goto t15_4
if /i "!input!"=="5" goto t15_5
if /i "!input!"=="M" cls & goto menu
cls
echo Erro de digitacao detectado
timeout 1 >nul
goto 15

:t15_1
cls
call :ARTps report
goto t15_end
:t15_2
cls
call :ARTps before
goto t15_end
:t15_3
cls
call :ARTps after
goto t15_end
:t15_5
cls
call :ARTps usedpc
goto t15_end
:t15_4
cls
call :ARTps checks
goto t15_end
:t15_end
echo.
echo. %w% Pressione qualquer tecla para continuar... %b%
pause > nul
cls
goto 15

:ARTps
set "ART_MODE=%~1"
chcp 65001 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText($env:ART_FILE); $a=$c.IndexOf('#PS_ART'+'_BEGIN'); $b=$c.IndexOf('#PS_ART'+'_END'); Invoke-Expression $c.Substring($a,$b-$a)"
exit /b


:soon
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                             %b%║%p%░░█████╗░██████╗░████████╗░░░░░██╗░░░██╗████████╗██╗██╗░░░░░██╗████████╗██╗░░░██╗░░░░░█████╗░░░░░░███╗░░%b%║
echo.                                             %b%║%p%░██╔══██╗██╔══██╗╚══██╔══╝░░░░░██║░░░██║╚══██╔══╝██║██║░░░░░██║╚══██╔══╝╚██╗░██╔╝░░░░██╔══██╗░░░░████║░░%b%║
echo.                                             %b%║%p%░███████║██████╔╝░░░██║░░░░░░░░██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░╚████╔╝░░░░░██║░░██║░░░██╔██║░░%b%║
echo.                                             %b%║%p%░██╔══██║██╔══██╗░░░██║░░░░░░░░██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░░╚██╔╝░░░░░░██║░░██║░░░╚═╝██║░░%b%║
echo.                                             %b%║%p%░██║░░██║██║░░██║░░░██║░░░░░░░░╚██████╔╝░░░██║░░░██║███████╗██║░░░██║░░░░░░██║░░░░░░░╚█████╔╝██╗███████╗%b%║
echo.                                             %b%║%p%░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░░░░╚═════╝░░░░╚═╝░░░╚═╝╚══════╝╚═╝░░░╚═╝░░░░░░╚═╝░░░░░░░░╚════╝░╚═╝╚══════╝%b%║
echo.                                             %b%║════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════║
echo.                                             %b%║                                                                                                                                    %b%║             
echo.                                             %b%║                  %p%[%w%1%p%]%w% Otimizacoes Gerais            %p%[%w%2%p%]%w% Otimizacao de Mouse e Teclado      %p%[%w%3%p%]%w% Ajustes do Windows                   %b%║                     
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║                  %p%[%w%4%p%]%w% Limpeza do PC                 %p%[%w%5%p%]%w% Otimizacao de Memoria/RAM          %p%[%w%6%p%]%w% Gerenciador de Inicializacao         %b%║
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║                  %p%[%w%7%p%]%w% Ajustes de GPU                %p%[%w%8%p%]%w% Ajustes de CPU                     %p%[%w%9%p%]%w% Ajustes de USB                       %b%║
echo.                                             %b%║                                                                                                                                    %b%║                                          
echo.                                             %b%║                  %p%[%w%10%p%]%w% Ajustes de Energia           %p%[%w%11%p%]%w% Debloat do Sistema                %p%[%w%12%p%]%w% Ajustes de Disco                    %b%║              
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║                  %p%[%w%13%p%]%w% Corrigir Arquivos            %p%[%w%14%p%]%w% Otimizacao de Tela Cheia          %p%[%w%15%p%]%w% Relatorio / Checagens               %b%║
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════║
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║                  %p%[%w%R%p%]%w% Reversoes / Correcoes                                                %p%[%w%P%p%]%w% Backup / Restauracao                 %b%║
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%║                                                    %p%[%w%X%p%]%w% Sair do Utilitario                                                          %b%║
echo.                                             %b%║                                                                                                                                    %b%║        
echo.                                             %b%║                                                                                                                                    %b%║                                         
echo.                                             %b%║                   %w%  Feito e distribuido por ART TWEAKS, 2026 * Versao 0.1 * Atualizado em 19 de Novembro de 2026                %b%║                                   
echo.                                             %b%║                                                                                                                                    %b%║
echo.                                             %b%╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝%w%



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
if /i %input% == 14 goto 14
if /i %input% == 15 goto 15

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

:14
:fse
cls
echo.
echo.
echo.                                                                           %p% ███████╗░██████╗███████╗
echo.                                                                           %p% ██╔════╝██╔════╝██╔════╝
echo.                                                                           %p% █████╗░░╚█████╗░█████╗░░
echo.                                                                           %p% ██╔══╝░░░╚═══██╗██╔══╝░░
echo.                                                                           %p% ██║░░░░░██████╔╝███████╗
echo.                                                                           %p% ╚═╝░░░░░╚═════╝░╚══════╝     
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"%w%
echo.      
echo.                                                    %p%[%w%1%p%]%w% FSE no Windows 10             %p%[%w%2%p%]%w% FSE no Windows 11           
echo.                                                                                           
echo.                                                                                           
echo.                                                    %p%%p%%p%%p%                         %p%[%w%M%p%]%w% Voltar ao menu                             
echo.                                                                                          
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo.                                                   %W% Selecione sua versao do Windows para aplicar a configuracao de FSO adequada
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo. 
set /p input=:
if /i %input% == 1 goto windows10
if /i %input% == 2 goto windows11
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect3

:MisspellRedirect3
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu3


:RedirectMenu3
cls
goto :14
:windows10
echo %w% - Configurando FSE Behavior Mode %b%

Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f

echo %w% - Delete Overlay %b%
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto menu

:windows11

echo %w% - Configurando FSE Behavior Mode %b%
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f

echo %w% - Desativando VRR Optimizations %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;SwapEffectUpgradeEnable=1;" /f

echo %w% - Delete Overlay %b%
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
echo.

pause > nul
cls
goto menu




:12
:storage
cls
echo.
echo.
echo.                                                            %p%░██████╗████████╗░█████╗░██████╗░░█████╗░░██████╗░███████╗   
echo.                                                            %p%██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝░██╔════╝ 
echo.                                                            %p%╚█████╗░░░░██║░░░██║░░██║██████╔╝███████║██║░░██╗░█████╗░░        
echo.                                                            %p%░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══██║██║░░╚██╗██╔══╝░░  
echo.                                                            %p%██████╔╝░░░██║░░░╚█████╔╝██║░░██║██║░░██║╚██████╔╝███████╗     
echo.                                                            %p%╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝      
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                           
echo.                                                                      %p%[%w%1%p%]%w% Trim/Desfragmentar Unidades
echo. 
echo.                                                                      %p%[%w%2%p%]%w% Ativar Cache de Gravacao do Usuario
echo. 
echo.                                                                      %p%[%w%3%p%]%w% Desativar Economia de Energia do SSD
echo.                                                                                           
echo.                                                                                           
echo.                                                                         %p%[%w%M%p%]%w% Voltar ao menu                             
echo.
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo.                                                 %W% Executa Trim e desfragmenta suas unidades e aplica algumas otimizacoes extras de armazenamento
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo. 
set /p input=:
if /i %input% == 1 goto s1
if /i %input% == 2 goto s2
if /i %input% == 3 goto s3
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

:s3
echo %w% - Desativando SSD Power Savings %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SD\IdleState\1" /v "IdleExitEnergyMicroJoules" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SD\IdleState\1" /v "IdleExitLatencyMs" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SD\IdleState\1" /v "IdlePowerMw" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SD\IdleState\1" /v "IdleTimeLengthMs" /t REG_DWORD /d "4294967295" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\1" /v "IdleExitEnergyMicroJoules" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\1" /v "IdleExitLatencyMs" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\1" /v "IdlePowerMw" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\1" /v "IdleTimeLengthMs" /t REG_DWORD /d "4294967295" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\2" /v "IdleExitEnergyMicroJoules" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\2" /v "IdleExitLatencyMs" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\2" /v "IdlePowerMw" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\2" /v "IdleTimeLengthMs" /t REG_DWORD /d "4294967295" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\3" /v "IdleExitEnergyMicroJoules" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\3" /v "IdleExitLatencyMs" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\3" /v "IdlePowerMw" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\Storage\SSD\IdleState\3" /v "IdleTimeLengthMs" /t REG_DWORD /d "4294967295" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:s1
cls
stART dfrgui.exe
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
Reg.exe add "%%k\Device Parameters\Disk" /v CacheIsPowerProtected /t REG_DWORD /d 1 /f
)

echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                             %p%   ░██╗░░░░░░░██╗██╗███╗░░██╗██████╗░░█████╗░░██╗░░░░░░░██╗░██████╗      
echo.                                                             %p%   ░██║░░██╗░░██║██║████╗░██║██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝      
echo.                                                             %p%   ░╚██╗████╗██╔╝██║██╔██╗██║██║░░██║██║░░██║░╚██╗████╗██╔╝╚█████╗░     
echo.                                                             %p%   ░░████╔═████║░██║██║╚████║██║░░██║██║░░██║░░████╔═████║░░╚═══██╗      
echo.                                                             %p%   ░░╚██╔╝░╚██╔╝░██║██║░╚███║██████╔╝╚█████╔╝░░╚██╔╝░╚██╔╝░██████╔╝      
echo.                                                             %p%   ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░░╚═════╝░      
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                                                      
echo.                                                             %p%%p%%p%%p%%p%[%w%A%p%]%w% Aplicar todas as otimizacoes da categoria Windows
echo.                                                          
echo.                                                             %p%[%w%1%p%]%w% Ajustes do Windows 11      %p%[%w%2%p%]%w% Desativar Animacoes Inuteis                      
echo.                                                                                                                      
echo.                                                             %p%[%w%3%p%]%w% Desativar Notificacoes      %p%[%w%4%p%]%w% Otimizar Pesquisa do Windows      
echo.                                                                                                                                
echo.                                                             %p%[%w%5%p%]%w% Desativar Bluetooth         %p%[%w%6%p%]%w% Desativar Transparencia 
echo.                                                                                                                                                                                                                 
echo.                                                             %p%[%w%7%p%]%w% Desativar Rel. de Erros      %p%[%w%8%p%]%w% Desativar Sincronizacao                    
echo.                                                                                                                                
echo.                                                             %p%[%w%9%p%]%w% Desativar Diagnosticos      %p%[%w%10%p%]%w% Desativar Apps em 2o Plano     
echo.
echo.                                                             %p%[%w%11%p%]%w% Desativar Experimentos     %p%[%w%12%p%]%w% Ativar Modo Jogo       
echo. 
echo.                                                             %p%[%w%13%p%]%w% Desativar Manutencao       %p%[%w%14%p%]%w% Desativar Rastreamento                                           
echo. 
echo.                                                             %p%[%w%15%p%]%w% Desativar Pop-ups e mais   %p%[%w%16%p%]%w% Desativar Feed de Atividades
echo. 
echo.                                                             %p%[%w%17%p%]%w% Desativar SmARTScreen      %p%[%w%18%p%]%w% Impedir Reinstalar Apps Pre-inst.   
echo.
echo.                                                             %p%[%w%19%p%]%w% Desativar Exp. CompART. %p%[%w%20%p%]%w% Registrar So Falhas Importantes      
echo.
echo.                                                             
echo.                                                             %p%%p%%p%%p%                     %p%[%w%R%p%]%w% Reverter Categoria
echo.
echo.                                                             %p%%p%%p%%p%                     %p%[%w%M%p%]%w% Voltar ao menu                                        
echo.     
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
echo.                                                               %W% Otimiza varias configuracoes do Windows para o melhor desempenho
echo.                                                         %W% Desativa varios itens incomodos como notificacoes, pop-ups e mais
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
echo.
set /p input=:
if /i %input% == A goto WA
if /i %input% == 1 goto win11menu
if /i %input% == 2 goto w3
if /i %input% == 3 goto w2
if /i %input% == 4 goto w4
if /i %input% == 5 goto w5
if /i %input% == 6 goto w1
if /i %input% == 7 goto w7
if /i %input% == 8 goto w8
if /i %input% == 9 goto w9
if /i %input% == 10 goto w10
if /i %input% == 11 goto w11
if /i %input% == 12 goto w12
if /i %input% == 13 goto w13
if /i %input% == 14 goto w14
if /i %input% == 15 goto w15
if /i %input% == 16 goto w16
if /i %input% == 17 goto w17
if /i %input% == 18 goto w18
if /i %input% == 19 goto w19
if /i %input% == 20 goto w20
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
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DoNotUseWebResults" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "StART" /t REG_DWORD /d "0" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
pause > nul
cls
goto windows

:WA
cls
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('This will apply all tweaks in the windows page', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo. 
echo. 
echo.                                              %b%╔═════════════════════════════════════════════════════════════════════════╗
echo.                                              %b%║  %w%  Pressione "S" para continuar, "N" para voltar                        %b%║
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
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DoNotUseWebResults" /t REG_DWORD /d "1" /f

echo %w% - Registrando apenas eventos de falha importantes %b%
Auditpol /set /subcategory:"Process Termination" /success:Disable /failure:Enable
Auditpol /set /subcategory:"RPC Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Filtering Platform Connection" /success:Disable /failure:Enable
Auditpol /set /subcategory:"DPAPI Activity" /success:Disable /failure:Disable
Auditpol /set /subcategory:"IPsec Driver" /success:	 /failure:Enable
Auditpol /set /subcategory:"Other System Events" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security State Change" /success:Disable /failure:Enable
Auditpol /set /subcategory:"Security System Extension" /success:Disable /failure:Enable
Auditpol /set /subcategory:"System Integrity" /success:Disable /failure:Enable
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "StART" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "StART" /t REG_DWORD /d "0" /f

echo %w% - Desativando Experimentos do Windows Insider%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Feed de Atividades%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f

echo %w% - Desativando Manutencao Automatica%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f 


echo %w% - Desativando Notificacoes%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f


echo %w% - Desativando Bluetooth%b%
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BTAGService" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bthserv" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BthAvctpSvc" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BluetoothUserService" /v "StART" /t REG_DWORD /d "4" /f

echo %w% - Desativando Servicos de Diagnostico%b%
sc config DiagTrack stART= Disabled 
sc config dmwappushservice stART= Disabled
sc config DPS stART= Disabled 
sc config diagnosticshub.standardcollector.service stART= Disabled 

echo %w% - Desativando Relatorio de Erros do Windows%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 

echo %w%- Desativando Experiencias CompARTilhadas %b%
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
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StARTLayout" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f 

echo %w%- Desativando SmARTScreen do Windows %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmARTScreen" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmARTScreenEnabled" /t REG_SZ /d "Off" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f 

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
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v "StART" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "StART" /t REG_DWORD /d "4" /f 

echo %w%- Desativando Transparencia %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f

echo %w% - Ativando Modo Jogo%b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 

echo %w% - Desativando Rastreamento e alguns diagnosticos%b%
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "1" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f
schtasks /change /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable

timeout 2 > nul
cls
echo.
echo.
echo.                                                       %p%░██████╗░░█████╗░███╗░░░███╗███████╗  ███╗░░░███╗░█████╗░██████╗░███████╗
echo.                                                       %p%██╔════╝░██╔══██╗████╗░████║██╔════╝  ████╗░████║██╔══██╗██╔══██╗██╔════╝
echo.                                                       %p%██║░░██╗░███████║██╔████╔██║█████╗░░  ██╔████╔██║██║░░██║██║░░██║█████╗░░
echo.                                                       %p%██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░  ██║╚██╔╝██║██║░░██║██║░░██║██╔══╝░░
echo.                                                       %p%╚██████╔╝██║░░██║██║░╚═╝░██║███████╗  ██║░╚═╝░██║╚█████╔╝██████╔╝███████╗
echo.                                                       %p%░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚══════╝
echo.                                              %b%"════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                               %p%[%w%1%p%]%w% Ativar Modo Jogo       %p%[%w%2%p%]%w% Desativar Modo Jogo
echo.
echo. 
echo.                                                                                      %p%[%w%S%p%]%w% Pular  
echo. 
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                          Recomendamos ativar o Modo Jogo no Windows 11, mas desativa-lo no Windows 10                                                 
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
         
set /p input=:
if /i %input% == 1 goto gmodeOn
if /i %input% == 2 goto gmodeOff
if /i %input% == S goto skipg
if /i %input% == X cls & goto 3

) ELSE (
echo %w%- Entrada invalida %b% & goto MisspellRedirect6

:MisspellRedirect6
cls
echo %w%- Erro de digitacao detectado  %b%
timeout 2
goto RedirectMenu6

:RedirectMenu6
goto 3

:gmodeON
echo %w% - Ativando Modo Jogo %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :skipg

:gmodeOFF
echo %w% - Desativando Modo Jogo %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :skipg

:skipg

cls 

%windir%\system32\SystemPropertiesPerformance.exe

chcp 65001 >nul 
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto menu









:w19
echo %w%- Desativando Experiencias CompARTilhadas %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :windows

:w17
echo %w%- Desativando SmARTScreen do Windows %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmARTScreen" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmARTScreenEnabled" /t REG_SZ /d "Off" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v "StART" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "StART" /t REG_DWORD /d "4" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows


:w12
:gamemode
cls
echo.
echo.
echo.                                                      %p%░██████╗░░█████╗░███╗░░░███╗███████╗  ███╗░░░███╗░█████╗░██████╗░███████╗
echo.                                                      %p%██╔════╝░██╔══██╗████╗░████║██╔════╝  ████╗░████║██╔══██╗██╔══██╗██╔════╝
echo.                                                      %p%██║░░██╗░███████║██╔████╔██║█████╗░░  ██╔████╔██║██║░░██║██║░░██║█████╗░░
echo.                                                      %p%██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░  ██║╚██╔╝██║██║░░██║██║░░██║██╔══╝░░
echo.                                                      %p%╚██████╔╝██║░░██║██║░╚═╝░██║███████╗  ██║░╚═╝░██║╚█████╔╝██████╔╝███████╗
echo.                                                      %p%░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚══════╝
echo.                                              %b%"════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                 %p%[%w%1%p%]%w% Ativar Modo Jogo       %p%[%w%2%p%]%w% Desativar Modo Jogo
echo.
echo.                           
echo.                                                                                %p%[%w%M%p%]%w% Voltar ao menu  
echo.                                                                             
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                          Recomendamos ativar o Modo Jogo no Windows 11, mas desativa-lo no Windows 10                                                 
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
         
set /p input=:
if /i %input% == 1 goto gmodeON_w12
if /i %input% == 2 goto gmodeOFF_w12
if /i %input% == X cls & goto 3

) ELSE (
echo %w%- Entrada invalida %b% & goto MisspellRedirect7

:MisspellRedirect7
cls
echo %w%- Erro de digitacao detectado  %b%
timeout 2
goto RedirectMenu7

:RedirectMenu7
goto 3

:gmodeON_w12
echo %w% - Ativando Modo Jogo %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :3

:gmodeOFF_w12
echo %w% - Desativando Modo Jogo %b%
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :3

:w14
cls
echo %w% - Desativando Rastreamento e alguns diagnosticos%b%
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "1" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f
schtasks /change /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" /Disable
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:13
cls
echo.
echo.

echo.                                                                %p%███████╗██╗██╗░░██╗    ██████╗░██╗░██████╗░█████╗░
echo.                                                                %p%██╔════╝██║╚██╗██╔╝    ██╔══██╗██║██╔════╝██╔══██╗
echo.                                                                %p%█████╗░░██║░╚███╔╝░    ██║░░██║██║╚█████╗░██║░░╚═╝
echo.                                                                %p%██╔══╝░░██║░██╔██╗░    ██║░░██║██║░╚═══██╗██║░░██╗
echo.                                                                %p%██║░░░░░██║██╔╝╚██╗    ██████╔╝██║██████╔╝╚█████╔╝
echo.                                                                %p%╚═╝░░░░░╚═╝╚═╝░░╚═╝    ╚═════╝░╚═╝╚═════╝░░╚════╝░
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                      %p%[%w%1%p%]%w% Corrigir Arquivos Corrompidos
echo.
echo.
echo.                                                                          %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                           %b%"══════════════════════════════════════════════════════════════════════════════════"
echo.                                                 %w% Encontra arquivos criticos do sistema necessarios para funcionar e coleta informacoes
echo.                                                 %w% e entao atualiza ou repara os arquivos corrompidos ou desatualizados. 
echo.                                           %b%"══════════════════════════════════════════════════════════════════════════════════"

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
DISM /Online /Cleanup-Image /StARTComponentCleanup
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:11war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Note: If you want to revert anything, you can do it in our revert category on the main page of the utility', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
chcp 65001 >nul 2>&1

:11
:Debloat
cls
echo.
echo.
echo.                                                                %p%   ██████╗░███████╗██████╗░██╗░░░░░░█████╗░░█████╗░████████╗     
echo.                                                                %p%   ██╔══██╗██╔════╝██╔══██╗██║░░░░░██╔══██╗██╔══██╗╚══██╔══╝      
echo.                                                                %p%   ██║░░██║█████╗░░██████╦╝██║░░░░░██║░░██║███████║░░░██║░░░    
echo.                                                                %p%   ██║░░██║██╔══╝░░██╔══██╗██║░░░░░██║░░██║██╔══██║░░░██║░░░     
echo.                                                                %p%   ██████╔╝███████╗██████╦╝███████╗╚█████╔╝██║░░██║░░░██║░░░  
echo.                                                                %p%   ╚═════╝░╚══════╝╚═════╝░╚══════╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░      
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                                    
echo.                                                                                       %p%[%w%A%p%]%w% Aplicar tudo
echo.                                                                                                                      
echo.                                                            %p%[%w%1%p%]%w% Desativar GameDVR         %p%[%w%2%p%]%w% Desativar Telemetria                 
echo.                                                                                                                      
echo.                                                            %p%[%w%3%p%]%w% Desativar XBOX            %p%[%w%4%p%]%w% Desinstalar Apps Inuteis                    
echo.                                                                                                                      
echo.                                                            %p%[%w%5%p%]%w% Desativar Telem. Office    %p%[%w%6%p%]%w% Desativar Impressao e Mapas
echo. 
echo.                                                            %p%[%w%7%p%]%w% Desinstalar Cortana       %p%[%w%8%p%]%w% Desinstalar Microsoft Edge   
echo.
echo.                                                            %p%[%w%9%p%]%w% Desativar Autologgers     %p%[%w%10%p%]%w% Desativar Programa de Experiencia                      
echo.                                                                                                                          
echo.                                                                                                                                
echo.                                                                                      %p%[%w%M%p%]%w% Voltar ao menu 
echo. 
echo.                                                                                      %p%[%w%R%p%]%w% Reverter Categoria                                        
echo.
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
echo.                                                                            %w% Nao desative o que voce realmente usa!                             
echo. 
echo.                                                                    %w% Desinstala e desativa recursos inuteis do Windows
echo.                                                      %w% Remove bloatware do sistema que roda em segundo plano consumindo recursos        
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
echo.

set /p input=:
if /i %input% == A goto AD
if /i %input% == 1 goto d1
if /i %input% == 2 goto d2
if /i %input% == 3 goto d3
if /i %input% == 4 goto d4
if /i %input% == 5 goto d5
if /i %input% == 6 goto d6
if /i %input% == 7 goto d7
if /i %input% == 8 goto d8
if /i %input% == 9 goto d9
if /i %input% == 10 goto d10
if /i %input% == M cls & goto menu
if /i %input% == R cls & goto revert
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
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('This will apply all tweaks in this page, do you want to continue?', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
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

:d2
echo %w% - Desativando Telemetria pelo Agendador de Tarefas %b%
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable 
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable 
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable 
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable 
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" 
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" 
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable 
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" 
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable 
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy" 
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /Disable 
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" 
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /Disable 
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" 
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable 
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" 
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" 
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable 
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks" 
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /Disable 
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" 
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable 
schtasks /end /tn "\Microsoft\Windows\AppID\SmARTScreenSpecific" 
schtasks /change /tn "\Microsoft\Windows\AppID\SmARTScreenSpecific" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" 
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" 
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" 
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable 
schtasks /end /tn "\Microsoftd\Office\OfficeTelemetryAgentFallBack" 
schtasks /change /TN "\Microsoftd\Office\OfficeTelemetryAgentFallBack" /Disable 
schtasks /end /tn "\Microsoft\Office\Office 15 Subscription HeARTbeat" 
schtasks /change /TN "\Microsoft\Office\Office 15 Subscription HeARTbeat" /Disable 
schtasks /end /tn "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" 
schtasks /change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable 
schtasks /end /tn "\Microsoft\Windows\Time Synchronization\SynchronizeTime" 
schtasks /change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable 
schtasks /end /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update" 
schtasks /change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable 
schtasks /end /tn "\Microsoft\Windows\Device Information\Device" 
schtasks /change /TN "\Microsoft\Windows\Device Information\Device" /Disable 
timeout /t 1 /nobreak > NUL
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls

goto :debloat
:d9
echo %w% - Desativando Autologgers%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPARTySuggestions" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :debloat

:DA
::1

echo %w% - Desativando Telemetria pelo Agendador de Tarefas %b%
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" 
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" 
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable 
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" 
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable 
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" 
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable 
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy" 
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /Disable 
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" 
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /Disable 
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent" 
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /Disable 
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" 
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable 
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" 
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable 
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" 
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable 
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks" 
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /Disable 
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" 
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable 
schtasks /end /tn "\Microsoft\Windows\AppID\SmARTScreenSpecific" 
schtasks /change /tn "\Microsoft\Windows\AppID\SmARTScreenSpecific" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" 
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" 
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable 
schtasks /end /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" 
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable 
schtasks /end /tn "\Microsoftd\Office\OfficeTelemetryAgentFallBack" 
schtasks /change /TN "\Microsoftd\Office\OfficeTelemetryAgentFallBack" /Disable 
schtasks /end /tn "\Microsoft\Office\Office 15 Subscription HeARTbeat" 
schtasks /change /TN "\Microsoft\Office\Office 15 Subscription HeARTbeat" /Disable 
schtasks /end /tn "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" 
schtasks /change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable 
schtasks /end /tn "\Microsoft\Windows\Time Synchronization\SynchronizeTime" 
schtasks /change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable 
schtasks /end /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update" 
schtasks /change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable 
schtasks /end /tn "\Microsoft\Windows\Device Information\Device" 
schtasks /change /TN "\Microsoft\Windows\Device Information\Device" /Disable 
timeout /t 1 /nobreak > NUL

echo %w% - Desativando Autologgers%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "StART" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f  
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPARTySuggestions" /t REG_DWORD /d "1" /f 
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
schtasks /end /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /Disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" > nul 2>&1

::2
echo %w% - Desativando Servicos de Impressao e Mapas  %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "StART" /t REG_DWORD /d "4" /f

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

::4
chcp 437 > nul
cls 
echo %w% - Excluindo Microsoft Edge %b%
echo %w% - Removendo associacoes de selecao de aplicativo do Edge %b%
:: Remove file association for "MSEdgeHTM" for .webp
:: Delete the registry value "MSEdgeHTM_.webp" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.webp'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xml
:: Delete the registry value "MSEdgeHTM_.xml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for http
:: Delete the registry value "MSEdgeHTM_http" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_http'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for https
:: Delete the registry value "MSEdgeHTM_https" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_https'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .htm
:: Delete the registry value "MSEdgeHTM_.htm" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.htm'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .html
:: Delete the registry value "MSEdgeHTM_.html" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.html'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgePDF" for .pdf
:: Delete the registry value "MSEdgePDF_.pdf" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgePDF_.pdf'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .svg
:: Delete the registry value "MSEdgeHTM_.svg" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.svg'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for mailto
:: Delete the registry value "MSEdgeHTM_mailto" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_mailto'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for read
:: Delete the registry value "MSEdgeHTM_read" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_read'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .mht
:: Delete the registry value "MSEdgeHTM_.mht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.mht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeMHT" for .mht
:: Delete the registry value "MSEdgeMHT_.mht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeMHT_.mht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .mhtml
:: Delete the registry value "MSEdgeHTM_.mhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.mhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeMHT" for .mhtml
:: Delete the registry value "MSEdgeMHT_.mhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeMHT_.mhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for microsoft-edge
:: Delete the registry value "MSEdgeHTM_microsoft-edge" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_microsoft-edge'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for microsoft-edge
:: Delete the registry value "MSEdgeHTM_microsoft-edge" from the key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_microsoft-edge'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xht
:: Delete the registry value "MSEdgeHTM_.xht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xhtml
:: Delete the registry value "MSEdgeHTM_.xhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for ftp
:: Delete the registry value "MSEdgeHTM_ftp" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_ftp'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"


:: --Remove Edge Open With associations--
echo %w% Edge Open With associations %b%
:: Delete Open With association for "{{ progId }}" for .htm
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.htm\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.htm\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .html
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.html\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.html\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .mht
:: Delete the registry value "MSEdgeMHT" from the key "HKLM\Software\Classes\.mht\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.mht\OpenWithProgids'; $valueName = 'MSEdgeMHT'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .mhtml
:: Delete the registry value "MSEdgeMHT" from the key "HKLM\Software\Classes\.mhtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.mhtml\OpenWithProgids'; $valueName = 'MSEdgeMHT'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .pdf
:: Delete the registry value "MSEdgePDF" from the key "HKLM\Software\Classes\.pdf\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.pdf\OpenWithProgids'; $valueName = 'MSEdgePDF'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .shtml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.shtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.shtml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .svg
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.svg\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.svg\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .webp
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.webp\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.webp\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xht
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xht\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xht\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xhtml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xhtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xhtml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"


:: Remove Edge user associations
echo %w% - Edge user associations %b%
:: Remove user-chosen URL association for "MSEdgeHTM" for http URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for https URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for microsoft-edge URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for microsoft-edge-holographic URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for ms-xbl-3d8b930f URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ms-xbl-3d8b930f\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ms-xbl-3d8b930f\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for read URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\read\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\read\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen file association for "MSEdgeHTM" for .htm files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .html files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgePDF" for .pdf files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgePDF'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .svg files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .mht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeMHT" for .mht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeMHT'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .mhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeMHT" for .mhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeMHT'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen URL association for "MSEdgeHTM" for ftp URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ftp\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ftp\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"


:: Remove Edge through official installer
echo %w% -  Removendo o Edge pelo instalador oficial %b%
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '1'; reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev' /v 'AllowUninstall' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Create a placeholder file at "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe".
PowerShell -ExecutionPolicy Unrestricted -Command "$filePath = '%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe'; $expandedFilePath = [System.Environment]::ExpandEnvironmentVariables($filePath); $placeholderText = 'privacy.sexy placeholder'; Write-Output "^""Creating placeholder file at `"^""$expandedFilePath`"^""."^""; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedFilePath); if (Test-Path $expandedFilePath -PathType Leaf) { Write-Host "^""Skipping file creation as `"^""$expandedFilePath`"^"" already exists."^""; Exit 0; }; if (Test-Path $parentDirectory -PathType Container) { Write-Host "^""Skipping parent directory creation as `"^""$parentDirectory`"^"" already exists."^""; } else { try { New-Item -ItemType Directory -Path "^""$parentDirectory"^"" -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created directory for placeholder file at `"^""$parentDirectory`"^""."^""; }  catch { Write-Error "^""Failed to create directory for placeholder at `"^""$parentDirectory`"^"": $_"^""; Exit 1; }; }; try { New-Item -ItemType File -Path $expandedFilePath -Value "^""$placeholderText"^"" -Force -ErrorAction Stop | Out-Null; Write-Host "^""Successfully created a placeholder file at `"^""$expandedFilePath`"^""."^""; } catch { Write-Error "^""Failed to create placeholder file at `"^""$expandedFilePath`"^"": $_"^""; Exit 1; }"
:: Uninstall running the official uninstaller
PowerShell -ExecutionPolicy Unrestricted -Command "$installers = (Get-ChildItem "^""$($env:ProgramFiles)*\Microsoft\Edge\Application\*\Installer\setup.exe"^""); if (!$installers) { Write-Host 'Installer not found. Microsoft Edge may already be uninstalled.'; } else { foreach ($installer in $installers) { $uninstallerPath = $installer.FullName; if (-Not (Test-Path "^""$uninstallerPath"^"")) { Write-Host "^""Installer not found at `"^""$uninstallerPath`"^"". Microsoft Edge may already be uninstalled."^""; continue; }; $installerArguments = @("^""--uninstall"^"", "^""--system-level"^"", "^""--verbose-logging"^"", "^""--force-uninstall"^""); Write-Output "^""Uninstalling through uninstaller: $uninstallerPath"^""; $process = StART-Process -FilePath "^""$uninstallerPath"^"" -ArgumentList $installerArguments -Wait -PassThru; if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 19) { Write-Host "^""Successfully uninstalled Edge."^""; } else { Write-Error "^""Failed to uninstall, uninstaller failed with exit code $($process.ExitCode)."^""; }; }; }"


:: Remove Edge shortcuts
echo %w% - Removendo atalhos do Edge %b%
PowerShell -ExecutionPolicy Unrestricted -Command "$shortcuts = @(; @{ Revert = $True;  Path = "^""$env:ProgramData\Microsoft\Windows\StART Menu\Programs\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:Public\Desktop\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:SystemRoot\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $False; Path = "^""$env:UserProfile\Desktop\Microsoft Edge.lnk"^""; }; ); foreach ($shortcut in $shortcuts) { if (-Not (Test-Path $shortcut.Path)) { Write-Host "^""Skipping, shortcut does not exist: `"^""$($shortcut.Path)`"^""."^""; continue; }; try { Remove-Item -Path $shortcut.Path -Force -ErrorAction Stop; Write-Output "^""Successfully removed shortcut: `"^""$($shortcut.Path)`"^""."^""; } catch { Write-Error "^""Encountered an issue while attempting to remove shortcut at: `"^""$($shortcut.Path)`"^""."^""; }; }"
chcp 65001 > nul
cls

::5
echo %w% - Desativando GameDVR%b%
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "0" /f

::6
echo %w% - Desativando Servicos Xbox%b%
sc config xbgm stART= Disabled >nul 2>&1
sc config XblAuthManager stART= Disabled
sc config XblGameSave stART= Disabled
sc config XboxGipSvc stART= Disabled
sc config XboxNetApiSvc stART= Disabled
cls

::7
cls
chcp 437 > nul
echo.
echo.
echo [                             0%                            ]
echo.
echo %w%- Desinstalando BingWeather (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==                           3.5%                          ]
echo.
echo %w%- Desinstalando GetHelp (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage}
CLS

echo.
echo.
echo [====                         7.0%                          ]
echo.
echo %w%- Desinstalando GetstARTed (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.GetstARTed* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=====                        10.5%                         ]
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage}
CLS

echo.
echo.
echo [======                       14.5%                         ]
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage}
CLS

echo.
echo.
echo [========                     18.0%                         ]
echo.
echo %w%- Desinstalando MicrosoftSolitaireCollection (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage}
CLS 

echo.
echo.
echo [==========                   21.5%                         ]
echo.
echo %w%- Desinstalando MicrosoftStickyNotes (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage}
CLS

echo.
echo.
echo [============                 24.5%                         ]
echo.
echo %w%- Desinstalando MixedReality.Portal (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==============               27.0%                         ]
echo.
echo %w%- Desinstalando OneConnect (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===============              28.5%                         ]
echo.
echo %w%- Desinstalando People (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.People* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==================           30.5%                         ]
echo.
echo %w%- Desinstalando Print3D (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===================           32.0%                        ]
echo.
echo %w%- Desinstalando SkypeApp (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage}
CLS

echo.
echo.
echo [====================         34.0%                         ]
echo.
echo %w%- Desinstalando WindowsAlarms (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=====================        35.2%                         ]
echo.
echo %w%- Desinstalando WindowsCamera (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage}
CLS

echo.
echo.
echo [======================       37.5%                         ]
echo.
echo %w%- Desinstalando windowscommunicationsapps (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=======================      38.8%                         ]
echo.
echo %w%- Desinstalando WindowsMaps (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage}
CLS

echo.
echo.
echo [========================     40.0%                         ]
echo.
echo %w%- Desinstalando WindowsFeedbackHub (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=========================    42.2%                         ]
echo.
echo %w%- Desinstalando WindowsSoundRecorder (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=========================    44.5%                         ]
echo.
echo %w%- Desinstalando YourPhone (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===========================  47.0%                         ]
echo.
echo %w%- Desinstalando ZuneMusic (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===========================  49.0%                         ]
echo.
echo %w%- Desinstalando HEIFImageExtension (removendo apps pre-instalados) %b%

PowerShell -command "& {Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================51.0%                         ]
echo.
echo %w%- Desinstalando WebMediaExtensions (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================53.5%==                       ]
echo.
echo %w%- Desinstalando WebpImageExtension (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================56.7%====                     ]
echo.
echo %w%- Desinstalando 3dBuilder (removendo apps pre-instalados) %b%
PowerShell -command "& {Get-AppxPackage *Microsoft.3dBuilder* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================59.5%======                   ]
echo.
echo %w%- Desinstalando bing (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================62.0%========                 ]
echo.
echo %w%- Desinstalando bingfinance (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================65.5%==========               ]
echo.
echo %w%- Desinstalando bingsports (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================69.0%============             ]
echo.
echo %w%- Desinstalando CommsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================75.0 %=============           ]
echo.
echo %w%- Desinstalando Drawboard PDF (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================79.5%%===============         ]
echo.
echo %w%- Desinstalando Sway (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================85.0%%===================     ]
echo.
echo %w%- Desinstalando WindowsAlarms (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================90.5%%=====================   ]
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================93.5%%=====================   ]
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================100.0%%=======================]
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
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f 


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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu



:d6 
cls
echo %w% - Desativando Servicos de Impressao e Mapas  %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "StART" /t REG_DWORD /d "4" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:d8
cls 
chcp 437 > nul

echo %w% - Excluindo Microsoft Edge %b%
echo %w% - Removendo associacoes de selecao de aplicativo do Edge %b%
:: Remove file association for "MSEdgeHTM" for .webp
:: Delete the registry value "MSEdgeHTM_.webp" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.webp'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xml
:: Delete the registry value "MSEdgeHTM_.xml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for http
:: Delete the registry value "MSEdgeHTM_http" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_http'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for https
:: Delete the registry value "MSEdgeHTM_https" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_https'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .htm
:: Delete the registry value "MSEdgeHTM_.htm" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.htm'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .html
:: Delete the registry value "MSEdgeHTM_.html" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.html'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgePDF" for .pdf
:: Delete the registry value "MSEdgePDF_.pdf" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgePDF_.pdf'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .svg
:: Delete the registry value "MSEdgeHTM_.svg" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.svg'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for mailto
:: Delete the registry value "MSEdgeHTM_mailto" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_mailto'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for read
:: Delete the registry value "MSEdgeHTM_read" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_read'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .mht
:: Delete the registry value "MSEdgeHTM_.mht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.mht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeMHT" for .mht
:: Delete the registry value "MSEdgeMHT_.mht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeMHT_.mht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .mhtml
:: Delete the registry value "MSEdgeHTM_.mhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.mhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeMHT" for .mhtml
:: Delete the registry value "MSEdgeMHT_.mhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeMHT_.mhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for microsoft-edge
:: Delete the registry value "MSEdgeHTM_microsoft-edge" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_microsoft-edge'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for microsoft-edge
:: Delete the registry value "MSEdgeHTM_microsoft-edge" from the key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_microsoft-edge'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xht
:: Delete the registry value "MSEdgeHTM_.xht" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xht'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for .xhtml
:: Delete the registry value "MSEdgeHTM_.xhtml" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_.xhtml'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove file association for "MSEdgeHTM" for ftp
:: Delete the registry value "MSEdgeHTM_ftp" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $valueName = 'MSEdgeHTM_ftp'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"


:: --Remove Edge Open With associations--
echo %w% Edge Open With associations %b%
:: Delete Open With association for "{{ progId }}" for .htm
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.htm\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.htm\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .html
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.html\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.html\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .mht
:: Delete the registry value "MSEdgeMHT" from the key "HKLM\Software\Classes\.mht\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.mht\OpenWithProgids'; $valueName = 'MSEdgeMHT'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .mhtml
:: Delete the registry value "MSEdgeMHT" from the key "HKLM\Software\Classes\.mhtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.mhtml\OpenWithProgids'; $valueName = 'MSEdgeMHT'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .pdf
:: Delete the registry value "MSEdgePDF" from the key "HKLM\Software\Classes\.pdf\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.pdf\OpenWithProgids'; $valueName = 'MSEdgePDF'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .shtml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.shtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.shtml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .svg
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.svg\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.svg\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .webp
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.webp\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.webp\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xht
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xht\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xht\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xhtml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xhtml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xhtml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Delete Open With association for "{{ progId }}" for .xml
:: Delete the registry value "MSEdgeHTM" from the key "HKLM\Software\Classes\.xml\OpenWithProgids" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKLM\Software\Classes\.xml\OpenWithProgids'; $valueName = 'MSEdgeHTM'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"


:: Remove Edge user associations
echo %w% - Edge user associations %b%
:: Remove user-chosen URL association for "MSEdgeHTM" for http URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for https URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for microsoft-edge URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for microsoft-edge-holographic URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for ms-xbl-3d8b930f URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ms-xbl-3d8b930f\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ms-xbl-3d8b930f\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen URL association for "MSEdgeHTM" for read URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\read\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\read\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen file association for "MSEdgeHTM" for .htm files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .html files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgePDF" for .pdf files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgePDF'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .svg files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .mht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeMHT" for .mht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeMHT'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .mhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeMHT" for .mhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeMHT'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen URL association for "MSEdgeHTM" for ftp URL protocol
:: Delete the registry value "ProgId" from the key "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ftp\UserChoice" 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ftp\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xht files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Remove user-chosen file association for "MSEdgeHTM" for .xhtml files
:: Delete the registry value "ProgId" from the key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice" (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RemovedRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RemovedRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RemoveAccessRule($denyRule)) { $AclChanges.RemovedRules += $denyRule; } else { Write-Warning 'Failed to remove the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RemoveAccessRule($rule)) { Write-Warning 'Failed to remove the rule.'; }; }; foreach ($rule in $AclChanges.RemovedRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $keyName = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $valueName = 'ProgId'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; $expectedData = 'MSEdgeHTM'; $currentData = Get-ItemProperty -LiteralPath $path -Name $valueName | Select-Object -ExpandProperty $valueName; if ($currentData -ne $expectedData) { Write-Host "^""Skipping, no action needed, current data '$currentData' is not same as '$expectedData'."^""; Exit 0; }; Grant-Permissions; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"


:: Remove Edge through official installer
echo %w% -  Removendo o Edge pelo instalador oficial %b%
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '1'; reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev' /v 'AllowUninstall' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Create a placeholder file at "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe".
PowerShell -ExecutionPolicy Unrestricted -Command "$filePath = '%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe'; $expandedFilePath = [System.Environment]::ExpandEnvironmentVariables($filePath); $placeholderText = 'privacy.sexy placeholder'; Write-Output "^""Creating placeholder file at `"^""$expandedFilePath`"^""."^""; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedFilePath); if (Test-Path $expandedFilePath -PathType Leaf) { Write-Host "^""Skipping file creation as `"^""$expandedFilePath`"^"" already exists."^""; Exit 0; }; if (Test-Path $parentDirectory -PathType Container) { Write-Host "^""Skipping parent directory creation as `"^""$parentDirectory`"^"" already exists."^""; } else { try { New-Item -ItemType Directory -Path "^""$parentDirectory"^"" -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created directory for placeholder file at `"^""$parentDirectory`"^""."^""; }  catch { Write-Error "^""Failed to create directory for placeholder at `"^""$parentDirectory`"^"": $_"^""; Exit 1; }; }; try { New-Item -ItemType File -Path $expandedFilePath -Value "^""$placeholderText"^"" -Force -ErrorAction Stop | Out-Null; Write-Host "^""Successfully created a placeholder file at `"^""$expandedFilePath`"^""."^""; } catch { Write-Error "^""Failed to create placeholder file at `"^""$expandedFilePath`"^"": $_"^""; Exit 1; }"
:: Uninstall running the official uninstaller
PowerShell -ExecutionPolicy Unrestricted -Command "$installers = (Get-ChildItem "^""$($env:ProgramFiles)*\Microsoft\Edge\Application\*\Installer\setup.exe"^""); if (!$installers) { Write-Host 'Installer not found. Microsoft Edge may already be uninstalled.'; } else { foreach ($installer in $installers) { $uninstallerPath = $installer.FullName; if (-Not (Test-Path "^""$uninstallerPath"^"")) { Write-Host "^""Installer not found at `"^""$uninstallerPath`"^"". Microsoft Edge may already be uninstalled."^""; continue; }; $installerArguments = @("^""--uninstall"^"", "^""--system-level"^"", "^""--verbose-logging"^"", "^""--force-uninstall"^""); Write-Output "^""Uninstalling through uninstaller: $uninstallerPath"^""; $process = StART-Process -FilePath "^""$uninstallerPath"^"" -ArgumentList $installerArguments -Wait -PassThru; if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 19) { Write-Host "^""Successfully uninstalled Edge."^""; } else { Write-Error "^""Failed to uninstall, uninstaller failed with exit code $($process.ExitCode)."^""; }; }; }"


:: Remove Edge shortcuts
echo %w% - Removendo atalhos do Edge %b%
PowerShell -ExecutionPolicy Unrestricted -Command "$shortcuts = @(; @{ Revert = $True;  Path = "^""$env:ProgramData\Microsoft\Windows\StART Menu\Programs\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:Public\Desktop\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:SystemRoot\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $False; Path = "^""$env:UserProfile\Desktop\Microsoft Edge.lnk"^""; }; ); foreach ($shortcut in $shortcuts) { if (-Not (Test-Path $shortcut.Path)) { Write-Host "^""Skipping, shortcut does not exist: `"^""$($shortcut.Path)`"^""."^""; continue; }; try { Remove-Item -Path $shortcut.Path -Force -ErrorAction Stop; Write-Output "^""Successfully removed shortcut: `"^""$($shortcut.Path)`"^""."^""; } catch { Write-Error "^""Encountered an issue while attempting to remove shortcut at: `"^""$($shortcut.Path)`"^""."^""; }; }"
chcp 65001 > nul

cls
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu



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
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StARTLayout" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w9
echo %w% - Desativando Servicos de Diagnostico%b%
sc stop DiagTrack > nul 2>&1
sc config DiagTrack stART= Disabled > nul 2>&1
sc stop dmwappushservice > nul 2>&1
sc config dmwappushservice stART= Disabled > nul 2>&1
sc stop diagnosticshub.standardcollector.service > nul 2>&1
sc config diagnosticshub.standardcollector.service stART= Disabled > nul 2>&1
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w5
CLS

echo %w% - Desativando Bluetooth%b%
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BTAGService" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bthserv" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BthAvctpSvc" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BluetoothUserService" /v "StART" /t REG_DWORD /d "4" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:d1
cls
echo %w% - Desativando GameDVR%b%
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

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
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:d3
cls
echo %w% - Desativando Servicos Xbox%b%
sc config xbgm stART= Disabled >nul 2>&1
sc config XblAuthManager stART= Disabled
sc config XblGameSave stART= Disabled
sc config XboxGipSvc stART= Disabled
sc config XboxNetApiSvc stART= Disabled
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:d7
cls
echo %w% - Desativando Cortana%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f 


chcp 437 >nul 
timeout /t 1 /nobreak > NUL
Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" 
timeout /t 1 /nobreak > NUL
chcp 65001 >nul 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :debloat

:w3
cls 

%windir%\system32\SystemPropertiesPerformance.exe
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

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
schtasks /end /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" > nul 2>&1
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu

:w13
echo %w% - Desativando Manutencao Automatica%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :windows

:w16
echo %w% - Desativando Feed de Atividades%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo [                             0%                            ]
echo.
echo %w%- Desinstalando BingWeather (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==                           3.5%                          ]
echo.
echo %w%- Desinstalando GetHelp (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage}
CLS

echo.
echo.
echo [====                         7.0%                          ]
echo.
echo %w%- Desinstalando GetstARTed (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.GetstARTed* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=====                        10.5%                         ]
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage}
CLS

echo.
echo.
echo [======                       14.5%                         ]
echo.
echo %w%- Desinstalando Messaging (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage}
CLS

echo.
echo.
echo [========                     18.0%                         ]
echo.
echo %w%- Desinstalando MicrosoftSolitaireCollection (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage}
CLS 

echo.
echo.
echo [==========                   21.5%                         ]
echo.
echo %w%- Desinstalando MicrosoftStickyNotes (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage}
CLS

echo.
echo.
echo [============                 24.5%                         ]
echo.
echo %w%- Desinstalando MixedReality.Portal (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==============               27.0%                         ]
echo.
echo %w%- Desinstalando OneConnect (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===============              28.5%                         ]
echo.
echo %w%- Desinstalando People (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.People* | Remove-AppxPackage}
CLS

echo.
echo.
echo [==================           30.5%                         ]
echo.
echo %w%- Desinstalando Print3D (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===================           32.0%                        ]
echo.
echo %w%- Desinstalando SkypeApp (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage}
CLS

echo.
echo.
echo [====================         34.0%                         ]
echo.
echo %w%- Desinstalando WindowsAlarms (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=====================        35.2%                         ]
echo.
echo %w%- Desinstalando WindowsCamera (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage}
CLS

echo.
echo.
echo [======================       37.5%                         ]
echo.
echo %w%- Desinstalando windowscommunicationsapps (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=======================      38.8%                         ]
echo.
echo %w%- Desinstalando WindowsMaps (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage}
CLS

echo.
echo.
echo [========================     40.0%                         ]
echo.
echo %w%- Desinstalando WindowsFeedbackHub (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=========================    42.2%                         ]
echo.
echo %w%- Desinstalando WindowsSoundRecorder (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=========================    44.5%                         ]
echo.
echo %w%- Desinstalando YourPhone (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===========================  47.0%                         ]
echo.
echo %w%- Desinstalando ZuneMusic (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage}
CLS

echo.
echo.
echo [===========================  49.0%                         ]
echo.
echo %w%- Desinstalando HEIFImageExtension (removendo apps pre-instalados) %b%

Powershell.exe -command "& {Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================51.0%                         ]
echo.
echo %w%- Desinstalando WebMediaExtensions (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================53.5%==                       ]
echo.
echo %w%- Desinstalando WebpImageExtension (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================56.7%====                     ]
echo.
echo %w%- Desinstalando 3dBuilder (removendo apps pre-instalados) %b%
Powershell.exe -command "& {Get-AppxPackage *Microsoft.3dBuilder* | Remove-AppxPackage}
CLS

echo.
echo.
echo [=============================59.5%======                   ]
echo.
echo %w%- Desinstalando bing (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================62.0%========                 ]
echo.
echo %w%- Desinstalando bingfinance (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================65.5%==========               ]
echo.
echo %w%- Desinstalando bingsports (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================69.0%============             ]
echo.
echo %w%- Desinstalando CommsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================75.0 %=============           ]
echo.
echo %w%- Desinstalando Drawboard PDF (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================79.5%%===============         ]
echo.
echo %w%- Desinstalando Sway (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================85.0%%===================     ]
echo.
echo %w%- Desinstalando WindowsAlarms (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================90.5%%=====================   ]
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================93.5%%=====================   ]
echo.
echo %w%- Desinstalando WindowsPhone (removendo apps pre-instalados) %b%
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
CLS

echo.
echo.
echo [=============================100.0%%=======================]
echo %w%- Finalizado! %b%


chcp 65001 > nul
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.
pause > nul
cls
goto :debloat



:e
:revert
cls
echo.
echo.
echo.                                                               %p%       ██████╗░███████╗██╗░░░██╗███████╗██████╗░████████╗
echo.                                                               %p%       ██╔══██╗██╔════╝██║░░░██║██╔════╝██╔══██╗╚══██╔══╝
echo.                                                               %p%       ██████╔╝█████╗░░╚██╗░██╔╝█████╗░░██████╔╝░░░██║░░░
echo.                                                               %p%       ██╔══██╗██╔══╝░░░╚████╔╝░██╔══╝░░██╔══██╗░░░██║░░░
echo.                                                               %p%       ██║░░██║███████╗░░╚██╔╝░░███████╗██║░░██║░░░██║░░░
echo.                                                               %p%       ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                 %w% Use estas opcoes para reverter certas otimizacoes                         
echo.                                                                                                                      
echo.                                                                                                                      
echo.                                                                       %p%[%w%1%p%]%w% Restaurar planos de energia padrao                             
echo.                                                                                                                          
echo.                                                                       %p%[%w%2%p%]%w% Reinstalar apps padrao do Windows                              
echo.                                                                                                                      
echo.                                                                       %p%[%w%3%p%]%w% Ativar Servicos XBOX                                           
echo.                                                                                                                      
echo.                                                                       %p%[%w%4%p%]%w% Ativar GameDVR                                                 
echo.                                                                                                                        
echo.                                                                       %p%[%w%5%p%]%w% Ativar Notificacoes                                            
echo.                                                                                                                       
echo.                                                                       %p%[%w%6%p%]%w% Ativar Bluetooth      
echo.
echo.                                                                       %p%[%w%7%p%]%w% Ativar Inicializacao Rapida, Hibernacao e Sleep Study (nao recomendado, prejudica o PC)                                                       
echo.                                         
echo.                                                                       %p%[%w%8%p%]%w% Ativar Power Throttling                                             
echo.                                                                                                    
echo.                                                                       %p%[%w%9%p%]%w% Ativar Manutencao
echo. 
echo.                                                                       %p%[%w%10%p%]%w% Ativar Servicos de Impressao e Mapas
echo.  
echo.                                                                       %p%[%w%11%p%]%w% Reinstalar Edge
echo.
echo.                                                                       %p%[%w%12%p%]%w% Reverter Ajustes do Windows 11 (Copilot, Recall, Widgets, menu classico)
echo.
echo.                                                                       %p%[%w%13%p%]%w% Ativar SmARTScreen do Windows
echo.
echo.                                                                       %p%[%w%14%p%]%w% Ativar Diagnosticos
echo. 
echo.                                                                       %p%[%w%15%p%]%w% Ativar Relatorio de Erros
echo.
echo.                                                                       %p%[%w%16%p%]%w% Reverter todos os ajustes de energia
echo.
echo.                                                                                                                       
echo.                                                                            %p%[%w%M%p%]%w% Voltar ao menu                                       
echo.                                                                              
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
echo.                                                       %W% Permite reverter varias configuracoes sem precisar de um ponto de restauracao
echo.                                                      %W% O que nao estiver listado aqui pode ser desfeito em Backup / Restauracao, tecla P no menu principal
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"
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
if /i %input% == 11 goto r11
if /i %input% == 12 goto r12
if /i %input% == 13 goto r13
if /i %input% == 14 goto r14
if /i %input% == 15 goto r15
if /i %input% == 16 goto r16
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

:r16
echo %w% - Ativando Log de Energia + Telemetria de Energia%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "1" /f 

echo %w%- Ativando Link State Power Managment %b%
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\System\CurrentControlSet\Services" /s "EnableHIPM"^| FINDSTR /V "EnableHIPM"') DO (
echo %w%- Ativando HIPM %b%
Reg.exe add "%%a" /v "EnableHIPM" /t REG_DWORD /d "1" /f  > nul 
echo %w%- Ativando DIPM %b%
Reg.exe add "%%a" /v "EnabledIPM" /t REG_DWORD /d "1" /f > nul 
echo %w%- Ativando HDD Parking %b%
Reg.exe add "%%a" /v "EnableHDDParking" /t REG_DWORD /d "1" /f > nul 
FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKLM\System\CurrentControlSet\Services\=!
) > nul 
)
	
echo %w% - Ativando GPU Energy Driver%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "StART" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "StART" /t REG_DWORD /d "4" /f 

echo %w% - Ativando CoalescingTimerInterval%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "1" /f  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "1" /f  

echo %w% - Ativando Power Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r14
echo %w% - Ativando Diagnosticos %b%
sc config DPS stART= auto
sc config DiagTrack stART= demand 
sc config dmwappushservice stART= demand 
sc config diagnosticshub.standardcollector.service stART= demand 
schtasks /change /tn "\Microsoft\Windows\Application Experience\StARTupAppTask" /Enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Enable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Diagnostics\Performance" /v "DisablediagnosticTracing" /t REG_DWORD /d "0" /f >nul 2>&1 
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r13
echo %w% - Ativando SmARTScreen do Windows  %b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmARTScreen" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmARTScreenEnabled" /t REG_SZ /d "On" /f 
Reg.exe add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmARTScreen" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmARTScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "1" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e


:r11
chcp 437 > nul
echo %w%- Revertendo o Edge pelo instalador oficial %B%
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev' /v 'AllowUninstall' /f 2>$null"
:: Revert the placeholder file at "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe".
PowerShell -ExecutionPolicy Unrestricted -Command "$filePath = '%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe'; $expandedFilePath = [System.Environment]::ExpandEnvironmentVariables($filePath); $placeholderText = 'privacy.sexy placeholder'; Write-Output "^""Attempting to Revert placeholder file at `"^""$expandedFilePath`"^""."^""; if (-Not (Test-Path $expandedFilePath -PathType Leaf)) { Write-Host "^""Skipping file removal as `"^""$expandedFilePath`"^"" does not exist, no action needed."^""; Exit 0; }; $currentContent = Get-Content $expandedFilePath -ErrorAction SilentlyContinue; if ($currentContent -ne $placeholderText) { Write-Output "^""Skipping removal as the file at `"^""$expandedFilePath`"^"" was not created by privacy.sexy."^""; Exit 0; }; Write-Output "^""File contents match the placeholder content. Proceeding to Revert the file."^""; try { Revert-Item -Path $expandedFilePath -Force -ErrorAction Stop; Write-Host "^""Successfully Revertd the placeholder file at `"^""$expandedFilePath`"^""."^""; } catch { Write-Error "^""Failed to delete the placeholder file at `"^""$expandedFilePath`"^"": $_"^""; Exit 1; }"
:: Download and run the official uninstaller
PowerShell -ExecutionPolicy Unrestricted -Command "$edgeExePath = Get-ChildItem -Path "^""$($env:ProgramFiles)*\Microsoft\Edge\Application"^"" -Filter 'msedge.exe' -Recurse; if ($edgeExePath) { Write-Host 'Microsoft Edge is already installed. Skipping reinstallation.'; Exit 0; }; Write-Host 'Downloading Microsoft Edge...'; $edgeInstallerUrl = 'https://c2rsetup.officeapps.live.com/c2r/downloadEdge.aspx?platform=Default&Channel=Stable&language=en'; $downloadPath = "^""$($env:TEMP)\MicrosoftEdgeSetup.exe"^""; Invoke-WebRequest -Uri "^""$edgeInstallerUrl"^"" -OutFile "^""$downloadPath"^""; $installerArguments = @('/install', '/silent'); Write-Host 'Installing Microsoft Edge...'; $process = StART-Process -FilePath "^""$downloadPath"^"" -ArgumentList "^""$installerArguments"^"" -Wait -PassThru; Revert-Item -Path $downloadPath -Force; if ($process.ExitCode -eq 0) { Write-Host 'Successfully reinstalled Microsoft Edge.'; } else { Write-Error "^""Failed to reinstall Microsoft Edge. Installer failed with exit code $($process.ExitCode)."^""; }"


echo %w%- Revertendo atalhos do Edge %B%
PowerShell -ExecutionPolicy Unrestricted -Command "$targetFilePath = "^""%PROGRAMFILES(X86)%\Microsoft\Edge\Application\msedge.exe"^""; $expandedTargetFilePath = [System.Environment]::ExpandEnvironmentVariables($targetFilePath); $shortcuts = @(; @{ Revert = $True;  Path = "^""$env:ProgramData\Microsoft\Windows\StART Menu\Programs\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:Public\Desktop\Microsoft Edge.lnk"^""; }; @{ Revert = $True;  Path = "^""$env:SystemRoot\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"^""; }; @{ Revert = $False; Path = "^""$env:UserProfile\Desktop\Microsoft Edge.lnk"^""; }; ); if (-Not (Test-Path $expandedTargetFilePath)) { Write-Warning "^""Target file `"^""$expandedTargetFilePath`"^"" does not exist."^""; }; $wscriptShell = $null; try { $wscriptShell = New-Object -ComObject WScript.Shell; } catch { throw "^""Failed to create WScript.Shell object: $($_.Exception.Message)"^""; }; foreach ($shortcut in $shortcuts) { if (-Not $shortcut.Revert) { Write-Host "^""Skipping, revert operation is not needed for: `"^""$($shortcut.Path)`"^""."^""; continue; }; if (Test-Path $shortcut.Path) { Write-Host "^""Shortcut already exists, skipping: `"^""$($shortcut.Path)`"^""."^""; continue; }; try { $shellShortcut = $wscriptShell.CreateShortcut($shortcut.Path); $shellShortcut.TargetPath = $expandedTargetFilePath; $shellShortcut.Save(); Write-Output "^""Successfully created shortcut at `"^""$($shortcut.Path)`"^""."^""; } catch { Write-Error "^""An error occurred while creating the shortcut at `"^""$($shortcut.Path)`"^""."^""; }; }"

echo %w%- Revertendo associacoes de selecao de aplicativo do Edge %B%
:: Restore toast association for "MSEdgeHTM" for .webp
:: Restore the registry value "MSEdgeHTM_.webp" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.webp'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .xml
:: Restore the registry value "MSEdgeHTM_.xml" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.xml'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for http
:: Restore the registry value "MSEdgeHTM_http" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_http'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for https
:: Restore the registry value "MSEdgeHTM_https" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_https'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .htm
:: Restore the registry value "MSEdgeHTM_.htm" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.htm'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .html
:: Restore the registry value "MSEdgeHTM_.html" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.html'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgePDF" for .pdf
:: Restore the registry value "MSEdgePDF_.pdf" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgePDF_.pdf'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .svg
:: Restore the registry value "MSEdgeHTM_.svg" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.svg'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for mailto
:: Restore the registry value "MSEdgeHTM_mailto" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_mailto'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for read
:: Restore the registry value "MSEdgeHTM_read" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_read'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .mht
:: Restore the registry value "MSEdgeHTM_.mht" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.mht'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeMHT" for .mht
:: Restore the registry value "MSEdgeMHT_.mht" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeMHT_.mht'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .mhtml
:: Restore the registry value "MSEdgeHTM_.mhtml" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.mhtml'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeMHT" for .mhtml
:: Restore the registry value "MSEdgeMHT_.mhtml" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeMHT_.mhtml'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for microsoft-edge
:: Restore the registry value "MSEdgeHTM_microsoft-edge" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_microsoft-edge'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for microsoft-edge
:: Restore the registry value "MSEdgeHTM_microsoft-edge" in key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_microsoft-edge'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .xht
:: Restore the registry value "MSEdgeHTM_.xht" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.xht'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for .xhtml
:: Restore the registry value "MSEdgeHTM_.xhtml" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_.xhtml'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore toast association for "MSEdgeHTM" for ftp
:: Restore the registry value "MSEdgeHTM_ftp" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '0'; $rawType = 'REG_DWORD'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts'; $value = 'MSEdgeHTM_ftp'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"


echo %w%- Revertendo associacoes "Abrir com" do Edge %B%
:: Restore Open With association for "{{ progId }}" for .htm
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.htm\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.htm\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .html
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.html\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.html\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .mht
:: Restore the registry value "MSEdgeMHT" in key "HKLM\Software\Classes\.mht\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.mht\OpenWithProgids'; $value = 'MSEdgeMHT'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .mhtml
:: Restore the registry value "MSEdgeMHT" in key "HKLM\Software\Classes\.mhtml\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.mhtml\OpenWithProgids'; $value = 'MSEdgeMHT'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .pdf
:: Restore the registry value "MSEdgePDF" in key "HKLM\Software\Classes\.pdf\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.pdf\OpenWithProgids'; $value = 'MSEdgePDF'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .shtml
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.shtml\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.shtml\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .svg
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.svg\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.svg\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .webp
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.webp\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.webp\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .xht
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.xht\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.xht\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .xhtml
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.xhtml\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.xhtml\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore Open With association for "{{ progId }}" for .xml
:: Restore the registry value "MSEdgeHTM" in key "HKLM\Software\Classes\.xml\OpenWithProgids" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $data = '[string]::Empty'; $data = $(Invoke-Expression $data); $rawType = 'REG_SZ'; $rawPath = 'HKLM\Software\Classes\.xml\OpenWithProgids'; $value = 'MSEdgeHTM'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"


echo %w%- Revertendo associacoes de usuario do Edge %B%
:: Restore user-chosen file association for "MSEdgeHTM" for .htm files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .html files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgePDF" for .pdf files
:: Restore user-chosen file association for "MSEdgeHTM" for .svg files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-20H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .mht files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeMHT" for .mht files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeMHT'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .mhtml files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-MostRecent'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeMHT" for .mhtml files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeMHT'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .xml files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-22H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy.sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xml\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .xht files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"
:: Restore user-chosen file association for "MSEdgeHTM" for .xhtml files
:: Restore the registry value "ProgId" in key "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice" to its original value (with additional permissions)
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy.sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $version = [Environment]::OSVersion.Version; $versionNoPatch = [System.Version]::new($version.Major, $version.Minor, $version.Build); if ($versionNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($versionNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$RawRegistryPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $AclChanges = [PSCustomObject]@{ PreviousOwner = $null; RevertdRules = @(); AddedRules = @(); InheritanceDisabled = $false; }; function Test-AccessModified { return $AclChanges.PreviousOwner -Or $AclChanges.RevertdRules.Count -gt 0 -Or $AclChanges.AddedRules.Count  -gt 0 -Or $AclChanges.InheritanceDisabled; }; function Open-RegistryKey { param ([Parameter(Mandatory=$true)][int]$Rights); <# [OutputType([Microsoft.Win32.RegistryKey])] # Not working through cmd.exe #>; $hive = $RawRegistryPath.Split('\')[0]; $pathWithoutHive = $RawRegistryPath.Substring($hive.Length + 1); try { $rootKey = switch ($hive) { 'HKCU' { [Microsoft.Win32.Registry]::CurrentUser }; 'HKLM' { [Microsoft.Win32.Registry]::LocalMachine }; default { Write-Error "^""Internal error: Unknown registry hive ($hive)."^""; Exit 1; }; }; $key = $rootKey.OpenSubKey( $pathWithoutHive, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, $Rights ); } catch { throw "^""Error when opening '$pathWithoutHive' on '$hive' hive: $_"^""; }; if (-Not $key) { throw "^""Unknown error when opening '$pathWithoutHive' on '$hive' hive."^""; }; return $key; }; function Grant-Permissions { Write-Host "^""Granting permissions to '$RawRegistryPath' registry key."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::TakeOwnership); $acl = $subkey.GetAccessControl(); $owner = $acl.GetOwner([System.Security.Principal.NTAccount]); if ($owner -eq $adminAccount) { $subkey.Close(); } else { $AclChanges.PreviousOwner = $owner; $acl.SetOwner($adminAccount); $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host "^""Successfully took ownership from '$($owner.Value)'."^""; }; } catch { Write-Warning "^""Failed to take ownership. Error: $($_.Exception.Message)"^""; }; try { $subkey = Open-RegistryKey -Rights ([System.Security.AccessControl.RegistryRights]::ChangePermissions); $acl = $subkey.GetAccessControl(); $adminFullControlExists = $acl.Access | Where-Object { $_.IdentityReference -eq $adminAccount -and $_.RegistryRights -eq [System.Security.AccessControl.RegistryRights]::FullControl -and $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow }; if (-Not $adminFullControlExists) { Write-Host 'Granting full control to administrators.'; $fullControlRule = New-Object System.Security.AccessControl.RegistryAccessRule( $adminAccount, [System.Security.AccessControl.RegistryRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $acl.AddAccessRule($fullControlRule); $AclChanges.AddedRules += $fullControlRule; }; if ($acl.AreAccessRulesProtected) { $acl.SetAccessRuleProtection($false, $false); $AclChanges.InheritanceDisabled = $true; }; $denyRules = @($acl.Access.Where({ $_.AccessControlType -eq 'Deny' })); foreach ($denyRule in $denyRules) { Write-Host "^""Removing a deny rule for '$($denyRule.IdentityReference)'."^""; if ($acl.RevertAccessRule($denyRule)) { $AclChanges.RevertdRules += $denyRule; } else { Write-Warning 'Failed to Revert the rule.'; }; }; if (-Not (Test-AccessModified)) { Write-Host 'No access modifications were necessary.'; $subkey.Close(); } else { $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully applied new access rules.'; }; } catch { Write-Warning "^""Failed to modify access. Error: $($_.Exception.Message)"^""; }; }; function Revoke-Permissions { Write-Host "^""Restoring permissions: '$RawRegistryPath'."^""; if (-Not (Test-AccessModified)) { Write-Host 'Skipping revoking permissions, they were not granted.'; return; } else { try { $subkey = Open-RegistryKey -Rights ( [System.Security.AccessControl.RegistryRights]::TakeOwnership -bor [System.Security.AccessControl.RegistryRights]::ChangePermissions ); $acl = $subkey.GetAccessControl(); if ($AclChanges.PreviousOwner) { Write-Host 'Restoring owner.'; $acl.SetOwner($AclChanges.PreviousOwner); }; foreach ($rule in $AclChanges.AddedRules) { Write-Host "^""Removing rule for '$($rule.IdentityReference)'."^""; if (-Not $acl.RevertAccessRule($rule)) { Write-Warning 'Failed to Revert the rule.'; }; }; foreach ($rule in $AclChanges.RevertdRules) { $acl.AddAccessRule($rule); Write-Host "^""Adding a rule for '$($rule.IdentityReference)'."^""; }; if ($AclChanges.InheritanceDisabled) { $acl.SetAccessRuleProtection($true, $true); Write-Host 'Restoring inheritance.'; }; $subkey.SetAccessControl($acl); $subkey.Close(); Write-Host 'Successfully restored permissions.'; } catch { Write-Warning "^""Failed to restore permissions. Error: $($_.Exception.Message)"^""; }; }; }; $data = 'MSEdgeHTM'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'; $value = 'ProgId'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy.sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; Grant-Permissions; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy.sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; } finally { Revoke-Permissions }"


::**MICROSOFT EDGE FIX**

::1. Open powershell as admin
::2. Paste the command below in:
::StART-Process -FilePath winget -ArgumentList "install --force  --accept-source-agreements --accept-package-agreements --silent Microsoft.Edge " -NoNewWindow



chcp 65001 > nul

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r10
echo %w% - Ativando Servicos de Impressao e Mapas  %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "StART" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "StART" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "StART" /t REG_DWORD /d "2" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
powercfg /h off
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL

echo %w% - Ativando Sleep Study%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "0" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :e

:r6
echo %w% - Ativando Bluetooth%b%
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BTAGService" /v "StART" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bthserv" /v "StART" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BthAvctpSvc" /v "StART" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BluetoothUserService" /v "StART" /t REG_DWORD /d "2" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r3
echo %w% - Ativando Servicos Xbox%b%
sc config xbgm stART= demand
sc config XblAuthManager stART= demand
sc config XblGameSave stART= demand
sc config XboxGipSvc stART= demand
sc config XboxNetApiSvc stART= demand
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:r2
echo %w% - Baixando novamente apps padrao do Windows%b%
chcp 437 > nul
Powershell -Command "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register “$($_.InstallLocation)\appxmanifest.xml” -DisabledevelopmentMode}"
chcp 65001 > nul

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('! Make sure to restART your pc after using, so the tweaks properly apply !, thanks for using the ART utility. Press "ok" to exit', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
timeout /t 1 /nobreak > nul
chcp 65001 >nul 2>&1
pause > nul
cls
exit





:8war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Do NOT do these if your pc has bad overheating issues', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
timeout /t 1 /nobreak > nul
chcp 65001 >nul 2>&1

:8
:cpu
cls
echo.
echo.
echo.                                                                  %p% ░█████╗░██████╗░██╗░░░██╗          
echo.                                                                  %p% ██╔══██╗██╔══██╗██║░░░██║       
echo.                                                                  %p% ██║░░╚═╝██████╔╝██║░░░██║         
echo.                                                                  %p% ██║░░██╗██╔═══╝░██║░░░██║        
echo.                                                                  %p% ╚█████╔╝██║░░░░░╚██████╔╝      
echo.                                                                  %p% ░╚════╝░╚═╝░░░░░░╚═════╝░        
echo.                                             %b%"════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                                                                                                                                                       
echo.                                                           %p%[%w%1%p%]%w% Aplicar Otimizacoes para CPUs AMD         
echo.
echo.                                                           %p%[%w%2%p%]%w% Aplicar Otimizacoes para CPUs Intel                                            
echo.                                                                                           
echo.                                                                                             
echo.                                                                      %p%[%w%T%p%]%w% Abrir Gerenciador de Tarefas                
echo.                                                                                           
echo.                                                                      %p%[%w%M%p%]%w% Voltar ao menu                              
echo.                                                                             
echo.                                             %b%"════════════════════════════════════════════════════════════════════" %w%
echo.                                                                 %w% Selecione o tipo de CPU que voce tem:
echo.          
echo.                                                   Desativa economia de energia, core parking e mais!
echo.                                             %b%"════════════════════════════════════════════════════════════════════"
echo.

set /p input=:
if /i %input% == 1 goto cpu1
if /i %input% == 2 goto cpu2
if /i %input% == T stART taskmgr & goto 8
if /i %input% == M cls & goto menu

) ELSE (
echo Entrada invalida & goto MisspellRedirect11

:MisspellRedirect11
cls
echo Erro de digitacao detectado
timeout 2
goto RedirectMenu11

:RedirectMenu11
cls
goto :8

:cpu1
cls
echo.  
echo.  
echo.
echo.                                                                  %p%░█████╗░███╗░░░███╗██████╗░  ░█████╗░██████╗░██╗░░░██╗
echo.                                                                  %p%██╔══██╗████╗░████║██╔══██╗  ██╔══██╗██╔══██╗██║░░░██║
echo.                                                                  %p%███████║██╔████╔██║██║░░██║  ██║░░╚═╝██████╔╝██║░░░██║
echo.                                                                  %p%██╔══██║██║╚██╔╝██║██║░░██║  ██║░░██╗██╔═══╝░██║░░░██║
echo.                                                                  %p%██║░░██║██║░╚═╝░██║██████╔╝  ╚█████╔╝██║░░░░░╚██████╔╝
echo.                                                                  %p%╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═════╝░  ░╚════╝░╚═╝░░░░░░╚═════╝░
echo.
timeout 1 /nobreak > NUL
echo %w%- Desativando Core Parking  %b%
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add HKLM\SYSTEM\CurrentControlSet\Control\Power /v CoreParkingDisabled /t REG_DWORD /d 0 /f
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100
powercfg /setactive SCHEME_CURRENT

echo %w%- Desativando Distribute Timers%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f

echo %w%- Desativando TSX%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "0" /f

echo %w%- Desativando Event Processor%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f

echo %w%- CPU Cooling Tweaks %b%
powercfg /setACvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setDCvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setactive SCHEME_CURRENT

echo %w%- Ativando Todos os Processadores Logicos %b%
bcdedit /set {current} numproc %NUMBER_OF_PROCESSORS% 

echo %w% - Desativando C-States%b%
powercfg -setacvalueindex scheme_current SUB_SLEEP AWAYMODE 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current SUB_SLEEP ALLOWSTANDBY 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current SUB_SLEEP HYBRIDSLEEP 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg /setactive SCHEME_CURRENT

echo %w%- Usando Higher P-States on Lower C-States And Viseversa %b%
powercfg -setacvalueindex scheme_current sub_processor IDLESCALING 1
powercfg /setactive SCHEME_CURRENT


echo %w% - Desativando Throttle States%b%
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:cpu2
echo.
echo.
echo.
echo.                                                                  %p%██╗███╗░░██╗████████╗███████╗██╗░░░░░  ░█████╗░██████╗░██╗░░░██╗
echo.                                                                  %p%██║████╗░██║╚══██╔══╝██╔════╝██║░░░░░  ██╔══██╗██╔══██╗██║░░░██║
echo.                                                                  %p%██║██╔██╗██║░░░██║░░░█████╗░░██║░░░░░  ██║░░╚═╝██████╔╝██║░░░██║
echo.                                                                  %p%██║██║╚████║░░░██║░░░██╔══╝░░██║░░░░░  ██║░░██╗██╔═══╝░██║░░░██║
echo.                                                                  %p%██║██║░╚███║░░░██║░░░███████╗███████╗  ╚█████╔╝██║░░░░░╚██████╔╝
echo.                                                                  %p%╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚══════╝╚══════╝  ░╚════╝░╚═╝░░░░░░╚═════╝░
echo.
timeout 1 /nobreak > NUL

echo %w%- Desativando Core Parking  %b%
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add HKLM\SYSTEM\CurrentControlSet\Control\Power /v CoreParkingDisabled /t REG_DWORD /d 0 /f
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100
powercfg /setactive SCHEME_CURRENT

echo %w%- Intel Specific Cpu tweaks %b%
bcdedit /set allowedinmemorysettings 0x0
bcdedit /set isolatedcontext No

echo %w%- Desativando Distribute Timers%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f

echo %w%- Desativando TSX%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "0" /f

echo %w%- Desativando Event Processor%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f

echo %w%- CPU Cooling Tweaks %b%
powercfg /setACvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setDCvalueindex scheme_current SUB_PROCESSOR SYSCOOLPOL 1
powercfg /setactive SCHEME_CURRENT

echo %w%- Ativando Todos os Processadores Logicos %b%
bcdedit /set {current} numproc %NUMBER_OF_PROCESSORS% 

echo %w% - Desativando C-States%b%
powercfg -setacvalueindex scheme_current SUB_SLEEP AWAYMODE 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current SUB_SLEEP ALLOWSTANDBY 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current SUB_SLEEP HYBRIDSLEEP 0
powercfg /setactive SCHEME_CURRENT
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg /setactive SCHEME_CURRENT
timeout /t 1 /nobreak > NUL

echo %w%- Usando Higher P-States on Lower C-States And Viseversa %b%
powercfg -setacvalueindex scheme_current sub_processor IDLESCALING 1
powercfg /setactive SCHEME_CURRENT

echo %w% - Desativando Throttle States%b%
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                %p%  ░██████╗░██████╗░██╗░░░██╗         
echo.                                                                %p%  ██╔════╝░██╔══██╗██║░░░██║        
echo.                                                                %p%  ██║░░██╗░██████╔╝██║░░░██         
echo.                                                                %p%  ██║░░╚██╗██╔═══╝░██║░░░██║        
echo.                                                                %p%  ╚██████╔╝██║░░░░░╚██████╔╝        
echo.                                                                %p%  ░╚═════╝░╚═╝░░░░░░╚═════╝░        
echo.                                             %b%"══════════════════════════════════════════════════════════════════"%w%  
echo.                                                                          
echo.                                                           %p%[%w%1%p%]%w% Aplicar Otimizacoes para GPU NVIDIA                        
echo.                                                                                            
echo.                                                           %p%[%w%2%p%]%w% Aplicar Otimizacoes para GPU AMD                           
echo.                                                                                          
echo.                                                           %p%[%w%3%p%]%w% Aplicar Otimizacoes para GPU Intel                      
echo.                                                                     
echo.                      
echo.                                                                  %p%[%w%T%p%]%w% Abrir Gerenciador de Tarefas                
echo.                                                                                                                                                                                     
echo.                                                                  %p%[%w%M%p%]%w% Voltar ao menu                              
echo.                                                                     
echo.                                             %b%"══════════════════════════════════════════════════════════════════"
echo.                                                             %w% Selecione o tipo de GPU que voce tem:
echo. 
echo.                                                       %W%  Otimiza sua GPU ajustando configuracoes 3D
echo.                                                       %W% Desativando economia de energia e muito mais
echo.                                             %b%"══════════════════════════════════════════════════════════════════"
echo.
set /p input=:
if /i %input% == 1 goto g1
if /i %input% == 2 goto g2
if /i %input% == 3 goto g3
if /i %input% == T stART taskmgr & goto 7
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


:g3
cls
echo.
echo.
echo.                                                       %p%   ██╗███╗░░██╗████████╗███████╗██╗░░░░░  ░██████╗░██████╗░██╗░░░██╗
echo.                                                       %p%   ██║████╗░██║╚══██╔══╝██╔════╝██║░░░░░  ██╔════╝░██╔══██╗██║░░░██║
echo.                                                       %p%   ██║██╔██╗██║░░░██║░░░█████╗░░██║░░░░░  ██║░░██╗░██████╔╝██║░░░██║
echo.                                                       %p%   ██║██║╚████║░░░██║░░░██╔══╝░░██║░░░░░  ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                       %p%   ██║██║░╚███║░░░██║░░░███████╗███████╗  ╚██████╔╝██║░░░░░╚██████╔╝  
echo.                                                       %p%   ╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚══════╝╚══════╝  ░╚═════╝░╚═╝░░░░░░╚═════╝░
echo.
echo.
echo %w% - Intel Gpu Tweaks%b%
for /f %%t in ('Reg query "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" /t REG_SZ /s /e /f "Intel" ^| findstr "HKEY"') do (

	Reg.exe add "%%t" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d "1" /f
    Reg.exe add "%%t" /v "IncreaseFixedSegment" /t REG_DWORD /d "1" /f
    Reg.exe add "%%t" /v "AdaptiveVsyncEnable" /t REG_DWORD /d "0" /f
    Reg.exe add "%%t" /v "DisablePFonDP" /t REG_DWORD /d "1" /f
    Reg.exe add "%%t" /v "EnableCompensationForDVI" /t REG_DWORD /d "1" /f
    Reg.exe add "%%t" /v "NoFastLinkTrainingForeDP" /t REG_DWORD /d "0" /f
    Reg.exe add "%%t" /v "ACPowerPolicyVersion" /t REG_DWORD /d "16898" /f
    Reg.exe add "%%t" /v "DCPowerPolicyVersion" /t REG_DWORD /d "16642" /f
)


Reg.exe add "HKLM\Software\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "512" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu




:1 
cls
echo.
echo.
echo.                                                       %p%   ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░     
echo.                                                       %p%   ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░     
echo.                                                       %p%   ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░    
echo.                                                       %p%   ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░      
echo.                                                       %p%   ╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗     
echo.                                                       %p%   ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝    
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                
echo.                                                        %p%[%w%1%p%]%w% Aplicar Otimizacoes Gerais de Latencia e Desempenho 
echo.
echo.                        
echo.                                                                                          
echo.                                                                            %p%[%w%M%p%]%w% Voltar ao menu                         
echo.
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                        %W%Aplica otimizacoes gerais no registro, bcdedit e mais!
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════"%w%
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
echo.                                                       %p%   ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░     
echo.                                                       %p%   ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░     
echo.                                                       %p%   ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░    
echo.                                                       %p%   ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░      
echo.                                                       %p%   ╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗     
echo.                                                       %p%   ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝    
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

::nfts
echo %w% - NFTS Tweaks%b%
fsutil behavior set memoryusage 2 >nul 2>&1
fsutil behavior set mftzone 4 >nul 2>&1
fsutil behavior set Disablelastaccess 1 >nul 2>&1
fsutil behavior set Disabledeletenotify 0 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1

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

::IRQ8 & IRQ16
echo %w% - Configurando IRQ8 Priority %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
echo %w% - Configurando IRQ16 Priority %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
 
::Menu Show Delay
echo %w% - Diminuindo tempo de encerramento de processos e atraso do menu%b%
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f

::IO Time Stamp
echo %w% - Configurando IO Time Stamp%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority" /t REG_DWORD /d "3" /f 

::CSRSS priority
echo %w% - Configurando CSRSS IO and CPU Priority to Realtime%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 

::LatencyTolerance
echo %w% - Configurando Latency Tolerance%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f 

::SetSystemResponsivness
echo %w% - Configurando System Responsiveness%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f 

timeout 3 > nul
cls 
:miti 
echo.
echo.
echo.                                                       %p%███╗░░░███╗██╗████████╗██╗░██████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
echo.                                                       %p%████╗░████║██║╚══██╔══╝██║██╔════╝░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
echo.                                                       %p%██╔████╔██║██║░░░██║░░░██║██║░░██╗░███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
echo.                                                       %p%██║╚██╔╝██║██║░░░██║░░░██║██║░░╚██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
echo.                                                       %p%██║░╚═╝░██║██║░░░██║░░░██║╚██████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
echo.                                                       %p%╚═╝░░░░░╚═╝╚═╝░░░╚═╝░░░╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░
echo.                                              %b%"════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                          %p%[%w%1%p%]%w% Desativar Mitigacoes         %p%[%w%2%p%]%w% Ativar Mitigacoes (reverter)
echo.
echo. 
echo.                                                                                        %p%[%w%X%p%]%w% Pular  
echo. 
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                  Mitigacoes protegem contra ataques baseados em memoria, mas custam desempenho
echo.                                                    Isto desativa varias basicas que causam perda de desempenho mas nao sao tao importantes
echo.                                              %b%"═════════════════════════════════════════════════════════════════════════════════════════════"%w%
         
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
echo %w% - Desativando ExceptionChainValidation%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f 
echo %w% - Desativando Sehop%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f 
echo %w% - Desativando CFG%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f 
echo %w% - Desativando Protection Mode%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f 
echo %w% - Desativando Spectre And Meltdown%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
echo %w% - Desativando Address Space Layout Randomization%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f  
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu


:mition
echo %w% - Ativando Isolation Memory Integrity%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f
echo %w% - Ativando HVCIMAT%b%
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "1" /f 
echo %w% - Ativando ExceptionChainValidation%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f 
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
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f  
 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :menu









:10war
chcp 437 >nul 2>&1
powershell "&  {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Do NOT do these if your pc has bad overheating issues', 'ART Tweaking Utility', 'Ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
timeout /t 1 /nobreak > nul
chcp 65001 >nul 2>&1
:10

:power
cls
echo.
echo.
echo.                                                                 %p%██████╗░░█████╗░░██╗░░░░░░░██╗███████╗██████╗░     
echo.                                                                 %p%██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔══██╗ 
echo.                                                                 %p%██████╔╝██║░░██║░╚██╗████╗██╔╝█████╗░░██████╔╝        
echo.                                                                 %p%██╔═══╝░██║░░██║░░████╔═████║░██╔══╝░░██╔══██   
echo.                                                                 %p%██║░░░░░╚█████╔╝░░╚██╔╝░╚██╔╝░███████╗██║░░██║      
echo.                                                                 %p%╚═╝░░░░░░╚════╝░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝      
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"%w%                                           
echo.                                                                                                                 
echo.                                                                  %p%[%w%1%p%]%w% Plano de Energia Desempenho Maximo (nativo)
echo.                                                                                           
echo.                                                                  %p%[%w%2%p%]%w% Desativar Power Throttling, Timer Coalescing e mais     
echo.   
echo.                                                                  %p%[%w%3%p%]%w% Desativar Telemetria de Energia
echo.
echo.                                                                  %p%[%w%4%p%]%w% Excluir planos de energia inuteis
echo.
echo.                                                                  %p%[%w%5%p%]%w% Desativar Hibernacao, Inicializacao Rapida e mais
echo. 
echo.                                                                                     
echo.                                                                  %p%[%w%R%p%]%w% Reverter ajustes de energia (exceto plano de energia)         
echo.                                                                                     
echo.      
echo.                                                                            %p%[%w%M%p%]%w% Voltar ao menu                             
echo.                                                                                      
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════════"
echo.                                                             %w% Pode aumentar a temperatura da CPU em PCs com refrigeracao fraca
echo.                                                         %W% Desativa varios recursos inuteis de economia de energia e mais
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════════"
echo.
echo.

set /p input=:
if /i %input% == 1 goto p1
if /i %input% == 2 goto p2
if /i %input% == 3 goto p3
if /i %input% == 4 goto p4
if /i %input% == 5 goto p5
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power

:p5
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:p4
echo %w% - Excluindo useless planos de energia%b%
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto power

:p3
echo %w% - Desativando Log de Energia + Telemetria de Energia%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :power

:P2
cls
cho %w%- Disable Link State Power Managment %b%
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\System\CurrentControlSet\Services" /s "EnableHIPM"^| FINDSTR /V "EnableHIPM"') DO (
echo %w%- Desativando HIPM %b%
Reg.exe add "%%a" /v "EnableHIPM" /t REG_DWORD /d "0" /f  > nul 
echo %w%- Desativando DIPM %b%
Reg.exe add "%%a" /v "EnabledIPM" /t REG_DWORD /d "0" /f > nul 
echo %w%- Desativando HDD Parking %b%
Reg.exe add "%%a" /v "EnableHDDParking" /t REG_DWORD /d "0" /f > nul 
FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKLM\System\CurrentControlSet\Services\=!
) > nul 
)	
echo %w% - Desativando GPU Energy Driver%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "StART" /t REG_DWORD /d "2" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "StART" /t REG_DWORD /d "2" /f 

echo %w% - Desativando CoalescingTimerInterval%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Power Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                         %p%███╗░░░███╗███████╗███╗░░░███╗░█████╗░██████╗░██╗░░░██╗     
echo.                                                         %p%████╗░████║██╔════╝████╗░████║██╔══██╗██╔══██╗╚██╗░██╔╝
echo.                                                         %p%██╔████╔██║█████╗░░██╔████╔██║██║░░██║██████╔╝░╚████╔╝░        
echo.                                                         %p%██║╚██╔╝██║██╔══╝░░██║╚██╔╝██║██║░░██║██╔══██╗░░╚██╔╝░░  
echo.                                                         %p%██║░╚═╝░██║███████╗██║░╚═╝░██║╚█████╔╝██║░░██║░░░██║░░░     
echo.                                                         %p%╚═╝░░░░░╚═╝╚══════╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░      
echo.                                             %b%"═════════════════════════════════════════════════════════════════════════════"%w%                                           
echo.                                                                         Selecione quanta RAM voce tem:             
echo.                                                                                          
echo.                                                    %p%[%w%1%p%]%w% 4GB                    %p%[%w%2%p%]%w% 8GB                 %p%[%w%3%p%]%w% 12GB                      
echo.                                                                                               
echo.                                                    %p%[%w%4%p%]%w% 16GB                   %p%[%w%5%p%]%w% 24GB                %p%[%w%6%p%]%w% 32GB
echo.  
echo.                                                    %p%[%w%7%p%]%w% 48GB                   %p%[%w%8%p%]%w% 64GB                %p%[%w%9%p%]%w% 128GB 
echo. 
echo.                                                                                       
echo.                                                    %p%%p%%p%%p%                           %p%[%w%T%p%]%w% Abrir Gerenciador de Tarefas
echo.
echo.                                                    %p%%p%%p%%p%                           %p%[%w%M%p%]%w% Voltar ao menu                             
echo.                                                                                   
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════"%w% 
echo.                                                 %w% Otimiza varios valores de registro da RAM para o melhor desempenho       
echo.                                                   %W% Desativa varios recursos inuteis que atrapalham o desempenho
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════"%w% 
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

echo %w% - Desativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f

goto rest

:8GB
chcp 437 >nul 2>&1
echo %w% - Ativando Compressao de Memoria%b%
PowerShell -Command "Enable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "8388608" /f 

echo %w% - Desativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f

goto rest

:12GB
chcp 437 >nul 2>&1
echo %w% - Ativando Compressao de Memoria%b%
PowerShell -Command "Enable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "12582912" /f 

echo %w% - Desativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f

goto rest

:16GB

chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "16777216" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:24GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "25165824" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:32GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "33554432" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:48GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "50331648" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:64GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "67108864" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:128GB
chcp 437 >nul 2>&1
echo %w% - Desativando Compressao de Memoria%b%
PowerShell -Command "Disable-MMAgent -MemoryCompression" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Configurando Best SvcHostSplitThresholdInKB for your ram size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "134217728" /f 

echo %w% - Ativando Cache de Sistema Grande%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

goto rest

:rest

echo %w% - Desativando Combinacao de Paginas%b%
chcp 437 >nul 2>&1
PowerShell -Command "Disable-MMAgent -PageCombining" > nul 2>&1
chcp 65001 >nul 2>&1

echo %w% - Desativando Paging Executive%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f 

echo %w% - Otimizando Memory Managment%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "StART" /t REG_DWORD /d "4" /f


echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                              %p%███╗░░██╗██╗░░░██╗██╗██████╗░██╗░█████╗░  ░██████╗░██████╗░██╗░░░██╗
echo.                                                              %p%████╗░██║██║░░░██║██║██╔══██╗██║██╔══██╗  ██╔════╝░██╔══██╗██║░░░██║
echo.                                                              %p%██╔██╗██║╚██╗░██╔╝██║██║░░██║██║███████║  ██║░░██╗░██████╔╝██║░░░██║
echo.                                                              %p%██║╚████║░╚████╔╝░██║██║░░██║██║██╔══██║  ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                              %p%██║░╚███║░░╚██╔╝░░██║██████╔╝██║██║░░██║  ╚██████╔╝██║░░░░░╚██████╔╝
echo.                                                              %p%╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═╝░░╚═╝  ░╚═════╝░╚═╝░░░░░░╚═════╝░
timeout 1 /nobreak > NUL

echo %w% - Forcando Contigous Memory Allocation %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d "1" /f

echo %w% - Desativando Write Combining %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f

for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_"') do (
echo %w%- Excluindo GPU Device Priority %b%
Reg.exe delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1

echo %w%- Removendo Msi GPU Limits %b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /f >nul 2>&1

echo %w%- Ativando MSI Mode on GPU if supported %b%
Reg.exe add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)
echo %w%- Desativando Preemption%b%			 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t Reg_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t Reg_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ComputePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f

echo %w%- Configurando query VRAM%b% 
fsutil behavior query memoryusage
fsutil behavior set memoryusage 2

echo %w% - Configurando NVIDIA Latency Tolerance%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "D3PCLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "F1TransitionLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LOWLATENCY" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Node3DLowLatency" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcMaxFtuS" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcMinFtuS" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcPerioduS" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrEiIdleThresholdUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrGrIdleThresholdUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrGrRgIdleThresholdUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrMsIdleThresholdUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectFlipDPCDelayUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectFlipTimingMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectJITFlipMsHybridFlipDelayUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrCursorMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrDeflickerMarginUs" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrDeflickerMaxUs" /t REG_DWORD /d "1" /f 


echo %w% - Desativando NVIDIA Telemetria%b%
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f 
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f 
schtasks /change /Disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 
schtasks /change /Disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" 

echo %w%- Desativando GpuEnergy Driver %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "StART" /t REG_DWORD /d "4" /f

echo %w% - Desativando Preemption%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f 

echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:g2
cls
echo.
echo.
echo.
echo.                                                              %p%░█████╗░███╗░░░███╗██████╗░  ░██████╗░██████╗░██╗░░░██╗
echo.                                                              %p%██╔══██╗████╗░████║██╔══██╗  ██╔════╝░██╔══██╗██║░░░██║
echo.                                                              %p%███████║██╔████╔██║██║░░██║  ██║░░██╗░██████╔╝██║░░░██║
echo.                                                              %p%██╔══██║██║╚██╔╝██║██║░░██║  ██║░░╚██╗██╔═══╝░██║░░░██║
echo.                                                              %p%██║░░██║██║░╚═╝░██║██████╔╝  ╚██████╔╝██║░░░░░╚██████╔╝
echo.                                                              %p%╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═════╝░  ░╚═════╝░╚═╝░░░░░░╚═════╝░
timeout 1 /nobreak > NUL

for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_"') do (
echo %w%- Excluindo GPU Device Priority %b%
Reg.exe delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1

echo %w%- Removendo Msi GPU Limits %b%
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /f >nul 2>&1

echo %w%- Ativando MSI Mode on GPU if supported %b%
Reg.exe add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)

echo %w%- Desativando GpuEnergy Driver %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "StART" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "StART" /t REG_DWORD /d "4" /f

echo %w% - Desativando Display Refresh Rate Override%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "3D_Refresh_Rate_Override_DEF" /t REG_DWORD /d "0" /f 

echo %w% - Desativando SnapShot%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSnapshot" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Anti Aliasing%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AAF_NA" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AntiAlias_NA" /t REG_SZ /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ASTT_NA" /t REG_SZ /d "0" /f 

echo %w% - Desativando Subscriptions%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSubscription" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Anisotropic Filtering%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AreaAniso_NA" /t REG_SZ /d "0" /f 

echo %w% - Desativando Radeon Overlay%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowRSOverlay" /t REG_SZ /d "false" /f  

echo Enabling Adaptive DeInterlacing%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Adaptive De-interlacing" /t REG_DWORD /d "1" /f 

echo %w% - Desativando Skins%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSkins" /t REG_SZ /d "false" /f  

echo %w% - Desativando Automatic Color Depth Reduction%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AutoColorDepthReduction_NA" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Power Gating%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableSAMUPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableUVDPowerGatingDynamic" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableVCEPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisabledrmdmaPowerGating" /t REG_DWORD /d "1" /f 

echo %w% - Desativando VCESW Clock Gating%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableVceSwClockGating" /t REG_DWORD /d "1" /f 

echo %w% - Desativando UVD Clock Gating%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUvdClockGating" /t REG_DWORD /d "1" /f 

echo %w% - Desativando Active State Power Management (ASPM)%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspmL0s" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspmL1" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Ultra Low Power States (ULPS) %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps_NA" /t REG_SZ /d "0" /f 

echo %w% - Ativando De-Lag%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL

echo %w% - Desativando Frame Rate Target%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_FRTEnabled" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL

echo %w% - Desativando DMA%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisabledMACopy" /t REG_DWORD /d "1" /f 

echo %w% - Ativando BlockWrite%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Stutter Mode%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "StutterMode" /t REG_DWORD /d "0" /f 

echo %w% - Desativando GPU Memory Clock Sleep State%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f 

echo %w% - Desativando Thermal Throttling%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f 

echo %w% - Desativando Preemption%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_EnableComputePreemption" /t REG_DWORD /d "0" /f 

echo %w% - Configurando Main3D%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f 

echo %w% - Configurando FlipQueueSize%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "FlipQueueSize" /t REG_BINARY /d "3100" /f 

echo %w% - Configurando Shader Cache Size%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3200" /f 

echo %w% - Configurando TFQ%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f 

echo %w%- Desativando Preemption %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisableCudaContextPreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ComputePreemptionLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisablePreemption" /t REG_DWORD /d "1" /f

echo %w% - Desativando GPU Power Down%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_GPUPowerDownEnabled" /t REG_DWORD /d "1" /f 

echo %w% - Desativando AMD Logging%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "StART" /t REG_DWORD /d "4" /f 

echo %w%- Latency Tolernace %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
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
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RMDisablePostL2Compression" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmDisableRegistryCaching" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL


echo %w%- Vram %b% 
fsutil behavior query memoryusage
fsutil behavior set memoryusage 2


echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:9
cls
echo.  
echo.  
echo.  
echo.                                                                           %p%██╗░░░██╗░██████╗██████╗░  ████████╗░██╗░░░░░░░██╗███████╗░█████╗░██╗░░██╗░██████╗
echo.                                                                           %p%██║░░░██║██╔════╝██╔══██╗  ╚══██╔══╝░██║░░██╗░░██║██╔════╝██╔══██╗██║░██╔╝██╔════╝
echo.                                                                           %p%██║░░░██║╚█████╗░██████╦╝  ░░░██║░░░░╚██╗████╗██╔╝█████╗░░███████║█████═╝░╚█████╗░
echo.                                                                           %p%██║░░░██║░╚═══██╗██╔══██╗  ░░░██║░░░░░████╔═████║░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
echo.                                                                           %p%╚██████╔╝██████╔╝██████╦╝  ░░░██║░░░░░╚██╔╝░╚██╔╝░███████╗██║░░██║██║░╚██╗██████╔╝
echo.                                                                           %p%░╚═════╝░╚═════╝░╚═════╝░  ░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
timeout 1 /nobreak > NUL
echo %w% - Desativando Economia de Energia do USB%b%
for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_USBController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "DeviceSelectiveSuspended" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnableSelectiveSuspend" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d "0" /f 
)


echo %w% - Thread Priority%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f

echo %w% - Desativando Suspensao Seletiva de USB%b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d "1" /f 

echo %w% - Enabing MSI mode on usb%b%
for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_USBController).PNPDeviceID" ^| findstr /B /L /C:"PCI\VEN_"') do (
echo %w% - DEL USB Device Priority %b%
Reg.exe delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
echo %w% -Ativando MSI Mode on USB %b%
Reg.exe add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)
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
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
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

echo %w% - Configurando CSRSS to Realtime%b%
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto kbm,

:2
:kbm
cls
echo.
echo.
echo.                                                               %p% ██╗░░██╗██████╗░███╗░░░███╗
echo.                                                               %p% ██║░██╔╝██╔══██╗████╗░████║
echo.                                                               %p% █████═╝░██████╦╝██╔████╔██║
echo.                                                               %p% ██╔═██╗░██╔══██╗██║╚██╔╝██║
echo.                                                               %p% ██║░╚██╗██████╦╝██║░╚═╝░██║
echo.                                                               %p% ╚═╝░░╚═╝╚═════╝░╚═╝░░░░░╚═╝    
echo.                                             %b%"═══════════════════════════════════════════════════════════════"%w%                    
echo.                                                                                          
echo.                                                           %p%[%w%1%p%]%w% Aplicar Otimizacoes de Registro (Mouse/Teclado)
echo.                                                                                           
echo.                                                           %p%[%w%2%p%]%w% Definir Tamanho da Fila de Dados
echo.                                                                                          
echo.                                                                                           
echo.                                                                   %p%[%w%M%p%]%w% Voltar ao menu 
echo.                            
echo.                                                                                         
echo.                                                             %p%%w%%w%%w%  Feito por ART TWEAKS® 2026    
echo.                                             %b%"════════════════════════════════════════════════════════════════"
echo.                                                %w% Otimiza varias configuracoes de registro de mouse e teclado
echo.                                             %b%"════════════════════════════════════════════════════════════════"
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

echo.                                                                               %p% ██╗░░██╗██████╗░███╗░░░███╗
echo.                                                                               %p% ██║░██╔╝██╔══██╗████╗░████║
echo.                                                                               %p% █████═╝░██████╦╝██╔████╔██║
echo.                                                                               %p% ██╔═██╗░██╔══██╗██║╚██╔╝██║
echo.                                                                               %p% ██║░╚██╗██████╦╝██║░╚═╝░██║
echo.                                                                               %p% ╚═╝░░╚═╝╚═════╝░╚═╝░░░░░╚═╝
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════"   
echo.                                                                                                                       
echo.                                                    %p%[%w%1%p%]%w% 14 (CPU topo)              %p%[%w%2%p%]%w% 17 (CPU media)            %p%[%w%3%p%]%w% 20 (CPU basica)                  
echo.                                                                                                                                                                                       
echo.                                                                                                                      
echo.                                                    %p%%p%%p%%p%                               %p%[%w%T%p%]%w% Abrir Gerenciador de Tarefas                          
echo.                                                                                                                       
echo.                                                    %p%%p%%p%%p%                               %p%[%w%R%p%]%w% Revert                  
echo.                                                                                          
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════"
echo.                                                              %w% Quanto menor o valor, menor a latencia dos perifericos
echo.                                                       %w% Mas pode causar travadas de mouse/teclado em PCs mais fracos se o valor for alto
echo.
echo.                                                %w% Comente sua CPU no video tutorial do YouTube e diremos qual valor usar
echo.                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════"
echo.
set /p input=: 
if /i %input% == 1 goto 14v
if /i %input% == 2 goto 17v
if /i %input% == 3 goto 20v
if /i %input% == R goto Revertm
if /i %input% == T stART taskmgr & goto k2
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu

:revertm
echo %w% - 100 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "256" /f
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                   %p%░█████╗░██╗░░░░░███████╗░█████╗░███╗░░██╗  
echo.                                                                   %p%██╔══██╗██║░░░░░██╔════╝██╔══██╗████╗░██║
echo.                                                                   %p%██║░░╚═╝██║░░░░░█████╗░░███████║██╔██╗██║      
echo.                                                                   %p%██║░░██╗██║░░░░░██╔══╝░░██╔══██║██║╚████║ 
echo.                                                                   %p%╚█████╔╝███████╗███████╗██║░░██║██║░╚███║    
echo.                                                                   %p%░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝      
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"%w%                
echo.                                                                                                       
echo.                                                  %p%[%w%1%p%]%w% Limpar Dados Temporarios       %p%[%w%2%p%]%w% Limpeza de Disco do Windows
echo.
echo.                                                  %p%[%w%3%p%]%w% Limpeza Completa: temp, cache do Update, shaders, navegadores, lixeira, DNS
echo.
echo.                                                                                                                                                                
echo.                                                                          %p%[%w%M%p%]%w% Voltar ao menu                             
echo.                                                                                    
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
echo.                                                               %W% Limpa varios dados temporarios do seu PC
echo.                                                             %W% Exclui drivers antigos, cache, logs e muito mais
echo.                                             %b%"════════════════════════════════════════════════════════════════════════════════"
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto :4

:c2
cls
stART cleanmgr.exe
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
echo.                                                                                  %b%╚═══════════════════════════════════════════════════════════════╝
echo.

pause > nul
cls
goto menu


:6
cls
call :ARTps stARTup
cls
goto menu


:backupmenu
cls
echo.
echo.
echo.
echo.                                                                  %p%B A C K U P   /   R E S T O R E%w%
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                  %p%[%w%1%p%]%w% Criar um Ponto de Restauracao agora
echo.
echo.                                                                  %p%[%w%2%p%]%w% Fazer backup das configuracoes: registro, servicos e tarefas agendadas
echo.
echo.                                                                  %p%[%w%3%p%]%w% Restaurar um backup de configuracoes
echo.
echo.                                                                  %p%[%w%4%p%]%w% Abrir Restauracao do Sistema do Windows
echo.
echo.                                                                  %p%[%w%5%p%]%w% Abrir a pasta de backups
echo.
echo.
echo.                                                                  %p%[%w%M%p%]%w% Voltar ao menu
echo.
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                          %W% Os backups ficam na sua pasta de usuario, em ART_Backups
echo.                                                          %W% Restaurar traz de volta os valores antigos. Valores criados do zero pelos ajustes permanecem
echo.                                                          %W% Nao coberto: bcdedit, planos de energia, opcoes NTFS. Use um Ponto de Restauracao para isso
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
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
call :ARTps backup
echo.
echo %w% Pressione qualquer tecla para continuar...%b%
pause > nul
goto backupmenu

:bk_restore
cls
call :ARTps restore
echo.
echo %w% Pressione qualquer tecla para continuar...%b%
pause > nul
goto backupmenu

:bk_open
if not exist "%USERPROFILE%\ART_Backups" md "%USERPROFILE%\ART_Backups"
stART "" explorer "%USERPROFILE%\ART_Backups"
goto backupmenu


:win11menu
if %WINBUILD% LSS 22000 goto w11_notsupported
cls
echo.
echo.
echo.
echo.                                                                  %p%W I N D O W S   1 1   T W E A K S%w%
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                  %p%[%w%A%p%]%w% Aplicar todos os ajustes do Windows 11
echo.
echo.                                                                  %p%[%w%1%p%]%w% Desativar Copilot
echo.
echo.                                                                  %p%[%w%2%p%]%w% Desativar Recall e analise de dados por IA
echo.
echo.                                                                  %p%[%w%3%p%]%w% Desativar Widgets
echo.
echo.                                                                  %p%[%w%4%p%]%w% Menu classico do botao direito
echo.
echo.
echo.                                                                  %p%[%w%R%p%]%w% Reverter estes ajustes
echo.
echo.                                                                  %p%[%w%M%p%]%w% Voltar aos Ajustes do Windows
echo.
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                          %W% Baseado em politicas, resiste melhor a atualizacoes do que remover o app
echo.                                                          %W% O menu classico reinicia o Explorer, a barra de tarefas pisca por um segundo
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
Dism /Online /Disable-Feature /FeatureName:Recall /NoRestART >nul 2>&1
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
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
echo.                                                                  %p%C O M P L E T E   C L E A N%w%
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                          Isto vai excluir:
echo.                                                            - Arquivos temporarios e o cache de download do Windows Update
echo.                                                            - Caches de shader: NVIDIA, AMD e DirectX. Os jogos recriam no proximo inicio
echo.                                                            - Caches de navegadores: Chrome, Edge, Brave e Firefox. Logins e favoritos sao mantidos
echo.                                                            - Cache de miniaturas, relatorios de erro e crash dumps
echo.                                                            - Cache DNS e a Lixeira
echo.  - Limpeza de Disco (cleanmgr). A pasta Downloads e a Windows.old nao sao tocadas
echo.
echo.                                                          Feche seus navegadores e jogos antes. A ultima etapa pode levar alguns minutos.
echo.
echo.                                             %b%"══════════════════════════════════════════════════════════════════════════════════════════════"%w%
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
if defined WU_WAS net stART wuauserv >nul 2>&1
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
Dism /Online /Cleanup-Image /StARTComponentCleanup >nul 2>&1
for /f %%f in ('powershell -NoProfile -Command "[math]::Round(([IO.DriveInfo]$env:SystemDrive).AvailableFreeSpace/1MB)"') do set "FREE_AFTER=%%f"
set /a FREED=FREE_AFTER-FREE_BEFORE
if %FREED% LSS 0 set "FREED=0"
echo.
echo %w% Limpeza Completa concluida. Espaco liberado: cerca de %FREED% MB%b%
echo.
echo.
echo.
echo.                                                                                  %b%╔═══════════════════════════════════════════════════════════════╗
echo.                                                                                  %b%║    %w% * Concluido * Pressione qualquer tecla para continuar...  %b%║
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
function Get-StARTupEntries {
    $list = New-Object System.Collections.ArrayList
    $adv = 'Software\Microsoft\Windows\CurrentVersion\Explorer\StARTupApproved'
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
        @{ Scope = 'User folder';    Dir = [Environment]::GetFolderPath('StARTup');       Hive = 'HKCU:' },
        @{ Scope = 'Machine folder'; Dir = [Environment]::GetFolderPath('CommonStARTup'); Hive = 'HKLM:' }
    )
    foreach ($f in $dirDefs) {
        if ($f.Dir -and (Test-Path -LiteralPath $f.Dir)) {
            Get-ChildItem -LiteralPath $f.Dir -File -Force | Where-Object { $_.Name -ne 'desktop.ini' } | ForEach-Object {
                [void]$list.Add([pscustomobject]@{ Name = $_.Name; Cmd = $_.FullName; Scope = $f.Scope; AppKey = ($f.Hive + '\' + $adv + '\StARTupFolder'); Enabled = $true })
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

function Set-StARTupState($e, [bool]$enable) {
    if (-not (Test-Path -LiteralPath $e.AppKey)) { New-Item -Path $e.AppKey -Force | Out-Null }
    if ($enable) {
        $bytes = [byte[]](2,0,0,0,0,0,0,0,0,0,0,0)
    } else {
        $bytes = [byte[]]((3,0,0,0) + [BitConverter]::GetBytes([DateTime]::Now.ToFileTime()))
    }
    New-ItemProperty -LiteralPath $e.AppKey -Name $e.Name -PropertyType Binary -Value $bytes -Force | Out-Null
}

function Show-StARTupManager {
    while ($true) {
        Clear-Host
        $items = @(Get-StARTupEntries)
        Write-Host ''
        Write-Host '   GERENCIADOR DE INICIALIZACAO' -ForegroundColor Green
        Write-Host '   Programas que iniciam com o Windows. Mesmo interruptor do Gerenciador de Tarefas > Aplicativos de inicializacao (nada e excluido).' -ForegroundColor Gray
        Write-Host ''
        if ($items.Count -eq 0) { Write-Host '   Nenhum item de inicializacao encontrado.' -ForegroundColor Yellow }
        $i = 0
        foreach ($e in $items) {
            $i++
            if ($e.Enabled) { $state = 'LIG'; $color = 'Green' } else { $state = 'DES'; $color = 'DarkGray' }
            $name = $e.Name
            if ($name.Length -gt 30) { $name = $name.Substring(0, 27) + '...' }
            $cmd = $e.Cmd
            if ($cmd.Length -gt 55) { $cmd = $cmd.Substring(0, 52) + '...' }
            Write-Host ('   [{0,2}] {1}  {2,-30} {3,-15} {4}' -f $i, $state, $name, $e.Scope, $cmd) -ForegroundColor $color
        }
        Write-Host ''
        Write-Host '   Digite um numero para LIGAR/DESLIGAR, R para atualizar, Q para voltar.' -ForegroundColor White
        Write-Host '   Nao desative itens de antivirus, audio, touchpad ou driver de video.' -ForegroundColor Yellow
        Write-Host ''
        $in = (Read-Host '   >').Trim()
        if ($in -match '^[Qq]$') { break }
        if ($in -match '^\d+$') {
            $num = [int]$in
            if ($num -ge 1 -and $num -le $items.Count) {
                $sel = $items[$num - 1]
                Set-StARTupState $sel (-not $sel.Enabled)
            }
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
    Get-CimInstance Win32_Service | Select-Object Name, StARTMode | Export-Csv -LiteralPath (Join-Path $dir 'services.csv') -NoTypeInformation
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
        Get-CimInstance Win32_Service | ForEach-Object { $now[$_.Name] = $_.StARTMode }
        foreach ($s in @(Import-Csv -LiteralPath $svcCsv)) {
            if ($map.ContainsKey($s.StARTMode) -and $now.ContainsKey($s.Name) -and ($now[$s.Name] -ne $s.StARTMode)) {
                & sc.exe config $s.Name stART= $map[$s.StARTMode] 2>$null | Out-Null
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
    [DllImport("user32.dll", CharSet = CharSet.Ansi)]
    public static extern bool EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE devMode);
    public static int[] Info() {
        DEVMODE cur = new DEVMODE(); cur.dmSize = (short)Marshal.SizeOf(typeof(DEVMODE));
        if (!EnumDisplaySettings(null, -1, ref cur)) return new int[] {0, 0, 0, 0};
        int max = 0; int i = 0;
        DEVMODE m = new DEVMODE(); m.dmSize = (short)Marshal.SizeOf(typeof(DEVMODE));
        while (EnumDisplaySettings(null, i, ref m)) {
            if (m.dmPelsWidth == cur.dmPelsWidth && m.dmPelsHeight == cur.dmPelsHeight && m.dmDisplayFrequency > max) max = m.dmDisplayFrequency;
            i++;
        }
        return new int[] {cur.dmPelsWidth, cur.dmPelsHeight, cur.dmDisplayFrequency, max};
    }
}
'@
        return [ARTDisp]::Info()
    } catch { return @(0,0,0,0) }
}

function Show-Report {
    Write-Title 'RELATORIO DO PC'
    $cs = Get-CimInstance Win32_ComputerSystem
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $isLaptop = $false
    if (Get-CimInstance Win32_Battery) { $isLaptop = $true }
    $enc = Get-CimInstance Win32_SystemEnclosure
    if ($enc -and ($enc.ChassisTypes | Where-Object { $_ -in 8,9,10,11,12,14,18,21,30,31,32 })) { $isLaptop = $true }
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
    $stARTup = @(Get-StARTupEntries | Where-Object { $_.Enabled }).Count
    [pscustomobject]@{
        Date      = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        RamUsedMB = ($totalMB - $freeMB)
        Processes = @(Get-Process).Count
        Services  = $svc
        StARTup   = $stARTup
        BootMs    = (Get-BootMs)
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
    Write-Line 'Apps no inicio' $s.StARTup
    if ($s.BootMs -gt 0) { Write-Line 'Ultimo boot' ('' + [math]::Round($s.BootMs / 1000, 1) + ' s') } else { Write-Line 'Ultimo boot' 'indisponivel no log de eventos' }
}

function Save-Before {
    Write-Title 'MEDIDOR ANTES/DEPOIS: salvando ANTES'
    Write-Host '   Dica: meca logo apos reiniciar, sem apps abertos, para os numeros serem comparaveis.' -ForegroundColor Gray
    Write-Host ''
    $s = Get-Snapshot
    $s | ConvertTo-Json | Set-Content -LiteralPath (Join-Path (Get-SnapPath) 'before.json') -Encoding UTF8
    Show-Snapshot $s
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
        @('Apps no inicio', $b.StARTup, $a.StARTup),
        @('Tempo de boot (s)', [math]::Round($b.BootMs / 1000, 1), [math]::Round($a.BootMs / 1000, 1))
    )
    foreach ($r in $rows) {
        $d = [math]::Round($r[2] - $r[1], 1)
        if ($d -le 0) { $c = 'Green' } else { $c = 'Yellow' }
        Write-Host ('   {0,-18} {1,10} {2,10} {3,12}' -f $r[0], $r[1], $r[2], $d) -ForegroundColor $c
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
        if ($m.Speed -and $m.ConfiguredClockSpeed -and ($m.ConfiguredClockSpeed -lt ($m.Speed - 50))) { $slow = $true }
    }
    if ($mods.Count -eq 0) {
        Write-Warn2 'Nao foi possivel ler os modulos de RAM.'
    } elseif ($slow) {
        $m0 = $mods | Select-Object -First 1
        Write-Warn2 ('A RAM e de ' + $m0.Speed + ' MT/s mas esta rodando a ' + $m0.ConfiguredClockSpeed + ' MT/s. O XMP/EXPO provavelmente esta DESLIGADO. Entre na BIOS e ative o XMP (Intel) ou EXPO (AMD). Isso costuma dar mais FPS do que qualquer ajuste de registro.')
    } else {
        Write-Ok 'A RAM esta rodando na velocidade nominal.'
    }
    $di = Get-MaxRefresh
    if ($di[0] -gt 0) {
        if ($di[3] -gt $di[2]) {
            Write-Warn2 ('O monitor esta a ' + $di[2] + ' Hz em ' + $di[0] + 'x' + $di[1] + ' mas ' + $di[3] + ' Hz esta disponivel. Configuracoes > Sistema > Video > Video avancado > Taxa de atualizacao. Use tambem um cabo DisplayPort/HDMI compativel.')
        } else {
            Write-Ok ('O monitor esta na maior taxa de atualizacao para esta resolucao: ' + $di[2] + ' Hz.')
        }
    } else {
        Write-Warn2 'Nao foi possivel ler a taxa de atualizacao do monitor.'
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
                Write-Ok ('O disco ' + $line + ' esta saudavel' + $extra + '.')
            }
        }
    }
    foreach ($gpu in @(Get-CimInstance Win32_VideoController)) {
        if ($gpu.Name -match 'Basic|Remote|Virtual|Hyper-V') { continue }
        if ($gpu.DriverDate) {
            $age = [int]((Get-Date) - $gpu.DriverDate).TotalDays
            if ($age -gt 180) {
                Write-Warn2 ('O driver de video de ' + $gpu.Name + ' tem ' + $age + ' dias (' + $gpu.DriverDate.ToString('yyyy-MM-dd') + '). Baixe o mais recente no site da NVIDIA/AMD.')
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
    if ($names -match 'NVIDIA|GeForce|RTX|GTX') { StART-Process 'https://www.nvidia.com/Download/index.aspx'; $opened = $true }
    if ($names -match 'AMD|Radeon') { StART-Process 'https://www.amd.com/en/support/download/drivers.html'; $opened = $true }
    if (-not $opened) { StART-Process 'https://www.nvidia.com/Download/index.aspx'; StART-Process 'https://www.amd.com/en/support/download/drivers.html' }
}

function Show-UsedPc {
    Write-Title 'PC EM USO: o que esta pesando no seu sistema'
    Write-Host '   Top 15 processos por RAM (agrupados por nome):' -ForegroundColor Cyan
    Get-Process | Group-Object ProcessName | ForEach-Object {
        [pscustomobject]@{ Name = $_.Name; Count = $_.Count; MB = [math]::Round((($_.Group | Measure-Object WorkingSet64 -Sum).Sum) / 1MB) }
    } | Sort-Object MB -Descending | Select-Object -First 15 | ForEach-Object {
        Write-Host ('   {0,-32} x{1,-3} {2,8} MB' -f $_.Name, $_.Count, $_.MB) -ForegroundColor White
    }
    Write-Host ''
    $items = @(Get-StARTupEntries)
    $on = @($items | Where-Object { $_.Enabled })
    Write-Host ('   Itens de inicializacao: ' + $on.Count + ' ativados de ' + $items.Count) -ForegroundColor Cyan
    foreach ($e in $on) { Write-Host ('   - ' + $e.Name + ' (' + $e.Scope + ')') -ForegroundColor White }
    Write-Host ''
    Write-Host '   Servicos de terceiros em inicio automatico e rodando agora:' -ForegroundColor Cyan
    $svcs = @(Get-CimInstance Win32_Service | Where-Object { $_.StARTMode -eq 'Auto' -and $_.State -eq 'Running' -and $_.PathName -and ($_.PathName -notmatch '(?i)\\windows\\') -and ($_.PathName -notmatch '(?i)Windows Defender|Microsoft') })
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
        if ($ans2 -match '^[SsYy]') { StART-Process services.msc }
    }
}


switch ($mode) {
    'stARTup' { Show-StARTupManager }
    'backup'  { Invoke-ARTBackup }
    'restore' { Invoke-ARTRestore }
    'report'    { Show-Report }
    'before'    { Save-Before }
    'after'     { Save-After }
    'checks'    { Show-Checks }
    'gpudrivers' { Open-GpuDrivers }
    'usedpc'    { Show-UsedPc }
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
#BKEY HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StARTupApproved
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
#BKEY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StARTLayout
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

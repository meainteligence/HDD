# Sistema .BAT para Gerenciar Discos e Baixar Windows

Abaixo está um exemplo de sistema `.bat` que:

* Lista discos conectados
* Permite selecionar HD/SSD/Pendrive
* Formata o disco
* Remove partições usando DiskPart
* Dá opção de baixar Windows 10 ou 11
* Cria pendrive bootável usando a ISO

⚠️ AVISO IMPORTANTE:

* Esse script APAGA TODOS OS DADOS do disco selecionado.
* Use apenas em discos corretos.
* Execute como Administrador.
* Faça backup antes.

---

# Estrutura dos Arquivos

Você pode criar:

```text
Projeto/
│
├── sistema.bat
├── limpar.txt
├── formatar.txt
└── criar_boot.txt
```

---

# Arquivo: sistema.bat

```bat
@echo off
title Sistema de Disco e Instalacao Windows
color 0A
mode con: cols=90 lines=35

:menu
cls
echo ==============================================
echo         SISTEMA DE GERENCIAMENTO DISCO
echo ==============================================
echo.
echo [1] Listar discos
echo [2] Formatar disco
echo [3] Apagar particoes e limpar disco
echo [4] Baixar Windows 10
echo [5] Baixar Windows 11
echo [6] Criar pendrive bootavel
echo [0] Sair
echo.
set /p opcao=Escolha:

if "%opcao%"=="1" goto listar
if "%opcao%"=="2" goto formatar
if "%opcao%"=="3" goto limpar
if "%opcao%"=="4" goto win10
if "%opcao%"=="5" goto win11
if "%opcao%"=="6" goto boot
if "%opcao%"=="0" exit

goto menu

:listar
cls
echo LISTA DE DISCOS:
echo.
diskpart /s listar.txt
pause
goto menu

:formatar
cls
echo ======================================
echo FORMATAR DISCO
echo ======================================
echo.
diskpart /s listar.txt

echo.
set /p disco=Digite o numero do disco:
set /p letra=Digite a letra da unidade (EX: E):

(
echo select disk %disco%
echo clean
echo create partition primary
echo format fs=ntfs quick
echo assign letter=%letra%
echo exit
) > formatar_temp.txt

diskpart /s formatar_temp.txt

echo.
echo DISCO FORMATADO.
pause
goto menu

:limpar
cls
echo ======================================
echo LIMPAR DISCO COMPLETO
necho ======================================
echo.
diskpart /s listar.txt

echo.
set /p disco=Digite o numero do disco para apagar tudo:

echo.
echo ATENCAO!
echo TODOS OS DADOS SERAO APAGADOS.
set /p confirma=Digite SIM para continuar:

if /I not "%confirma%"=="SIM" goto menu

(
echo select disk %disco%
echo clean
echo convert gpt
echo exit
) > limpar_temp.txt

diskpart /s limpar_temp.txt

echo.
echo DISCO LIMPO COM SUCESSO.
pause
goto menu

:win10
cls
echo Baixando Windows 10...
start https://www.microsoft.com/software-download/windows10
pause
goto menu

:win11
cls
echo Baixando Windows 11...
start https://www.microsoft.com/software-download/windows11
pause
goto menu

:boot
cls
echo ======================================
echo CRIAR PENDRIVE BOOTAVEL
echo ======================================
echo.

echo Conecte o pendrive.
pause

diskpart /s listar.txt

echo.
set /p disco=Digite o numero do pendrive:
set /p iso=Caminho da ISO do Windows:

(
echo select disk %disco%
echo clean
echo create partition primary
echo format fs=fat32 quick
echo active
echo assign
echo exit
) > boot_temp.txt

diskpart /s boot_temp.txt

echo.
echo ======================================
echo Montando ISO...
echo ======================================

powershell Mount-DiskImage -ImagePath "%iso%"

echo.
echo Copie os arquivos da ISO para o pendrive.
echo.
echo Metodo simples:
echo.
echo 1 - Abra o Explorador
echo 2 - Abra a ISO montada
echo 3 - Copie tudo para o pendrive

echo.
echo PENDRIVE PREPARADO.
pause
goto menu
```

---

# Arquivo: listar.txt

```txt
list disk
exit
```

---

# Como usar

1. Crie uma pasta.
2. Crie o arquivo `sistema.bat`.
3. Crie o arquivo `listar.txt`.
4. Cole os códigos acima.
5. Execute como Administrador.

---

# O que esse sistema consegue fazer

✅ Detectar HD/SSD/Pendrive

✅ Formatar discos

✅ Apagar todas partições

✅ Converter GPT

✅ Abrir download oficial Windows 10

✅ Abrir download oficial Windows 11

✅ Preparar pendrive bootável

---

# Melhorias que você pode adicionar depois

Você pode evoluir isso para:

* Interface gráfica
* Detectar automaticamente pendrive
* Instalar Windows automaticamente
* Multi boot
* Ver temperatura do HD
* Ver saúde SMART
* Backup automático
* Menu gamer estilo BIOS
* Sistema WinPE
* Integração com Rufus/Ventoy

---

# Recomendação Melhor

Para criar pendrive bootável automaticamente, normalmente é melhor usar:

* Rufus
* Ventoy
* Media Creation Tool

Porque o `.bat` sozinho possui limitações para tornar a instalação totalmente automática.

---

# Site oficial Microsoft

## Windows 10

[https://www.microsoft.com/software-download/windows10](https://www.microsoft.com/software-download/windows10)

## Windows 11

[https://www.microsoft.com/software-download/windows11](https://www.microsoft.com/software-download/windows11)

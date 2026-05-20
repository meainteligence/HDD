# PowerShell Avançado — Gerenciador de Discos + Boot Windows

⚠️ AVISO:

Este projeto usa comandos administrativos reais.

Ele consegue:

* Detectar discos automaticamente
* Detectar pendrive USB
* Mostrar tamanho do disco
* Mostrar temperatura SMART
* Confirmar disco antes de apagar
* Formatar com segurança
* Preparar boot UEFI
* Montar ISO automaticamente
* Copiar arquivos automaticamente
* Verificar erros
* Criar logs

Execute como ADMINISTRADOR.

---

# Arquivo: sistema.ps1

```powershell
# ======================================
# SISTEMA WINDOWS TOOL
# ======================================

Clear-Host
$Host.UI.RawUI.WindowTitle = "Windows Tool"

function Menu {
    Clear-Host

    Write-Host "=========================================" -ForegroundColor Green
    Write-Host "        WINDOWS DISK TOOL"
    Write-Host "=========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1] Listar discos"
    Write-Host "[2] Ver temperatura SMART"
    Write-Host "[3] Formatar disco"
    Write-Host "[4] Limpar disco completo"
    Write-Host "[5] Criar pendrive bootavel"
    Write-Host "[6] Baixar Windows 10"
    Write-Host "[7] Baixar Windows 11"
    Write-Host "[0] Sair"
    Write-Host ""

    $opcao = Read-Host "Escolha"

    switch ($opcao) {
        "1" { ListarDiscos }
        "2" { SMART }
        "3" { Formatar }
        "4" { Limpar }
        "5" { Boot }
        "6" { Start-Process "https://www.microsoft.com/software-download/windows10" }
        "7" { Start-Process "https://www.microsoft.com/software-download/windows11" }
        "0" { exit }
    }

    Pause
    Menu
}

# ======================================
# LISTAR DISCOS
# ======================================

function ListarDiscos {

    Clear-Host

    Write-Host "DISCOS DETECTADOS" -ForegroundColor Cyan
    Write-Host ""

    Get-Disk | Format-Table Number, FriendlyName, Size, PartitionStyle, BusType
}

# ======================================
# SMART / TEMPERATURA
# ======================================

function SMART {

    Clear-Host

    Write-Host "STATUS SMART" -ForegroundColor Yellow
```

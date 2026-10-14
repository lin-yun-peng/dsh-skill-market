<#
  在市场的货架上新建一个技能骨架。
  用法:
    powershell -ExecutionPolicy Bypass -File 新建技能.ps1 -Name my-skill -Description '一句话说明'
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)][string]$Name,
  [Parameter(Mandatory = $true, Position = 1)][string]$Description
)

$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false) } catch { }

# 本脚本在 货架\skill-maker\scripts\，往上三级就是 货架
$Shelf = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

if ($Name -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
  Write-Host ('技能名必须是小写 kebab-case，例如 my-skill。收到: ' + $Name)
  exit 1
}

$Dir = Join-Path $Shelf $Name
if (Test-Path -LiteralPath $Dir) {
  Write-Host ('已经存在: ' + $Dir)
  exit 1
}

New-Item -ItemType Directory -Path (Join-Path $Dir 'scripts') -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $Dir 'references') -Force | Out-Null

$template = @'
---
name: __NAME__
description: __DESC__
---

# __NAME__

## 什么时候用

（写清楚触发条件。这一节越具体，AI 越容易在该用的时候用上。）

## 怎么做

（写步骤、能直接复制的命令、容易踩的坑。）
'@

$body = $template.Replace('__NAME__', $Name).Replace('__DESC__', $Description)
$file = Join-Path $Dir 'SKILL.md'
[System.IO.File]::WriteAllText($file, $body, [System.Text.UTF8Encoding]::new($false))

Write-Host ('已创建: ' + $file)
Write-Host ('下一步: 编辑 SKILL.md，然后 cd 到 工具 目录执行  .\skill-market.cmd install ' + $Name)
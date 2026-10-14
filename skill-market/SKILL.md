---
name: skill-market
description: 本机 DSH 技能市场的使用手册。当用户提到技能市场、装个技能、卸载技能、有没有能做某事的技能，或问到 skill 市场相关操作时，加载本技能。里面写明市场路径、管理脚本命令和技能格式。
whenToUse: 用户想安装、卸载、查找、制作 DSH 技能，或问「有没有能做 X 的技能」时。
---

# 技能市场

## 市场在哪

根目录 `F:\ai agent data\deepseek\skill市场`，里面有四样东西：

| 目录 | 含义 |
| --- | --- |
| `货架\` | 所有可安装的技能，同时是 Git 仓库 |
| `已安装\` | 已经装上的技能 |
| `工具\skill-market.cmd` | 管理脚本 |
| `权限修复记录\` | 修权限时的备份，不要动 |

## 发现机制

DSH 默认扫描用户级技能根目录 `C:\Users\Lenovo\.dsh\skills`，它是指向 `已安装\` 的目录快捷方式。
新增、改名、删除技能会被自动监视，**不需要重启 DSH**。只认一层：`<根>\<技能名>\SKILL.md`。

## 管理命令

```powershell
cd 'F:\ai agent data\deepseek\skill市场\工具'
pwsh -File .\skill-market.cmd list
pwsh -File .\skill-market.cmd search <关键词>
pwsh -File .\skill-market.cmd install <技能名> [更多技能名...]
pwsh -File .\skill-market.cmd install all
pwsh -File .\skill-market.cmd remove <技能名>
pwsh -File .\skill-market.cmd sync
pwsh -File .\skill-market.cmd publish
pwsh -File .\skill-market.cmd 索引
pwsh -File .\skill-market.cmd doctor
```

## 技能格式

目录 bundle：`<技能名>\SKILL.md`，加可选的 `scripts\`、`references\`、`assets\`。开头必须是 YAML frontmatter：

```yaml
---
name: kebab-case-名字
description: 一句话说明它做什么、什么时候用
whenToUse: 可选，触发条件
---
```

`name` 必须是小写 kebab-case。文件夹名可以是中文，但 frontmatter 的 `name` 必须是英文。

## 注意

- 安装是**目录快捷方式**，不是复制：改货架上的技能，已安装的立刻跟着变。
- 卸载只删快捷方式，货架上的真身不动。要用 `skill-market.cmd remove`，直接删文件夹有风险。
- 技能正文写给 AI 看，用中文写清楚步骤和坑。
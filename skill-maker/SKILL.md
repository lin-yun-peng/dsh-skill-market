---
name: skill-maker
description: 教你把一份做法固化成 DSH 技能，包括目录结构、SKILL.md 的 frontmatter 写法、description 怎么写才容易被触发，以及装进技能市场的流程。当用户说「做个技能」「把这个流程存成技能」「以后都按这个来」时使用。
whenToUse: 用户要新建、修改、调试一个 DSH 技能，或想把重复的工作流程固化下来时。
---

# 做一个新技能

## 什么时候值得做成技能

同一个做法要重复用、每次都要跟 AI 重新解释一遍的，就值得。一次性任务不值得。

## 最小结构

```
货架\<技能名>\
  SKILL.md          必须，正文写给 AI 看
  scripts\          可选，可执行脚本
  references\       可选，参考资料
  assets\           可选，模板、图片等
```

## SKILL.md 的 frontmatter

```yaml
---
name: my-skill
description: 做什么 + 什么时候用。这一行决定 AI 会不会加载它，要写具体。
whenToUse: 可选，进一步限定触发场景
---
```

硬性要求：

- `name` 必须小写 kebab-case，只能有字母、数字、连字符，且要和文件夹名一致。
- `description` 必填。写得含糊，技能就永远不会被触发，这是最常见的失败原因。
- 开头三横线必须顶格，前后不能有空行。

`description` 写法对比：

| 差的写法 | 好的写法 |
| --- | --- |
| 处理文档 | 读写 Word 文档（.docx），包括报告、信函和表格；当输入或交付物是 docx 时使用 |

## 正文怎么写

写成给新同事的操作说明：先说什么时候用、边界在哪，再给步骤和能直接复制的命令。
路径要写绝对路径，或说清相对谁。把容易踩的坑写进去，这是技能最大的价值。

## 建一个新技能

```powershell
powershell -ExecutionPolicy Bypass -File 'F:\ai agent data\deepseek\skill市场\货架\skill-maker\scripts\新建技能.ps1' -Name my-skill -Description '一句话说明什么时候用它'
```

然后编辑生成的 `SKILL.md`，再装进市场：

```powershell
cd 'F:\ai agent data\deepseek\skill市场\工具'
.\skill-market.cmd install my-skill
.\skill-market.cmd index
```

## 调试：技能没被用上怎么办

按顺序查：

1. `已安装\<技能名>\SKILL.md` 存在吗（`.\skill-market.cmd doctor` 会查）。
2. frontmatter 的 `---` 顶格了吗，`name` 是 kebab-case 吗。
3. `description` 是不是太笼统。
4. 换成更明确的触发词再试。DSH 下一轮就刷新目录，不用重启。

## 注意

- 市场只扫描一层，不要在建好的技能文件夹里再套技能文件夹。
- 技能正文是给 AI 读的，写清楚怎么做，而不是写给人看的介绍。
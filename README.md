# universal-handoff

个人级通用 Codex Skill，用当前项目的 `.ai/HANDOFF.md` 做跨窗口交接。

## 安装

把这个仓库地址发给 Codex，并让它运行对应系统的安装脚本即可。

Windows PowerShell：

```powershell
.\install.ps1
```

macOS / Linux：

```bash
bash install.sh
```

安装脚本会：

- 复制 `universal-handoff/SKILL.md` 到个人目录 `.agents/skills/universal-handoff/SKILL.md`
- 创建或更新个人全局规则 `.codex/AGENTS.md`
- 如果 `# Universal Handoff Rules` 已存在，则不会重复追加

## 使用

在任意项目里保存进度：

```text
交接
```

或：

```text
保存进度
```

它会更新当前项目的：

```text
.ai/HANDOFF.md
```

新窗口继续时，先打开同一个项目目录，然后输入：

```text
续上
```

## 多项目说明

每个项目都有自己的交接文件：

```text
A项目/.ai/HANDOFF.md
B项目/.ai/HANDOFF.md
```

交接文件会记录：

```text
Project path: <当前项目绝对路径>
```

续上时会先核对 `Project path` 是否匹配当前项目目录，避免在错误项目里继续。

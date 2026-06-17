---
name: universal-handoff
description: 当用户说“交接”“更新交接”“生成交接”“开新窗”“准备新窗口”“上下文快满了”“压缩前保存”“保存进度”“保存开发进度”时，必须使用此 skill 在当前项目中实际创建或更新 .ai/HANDOFF.md；不得只总结、不得只建议保存路径、不得写到 docs/HANDOFF.md。不要在用户说“续上”“继续”“接着做”“按交接继续”“继续上次”时使用此 skill，这些情况只读取当前项目的 .ai/HANDOFF.md，先核对 Project path 是否匹配当前项目目录，再继续执行。
---

# Universal Handoff Skill

这是个人级通用 Codex Skill，适用于任何项目。

目标：维护当前项目的 `.ai/HANDOFF.md`，让新窗口可以继续开发，不依赖被压缩的聊天上下文。

## 硬性规则

触发“交接”时，必须实际写入文件，不能只在回复里展示内容。

必须使用且只能默认使用当前项目目录下的：

```text
.ai/HANDOFF.md
```

除非用户明确指定其它路径，否则禁止写到：

- `docs/HANDOFF.md`
- `HANDOFF.md`
- `a_share_tail_ai/docs/HANDOFF.md`
- 当前项目之外的任意路径

不需要询问“是否保存”。用户输入“交接”等口令本身就表示要保存。

如果 `.ai/` 不存在，先创建 `.ai/` 目录，再写入 `.ai/HANDOFF.md`。

如果因为权限、沙箱或其它错误无法写入，必须明确告诉用户“未写入”，并给出失败原因和目标绝对路径。不能假装已经完成。

完成回复必须包含：

```text
已写入: <当前项目绝对路径>/.ai/HANDOFF.md
验证: 文件存在
```

## 口令

### 交接

用户输入以下内容时触发：

- 交接
- 更新交接
- 生成交接
- 开新窗
- 准备新窗口
- 上下文快满了
- 压缩前保存
- 保存进度
- 保存开发进度

执行：

1. 确认当前项目根目录。
2. 盘点项目，不准直接总结。
3. 创建目录：`<当前项目>/.ai/`。
4. 创建或更新文件：`<当前项目>/.ai/HANDOFF.md`。
5. 在 HANDOFF 中写入当前项目绝对路径：`Project path: <当前项目绝对路径>`。
6. 只记录后续开发必须知道的信息。
7. 不修改业务代码，除非用户明确要求。
8. 写完后重新检查 `.ai/HANDOFF.md` 是否存在。
9. 最后告诉用户：新窗口输入“续上”即可继续。

### 续上

用户输入以下内容时不要触发本 Skill：

- 续上
- 继续
- 接着做
- 按交接继续
- 继续上次

执行：

1. 只读取当前项目 `.ai/HANDOFF.md`。
2. 先核对 `.ai/HANDOFF.md` 中的 `Project path` 是否和当前项目目录一致。
3. 如果 `Project path` 不一致，停止继续并提醒用户切换到正确项目目录，不能按错误项目的 HANDOFF 继续。
4. 如果 `Project path` 缺失，提示用户该交接文档缺少项目路径，需要人工确认当前目录是否正确。
5. 按“下一步动作”继续。
6. 不重新总结。
7. 不更新 `.ai/HANDOFF.md`。
8. 修改文件前先检查当前文件状态。

如果 `.ai/HANDOFF.md` 不存在，提示用户先输入“交接”。

## 交接前必须盘点

触发“交接”时，尽量检查：

- 当前项目 `AGENTS.md`
- 旧 `.ai/HANDOFF.md`
- `README.md`
- `docs/`
- 项目配置文件：`package.json`、`requirements.txt`、`pyproject.toml`、`go.mod`、`Cargo.toml`、`tsconfig.json`、`vite.config.*`、`next.config.*`、`Dockerfile`
- `git status --short`
- `git diff --stat`
- `git diff`
- `git diff --staged`
- TODO / FIXME / NOTE / HACK / 待办 / 注意 / 不要改 / 禁止 / 兼容 / 报错 / 风险

如果某一步无法执行，写入“待确认事项”，不能假装已检查。

## 信息来源

重要信息后面标注来源：

- 用户明确要求
- 旧 HANDOFF
- AGENTS.md
- git diff
- git status
- 代码文件
- README / docs
- 测试结果
- 报错信息
- 待确认

不要把猜测写成事实。不确定就标注“待确认”。

## 敏感信息记录规则

交接文档要保留后续开发必须知道的连接和部署信息，但不能泄露秘密正文。

必须记录但可按来源标注：

- 网站地址、管理后台地址、API 地址
- 服务器 IP、域名、端口
- SSH 用户名、连接别名、SSH 命令结构
- SSH 私钥文件路径、配置文件路径、证书文件路径
- 部署目录、日志目录、配置文件位置
- 数据库主机、端口、库名、非秘密用户名
- 环境变量名、密钥用途、密钥存放位置
- 用户发给窗口且后续继续工作需要的信息

禁止明文写入：

- 密码
- API key
- token
- cookie / session
- 私钥正文
- 恢复码、验证码、一次性口令

如果用户已经在聊天里提供了秘密值，只记录用途和存放位置，不复制秘密正文。例如：

```md
- SSH 主机：1.2.3.4（用户明确要求）
- SSH 用户：ubuntu（用户明确要求）
- 私钥路径：C:\Users\Yuzzy\.ssh\server.pem（用户明确要求）
- 注意：用户曾提供过私钥/密码类敏感信息，HANDOFF 不记录明文；如需使用，请回到安全存放位置读取。
```

如果不确定某条信息是否敏感，按敏感处理：保留上下文、用途和位置，隐藏秘密值本身。

## HANDOFF 模板

更新 `.ai/HANDOFF.md` 时使用：

```md
# Project Handoff

Last updated: YYYY-MM-DD HH:mm
Handoff status: ready_for_resume
Project path: <当前项目绝对路径>

Do not regenerate handoff on resume unless user explicitly asks.

## 1. 当前目标

## 2. 用户明确要求

## 3. 禁止修改 / 高风险区域

## 4. 已完成工作

## 5. 当前项目状态

## 6. 本轮改动文件

## 7. 关键实现说明

## 8. 已知问题 / 未完成事项

## 9. 待确认事项

## 10. 未归类但可能重要

## 11. 相关文件

## 11.1 连接 / 部署 / 外部资源信息

记录网站、IP、SSH、部署目录、密钥文件路径等后续必须知道的信息。不要写入密码、token、API key、私钥正文。

## 12. 验证清单

## 13. 下一步动作

## 14. 漏项自检结果

需确认已检查：

- 旧 HANDOFF
- 用户明确要求
- git status
- git diff
- TODO / FIXME / NOTE
- 报错信息
- 未完成事项
- 禁止修改项
- Project path
- 连接 / 部署 / 外部资源信息
- 敏感信息未写入明文
- `.ai/HANDOFF.md` 已实际写入

## 15. 新窗口启动口令

新窗口只需要输入：

> 续上
```

## 防漏规则

写完 `.ai/HANDOFF.md` 后必须自检：

* 旧 HANDOFF 的未完成事项是否保留
* 用户明确要求是否写入
* 禁止修改项是否写入
* git diff 文件是否写入
* 报错、测试失败、未验证内容是否写入
* 下一步动作是否具体
* 用户提过的网站、IP、SSH、部署目录、密钥文件路径是否保留
* 密码、token、API key、私钥正文是否未写入明文
* Project path 是否写入且为当前项目绝对路径
* 文件是否真的存在于当前项目 `.ai/HANDOFF.md`
* 是否误写到了 `docs/HANDOFF.md` 或其它路径
* 是否把猜测写成事实
* 是否把未确认内容写成已完成

发现漏项必须补充。

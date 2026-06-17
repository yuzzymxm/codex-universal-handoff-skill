---
name: universal-handoff
description: 当用户说“交接”“更新交接”“生成交接”“开新窗”“准备新窗口”“上下文快满了”“压缩前保存”“保存进度”“保存开发进度”时，使用此 skill 在当前项目中创建或更新 .ai/HANDOFF.md。不要在用户说“续上”“继续”“接着做”“按交接继续”“继续上次”时使用此 skill，这些情况只读取当前项目的 .ai/HANDOFF.md，先核对 Project path 是否匹配当前项目目录，再继续执行。
---

# Universal Handoff Skill

这是个人级通用 Codex Skill，适用于任何项目。

目标：维护当前项目的 `.ai/HANDOFF.md`，让新窗口可以继续开发，不依赖被压缩的聊天上下文。

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

1. 创建或更新当前项目 `.ai/HANDOFF.md`。
2. 先盘点项目，不准直接总结。
3. 在 HANDOFF 中写入当前项目绝对路径：`Project path: <当前项目绝对路径>`。
4. 只记录后续开发必须知道的信息。
5. 不修改业务代码，除非用户明确要求。
6. 最后告诉用户：新窗口输入“续上”即可继续。

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
* Project path 是否写入且为当前项目绝对路径
* 是否把猜测写成事实
* 是否把未确认内容写成已完成

发现漏项必须补充。

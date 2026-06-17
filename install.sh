#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_skill="$repo_root/universal-handoff"
target_skill="$HOME/.agents/skills/universal-handoff"
agents_path="$HOME/.codex/AGENTS.md"

if [[ ! -f "$source_skill/SKILL.md" ]]; then
  echo "Cannot find universal-handoff/SKILL.md next to install.sh." >&2
  exit 1
fi

mkdir -p "$target_skill"
cp "$source_skill/SKILL.md" "$target_skill/SKILL.md"

mkdir -p "$(dirname "$agents_path")"
touch "$agents_path"

if ! grep -q '^# Universal Handoff Rules[[:space:]]*$' "$agents_path"; then
  cat >> "$agents_path" <<'EOF'

# Universal Handoff Rules

所有项目统一使用当前项目目录下的：

`.ai/HANDOFF.md`

作为跨窗口交接文档。

`.ai/HANDOFF.md` 是跨窗口继续工作的事实源，不要依赖被压缩的聊天上下文恢复项目状态。

## 交接

当用户输入：

- 交接
- 更新交接
- 生成交接
- 开新窗
- 准备新窗口
- 上下文快满了
- 压缩前保存
- 保存进度
- 保存开发进度

含义是：

1. 使用 `universal-handoff` Skill。
2. 在当前项目中创建或更新 `.ai/HANDOFF.md`。
3. 先执行项目盘点，不准直接总结。
4. 写入当前项目绝对路径：`Project path: <当前项目绝对路径>`。
5. 只记录后续开发必须知道的信息。
6. 不总结完整聊天记录。
7. 不修改业务代码，除非用户明确要求。
8. 完成后告诉用户：新窗口输入“续上”即可继续。

## 续上

当用户输入：

- 续上
- 继续
- 接着做
- 按交接继续
- 继续上次

含义是：

1. 检查当前项目是否存在 `.ai/HANDOFF.md`。
2. 如果存在，读取 `.ai/HANDOFF.md`。
3. 先核对 `Project path` 是否和当前项目目录一致。
4. 如果 `Project path` 不一致，停止继续并提醒用户切换到正确项目目录。
5. 如果 `Project path` 缺失，提示用户该交接文档缺少项目路径，需要人工确认当前目录是否正确。
6. 按照 `.ai/HANDOFF.md` 的“下一步动作”继续。
7. 不重新总结。
8. 不更新 `.ai/HANDOFF.md`。
9. 不调用 `universal-handoff`。
10. 修改文件前，先检查当前文件状态，避免覆盖已有改动。

如果 `.ai/HANDOFF.md` 不存在，提示用户当前项目还没有交接文档，并建议输入“交接”。

## 交接防漏规则

当用户输入“交接”“保存进度”“保存开发进度”时，必须先盘点项目，再更新 `.ai/HANDOFF.md`。

交接文档必须覆盖：

- 用户明确要求
- 禁止修改项
- 已完成工作
- 本轮改动文件
- git status
- git diff
- 未完成事项
- 已知问题
- 待确认事项
- 验证清单
- 下一步动作
- Project path

如果信息不确定，必须写“待确认”，不能猜。

如果信息不知道放哪里，写入“未归类但可能重要”，不能丢弃。

## 防止反复交接

用户输入“续上”“继续”“接着做”“按交接继续”时，只读取 `.ai/HANDOFF.md` 并继续。

不要再次生成交接。

只有用户明确输入“交接”“更新交接”“保存进度”“保存开发进度”时，才更新 `.ai/HANDOFF.md`。
EOF
  echo "Installed universal-handoff and appended Universal Handoff Rules."
else
  echo "Installed universal-handoff. Universal Handoff Rules already exist; skipped append."
fi

echo "Skill: $target_skill"
echo "Rules: $agents_path"

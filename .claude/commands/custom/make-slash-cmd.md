---
description: "交互式创建 Claude Code slash-command"
---

# Claude Code Slash-Commands 创建器

## 什么是 Slash-Commands

Slash-commands 是 Claude Code 的特殊命令，允许用户控制 Claude 的行为。格式：`/command-name [arguments]`

**存储位置**：
- 项目级别：`.claude/commands/` (与团队共享)
- 个人级别：`~/.claude/commands/` (个人使用)

**文件格式**：Markdown 文件，文件名为 `command-name.md`

## 支持的功能

1. **参数占位符**：`$ARGUMENTS` - 接收用户输入的参数
2. **Bash 命令**：`!command` - 执行 shell 命令  
3. **文件引用**：`@filename` - 引用文件内容
4. **Frontmatter**：YAML 格式的元数据配置
5. **Extended thinking**：支持深度思考关键字

## 文件结构示例

```markdown
---
description: "命令描述"
thinking: true  # 可选：启用扩展思考
---

你的提示内容在这里。

使用 $ARGUMENTS 获取用户输入的参数。

需要执行命令时：
!ls -la

需要读取文件时：
@package.json
```

## 交互式创建流程

**用户输入**：$ARGUMENTS

**我的任务**：
1. **分析用户描述**，理解想要实现的功能
2. **智能推荐命令名**：根据功能推荐 2-3 个简洁的命令名选项
3. **生成具体实现**：直接创建最合适的 markdown 文件内容
4. **等待用户确认**：用户同意后才创建文件

**交互示例**：
```
用户：/make-slash-cmd 我想要一个检查代码风格的命令
我：根据您的描述，我推荐：
    命令名：/check-style 或 /lint-code 或 /style
    实现：[展示完整 markdown 内容]
    是否确认创建？
```

**现在开始**：

请告诉我您想要创建什么功能的 slash-command，我将推荐命令名、生成完整实现、等待确认后创建。

**用户需求描述**：$ARGUMENTS
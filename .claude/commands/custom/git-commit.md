---
description: "智能分析git变更并创建Conventional Commits风格的commit消息"
---

分析当前git变更并创建符合Conventional Commits规范的commit消息。

**参数处理:**
- 如果参数以@开头或包含路径（如 @frontend/ 或 frontend/），先切换到该目录
- 如果参数包含"push"，commit后推送到远程
- 支持自定义消息格式

**执行步骤:**
1. 解析参数，处理目录切换
2. 检查git状态和变更内容
3. 分析变更类型，生成Conventional Commits格式消息
4. 创建commit
5. 可选推送

**重要要求:**
- 使用中文书写commit消息

**Conventional Commits格式:**
- `feat:` 新增功能
- `fix:` 修复bug
- `docs:` 文档变更
- `style:` 代码格式调整（不影响功能）
- `refactor:` 代码重构
- `test:` 测试相关
- `chore:` 构建工具、依赖管理等
- `perf:` 性能优化
- `ci:` CI/CD相关

**参数示例:**
- `@frontend/` - 在frontend目录操作
- `@api/ push` - 在api目录操作并推送  
- `push` - 当前目录操作并推送

参数: $ARGUMENTS
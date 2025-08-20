---
allowed-tools: [Read, Grep, Glob]
description: "智能分析项目中的无用函数代码"
---

# /find-dead-code - 智能Dead Code分析

## 功能
对指定文件进行智能dead code分析，通过深层上下文分析识别真正未使用的函数，而不是简单的字符串匹配。

## 使用方法
```
/find-dead-code <file-path> [--format text|json] [--include-exports]
```

## 参数
- `file-path` - 要分析的目标文件（必需）
- `--format` - 输出格式（text, json），默认：text
- `--include-exports` - 是否包含导出函数（可能被外部使用）

## 智能分析策略

### 1. 上下文分析
- **真实调用 vs 仅引用**：区分 `foo()` （真实调用）和 `const x = foo`（仅引用）
- **引用后使用检查**：分析引用的变量是否真的被使用
- **调用模式识别**：识别不同的调用方式（直接调用、方法调用、回调等）

### 2. 调用链分析
- **递归检查**：如果函数A只被函数B调用，而B也是dead code，则A也是dead code
- **调用链追踪**：分析整个调用链的活跃性
- **依赖关系图**：构建函数间的依赖关系进行综合判断

### 3. 导出函数特殊处理
- **导出函数标注**：被export的函数可能被外部使用，单独标注
- **模块边界分析**：检查跨模块的真实使用情况
- **公共API识别**：区分内部函数和可能的公共API

## 执行流程
1. 读取目标文件，提取函数定义
2. 对每个函数进行项目范围内的智能引用分析
3. 应用上下文分析和调用链分析
4. 生成详细的分析报告，包含：
   - 确认的dead code
   - 可疑的dead code（需要人工确认）
   - 导出函数的使用情况
5. 提供具体的清理建议

## 支持语言
自动识别常见函数定义模式：
- JavaScript/TypeScript: `function name`, `const name =`, `name: function`, `name() {}`
- Python: `def name(`
- Java/C#: `type name(`  
- Go: `func name(`
- 其他语言的通用模式

参数: $ARGUMENTS
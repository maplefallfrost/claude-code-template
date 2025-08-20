---
allowed-tools: [Read, Grep, Glob]
description: "Analyze unused functions in specified file across the project"
---

# /sc:dead-code - Dead Code Analysis

## Purpose
Identify unused functions in a specified file by analyzing function definitions and searching for references across the entire project.

## Usage
```
/sc:dead-code <file-path> [--format text|json] [--include-exports]
```

## Arguments
- `file-path` - Target file to analyze for dead functions (required)
- `--format` - Output format (text, json) - default: text
- `--include-exports` - Include exported functions in analysis (may be used externally)

## Execution
1. Read target file and extract function definitions using language-agnostic patterns
2. For each function, search project-wide for references excluding the definition line
3. Identify functions with zero references as dead code
4. Generate comprehensive report with function locations and usage statistics
5. Provide actionable cleanup recommendations

## Claude Code Integration
- Uses Read for target file content analysis
- Leverages Grep for function pattern extraction and reference searching
- Applies Glob for project-wide file discovery when needed
- Maintains clean, structured dead code reporting

## Detection Patterns
Automatically detects common function definition patterns across languages:
- JavaScript: `function name`, `const name =`, `name: function`
- Python: `def name(`
- Java/C#: `type name(`
- Go: `func name(`
- And other common patterns without language-specific parsing
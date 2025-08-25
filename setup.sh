#!/bin/bash

# Claude Code Template Setup Script
# 将当前仓库的.claude/commands目录内容安装到用户的~/.claude目录

set -e  # 遇到错误时退出

show_help() {
    echo "使用方法: $0 [install|uninstall]"
    echo ""
    echo "命令:"
    echo "  install     安装Claude Code自定义命令到~/.claude"
    echo "  uninstall   删除已安装的自定义命令文件（可选恢复备份）"
    echo ""
}

install() {
    echo "🚀 开始安装 Claude Code 自定义命令..."

    # 检查当前目录是否包含.claude/commands目录
    if [ ! -d ".claude/commands" ]; then
        echo "❌ 错误: 当前目录下没有找到.claude/commands目录"
        echo "请确保在claude-code-template项目根目录下运行此脚本"
        exit 1
    fi

    # 备份现有的~/.claude目录（如果存在）
    if [ -d "$HOME/.claude" ]; then
        echo "📦 备份现有的~/.claude到~/.claude.backup"
        rm -rf "$HOME/.claude.backup"  # 删除旧备份（如果存在）
        cp -r "$HOME/.claude" "$HOME/.claude.backup"
        echo "✅ 备份完成"
    fi

    # 创建目标目录（如果不存在）
    mkdir -p "$HOME/.claude/commands"
    mkdir -p "$HOME/.claude/agents"

    # 复制.claude/commands目录内容
    echo "📋 复制.claude/commands目录内容到~/.claude/commands/"
    cp -r .claude/commands/* "$HOME/.claude/commands/"

    # 复制agents目录内容（如果存在）
    if [ -d "agents" ]; then
        echo "📋 复制agents目录内容到~/.claude/agents/"
        cp -r agents/* "$HOME/.claude/agents/"
    fi

    echo "✅ 安装完成！"
}

uninstall() {
    echo "🔄 开始卸载 Claude Code 自定义命令..."

    # 检查当前项目是否包含.claude/commands目录
    if [ ! -d ".claude/commands" ]; then
        echo "❌ 错误: 当前目录下没有找到.claude/commands目录"
        echo "请确保在claude-code-template项目根目录下运行此脚本"
        exit 1
    fi

    # 删除项目中存在的命令文件
    echo "🗑️  删除已安装的自定义命令文件..."
    
    # 遍历项目中的commands文件，删除对应的已安装文件
    find .claude/commands -type f -name "*.md" | while read -r file; do
        # 获取相对路径（去掉.claude/前缀）
        relative_path="${file#.claude/}"
        target_file="$HOME/.claude/$relative_path"
        
        if [ -f "$target_file" ]; then
            echo "  删除: ~/.claude/$relative_path"
            rm -f "$target_file"
        fi
    done

    # 遍历项目中的agents文件，删除对应的已安装文件
    if [ -d "agents" ]; then
        find agents -type f -name "*.md" | while read -r file; do
            target_file="$HOME/.claude/$file"
            
            if [ -f "$target_file" ]; then
                echo "  删除: ~/.claude/$file"
                rm -f "$target_file"
            fi
        done
    fi

    # 清理空的custom目录（但保留commands目录）
    if [ -d "$HOME/.claude/commands/custom" ] && [ -z "$(ls -A "$HOME/.claude/commands/custom")" ]; then
        echo "  清理空目录: ~/.claude/commands/custom"
        rmdir "$HOME/.claude/commands/custom"
    fi

    echo "✅ 卸载完成！"
}

# 主逻辑
case "${1:-}" in
    "install")
        install
        ;;
    "uninstall")
        uninstall
        ;;
    "-h"|"--help"|"help")
        show_help
        ;;
    "")
        echo "❌ 错误: 请指定操作 (install 或 uninstall)"
        show_help
        exit 1
        ;;
    *)
        echo "❌ 错误: 未知命令 '$1'"
        show_help
        exit 1
        ;;
esac
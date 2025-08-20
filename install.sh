#!/bin/bash

# Claude Code Template Installation Script
# 将当前仓库的.claude目录内容安装到用户的~/.claude目录

set -e  # 遇到错误时退出

show_help() {
    echo "使用方法: $0 [install|uninstall]"
    echo ""
    echo "命令:"
    echo "  install     安装Claude Code自定义命令到~/.claude"
    echo "  uninstall   从备份恢复原有的~/.claude配置"
    echo ""
}

install() {
    echo "🚀 开始安装 Claude Code 自定义命令..."

    # 检查当前目录是否包含.claude目录
    if [ ! -d ".claude" ]; then
        echo "❌ 错误: 当前目录下没有找到.claude目录"
        echo "请确保在claude-code-template项目根目录下运行此脚本"
        exit 1
    fi

    # 备份现有的~/.claude目录（如果存在）
    if [ -d "$HOME/.claude" ]; then
        echo "📦 备份现有的~/.claude到~/.claude.backup"
        rm -rf "$HOME/.claude.backup"  # 删除旧备份（如果存在）
        cp -r "$HOME/.claude" "$HOME/.claude.backup"
        echo "✅ 备份完成"
    else
        echo "📁 ~/.claude目录不存在，将创建新目录"
    fi

    # 创建目标目录（如果不存在）
    mkdir -p "$HOME/.claude"

    # 复制.claude目录内容
    echo "📋 复制.claude目录内容到~/.claude/"
    cp -r .claude/* "$HOME/.claude/"

    echo "✅ 安装完成！"
}

uninstall() {
    echo "🔄 开始卸载 Claude Code 自定义命令..."

    # 检查备份是否存在
    if [ ! -d "$HOME/.claude.backup" ]; then
        echo "❌ 错误: 没有找到备份目录~/.claude.backup"
        echo "无法恢复原有配置"
        exit 1
    fi

    # 删除当前的~/.claude
    if [ -d "$HOME/.claude" ]; then
        echo "🗑️  删除当前的~/.claude目录"
        rm -rf "$HOME/.claude"
    fi

    # 恢复备份
    echo "📦 从~/.claude.backup恢复原有配置"
    cp -r "$HOME/.claude.backup" "$HOME/.claude"

    echo "✅ 卸载完成，已恢复原有配置！"
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
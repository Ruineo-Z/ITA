#!/bin/bash

# ITA 角色资源同步脚本
# 将当前项目的 role 目录同步到 ~/.promptx/resource/role/ita

# 获取脚本所在目录（项目根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 源目录和目标目录
SOURCE_DIR="${SCRIPT_DIR}/role"
TARGET_DIR="${HOME}/.promptx/resource/role/ita"

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ 错误: 源目录不存在: $SOURCE_DIR"
    exit 1
fi

# 创建目标目录（如果不存在）
mkdir -p "$TARGET_DIR"

# 同步文件（使用 rsync 保持目录结构，删除目标中多余的文件）
echo "📦 正在同步 ITA 角色资源..."
echo "   源目录: $SOURCE_DIR"
echo "   目标目录: $TARGET_DIR"

# 先清空目标目录，再复制（确保删除的文件也被同步）
rm -rf "$TARGET_DIR"/*
cp -R "$SOURCE_DIR"/* "$TARGET_DIR"/

if [ $? -eq 0 ]; then
    echo "✅ 同步完成!"
    echo ""
    echo "📁 已同步的文件:"
    find "$TARGET_DIR" -type f -name "*.md" | while read file; do
        echo "   - ${file#$TARGET_DIR/}"
    done
else
    echo "❌ 同步失败!"
    exit 1
fi
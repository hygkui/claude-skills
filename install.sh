#!/bin/bash

# =================================================================
# Claude Skills 一键安装脚本
# 作用：自动将本仓库中的 skills 复制到 Claude 的技能目录中
# =================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检测操作系统
OS_TYPE="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="mac"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="windows"
fi

# 定义目标路径
OPENCODE_DIR="$HOME/.config/opencode/skill"
CLAUDE_DIR="$HOME/.claude/skills"

# 自动检测环境
HAS_OPENCODE=false
HAS_CLAUDE=false
[[ -d "$HOME/.config/opencode" ]] && HAS_OPENCODE=true
[[ -d "$HOME/.claude" ]] && HAS_CLAUDE=true

# 智能识别默认目标
DEFAULT_CHOICE="1"
if $HAS_OPENCODE && $HAS_CLAUDE; then
    DEFAULT_CHOICE="3"
elif $HAS_OPENCODE; then
    DEFAULT_CHOICE="2"
fi

# 交互式选择安装目标（带 5 秒倒计时自动识别）
echo -e "${BLUE}环境检测中...${NC}"
[[ "$HAS_CLAUDE" == "true" ]] && echo -e "  [√] 发现 Claude Code 环境"
[[ "$HAS_OPENCODE" == "true" ]] && echo -e "  [√] 发现 OpenCode 环境"

echo -e "\n${BLUE}请确认安装目标 [5 秒后将根据检测结果自动执行]:${NC}"
echo -e "1) Claude Code (~/.claude/skills) $([[ "$DEFAULT_CHOICE" == "1" ]] && echo "[默认]")"
echo -e "2) OpenCode    (~/.config/opencode/skill) $([[ "$DEFAULT_CHOICE" == "2" ]] && echo "[默认]")"
[[ "$HAS_CLAUDE" == "true" && "$HAS_OPENCODE" == "true" ]] && echo -e "3) 全部安装 (Both) $([[ "$DEFAULT_CHOICE" == "3" ]] && echo "[默认]")"

read -t 5 -p "请输入选项 (1/2/3): " choice || choice="$DEFAULT_CHOICE"
echo "" # 换行

# 定义实际要安装的目标数组
TARGET_DIRS=()
case $choice in
    2)
        TARGET_DIRS+=("$OPENCODE_DIR")
        echo -e "${BLUE}目标已确认为: OpenCode${NC}"
        ;;
    3)
        TARGET_DIRS+=("$CLAUDE_DIR" "$OPENCODE_DIR")
        echo -e "${BLUE}目标已确认为: 全部安装 (Claude & OpenCode)${NC}"
        ;;
    *)
        TARGET_DIRS+=("$CLAUDE_DIR")
        echo -e "${BLUE}目标已确认为: Claude Code${NC}"
        ;;
esac

# 确保所有目标目录都存在
for target in "${TARGET_DIRS[@]}"; do
    if [ ! -d "$target" ]; then
        echo -e "正在创建技能目录: $target"
        mkdir -p "$target"
    fi
done

# 获取当前脚本所在目录
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 遍历仓库中的所有文件夹（假设每个文件夹是一个 skill）
# 排除 .git 和 README 等非技能目录
for dir in "$SOURCE_DIR"/*/; do
    dir=${dir%*/}
    dirname=$(basename "$dir")
    
    # 过滤掉隐藏目录和已知非技能目录
    if [[ "$dirname" == "."* ]] || [[ "$dirname" == "scripts" ]] || [[ "$dirname" == "docs" ]]; then
        continue
    fi

    # 检查目录下是否存在 SKILL.md (Skills 规范的核心文件)
    if [ -f "$dir/SKILL.md" ]; then
        echo -e "发现 Skill: ${GREEN}$dirname${NC}"
        # 遍历所有选定的目标目录进行同步
        for target in "${TARGET_DIRS[@]}"; do
            cp -r "$dir" "$target/"
            echo -e "  - 已同步到 ${target#$HOME/}/$dirname"
        done
    fi
done

echo -e "\n${GREEN}✅ 安装完成！${NC}"

# 打印支持状态总结
if $HAS_CLAUDE && $HAS_OPENCODE; then
    echo -e "当前环境提示: 系统同时支持 ${BLUE}Claude Code${NC} 与 ${BLUE}OpenCode${NC}"
elif $HAS_CLAUDE; then
    echo -e "当前环境提示: 系统已配置 ${BLUE}Claude Code${NC}"
elif $HAS_OPENCODE; then
    echo -e "当前环境提示: 系统已配置 ${BLUE}OpenCode${NC}"
fi

echo -e "技能已成功同步至以上目录。"

if [ -f "$SOURCE_DIR/INDEX.md" ]; then
    echo -e "\n${BLUE}📚 当前已安装技能列表：${NC}"
    # 使用 tail 从第 3 行开始显示（跳过 Markdown 标题），或者直接显示
    cat "$SOURCE_DIR/INDEX.md"
fi

echo -e "\n${GREEN}现在你可以开始使用以上技能了！${NC}"

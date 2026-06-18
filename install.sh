#!/bin/bash
# Kytos OS — 스킬 설치 스크립트
# 사용법: bash install.sh

set -e

KYTOS_OS_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$KYTOS_OS_DIR/skills"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

echo ""
echo "Kytos OS 스킬 설치를 시작합니다."
echo ""

# ~/.claude/commands 폴더 생성
mkdir -p "$CLAUDE_COMMANDS_DIR"

# 스킬 파일 복사
for skill in "$SKILLS_SRC"/*.md; do
    filename=$(basename "$skill")
    cp "$skill" "$CLAUDE_COMMANDS_DIR/$filename"
    echo "  ✓ $filename"
done

echo ""
echo "스킬 설치 완료."
echo ""
echo "다음 단계:"
echo "  1. kytos-data 프라이빗 레포를 만들어 clone합니다:"
echo "     cp -r $KYTOS_OS_DIR/kytos-data-template ~/kytos-data"
echo "     cd ~/kytos-data && git init"
echo ""
echo "  2. KYTOS_DATA_DIR 환경변수를 셸 프로필에 추가합니다:"
echo "     echo 'export KYTOS_DATA_DIR=\$HOME/kytos-data' >> ~/.zshrc"
echo "     source ~/.zshrc"
echo ""
echo "  3. me.json을 작성합니다:"
echo "     ~/kytos-data/individual/me.json"
echo ""
echo "자세한 내용: docs/setup.md"
echo ""

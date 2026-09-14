#!/bin/bash
# Kytos OS 부트스트랩
#
# 이 레포(kytos-os)는 스키마/스킬 템플릿 레포다. 실제로 쓰는 팀 데이터 +
# 커스텀 스킬은 spiratus-org/kytos-os-spiratus(비공개)에 있다.
# 이 훅은 Claude Code on the web 세션이 이 레포 위에서 시작될 때마다
# kytos-os-spiratus를 준비해서, 매 세션이 "kytos 위에서" 시작되게 한다.
#
# 절대 세션 시작을 막지 않는다 (항상 exit 0).
set -uo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
DATA_DIR="/home/user/kytos-os-spiratus"
REPO_URL="https://github.com/spiratus-org/kytos-os-spiratus.git"

# 1) 팀 데이터 레포 준비 (있으면 동기화, 없으면 클론 시도)
if [ -d "$DATA_DIR/.git" ]; then
  if [ -f "$DATA_DIR/.claude/scripts/session-start-sync.sh" ]; then
    CLAUDE_PROJECT_DIR="$DATA_DIR" bash "$DATA_DIR/.claude/scripts/session-start-sync.sh" >/dev/null 2>&1 || true
  fi
else
  timeout 90 git clone --depth 1 "$REPO_URL" "$DATA_DIR" >/dev/null 2>&1 || true
fi

# 2) 명령어(스킬) 설치 — kytos-os/skills는 $KYTOS_DIR을 쓰므로 cwd와 무관하게 동작한다
mkdir -p "$PROJECT_DIR/.claude/commands"
if [ -d "$PROJECT_DIR/skills" ]; then
  cp "$PROJECT_DIR"/skills/*.md "$PROJECT_DIR/.claude/commands/" 2>/dev/null || true
fi

# 3) 결과에 따라 KYTOS_DIR 설정 + 안내
if [ -d "$DATA_DIR/.git" ]; then
  if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
    echo "export KYTOS_DIR=\"$DATA_DIR\"" >> "$CLAUDE_ENV_FILE"
  fi
  echo "{\"systemMessage\": \"Kytos OS 준비 완료 — 팀 레포(kytos-os-spiratus)가 ${DATA_DIR}에 연결됐고 KYTOS_DIR로 설정됐습니다. 처음이면 /kytos-setup, 이후에는 /kytos-open → /task-start → /task-end 순서로 쓰세요.\"}"
else
  echo "{\"systemMessage\": \"Kytos OS 자동 연결 실패 — spiratus-org/kytos-os-spiratus(비공개) 레포에 접근하지 못했습니다. Claude에게 '이 레포를 추가해줘(add_repo)'라고 요청한 뒤 다시 클론해 KYTOS_DIR을 설정해 달라고 하세요.\"}"
fi

exit 0

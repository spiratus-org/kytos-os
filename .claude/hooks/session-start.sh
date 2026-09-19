#!/bin/bash
set -uo pipefail

KYTOS_DIR="${KYTOS_DIR:-$HOME/kytos-data}"

if [ ! -d "$KYTOS_DIR/.git" ]; then
  echo "kytos-data(\$KYTOS_DIR=$KYTOS_DIR)가 git 저장소가 아닙니다 — pull 건너뜀." >&2
  exit 0
fi

cd "$KYTOS_DIR" || exit 0

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "kytos-data에 원격 저장소가 없습니다 — 로컬 상태로 시작합니다." >&2
  exit 0
fi

if git pull --ff-only 2>&1; then
  echo "✓ kytos-data 최신 상태로 업데이트됐습니다."
else
  echo "kytos-data pull 실패 — 로컬 상태로 시작합니다. 수동으로 확인해주세요." >&2
fi

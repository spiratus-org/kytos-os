---
description: 태스크 종료 — 세션 추출 후 파일 업데이트 및 git 커밋
---

현재 세션을 마무리합니다. 의미 있는 것을 추출하고, 파일을 업데이트하고, git에 커밋합니다.

**1단계: 환경 확인**

```bash
echo $KYTOS_DATA_DIR
```

`KYTOS_DATA_DIR`이 비어 있으면 멈추고 안내합니다.

**2단계: 세션 리뷰**

이 세션 전체를 돌아보며 다음을 파악합니다:
- 무엇을 했는가 (실제로 완료된 것)
- 어떤 결정이 내려졌는가
- 무엇이 작동했고 무엇이 작동하지 않았는가
- 미완료 항목은 무엇인가
- 인사이트나 발견이 있었는가

**3단계: 작업 유형별 추출**

`/task-start` 시 선언한 유형에 따라 추출 항목이 다릅니다.

**조직의 일:**
`$KYTOS_DATA_DIR/org/[조직명]/log.md` 에 다음을 추가합니다:
```markdown
## YYYY-MM-DD — [작업 제목]
**완료**: [실제로 완료된 것]
**결정**: [내려진 결정]
**패턴**: [작동한 것, 작동하지 않은 것]
**다음**: [미완료 항목]
```

**개인→조직:**
`$KYTOS_DATA_DIR/individual/insights/YYYY-MM-DD.md` 를 생성하고:
```markdown
---
date: YYYY-MM-DD
tags: [조직명, 주제태그]
type: personal_to_org
---
## 인사이트
[세션에서 발견한 것]

## 조직 연결 가능성
[이것이 조직에 어떻게 기여될 수 있는가]
```
그리고 `$KYTOS_DATA_DIR/org/[조직명]/insights/` 에 링크(파일명)를 기록합니다.

**개인의 일:**
`$KYTOS_DATA_DIR/individual/log.md` 에만 간단히 기록합니다. org에는 아무것도 기록하지 않습니다.

**4단계: 파일 업데이트**

위에서 정리한 내용을 Read 후 Write/Edit 도구로 파일에 씁니다.

**5단계: git 커밋**

```bash
cd $KYTOS_DATA_DIR
git add -A
git diff --staged --stat
```

변경 파일을 확인한 후 커밋합니다:

```bash
git commit -m "$(cat <<'EOF'
[조직명|개인]: [무엇을 했는지] — [핵심 인사이트 또는 결정]

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

커밋 후 결과를 사용자에게 보여줍니다:

```
✓ 태스크 종료
━━━━━━━━━━━━━━━━━━━━━
업데이트된 파일: [파일명들]
커밋: [커밋 해시 앞 7자]
━━━━━━━━━━━━━━━━━━━━━
```

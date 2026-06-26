---
description: 태스크 종료 — 세션 추출, frontmatter 자동 생성, git 커밋
---

현재 세션을 마무리합니다.

---

**1단계: 환경 확인**

```bash
echo $KYTOS_DIR
```

`KYTOS_DIR`이 비어 있으면 멈추고 안내합니다: `docs/setup.md`의 4단계를 따라 설정해주세요.

---

**2단계: 세션 리뷰**

이 세션 전체를 읽고 다음을 파악합니다:
- 무엇이 완료됐는가
- 어떤 결정이 내려졌는가
- 무엇을 발견하거나 배웠는가
- 미완료 항목이 있는가

---

**3단계: frontmatter 자동 생성**

`$KYTOS_DIR/individual/me.json`을 읽어 `short_id`를 가져옵니다.

아래 항목을 채웁니다:

| 항목 | 방법 |
|------|------|
| `id` | `{short_id}-{type앞글자}-{YYYYMMDD}-001` |
| `date` | 오늘 날짜 |
| `scope` | `/task-start` 선언값 |
| `orgs` | `/task-start` 선언값 |
| `type` | 대화 내용으로 추론: `insight` \| `learning` \| `decision` \| `log` |
| `domains` | 대화 주제로 추론 (예: somatic, facilitation, tech, academic) |
| `projects` | 언급된 프로젝트명으로 추론 |
| `visibility` | 기본값 `private` |

---

**4단계: 확인 요청 (한 번만)**

추론한 내용을 보여주고 한 번에 확인받습니다:

```
📋 세션 요약
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[세션에서 일어난 일 2-3줄 요약]

기록될 frontmatter:
  type:       insight
  scope:      individual_to_org
  orgs:       [바디템플]
  domains:    [somatic, facilitation]
  projects:   [에스테틱댄스-프로그램]
  visibility: private  ← shared로 바꾸려면 알려주세요

맞으면 enter, 고칠 것이 있으면 말씀해 주세요.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

사용자가 수정을 요청하면 반영합니다. 그냥 넘어가면 그대로 진행합니다.

---

**5단계: 파일 작성**

작업 유형에 따라 파일을 씁니다.

**scope: individual**

`$KYTOS_DIR/individual/insights/YYYY-MM-DD.md` 생성:

```markdown
---
id: {id}
date: YYYY-MM-DD
type: {type}
scope: individual
orgs: {orgs}
domains: {domains}
projects: {projects}
visibility: {visibility}
---

## 세션 요약
{무엇을 했는가}

## 인사이트 / 결정 / 학습
{추출된 내용}

## 다음
{미완료 항목 또는 이어질 것}
```

**scope: individual_to_org**

`$KYTOS_DIR/individual/insights/YYYY-MM-DD.md` 생성 (위와 동일).

추가로 `$KYTOS_DIR/org/{조직명}/insights/index.md`에 링크 한 줄 추가:
```
- {YYYY-MM-DD} [{한줄 요약}] — individual/insights/YYYY-MM-DD
```

**scope: org**

`$KYTOS_DIR/org/{조직명}/log.md`에 항목 추가:

```markdown
## YYYY-MM-DD — {작업 제목}
**완료**: {실제로 완료된 것}
**결정**: {내려진 결정}
**패턴**: {작동한 것, 작동하지 않은 것}
**다음**: {미완료 항목}
```

---

**6단계: git 커밋**

`individual/`은 `.gitignore`에 의해 자동으로 제외됩니다. org 데이터만 커밋됩니다.

```bash
cd $KYTOS_DIR
git add -A
git diff --staged --stat
git commit -m "$(cat <<'EOF'
{scope}: {작업 제목 한줄} — {핵심 인사이트 또는 결정}

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

완료 후:

```
✓ 커밋 완료
━━━━━━━━━━━━━━━━━━━━━
커밋: {해시 앞 7자}
파일: {변경된 파일명}
━━━━━━━━━━━━━━━━━━━━━
```

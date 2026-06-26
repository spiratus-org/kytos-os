---
description: 개인 노트를 kytosOS 생태계로 편입 — vault/inbox/ 파일에 frontmatter 생성 후 이동
---

`vault/inbox/`에 있는 파일을 kytosOS 생태계로 편입합니다.

---

**1단계: 환경 확인**

```bash
echo $KYTOS_INDIVIDUAL_DIR
```

비어 있으면 멈추고 안내합니다: `docs/setup.md`의 4단계를 따라 설정해주세요.

---

**2단계: inbox 스캔**

```bash
ls $KYTOS_INDIVIDUAL_DIR/individual/vault/inbox/
```

파일이 없으면 안내합니다:

> `~/kytos-data/individual/vault/inbox/`에 처리할 파일이 없습니다.
> Obsidian에서 생태계에 넣고 싶은 노트를 `inbox/` 폴더로 옮겨주세요.

파일이 여러 개면 하나씩 순서대로 처리합니다.

---

**3단계: 파일별 처리**

각 파일에 대해:

**3-1. 내용 읽기**

Read 도구로 파일 전체를 읽습니다.

**3-2. frontmatter 추론**

내용을 바탕으로 다음을 추론합니다:

| 항목 | 추론 방법 |
|------|---------|
| `type` | 주제가 인사이트인가, 학습인가, 결정인가, 메모인가 |
| `scope` | 개인 기록인가, 조직과 연결 가능한가 |
| `orgs` | 특정 조직 이름이 언급됐는가 |
| `domains` | 어떤 분야의 내용인가 |
| `projects` | 어떤 프로젝트와 연결되는가 |
| `date` | 파일 내 날짜 언급 → 없으면 오늘 날짜 |

`id`는 `{short_id}-{type앞글자}-{YYYYMMDD}-{순번}`으로 생성합니다.
`short_id`는 `$KYTOS_INDIVIDUAL_DIR/individual/me.json`에서 읽어옵니다.

**3-3. 미리보기 제시**

```
📄 {파일명}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
내용 요약: [2줄 요약]

생성될 frontmatter:
  id:         {id}
  date:       {date}
  type:       {type}
  scope:      {scope}
  orgs:       {orgs}
  domains:    {domains}
  projects:   {projects}
  visibility: private

이동 위치: individual/insights/{date}.md

편입하려면 enter, 건너뛰려면 s, 수정하려면 내용을 말씀해 주세요.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**3-4. 사용자 응답에 따라 처리**

- **enter (편입)**: frontmatter를 붙여 `individual/insights/{date}.md`로 저장. 원본은 `vault/imported/`로 이동.
- **s (건너뜀)**: 해당 파일은 inbox에 그대로 두고 다음 파일로.
- **수정 요청**: 반영 후 미리보기 다시 제시.

---

**4단계: git 커밋**

편입된 파일이 하나라도 있으면:

```bash
cd $KYTOS_INDIVIDUAL_DIR
git add -A
git diff --staged --stat
git commit -m "$(cat <<'EOF'
kytos-import: {편입된 파일 수}개 노트 생태계 편입

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

완료:

```
✓ 편입 완료
━━━━━━━━━━━━━━━━━━━━━
편입: {파일명들}
건너뜀: {파일명들 또는 없음}
커밋: {해시 앞 7자}
━━━━━━━━━━━━━━━━━━━━━
```

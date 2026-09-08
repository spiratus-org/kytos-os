---
description: 텍스트 풀에서 pooled 상태인 조각들을 엮어 하나의 AtomicPiece(완결된 글)를 만듭니다
---

`content-pool/`에 태깅되어 쌓인 조각(ContentFragment) 중, 서로 유관한 것들을 엮어
하나의 개념만 담은 완결된 글(AtomicPiece)을 만듭니다.

---

**1단계: 환경 확인**

```bash
echo $KYTOS_DIR
```

비어 있으면 멈추고 안내합니다: `docs/setup.md`의 4단계를 따라 설정해주세요.

---

**2단계: pooled 조각 스캔**

```bash
ls $KYTOS_DIR/individual/content-pool/
```

각 파일의 frontmatter를 Read로 확인해 `status: pooled`인 것만 후보로 삼습니다.
(`raw`는 아직 태깅 전, `woven`은 이미 다른 글에 쓰인 것, `archived`는 제외)

후보가 없으면 안내합니다:
> 엮을 수 있는 조각이 없습니다. `content-pool/`에 태깅된 조각을 먼저 쌓아주세요.

---

**3단계: 유관 조각 그룹 제안**

후보들의 `tags`(keywords, domains, orgs, tone)를 비교해 겹치는 정도로 그룹을 묶어 제안합니다.

```
🧵 엮을 수 있는 후보 묶음
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
묶음 A: {공통 키워드/도메인} — {파일명 목록}
묶음 B: {공통 키워드/도메인} — {파일명 목록}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
어느 묶음을 엮을까요? (묶음 이름 또는 직접 파일명 지정, 사용자가 이미 대상을 말했다면 이 단계는 건너뜁니다)
```

---

**4단계: 핵심 개념 도출 및 초안 작성**

선택된 조각들의 내용을 모두 Read한 뒤:

1. 이 조각들을 관통하는 **단 하나의 개념/주장**을 한두 문장으로 뽑아 `core_concept`으로 제안합니다.
2. 조각들의 원문을 재료 삼아 완결된 글 초안(`content`)을 작성합니다. 조각을 그대로 이어붙이지 않고, 하나의 글로 다시 씁니다.
3. `title`을 제안합니다.

원자성 점검: 초안에 두 개 이상의 독립적인 주장이 섞여 있다면, 쪼개서 별도의 AtomicPiece로 만들 것을 제안합니다.

---

**5단계: 미리보기 및 확인**

```
📄 AtomicPiece 초안
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
제목: {title}
핵심 개념: {core_concept}
엮인 조각: {source_fragments 파일명 목록}
태그: {합쳐진 tags}

[본문 미리보기 — 앞부분 몇 줄]

맞으면 enter, 고칠 게 있으면 말씀해 주세요.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

**6단계: 저장**

`id`는 `did:kytos:{uuid}` 형식(신규 uuid 생성)으로 만듭니다.

- Write로 `$KYTOS_DIR/individual/atomic-pieces/{date}-{slug}.md` 저장 (`schema/atomic-piece.json` 형태, frontmatter + 본문)
- Edit로 엮인 각 조각 파일의 frontmatter `status`를 `woven`으로 변경
- 각 조각 → 새 AtomicPiece 관계를 `$KYTOS_DIR/individual/connections/{uuid}.json`에 `relation: generates`로 기록 (`schema/connection-node.json` 형태)

---

**7단계: git 커밋**

```bash
cd $KYTOS_DIR
git add -A
git commit -m "$(cat <<'EOF'
content-weave: {title} — {엮인 조각 수}개 조각을 AtomicPiece로 엮음

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

완료:

```
✓ 엮기 완료
━━━━━━━━━━━━━━━━━━━━━
AtomicPiece: {title}
다음: 원본 채널에 게시한 뒤 /content-publish 로 파생본을 만드세요.
━━━━━━━━━━━━━━━━━━━━━
```

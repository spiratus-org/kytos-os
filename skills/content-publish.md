---
description: 완결된 AtomicPiece를 채널·의도에 맞는 형식의 Publication으로 파생시킵니다
---

원본 채널에 게시된(또는 게시 예정인) AtomicPiece 하나를 골라,
목적과 채널에 맞는 파생본(Publication)을 만듭니다.

---

**1단계: 환경 확인**

```bash
echo $KYTOS_DIR
```

비어 있으면 멈추고 안내합니다: `docs/setup.md`의 4단계를 따라 설정해주세요.

---

**2단계: 대상 AtomicPiece 선택**

```bash
ls $KYTOS_DIR/individual/atomic-pieces/
```

사용자가 이미 어떤 글인지 말했다면 그 파일을 Read합니다. 아니면 목록을 보여주고 고르게 합니다.

`status`가 아직 `draft`이고 `origin_url`이 비어 있으면 안내합니다:
> 이 글이 아직 원본 채널(개인 홈페이지 등)에 게시되지 않은 것 같습니다. 먼저 원본을 게시할까요, 아니면 파생본부터 준비할까요?

---

**3단계: 채널·의도 확인**

```
어떤 조직/채널을 위한 파생본인가요? (예: bodytemple, hyunhyun, 없으면 개인 채널)
>

의도가 무엇인가요?
  1) healing-support  — 치유적 활동을 뒷받침
  2) research-context — 창작/활동의 배경 리서치
  3) commercial-marketing — 상업 활동의 마케팅
  4) other
>

매체는 무엇인가요? (website | blog | instagram | magazine | info-sheet | newsletter | other)
>
```

---

**4단계: 형식 제안 및 각색**

`intent`와 `medium`을 근거로 구체적 형식(`format`)을 제안합니다. 아직 정해진 규칙이 없으므로,
과거에 같은 `org`+`intent`+`medium` 조합으로 만든 Publication이 있으면 `publications/`에서 찾아 참고합니다.

AtomicPiece의 `core_concept`은 그대로 유지하면서, 선택된 형식에 맞게 본문을 다시 씁니다
(요약/재구성/톤 변경 — 원본을 그대로 복사하지 않습니다).

---

**5단계: 미리보기 및 확인**

```
📄 Publication 초안
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
원본: {AtomicPiece 제목}
조직: {org 또는 "개인"}
의도: {intent}
매체: {medium}
형식: {format}

[본문 미리보기]

맞으면 enter, 고칠 게 있으면 말씀해 주세요.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

**6단계: 저장**

- Write로 `$KYTOS_DIR/individual/publications/{date}-{slug}.md` 저장 (`schema/publication.json` 형태, `derived_from`에 원본 AtomicPiece id 기입)
- AtomicPiece → Publication 관계를 `$KYTOS_DIR/individual/connections/{uuid}.json`에 `relation: generates`로 기록

---

**7단계: git 커밋**

```bash
cd $KYTOS_DIR
git add -A
git commit -m "$(cat <<'EOF'
content-publish: {AtomicPiece 제목} → {org 또는 개인}/{medium} 파생본 생성

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

완료:

```
✓ 파생 완료
━━━━━━━━━━━━━━━━━━━━━
Publication: {org 또는 개인}/{medium} — {format}
━━━━━━━━━━━━━━━━━━━━━
```

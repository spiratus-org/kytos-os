---
description: 처음 설정 — me.json을 인터뷰 방식으로 작성합니다
---

kytos-data를 처음 설정할 때 한 번만 실행합니다.

---

**1단계: 환경 확인**

```bash
echo $KYTOS_DIR
```

비어 있으면 멈추고 안내합니다:
> `KYTOS_DIR` 환경변수가 설정되지 않았습니다.
> `docs/setup.md`의 4단계를 따라 설정한 뒤 다시 실행해주세요.

---

**2단계: 기존 me.json 확인**

```bash
cat $KYTOS_DIR/individual/me.json
```

`id`가 `did:kytos:YOUR_NAME` 그대로면 아직 작성 전 → 인터뷰 진행.
이미 작성되어 있으면:
> `me.json`이 이미 작성되어 있습니다.
> 수정하려면 `$KYTOS_DIR/individual/me.json`을 직접 편집하거나 계속 진행하려면 enter를 누르세요.

enter면 인터뷰 진행, 다른 입력이면 종료.

---

**3단계: 인터뷰**

한 항목씩 순서대로 묻습니다.

**이름**
```
이름이 어떻게 되세요?
>
```

**short_id 제안**

입력받은 이름에서 자동으로 추출해 제안합니다.

추출 규칙:
- 한국어 이름: 성(1자) + 이름 첫 글자 + 이름 마지막 글자 → 로마자 변환 (예: 김지수 → kjisu의 자음 → `kjs`, 배서영 → `bsy`)
- 영어 이름: 이름 첫 글자 + 성 첫 두 글자 소문자 (예: Jane Kim → `jki`)
- 2-3자로 맞춥니다

```
short_id를 `{제안값}`으로 할까요? (팀 내 고유 약어입니다. 다른 값을 원하면 입력해주세요, 그대로면 enter)
>
```

enter면 제안값 사용, 입력이 있으면 그 값 사용.

**역할**
```
어떤 역할을 하고 계세요? (예: 퍼실리테이터, 개발자, 디자이너, 연구자)
>
```

**소속 조직**

조직이 여러 개일 수 있으므로 반복합니다.

```
소속 조직이 있으신가요? 조직 이름을 입력해주세요. (없으면 enter로 건너뜁니다)
>
```

조직 이름이 입력되면:
```
{조직명}에 언제 합류하셨나요? (YYYY-MM-DD 형식, 모르면 enter → 오늘 날짜로 입력됩니다)
>
```

조직 하나 완료 후:
```
다른 조직도 있으신가요? (있으면 이름 입력, 없으면 enter)
>
```

없을 때까지 반복.

---

**4단계: 미리보기 및 확인**

수집한 내용으로 me.json을 구성해 보여줍니다:

```
이렇게 저장할게요:

{
  "id": "did:kytos:{이름 로마자}",
  "short_id": "{short_id}",
  "name": "{이름}",
  "role": "{역할}",
  "orgs": [...],
  "created": "{오늘 날짜}",
  "data_location": "individual://"
}

맞으면 enter, 고칠 게 있으면 말씀해 주세요.
```

수정 요청이 있으면 반영 후 다시 보여줍니다.

---

**5단계: me.json 저장**

확인이 완료되면 Write 도구로 `$KYTOS_DIR/individual/me.json`을 저장합니다.

`$schema`와 `note` 필드는 템플릿 원본 그대로 유지합니다.

---

**6단계: git 커밋**

```bash
cd $KYTOS_DIR
git add individual/me.json
git commit -m "$(cat <<'EOF'
init: me.json 초기 설정

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

완료:

```
✓ 설정 완료
━━━━━━━━━━━━━━━━━━━━━
안녕하세요, {이름}님. me.json이 저장됐습니다.

이제 시작할 준비가 됐습니다:
  /kytos-open   ← 매일 세션 시작할 때
  /task-start   ← 작업 시작
  /task-end     ← 작업 종료 + 자동 커밋
━━━━━━━━━━━━━━━━━━━━━
```

# Kytos OS — 설치 가이드

이 가이드를 따라하면 `/task-start`, `/task-end` 스킬이 작동하는 상태가 됩니다.

예상 소요 시간: **15분**

---

## 전제조건 설치

### Claude Code

Kytos OS의 AI 레이어입니다. 반드시 필요합니다.

1. [claude.ai](https://claude.ai) 계정 생성 (없으면)
2. Node.js가 없다면 먼저 설치합니다: [nodejs.org](https://nodejs.org) → LTS 버전
3. 터미널에서 Claude Code 설치:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
4. 로그인:
   ```bash
   claude
   ```
   처음 실행하면 브라우저가 열리고 계정 연동이 진행됩니다.

### Git

버전 관리 도구입니다. macOS에는 대부분 기본 설치되어 있습니다.

```bash
git --version
```

명령이 없다면:
```bash
xcode-select --install
```

### GitHub 계정

kytos-data 프라이빗 레포 보관에 필요합니다. [github.com](https://github.com)에서 계정을 만드세요.

### Obsidian (선택)

지식망을 시각적으로 탐색하고 싶다면 설치합니다. [obsidian.md](https://obsidian.md)

---

## 1단계 — kytos-os 클론

스키마와 스킬을 받아옵니다.

```bash
git clone https://github.com/spiratus-org/kytos-os.git ~/git/kytos-os
```

---

## 2단계 — 스킬 설치

스킬 파일을 Claude Code 명령 폴더에 복사합니다.

```bash
bash ~/git/kytos-os/install.sh
```

설치 후 Claude Code를 재시작하면 `/task-start`, `/task-end` 명령이 활성화됩니다.

---

## 3단계 — 나의 데이터 공간 설정

kytos-data는 **나만의 프라이빗 레포**입니다. kytos-os와 절대 같은 레포에 두지 않습니다.

### 3-1. 템플릿에서 복사

```bash
cp -r ~/git/kytos-os/kytos-data-template ~/kytos-data
cd ~/kytos-data
git init
git add -A
git commit -m "초기 설정"
```

### 3-2. GitHub에 프라이빗 레포 생성 후 연결

1. [github.com/new](https://github.com/new) 접속
2. Repository name: `kytos-data`
3. **Private** 선택 (반드시)
4. "Create repository" 클릭
5. 터미널에서 연결:

```bash
cd ~/kytos-data
git remote add origin https://github.com/[내GitHub아이디]/kytos-data.git
git push -u origin main
```

`[내GitHub아이디]` 부분을 본인 GitHub 아이디로 바꿉니다.

---

## 4단계 — 환경변수 설정

셸 프로필(`~/.zshrc` 또는 `~/.bashrc`)에 추가합니다:

```bash
export KYTOS_DATA_DIR=$HOME/kytos-data
```

적용합니다:

```bash
source ~/.zshrc
```

확인:

```bash
echo $KYTOS_DATA_DIR
# → /Users/[이름]/kytos-data
```

---

## 5단계 — me.json 작성

나의 Individual Node 정체성을 선언합니다.

```bash
open -e ~/kytos-data/individual/me.json
```

다음 항목을 채웁니다:

| 항목 | 설명 | 예시 |
|------|------|------|
| `id` | 나를 식별하는 고유 id | `"did:kytos:김지수"` |
| `short_id` | 파일 id 자동 생성용 2-3자 약어. 팀 내에서 고유해야 합니다 | `"jsk"` |
| `name` | 이름 | `"김지수"` |
| `role` | 역할 | `"퍼실리테이터"` |
| `orgs` | 소속 조직 목록. 여러 개면 항목을 복사해 추가합니다 | 아래 참조 |

소속 조직이 여러 개라면:
```json
"orgs": [
  {
    "id": "did:kytos:org:bodytemple",
    "name": "바디템플",
    "joined": "2026-06-19",
    "permission": "open"
  },
  {
    "id": "did:kytos:org:hyunhyeon",
    "name": "현현",
    "joined": "2026-06-19",
    "permission": "open"
  }
]
```

저장 후 터미널에서 확인:
```bash
cat ~/kytos-data/individual/me.json
```

---

## 6단계 — Obsidian 볼트 열기 (선택)

Obsidian에서 **기존 볼트 열기** → `~/kytos-data/individual/vault/` 선택.

---

## 완료

터미널에서 Claude Code를 실행합니다:

```bash
claude
```

이제 다음 명령을 사용할 수 있습니다:

```
/task-start 바디템플 프로그램 설명 페이지 작성
... 작업 진행 ...
/task-end
```

`/task-start`는 작업 컨텍스트를 선언하고, `/task-end`는 세션을 정리해 `~/kytos-data`에 자동으로 커밋합니다.

### 잘 됐는지 확인

`/task-end` 후 다음 명령으로 커밋이 생겼는지 확인합니다:

```bash
cd ~/kytos-data && git log --oneline -3
```

---

## 조직 뷰 추가

다른 팀원이 공유한 조직 기억을 받으려면 `org/` 폴더에 연결합니다.
(현재 준비 중 — 조직 데이터 레포 설계 이후 안내 추가 예정)

---

## 문제가 생겼을 때

- `KYTOS_DATA_DIR` 없다는 오류 → 4단계 재확인
- `/task-start` 명령이 없다 → Claude Code 재시작 후 재시도
- 기타 → [Issues](https://github.com/spiratus-org/kytos-os/issues)

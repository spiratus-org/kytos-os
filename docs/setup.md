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

### Obsidian

지식망을 시각적으로 탐색하는 도구입니다. [obsidian.md](https://obsidian.md)에서 다운로드 후 설치합니다.

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

## 6단계 — Obsidian 볼트 열기 및 Git 동기화 설정

Obsidian 볼트(`~/kytos-data/individual/vault/`)는 kytos-data 레포 안에 있습니다.
Git 플러그인을 설정하면 Obsidian에서 작성한 노트가 자동으로 커밋·동기화됩니다.

### 6-1. 볼트 열기

Obsidian 실행 → **기존 볼트 열기(Open folder as vault)** → `~/kytos-data/individual/vault/` 선택.

볼트 안 폴더 구조:

```
vault/
├── notes/      ← 자유 영역. 규칙 없이 아무렇게나 씁니다.
├── inbox/      ← 생태계에 넣고 싶은 노트를 여기로 옮깁니다.
└── imported/   ← /kytos-import 처리가 끝난 노트가 보관됩니다.
```

**노트를 생태계에 편입하는 방법**

Obsidian에서 작성한 노트를 kytosOS 생태계(`individual/insights/`)에 넣고 싶을 때:

1. 해당 노트를 `inbox/` 폴더로 옮깁니다
2. Claude Code에서 `/kytos-import` 실행
3. Claude가 내용을 읽고 frontmatter를 생성해 제안합니다
4. 확인하면 자동으로 편입 및 커밋됩니다

직접 frontmatter를 작성할 필요가 없습니다. 넣고 싶은 것만 `inbox/`로 옮기면 됩니다.

### 6-2. Obsidian Git 플러그인 설치

1. Obsidian 설정(⚙️) → **Community plugins**
2. **안전 모드 끄기(Turn off safe mode)** → 확인
3. **Browse** 클릭 → `Obsidian Git` 검색 → **Install** → **Enable**

### 6-3. 플러그인 설정

Obsidian 설정 → **Obsidian Git** 항목에서:

| 항목 | 값 | 설명 |
|------|-----|------|
| Auto commit interval | `10` | 10분마다 변경사항 자동 커밋 |
| Auto pull interval | `10` | 10분마다 원격에서 최신 내용 pull |
| Commit message | `vault: auto-sync {{date}}` | 자동 커밋 메시지 |
| Pull on startup | 켜기 | 볼트 열 때 최신 상태로 시작 |

설정 후 Obsidian에서 작성한 노트는 10분 간격으로 `~/kytos-data`에 자동 커밋됩니다.
`/task-end` 호출 시에는 세션 인사이트와 함께 한 번 더 명시적으로 커밋됩니다.

---

## 완료

터미널에서 Claude Code를 실행합니다:

```bash
claude
```

### 매일 이렇게 씁니다

```
/kytos-open                            ← 하루 시작할 때 한 번만
                                          (git pull + 마지막 세션 요약)

/task-start 바디템플 프로그램 설명 작성  ← 작업 시작
... 작업 진행 ...
/task-end                              ← 작업 종료 + 자동 커밋

/task-start 다른 작업                  ← 같은 세션에서 바로 다음 작업
... 작업 진행 ...
/task-end
```

`/kytos-open`은 최신 데이터를 받아오고 이전 세션에서 이어서 할 것을 보여줍니다.
`/task-end`는 세션을 정리해 `~/kytos-data`에 자동으로 커밋합니다.

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

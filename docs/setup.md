# Kytos OS — 설치 가이드

이 가이드를 따라하면 `/task-start`, `/task-end` 스킬이 작동하는 상태가 됩니다.

예상 소요 시간: **15분**

> **macOS 버전 요구사항: 26.2 이상**
> 낮은 버전이면 애플 로고 → 시스템 설정 → 일반 → 소프트웨어 업데이트에서 먼저 업데이트하세요.

---

## 전제조건 설치

### Node.js 설치 (npm 포함)

Claude Code 설치에 필요합니다. 먼저 설치되어 있는지 확인합니다:

```bash
node --version
```

숫자(`v20.x.x` 등)가 나오면 이미 설치된 것입니다. → 다음 단계로 건너뜁니다.

`command not found`가 나오면 아래 순서로 설치합니다.

**Xcode Command Line Tools 설치**

Homebrew보다 먼저 필요합니다:

```bash
xcode-select --install
```

팝업이 뜨면 **설치** 클릭. 완료 후 계속 진행합니다.

**Homebrew 확인**

```bash
brew --version
```

숫자가 나오면 이미 있음 → Node.js 설치로 건너뜁니다.

`command not found`가 나오면 Homebrew 먼저 설치합니다:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> 비밀번호를 입력하라고 나오면 Mac 로그인 비밀번호를 입력합니다.  
> 입력해도 화면에 글자가 보이지 않는 것이 정상입니다.

**Node.js 설치**

```bash
brew install node
```

**설치 확인**

```bash
node --version && npm --version
```

두 줄 모두 숫자가 나오면 성공입니다.

### Claude Code

Kytos OS의 AI 레이어입니다. 반드시 필요합니다.

1. [claude.ai](https://claude.ai) 계정 생성 (없으면)
2. 터미널에서 설치:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
3. 로그인:
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

설치되는 스킬 목록:
- `/kytos-setup` — 최초 설정 (me.json 인터뷰 방식 작성)
- `/kytos-open` — 세션 시작 (git pull + 마지막 세션 요약)
- `/task-start` — 작업 시작
- `/task-end` — 작업 종료 + 자동 커밋
- `/kytos-import` — 개인 노트 생태계 편입

**설치 후 Claude Code를 완전히 종료했다가 다시 실행해야** 스킬이 활성화됩니다.

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

Claude Code를 실행하고 `/kytos-setup`을 입력합니다:

```bash
claude
```

```
/kytos-setup
```

Claude가 이름, 역할, 소속 조직을 하나씩 물어보고 자동으로 `me.json`을 작성해줍니다. JSON을 직접 편집할 필요가 없습니다.

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

### 설치 완료 확인

Claude Code에서 다음을 실행합니다:

```
/kytos-open
```

이름과 마지막 세션 요약이 뜨면 모든 설정이 완료된 것입니다.

`/task-end` 후 커밋이 생겼는지 확인하려면:

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

# Kytos OS — 시작 가이드

Claude Code(AI)로 작업을 기록하고 팀 기억을 쌓는 시스템입니다.
이 가이드를 따라하면 `/task-start`, `/task-end`가 작동하는 상태가 됩니다.

예상 소요 시간: **20분**

---

## 준비물

| 항목 | 확인 방법 |
|------|----------|
| Mac | — |
| GitHub 계정 | [github.com](https://github.com) 로그인 되는지 확인 |
| 팀 레포 초대 수락 | GitHub 이메일에서 초대 수락 |

GitHub 계정이 없으면 [github.com](https://github.com)에서 먼저 만듭니다.
팀 초대를 못 받았으면 팀 관리자에게 요청합니다.

---

## 1단계 — 터미널 열기

`⌘ + 스페이스` → "터미널" 입력 → 엔터.

검은 창이 뜨면 준비된 것입니다. 이후 모든 명령어는 이 창에 입력합니다.

---

## 2단계 — Git, Node.js 확인

```bash
git --version
node --version
```

둘 다 숫자가 나오면 → **3단계로 넘어갑니다.**

숫자 대신 `command not found`가 나오면:

**Git이 없는 경우**
```bash
xcode-select --install
```
팝업이 뜨면 **설치** 클릭. 완료 후 계속합니다.

**Node.js가 없는 경우**
```bash
brew install node
```
`brew` 명령도 없으면 먼저 Homebrew를 설치합니다:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
> 비밀번호를 입력하라고 나오면 Mac 로그인 비밀번호를 입력합니다.
> 입력해도 화면에 글자가 보이지 않는 것이 정상입니다.

---

## 3단계 — Claude Code 설치

Claude Code는 이 시스템의 AI 두뇌입니다. 작업을 이해하고 기록을 남깁니다.

```bash
npm install -g @anthropic-ai/claude-code
```

설치 후 로그인합니다:
```bash
claude
```

처음 실행하면 브라우저가 열리고 claude.ai 계정 연동이 진행됩니다.
계정이 없으면 [claude.ai](https://claude.ai)에서 만듭니다.

> Claude Code는 claude.ai 유료 구독이 필요합니다.

연동이 완료되면 터미널로 돌아와 `q`를 눌러 Claude Code를 종료합니다.

---

## 4단계 — kytos-os 클론 및 스킬 설치

스킬(명령어) 파일을 받아옵니다.

```bash
git clone https://github.com/spiratus-org/kytos-os.git ~/git/kytos-os
bash ~/git/kytos-os/install.sh
```

설치 완료 메시지가 뜨면 성공입니다.

---

## 5단계 — 공유 레포 클론

팀 데이터가 쌓이는 레포를 받아옵니다.

```bash
git clone https://github.com/spiratus-org/kytos-os-spiratus.git ~/git/kytos-os-spiratus
```

> "접근 권한이 없다"는 오류가 나오면 팀 관리자에게 초대 요청을 합니다.

---

## 6단계 — 환경변수 설정

시스템이 데이터 위치를 알 수 있도록 설정합니다.

```bash
echo 'export KYTOS_DIR=$HOME/git/kytos-os-spiratus' >> ~/.zshrc
source ~/.zshrc
```

확인합니다:
```bash
echo $KYTOS_DIR
```

`/Users/[이름]/git/kytos-os-spiratus` 경로가 출력되면 성공입니다.

---

## 7단계 — 나 설정하기

Claude Code를 실행합니다:
```bash
claude
```

Claude Code 안에서 입력합니다:
```
/kytos-setup
```

이름, 역할, 소속 조직을 물어봅니다. 답하면 자동으로 저장됩니다.

---

## 완료

### 데이터가 저장되는 위치

```
~/git/kytos-os-spiratus/
├── individual/     ← 내 컴퓨터에만 존재. 팀과 공유되지 않음.
└── org/
    └── [팀명]/     ← 팀 전체가 볼 수 있음.
```

### 매일 이렇게 씁니다

```
/kytos-open                      ← 하루 시작할 때 한 번
/task-start [작업 이름]           ← 작업 시작할 때마다
... Claude와 함께 작업 ...
/task-end                        ← 작업 끝날 때마다
```

`/task-end`를 실행하면 `org/` 데이터가 팀 레포에 자동으로 커밋됩니다.

---

## 문제가 생겼을 때

- `KYTOS_DIR` 없다는 오류 → 6단계 재확인
- `/task-start` 명령이 없다 → Claude Code 재시작 후 재시도
- 기타 → [Issues](https://github.com/spiratus-org/kytos-os/issues)

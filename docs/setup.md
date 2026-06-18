# Kytos OS — 설치 가이드

팀원이 Kytos OS를 처음 설정하는 절차입니다.
따라하면 `/task-start`, `/task-end` 스킬이 작동하는 상태가 됩니다.

예상 소요 시간: **10분**

---

## 전제조건

- [Claude Code](https://claude.ai/code) 설치됨
- Git 설치됨
- (선택) [Obsidian](https://obsidian.md) 설치됨

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

GitHub에서 프라이빗 레포를 만들고 연결합니다 (이름 예: `kytos-data`).

```bash
git remote add origin https://github.com/[USERNAME]/kytos-data.git
git push -u origin main
```

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
open ~/kytos-data/individual/me.json
```

`YOUR_NAME`과 `ORG_NAME` 등을 실제 값으로 바꿉니다. `id`는 팀 내에서 고유하면 됩니다.

---

## 6단계 — Obsidian 볼트 열기 (선택)

Obsidian에서 **기존 볼트 열기** → `~/kytos-data/individual/vault/` 선택.

---

## 완료

이제 Claude Code에서 사용할 수 있습니다:

```
/task-start 바디템플 프로그램 설명 페이지 작성
... 작업 진행 ...
/task-end
```

`/task-end`가 세션을 정리하고 `~/kytos-data`에 자동으로 커밋합니다.

---

## 조직 뷰 추가

다른 팀원이 공유한 조직 기억을 받으려면 `org/` 폴더에 연결합니다.
(현재 준비 중 — 조직 데이터 레포 설계 이후 안내 추가 예정)

---

## 문제가 생겼을 때

- `KYTOS_DATA_DIR` 없다는 오류 → 4단계 재확인
- `/task-start` 명령이 없다 → Claude Code 재시작 후 재시도
- 기타 → [Issues](https://github.com/spiratus-org/kytos-os/issues)

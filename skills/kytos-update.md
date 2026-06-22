---
description: kytos-os 업데이트 — git pull 후 스킬 재설치
---

kytos-os가 업데이트됐을 때 실행합니다. 최신 스킬을 받아옵니다.

---

**1단계: kytos-os 위치 확인**

```bash
ls ~/git/kytos-os/install.sh
```

파일이 없으면 멈추고 안내합니다:
> `~/git/kytos-os`에 kytos-os가 없습니다.
> `docs/setup.md`의 1단계를 따라 먼저 클론해주세요.

---

**2단계: git pull**

```bash
cd ~/git/kytos-os && git pull 2>&1
```

결과에 따라:
- 새 커밋이 있음: "✓ 업데이트를 받아왔습니다"
- 이미 최신: "이미 최신 버전입니다" — 그래도 스킬 재설치는 진행합니다

---

**3단계: 스킬 재설치**

```bash
bash ~/git/kytos-os/install.sh
```

---

**4단계: 완료 메시지**

```
✓ kytos-os 업데이트 완료
━━━━━━━━━━━━━━━━━━━━━
Claude Code를 완전히 종료했다가 다시 실행해야 새 스킬이 적용됩니다.
━━━━━━━━━━━━━━━━━━━━━
```

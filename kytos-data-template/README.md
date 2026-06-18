# kytos-data

나의 Kytos OS 데이터 공간입니다.

이 레포는 **프라이빗**으로 유지합니다.
스키마(설계도)는 [kytos-os](https://github.com/spiratus-org/kytos-os)에 있습니다.

---

## 구조

```
kytos-data/
├── individual/          ← 나의 것. 내가 소유.
│   ├── me.json              개인 노드 정체성
│   ├── log.md               개인 작업 기록
│   ├── memory/              학습과 기억
│   ├── insights/            인사이트 (조직 공유 가능)
│   ├── contributions/       조직에 공유된 기여 목록
│   └── vault/               Obsidian 볼트
│
└── org/                 ← 내가 접근권 가진 조직 뷰
    └── [조직명]/
        ├── memory/          조직 기억 (로컬 캐시)
        ├── insights/        조직 인사이트 링크
        └── log.md           조직 작업 로그
```

---

## 데이터 주권

- `individual/` 안의 모든 것은 내가 소유합니다
- 조직에 공유할 것은 내가 직접 태그하고 허용합니다
- 언제든 공유를 철회할 수 있습니다

---

## 설정

이 레포를 clone한 후 환경변수를 설정합니다:

```bash
export KYTOS_DATA_DIR=~/kytos-data
```

`me.json`을 편집해 나의 정보를 입력합니다.

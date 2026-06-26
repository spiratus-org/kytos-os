# kytos-data

나의 Kytos OS 데이터 공간입니다.

이 레포는 **프라이빗**으로 유지합니다.
스키마(설계도)는 [kytos-os](https://github.com/spiratus-org/kytos-os)에 있습니다.

---

## 구조

```
kytos-data/               ← 개인 전용 프라이빗 레포
└── individual/
    ├── me.json               개인 노드 정체성
    ├── log.md                개인 작업 기록
    ├── memory/               학습과 기억
    ├── insights/             인사이트
    ├── contributions/        조직에 공유된 기여 목록
    └── vault/                Obsidian 볼트
```

조직 데이터는 별도의 공유 레포(`KYTOS_DIR`)에서 관리합니다.

---

## 데이터 주권

- 이 레포 안의 모든 것은 내가 소유합니다
- 조직 공유 데이터는 `KYTOS_DIR`로 분리되어 있습니다
- 언제든 공유를 철회할 수 있습니다

---

## 설정

이 레포를 clone한 후 환경변수를 설정합니다:

```bash
export KYTOS_DIR=~/kytos-data
```

조직 협업 시 공유 레포도 함께 설정합니다:

```bash
export KYTOS_DIR=~/[조직명]-org-data
```

`me.json`은 `/kytos-setup`으로 작성합니다.

# 프로젝트 구조

LIVING ORG OS PROJECT의 설계 구조와 로드맵.

*마지막 업데이트: 2026-06-08*

---

## 프로젝트 헌장

```
프로젝트명    LIVING ORG OS PROJECT
OS 가제       Kytos
최종 비전     Kytos OS → Mycelium Network
형태          오픈소스 스키마 + AI Middle OS
목표          누구든 다운받아 → 심으면 → 조직이 자란다
제약          저비용 · 저사양 · 범용 · 스키마/데이터 분리
라이센스      AGPL v3 + Commercial License (Dual Licensing)
스키마 포맷   JSON
AI            Claude (현재) — 모델 독립적으로 설계
```

---

## 핵심 구조

```
                        VISION
              살아있는 조직의 OS를 설계한다
                          │
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼
    Individual Node   AI Middle OS     Org Node
    (개인이 주체)     (Mycelium Layer)  (조직은 파생)
    학습·인사이트     스키마 해석        개인 기여 집합
    태그·권한 보유    의도 실행          크레딧 명시
    데이터 소유       흐름 중재          조직 간 연결

                          │
                          ▼
                    SCHEMA LAYER
              (이 레포에서 만드는 것)
              각 조직이 심어 쓰는 설계도

                          │
                          ▼
                     DATA LAYER
              (각 조직이 소유하는 것)
           실제 멤버 / 프로젝트 / 자원 / 기록
```

---

## WBS — 작업 분해 구조

```
LIVING ORG OS PROJECT
│
├── 0. DISCOVERY                          ✓ 완료
│   ├── 0-1  비전 문서화
│   ├── 0-2  기술 스택 결정
│   │         ├── 스키마 포맷: JSON
│   │         ├── AI: Claude (모델 독립 설계)
│   │         └── 저장소: Git 기반
│   ├── 0-3  라이센스 결정
│   │         └── AGPL v3 + Commercial License
│   └── 0-4  레포 구성
│
├── 1. FOUNDATION DESIGN                  → 진행 중
│   │
│   ├── 1-1  아키텍처 설계               ✓ 완료
│   │         ├── ✓ 노드 구조: Individual Node + Org Node
│   │         ├── ✓ 패러다임: 개인 OS 기본 단위, 조직은 파생
│   │         ├── ✓ 작업 분류 체계 (조직 / 개인→조직 / 개인)
│   │         ├── ✓ 셀프 피드백 루프 설계
│   │         ├── ✓ 권력 균형 장치 (데이터 주권 + 철회 메커니즘)
│   │         └── ✓ 네트워크 구조 시각화 (Mermaid + JSON)
│   │
│   ├── 1-2  AI Middle OS 역할 명세      ✓ 완료
│   │         ├── ✓ AI = Mycelium Layer (해석자, 중간 OS)
│   │         ├── ✓ kytos-[조직명] 활성화 명령 설계
│   │         └── ✓ Task 라이프사이클: /task-start → /task-end
│   │
│   ├── 1-3  핵심 스키마 설계            → 진행 중
│   │         ├── → Org Node 스키마 (JSON)     ← 지금 시작
│   │         ├── → Individual Node 스키마 (JSON)
│   │         ├── → 태그 시스템 스키마
│   │         ├── → 권한 시스템 (open/close/invite-only)
│   │         └── → 크레딧 시스템 스키마
│   │
│   └── 1-4  철학 통합                   ✓ 완료
│             ├── ✓ design-philosophy.md 작성 (살아있는 문서)
│             ├── ✓ 문제의식-해결방안 6쌍 정리
│             ├── ✓ 생태 모델 통합 (개인의 융성 → 전체 풍요)
│             └── → 소마틱 / 4E Cognition 연결 (추후)
│
├── 2. PROTOTYPE                          → 진행 중
│   ├── 2-1  스키마 v0.1 — JSON 초안
│   ├── 2-2  AI 해석 레이어 — 프롬프트 체계
│   │         ├── ✓ /task-start 스킬 구현
│   │         ├── ✓ /task-end 스킬 구현 (frontmatter 자동 생성 + git 커밋)
│   │         ├── ✓ /kytos-import 스킬 구현 (개인 노트 생태계 편입)
│   │         └── → kytos-[조직명] shell command 구현
│   ├── 2-3  바디템플 / 현현에 직접 적용하며 검증
│   └── 2-4  kytos-data-template 배포 및 팀 온보딩
│             ├── ✓ kytos-data-template 구조 설계 (vault 3구역 포함)
│             ├── ✓ install.sh 배포 스크립트
│             ├── ✓ docs/setup.md 완성
│             └── → 팀원 실제 온보딩 테스트
│
├── 3. MVP RELEASE                        → 미정
│   ├── 3-1  README + 철학 문서 정비
│   ├── 3-2  첫 번째 오픈소스 배포
│   └── 3-3  사용 가이드
│
└── 4. ECOSYSTEM                          → 미정
    ├── 4-1  커뮤니티 채널
    ├── 4-2  사례 조직 온보딩
    ├── 4-3  Mycelium Network 형성
    └── 4-4  식별자 레지스트리 설계
              → M6(오픈소스 배포) 전에 필요
              → 형태: git 레지스트리 (kytos-os/registry/, PR로 등록)
              → DB 불필요 — 도메인 기반 또는 git 목록으로 충분
              → 현재는 팀 관례(did:kytos:이름)로 운영
```

---

## 마일스톤

```
M0  ✓  Charter 확정            비전 + 이름(가제) + 방향
M1  ✓  기술 스택 결정           JSON / AGPL v3 / Claude
M2  ✓  레포 구성                GitHub 레포 오픈
M3  ✓  아키텍처 설계 완료        노드 구조 / 피드백 루프 / 철학 문서
M4     스키마 v0.1 설계          Org Node → Individual Node → 연결 시스템
M5     Prototype 검증            바디템플 / 현현 적용
M6     오픈소스 배포 v0.1
M7     첫 번째 외부 사용 조직
```

---

## 결정 사항

### 기술 결정

| 항목 | 결정 | 이유 |
|------|------|------|
| 스키마 포맷 | JSON | 기계 검증 가능, 범용, 어떤 환경에서도 읽힘 |
| 라이센스 | AGPL v3 + Commercial | 자유로운 공유 + 상업 보호 |
| AI | Claude (현재) | 모델 독립적으로 설계, 교체 가능 |
| 저장소 | Git | 저사양, 버전 관리, 오프라인 |
| CLA | 필수 | 라이센스 전략적 변경 권한 확보 |

### 아키텍처 결정

| 항목 | 결정 | 이유 |
|------|------|------|
| 노드 타입 | Individual Node + Org Node | 개인이 주체, 조직은 파생 |
| 패러다임 | 개인 OS 기본 단위 | 개인이 조직을 초청, 조직이 개인을 사용하지 않음 |
| 작업 분류 | 3가지 유형 | 조직 기억에 무엇이 들어오는지 명확히 구분 |
| 피드백 루프 | /task-start → /task-end | 작업 단위로 경험 추출, 조직 기억 축적 |
| 권력 구조 | 개인 데이터 주권 | 크레딧 귀속 + 철회 가능 → 조직이 개인 존중 |
| 참조 모델 | 오픈소스 + 학계 | commit 기록 + 논문 인용 방식 적용 |
| 그래프 포맷 | Mermaid + JSON | 시각화(Mermaid) + 기계처리(JSON node-link) |

---

## 미결정 사항

```
OS 이름              Kytos는 가제. 아직 확정되지 않았다.
Org Node 스키마      무엇을 최소한으로 담는가. 지금 설계 시작.
Individual Node      Org Node 이후 설계.
태그·권한·크레딧     스키마 설계 후 연결 시스템 설계.
식별자 고유성        현재: 팀 관례로 운영. M6 전에 git 레지스트리 설계 필요.
                     did:kytos: 메서드 스펙 결정 (도메인 기반 권장).
가격 정책            상업적 라이센스 비용 구조 미정.
거버넌스             커뮤니티 의사결정 구조 미설계.
```

---

## 산출물 현황

| 파일 | 상태 | 내용 |
|------|------|------|
| `README.md` | ✓ | 프로젝트 소개, 철학, 구조 |
| `docs/philosophy.md` | ✓ | 공개용 철학 소개 |
| `docs/design-philosophy.md` | ✓ | 설계 철학 + 아키텍처 (살아있는 문서) |
| `docs/project-structure.md` | ✓ | 이 문서 |
| `docs/network-graph.json` | ✓ | 네트워크 구조 (기계 처리용) |
| `schema/org-node.json` | → | 설계 시작 예정 |
| `schema/individual-node.json` | → | Org Node 이후 |
| `skills/task-start.md` | ✓ | 태스크 시작 스킬 |
| `skills/task-end.md` | ✓ | 태스크 종료 + git 커밋 스킬 |
| `kytos-data-template/` | ✓ | 개인 데이터 레포 템플릿 (Obsidian 볼트 포함) |
| `install.sh` | ✓ | 스킬 설치 스크립트 |
| `docs/setup.md` | ✓ | 설치 및 온보딩 가이드 |
| `LICENSE` | ✓ | AGPL v3 |
| `CLA.md` | ✓ | 기여자 라이센스 동의 |
| `CONTRIBUTING.md` | ✓ | 기여 가이드 |
| `COMMERCIAL.md` | ✓ | 상업 라이센스 안내 |

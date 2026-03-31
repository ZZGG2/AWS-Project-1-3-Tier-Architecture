# 🚀 AWS Project #1: 3-Tier Architecture

본 프로젝트는 AWS 클라우드 환경에서 고가용성(High Availability)과 보안(Security)을 극대화한 3-Tier Architecture를 구축하고, 실제 장애 상황을 가정한 트러블슈팅을 통해 인프라의 안정성을 검증한 프로젝트입니다.

---

## 🏗️ Architecture Diagram
![AWS-Project-1-3-Tier-Architecture](./architecture.png)

---

## 📌 Project Overview
* **기간**: 2026.03
* **핵심 목표**: 
    * Public/Private Subnet 분리를 통한 네트워크 보안 계층화
    * ALB 및 ASG를 활용한 무중단 서비스 환경 구축
    * SSM 도입으로 Bastion Host 없는 안전한 서버 관리 구현
    * RDS Multi-AZ 구성을 통한 데이터 가용성 확보

## 🛠 Tech Stack
* **Cloud**: AWS (VPC, EC2, RDS, ALB, ASG, SSM, IAM, NAT Gateway)
* **Web Server**: Nginx
* **Database**: MySQL (RDS)

---

## 🏛 Architecture Details

### 1. Networking & Security
* **VPC 설계**: `10.0.0.0/16` 대역을 가용 영역(AZ-2a, 2c)별로 세분화하여 설계
* **Security Group Chaining**: ALB 보안 그룹 ID를 EC2 인바운드 소스로 지정하여 계층 간 트래픽 통제
* **No Bastion Strategy**: AWS Systems Manager(SSM)를 도입하여 22번 포트(SSH) 개방 없이 서버 관리

### 2. Compute & Auto Scaling
* **Golden Image (AMI)**: Nginx 및 초기 환경이 세팅된 커스텀 AMI 생성
* **High Availability**: Launch Template과 ASG를 연동하여 가용 영역별 최소 2대의 인스턴스 상시 유지

### 3. Database
* **Multi-AZ RDS**: Primary-Standby 구조를 통해 리전 내 AZ 장애 시 자동 페일오버(Failover) 구현

---

## 🔍 Troubleshooting & Verification
실습 중 발생한 장애 상황과 비용 문제를 엔지니어링 관점에서 해결했습니다.

* **[Case 1] EC2/RDS 장애 복구 테스트**: 인스턴스 강제 종료 후 ASG의 자가 치유(Self-healing) 및 RDS의 자동 전환 확인
* **[Case 2] 비용 최적화**: NAT Gateway 및 EIP 등 프리티어 외 요금 발생 원인을 분석하고, AWS Budgets를 통한 모니터링 체계 구축

---

## 🔗 Detailed Blog Posts (Velog)
각 단계별 상세 구축 과정과 트러블슈팅 기록은 아래 블로그에서 확인하실 수 있습니다.

* 🌐 **Part 1**: [고가용성 3-Tier Networking 구축기](https://velog.io/@tkdxm0208/AWS-Project-1-%EA%B3%A0%EA%B0%80%EC%9A%A9%EC%84%B1-3-Tier-Architecture-%EA%B5%AC%EC%B6%95-Networking)
* 💻 **Part 2**: [EC2 & ASG를 활용한 고가용성 서버 환경 구축](https://velog.io/@tkdxm0208/AWS-Project-1-고가용성-3-Tier-Architecture-구축-Compute-Load-Balancing)
* 🗄️ **Part 3**: [RDS Multi-AZ 및 계층 간 연결 완성](https://velog.io/@tkdxm0208/AWS-Project-1-%EA%B3%A0%EA%B0%80%EC%9A%A9%EC%84%B1-3-Tier-Architecture-%EA%B5%AC%EC%B6%95-Database)
* 🛠️ **Part 4**: [장애 대응 테스트 및 자가 치유 검증](https://velog.io/@tkdxm0208/AWS-Project-1-Troubleshooting-%EC%9E%A5%EC%95%A0-%EB%B0%9C%EC%83%9D-%EC%8B%9C-%EC%9D%B8%ED%94%84%EB%9D%BC%EC%9D%98-Failover-%EA%B2%80%EC%A6%9D)
* 💰 **Part 5**: [예상치 못한 요금 폭탄 해결기 및 비용 최적화](https://velog.io/@tkdxm0208/AWS-Project-1-비용-최적화-예상치-못한-요금-발생)

---

## 📂 Project Structure
```text
.
├── scripts/
│   └── install_nginx.sh    # EC2 초기 세팅용 User Data 스크립트
└── README.md

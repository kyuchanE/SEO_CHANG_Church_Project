# SEO_CHANG_Church_Project

### 이 프로젝트는 Flutter의 Bloc, Clean Architecture 설계를 목표로한 간단한 성경 구절 탐색 기능을 구현 했습니다.

## 👉 Project Architecture

![Image](https://github.com/user-attachments/assets/340dc129-cad7-4dfd-81d4-acb836f8de5e)


## 👉 Clean Architecture
<img src = "https://github.com/user-attachments/assets/e3945ef3-edcf-4196-860d-3d13f96f1537" width = "480" height = "300"/>

#### 🎯 Clean Architecture의 필요성
- 모듈별 테스트에서 이점을 얻을 수 있다.
- 유지보수성에서 이점을 얻을 수 있다.
- 비즈니스 로직을 완전히 분리하여 여러 플랫폼에서 활용 가능 하다.

#### 🤝 계층 의존 관계
- Presentation Layer -> Domain Layer <- Data Layer
#### ▶️ Presentation Layer (UI)
- Data, Domain Layer에 의존한다.
#### ▶️ Domain Layer
- 가장 내부에 위치하며 독립적인 존재.
- 다른 계층의 수정 또는 변화가 Domain에 영향을 줄 수 없다.
- 핵심 비즈니스 로직.
#### ▶️ Data Layer
- 필요한 Data를 조회 관리하는 계층.

## 👉 DI
Clean Architecture의 계층별 의존성을 위한 작업 필요 
get_it, injectable 패키지를 활용하여 진행.

- 📘 [pub.dev - get_it](https://pub.dev/packages/get_it)
- 📘 [pub.dev - injectable](https://pub.dev/packages/injectable)

## 👉 상태관리
MVVM 디자인 패턴에서의 ViewModel과 비슷한 역할을 Bloc를 통하여 가능하다고 생각합니다.
flutter_bloc, bloc 패키지를 활용하여 진행.

- 📘 [pub.dev - flutter_bloc](https://pub.dev/packages/flutter_bloc)
- 📘 [pub.dev - bloc](https://pub.dev/packages/bloc)

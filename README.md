# NowToDo 📌
할 일을 추가하고 마감일 저장, 푸시 알림을 설정할 수 있는 서비스입니다.

## 스킬
- SwiftUI
- MVVM Pattern
- UserDefaults
- UserNotifications

## 특징

### 메인화면
- 사용자가 설정한 ToDo를 스크롤하여 볼 수 있습니다.
- 우측 상단의 메뉴 버튼은 ToDo 정렬 등 여러 기능을 수행합니다.
- 하단의 '새로운 미리 알림'을 누르면 ToDo가 추가됩니다.

<img src="https://github.com/user-attachments/assets/0fe6ee41-992e-4121-b45b-0e9700653574" width="300" alt="메인화면">

### ToDo
- '할 일 추가'에 할 일을 입력합니다.
- 버튼을 누르면 임시 완료 상태가 되어 텍스트가 회색으로 바뀝니다.
- 3초 간 클릭이 더 없다면 선택된 ToDo들을 완료된 항목으로 이동합니다.
- 셀을 왼쪽으로 밀어 마감일, 푸시 알림을 설정하고 ToDo를 삭제합니다.
- 셀을 오른쪽으로 밀어 세부사항을 확인합니다.

  #### 마감일 설정
  - 마감일이 설정되면 버튼이 연두색으로 바뀌며, 남은 일 수가 표시됩니다.
  - 24시간 이상 남았다면 연두색, 이내라면 주황색, 지났다면 빨간색으로 표시됩니다.
  - '기한 지우기'를 통해 마감일을 초기화할 수 있습니다.
  
<img src="https://github.com/user-attachments/assets/186cfd52-f656-40a4-934c-c92c0f7547bf" width="300" alt="할 일 추가, 완료">
<img src="https://github.com/user-attachments/assets/296f5f48-3a28-4372-b6e8-6e59ed9c8e3a" width="300" alt="할 일 추가, 완료">

  #### 알림 설정
  - 이미 지난 시간이거나 푸시 알림 권한을 허용하지 않은 경우 설정할 수 없습니다.
  - 알림이 설정되면 아이콘이 활성화됩니다.
  - 마감일 이후 설정된다면 확인 메시지를 보냅니다.
  - 입력한 텍스트가 알림에 표시됩니다.
  - '알림 지우기'를 통해 알림을 취소할 수 있습니다.
<img width="300" alt="스크린샷 2025-05-26 오후 5 31 04" src="https://github.com/user-attachments/assets/652be740-4762-4c73-9ec0-5c73a3dbc531" />
<img width="300" alt="스크린샷 2025-05-26 오후 4 40 03" src="https://github.com/user-attachments/assets/78e37275-6828-4693-93fc-78eb6b58e469" />
<p></p>

  <img width="200" alt="스크린샷 2025-05-26 오후 4 16 49" src="https://github.com/user-attachments/assets/86f736a1-dea0-4f25-aeb5-7787d526b897" />
  <img width="200" alt="스크린샷 2025-05-26 오후 4 17 10" src="https://github.com/user-attachments/assets/74b29716-373b-4cc0-a932-5bc2d2284f1e" />
  <img src="https://github.com/user-attachments/assets/e0c9e412-206e-493f-9c02-5108c05f5df9" width="200" alt="할 일 추가, 완료">

  #### 삭제
  - ToDo 셀을 끝까지 밀면 ToDo가 삭제됩니다.
  - 이후 울릴 알림이 있었다면, 자동으로 취소시킵니다.
 <img src="https://github.com/user-attachments/assets/5288c7bb-3bf4-4545-864f-1080c2c22f19" width="300" alt="할 일 추가, 완료">
  
  #### 세부 사항
  - 해당 ToDo에 대한 구체적인 마감일과 알림일을 보여줍니다.
<img width="300" alt="스크린샷 2025-05-26 오후 5 37 22" src="https://github.com/user-attachments/assets/47181d10-5ea6-4368-8226-a0eb0c901467" />
<img width="300" alt="스크린샷 2025-05-26 오후 4 56 57" src="https://github.com/user-attachments/assets/8d262929-f676-4c26-84a5-e3a25ca67647" />

### 메뉴
- 울린 알림과 완료된 항목을 볼 수 있습니다.
- 앱에 들어오면 울린 알림 항목이 업데이트 됩니다.
- '삭제'를 클릭하면, 확인 후 버튼이 눌린 일들을 삭제합니다.
- ToDo를 먼저 추가한 순(기본), 마감이 빠른 순 중 선택하여 정렬합니다.
- 현재 정렬 방식에 체크마크가 표시됩니다.
- 마감일 정렬의 경우, 마감일이 없는 ToDo는 뒤로 밀리며 먼저 추가한 순으로 배치됩니다.
<img width="200" alt="스크린샷 2025-05-26 오후 5 31 17" src="https://github.com/user-attachments/assets/add36c02-da13-461f-93f6-9415cc3f51da" />
<img width="200" alt="스크린샷 2025-05-26 오후 4 56 57" src="https://github.com/user-attachments/assets/ee57f803-53ff-4a25-a65c-5312200ac9e9" />
<img width="200" alt="스크린샷 2025-05-26 오후 4 56 57" src="https://github.com/user-attachments/assets/26111615-f4b2-488e-8c5a-351bbdee3cbe" />

.

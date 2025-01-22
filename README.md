# log-viewer



### 팀원 소개
|<img src="https://avatars.githubusercontent.com/u/95984922?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/165532198?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/121565744?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/179544856?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|나홍찬<br/>[@nahong_c](https://github.com/HongChan1412)|김소연<br/>[@ssoyeonni](https://github.com/ssoyeonni)|이은정<br/>[@eundeom](https://github.com/eundeom)|이은준<br/>[@2EunJun](https://github.com/2EunJun)|

<br><br>
　　
## 🚨트러블 슈팅
### 1. Windows에서 SSH 연결로 Linux의 데이터를 가져오는 과정에서 에러 발생<br>

**🛎해결법**
1) 윈도우 공유 폴더 만들어서 우분투에 연결하기 위해 마운트 시키기
2) Linux에 filebeat 설치
3) SSH 파일 전송 프로토콜인 scp 명령어를 사용하여 log 파일 받기 <- 채택 ✔
<br><br><br>

### 2. logstash에서  logstash -f ../config/ubuntu.conf 실행시켰을 때 연결이 shutdown되는 에러 발생<br>
**🧩원인**
- conf 파일 코드에서 쉼표(,)로 인한 오류<br>

**🛎해결법**<br>
- conf 파일 문법에 맞도록 오류 코드 수정
<br><br><br>

### 3. 윈도우의 작업 스케쥴러에 등록한 배치파일이 정상적인 실행이 안되는 오류
**🛎해결법**
<br>
1. 시작 위치 옵션을 사용하여 경로와 프로그램을 분리하기<br>


![image](https://github.com/user-attachments/assets/bfe10537-45d4-4bb9-b9f7-2285dde10bcd)
- 프로그램/스크립트 빈칸에 파일 위치가 모두 적혀있었음

![image](https://github.com/user-attachments/assets/2d30ab5f-0687-4646-8359-4c8972ff50a3)
- 경로를 시작 위치로 따로 적어주고 프로그램만 남겨둠
- 해결 안됨❌<br><br>

2. 전원 코드 연결<br>

  - 전원 코드 연결하여 충전하면서 작업 스케쥴러 실행
  - 성공!!!⭕
<br>

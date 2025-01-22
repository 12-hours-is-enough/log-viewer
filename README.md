
# log-viewer 📝

<br><br>

## 팀원 소개
<div align=center> 
  
|<img src="https://avatars.githubusercontent.com/u/95984922?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/165532198?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/121565744?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/179544856?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|나홍찬<br/>[@nahong_c](https://github.com/HongChan1412)|김소연<br/>[@ssoyeonni](https://github.com/ssoyeonni)|이은정<br/>[@eundeom](https://github.com/eundeom)|이은준<br/>[@2EunJun](https://github.com/2EunJun)|

</div>

<br><br>

## 🔍 프로젝트 개요
### ◽ 목표
⇢ **리눅스 서버에서 발생하는 로그 기록 (auth.log)을 수집**하여, 이를 **실시간으로 시각화하고 분석**하는 시스템을 구축하였습니다. <br>
### ◽ 주제 선택 이유
⇢ 서버 관리자가 로그 데이터를 효과적으로 분석할 수 있도록 도와주는 시스템을 구축 하는 것이 목표입니다. <br> 
우분투 서버 접속 기록을 실시간으로 모니터링하고, 로그인 성공/실패 여부, 접속자 IP 등을 시각적으로 확인할 수 있도록 하여, <br>
<b>서버 보안을 강화</b>하고 <b>로그 데이터를 쉽게 추적</b>할 수 있는 환경을 제공합니다. <br> 
이는 서버 관리자의 효율적인 문제 해결과 의사 결정을 돕기 위한 연습이기도 합니다.

<br><br>

## 🗄️ 프로젝트 구성 (흐름?)
- **로그 수집**: 리눅스 서버의 auth.log 파일을 수집하여 실시간으로 로그를 기록합니다.
- **데이터 파이프라인**
<div align=center> 
  <img src="https://github.com/user-attachments/assets/70457385-9ef5-4f79-ad90-324afc4580de" width="1000"/>
</div>

- **데이터 영구 저장**: **MySQL에 로그 파일을 영구적으로 저장**하여 나중에 분석할 수 있도록 합니다.
- **자동화**: 윈도우 작업 스케줄러을 이용하여 데이터 수집 및 전송을 **10분마다 자동으로 실행되도록 설정**합니다.
- **서버 접근자 추적**: 접속자의 **IP 주소를** 추출하여 서버 접근자 정보를 추적하고, 로그인 시도에 대한 성공/실패 여부를 기록합니다.

<br><br>

## 🧱 기술 스택

<div align=center> 
  
  <img src="https://img.shields.io/badge/ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
  
  <img src="https://img.shields.io/badge/virtualbox-2F61B4?style=for-the-badge&logo=virtualbox&logoColor=white">
  
  <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
  
  <img src="https://img.shields.io/badge/linux-FCC624?style=for-the-badge&logo=linux&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/elasticsearch-005571?style=for-the-badge&logo=elasticsearch&logoColor=white">
  
  <img src="https://img.shields.io/badge/kibana-005571?style=for-the-badge&logo=kibana&logoColor=white">
  
  <img src="https://img.shields.io/badge/logstash-005571?style=for-the-badge&logo=logstash&logoColor=white">
  
  <img src="https://img.shields.io/badge/beats-005571?style=for-the-badge&logo=beats&logoColor=white">
</div>

<br><br>

## ⚙ Architecture

<div align=center> 
  <img src="https://github.com/user-attachments/assets/af972e81-35b9-4051-8d30-473fc1ba0bee" width="600"/>
</div>


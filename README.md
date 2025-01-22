
## log-viewer 📝

<br>

## ◌ 목차
1. [⏲팀 소개](#-team-12시간이-모자라)
2. [🔍 프로젝트 개요](#-프로젝트-개요)
3. [🗄️ 프로세스 흐름도](#%EF%B8%8F-프로세스-흐름도)
4. [🧱 기술 스택](#-기술-스택)
5. [⚙ 아키텍쳐](#-아키텍쳐)
6. [💻 주요 코드](#-주요-코드)
7. [🔄 실행 흐름](#-실행-흐름)
8. [🚨 트러블 슈팅](#-트러블-슈팅)
9. [회고](#-회고)

<br>


## ⏲ TEAM 12시간이 모자라 
### 팀원 소개
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


<br><br>

## 🗄️ 프로세스 흐름도
- **데이터 파이프라인**
<div align=center> 
  <img src="https://github.com/user-attachments/assets/70457385-9ef5-4f79-ad90-324afc4580de" width="1000"/>
</div>

- **로그 수집**: 리눅스 서버의 auth.log 파일을 수집하여 실시간으로 로그를 기록합니다.
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

## ⚙ 아키텍쳐


<div align=center> 
  <img src="https://github.com/user-attachments/assets/af972e81-35b9-4051-8d30-473fc1ba0bee" width="600"/>
</div>

<br> <br>

## 💻 주요 코드 

> **Get-Log.bat**
```
# Ubuntu에 접속해 /var/log/auth.log 복사해서 C:\00.dataSet\auth.log 저장
set REMOTE_USER=ubuntu
set REMOTE_HOST=127.0.0.1
set REMOTE_PATH="/var/log/auth.log"
set LOCAL_PATH="C:\00.dataSet\auth.log"

if exist "%LOCAL_PATH%" (
    del "%LOCAL_PATH%"
)
scp %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_PATH% %LOCAL_PATH%
```

> **logs_ddl.sql**
```
# Log가 적재되는 MySQL 테이블 DDL
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,          	
    timestamp DATETIME,                			
    hostname VARCHAR(255),             				
    program VARCHAR(255),              				
    ip_address VARCHAR(255),						
    connection_status VARCHAR(255),					
    pid INT ,                           			
    message VARCHAR(255),                       	
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    UNIQUE KEY unique_message (message)     		
);
```

> **filebeat_ubuntu.yml**
```
# filebeat input 설정
filebeat.inputs:
  - type: log
    enabled: true
    paths:
      - "C:/00.dataSet/auth.log"
# filebeat output 설정
output.logstash:
  hosts: ["localhost:5044"]
```

> **ubuntu.conf**
```
# log기록 전처리
filter {
   grok {
      match => {
         "message" => "%{TIMESTAMP_ISO8601:timestamp}\s+%{HOSTNAME:hostname}\s+%{WORD:program}\[%{INT:pid}\]:\s+(.*)"
      }
   }

   # IP 주소 추출 (로그 메시지에서 'from IP_ADDRESS' 패턴을 찾아서 ip_address 필드에 저장)
   grok {
      match => {
         "message" => "from\s+(?<ip_address>\d+\.\d+\.\d+\.\d+)"
      }
   }

   # 접속 상태 구분 (성공/실패 및 연결 끊김 여부)
   if "Accepted password" in [message] or "Accepted publickey" in [message] {
      mutate {
         add_field => {
            "connection_status" => "success"
         }
      }
   } else if "Failed password" in [message] {
      mutate {
         add_field => {
            "connection_status" => "failed"
         }
      }
   } else if "Connection reset" in [message] {
      mutate {
         add_field => {
            "connection_status" => "connection_reset"
         }
      }
   }

   # 불필요한 필드 제거
   mutate {
      remove_field => ["ecs", "host", "@version", "agent", "log", "tags", "input", "date"]
   }

   # 타임스탬프 포맷 변환
   date {
      match => ["timestamp", "ISO8601"]  # timestamp를 Date 타입으로 변환
      timezone => "Asia/Seoul"
      target => "@timestamp"  # @timestamp 필드에 저장
   }
}

# output 
output {
   elasticsearch {
      hosts => ["http://localhost:9200"]
      index => "ubuntu"
      document_id => "%{timestamp}"  # Using timestamp as the unique ID
   }

   jdbc {
      driver_jar_path => "C:\\02.devEnv\\ELK\\logstash-7.11.1\\logstash-core\\lib\\jars\\mysql-connector-j-9.1.0.jar"
      driver_class => "com.mysql.jdbc.Driver"
      connection_string => "jdbc:mysql://localhost:3306/fisa"
      username => "user01"
      password => "user01"
      statement => [
         "INSERT INTO logs (timestamp, hostname, program, ip_address, connection_status, pid, message, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())",
         "timestamp",
         "hostname",
         "program",
         "ip_address",
         "connection_status",
         "pid",
         "message"
      ]
   }
}
```

<br><br>

## 🔄 실행 환경 구성

**1. conf 파일(ubuntu.conf)과 yml 파일(filebeat_ubuntu.yml) 설정**<br><br>
**2. scp 명령어로 Linux의 auth.log 파일 복사**<br>
　```
　scp ubuntu@127.0.0.1:/var/log/auth.log C:\00.dataSet
　```
<br><br>
**3. .bat 파일 생성하여 실행 자동화**<br><br>
**4. .bat 파일을 스케쥴러에 등록**<br>

- 방법 1.<br>
　```
　schtasks /create /tn "10분마다 실행하는 작업" /tr "C:\경로\프로그램.exe" /sc minute /mo 10
　```
<br>

- 방법 2.<br>
　![image](https://github.com/user-attachments/assets/bc0cc444-e506-458b-9024-14b68edf223e)
<br><br>

**5. 스케쥴러를 이용한 자동 로그 갱신이 ElasticSearch에 전송되었는지 확인**<br>
　![image](https://github.com/user-attachments/assets/e5b9b6b7-8361-4b50-bc6c-6bc77ac54df3)
<br><br>

**6. log 정보를 MySQL에 영구 저장**<br>
- 방법?

- 사진
<br><br>

**7. ES의 log 정보를 Kibana로 시각화**

<br><br>
## Kibana 대시보드?시각화?
=======
> output에 Elasticsearch과 MySQL을 사용하는 이유
>
> Log기록은 영구저장되야 하기 때문에 MySQL에 적재, Elasticsearch 에서는 최신 log 저장



<br><br>
　　

## 🚨 트러블 슈팅
### 1. Windows에서 SSH 연결로 Linux의 데이터를 가져오는 과정에서 에러 발생 <br>


**🛎해결법**
1) 윈도우 공유 폴더 만들어서 우분투에 연결하기 위해 마운트 시키기
2) Linux에 filebeat 설치
3) SSH 파일 전송 프로토콜인 scp 명령어를 사용하여 log 파일 받기 <- 채택 ✔
<br><br><br>

### 2. logstash에서  logstash -f ../config/ubuntu.conf 실행시켰을 때 연결이 shutdown되는 에러 발생<br>
**🧩원인**
- conf 파일 코드에서 쉼표(,)로 인한 오류<br>

**🛎해결법**
<br>
- conf 파일 문법에 맞도록 오류 코드 수정
<br><br><br>

### 3. 윈도우의 작업 스케쥴러에 등록한 배치파일이 정상적인 실행이 안되는 오류
**🛎해결법**
<br>
1. 시작 위치 옵션을 사용하여 경로와 프로그램을 분리하기<br>

<img src="https://github.com/user-attachments/assets/bfe10537-45d4-4bb9-b9f7-2285dde10bcd" width="400"/>

- 프로그램/스크립트 빈칸에 파일 위치가 모두 적혀있었음

<img src="https://github.com/user-attachments/assets/2d30ab5f-0687-4646-8359-4c8972ff50a3" width="400"/>

- 경로를 시작 위치로 따로 적어주고 프로그램만 남겨둠
- 해결 안됨❌<br><br>

2. 전원 코드 연결<br>
  - 전원 코드 연결하여 충전하면서 작업 스케쥴러 실행
  - 성공!!!⭕
<br><br><br>

### 4. logstash output을 jdbc 연결
**🧩원인**
- logstash는 공식적으로 jdbc output plugin을 지원하지 않음<br>

**🛎해결법**
<br>
1. https://dev.mysql.com/downloads/connector/j/ MySQL Connector(Platform Independent) 설치<br>
2. https://github.com/theangryangel/logstash-output-jdbc 해당 외부 플러그인 설치<br>
3. logstash output jdbc 설정<br>

> 참고 : https://discuss.elastic.co/t/jdbc-for-input-and-output/186722
   
## 회고
Ubuntu에는 다양한 Log들이 있는데 auth.log만 분석해 아쉬움이 남았다.

=======

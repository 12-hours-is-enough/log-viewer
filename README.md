# log-viewer



### 팀원 소개
|<img src="https://avatars.githubusercontent.com/u/95984922?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/165532198?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/121565744?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/179544856?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|나홍찬<br/>[@nahong_c](https://github.com/HongChan1412)|김소연<br/>[@ssoyeonni](https://github.com/ssoyeonni)|이은정<br/>[@eundeom](https://github.com/eundeom)|이은준<br/>[@2EunJun](https://github.com/2EunJun)|

---

### 주요 코드
**Get-Log.bat**
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

**logs_ddl.sql**
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

**filebeat_ubuntu.yml**
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

**ubuntu.conf**
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
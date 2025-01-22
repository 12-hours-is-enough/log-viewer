CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,          	-- 고유 ID (자동 증가)
    timestamp DATETIME,                				-- 로그 발생 시간
    hostname VARCHAR(255),             				-- 호스트 이름
    program VARCHAR(255),              				-- 프로그램 이름
    ip_address VARCHAR(255),						-- 접근 ip
    connection_status VARCHAR(255),					-- 접속 상태
    pid INT ,                           			-- 프로세스 ID
    message VARCHAR(255),                       	-- 로그 메시지
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 데이터 생성 시간
    UNIQUE KEY unique_message (message)     		-- timestamp를 기준으로 중복 방지
);

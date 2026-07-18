#!/bin/bash

# 1. 시스템 업데이트 및 Nginx 설치
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y || sudo yum install nginx -y

# 2. Nginx 서비스 시작 및 부팅 시 자동 실행 설정
sudo systemctl start nginx
sudo systemctl enable nginx

# 3. IMDSv2(Instance Metadata Service)를 사용하여 가용 영역(AZ) 정보 추출
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# 4. 테스트용 웹 페이지 생성 (Project #1 전용 레이아웃)
cat <<EOF | sudo tee /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>AWS Project #1 | High Availability Test</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            text-align: center; 
            background-color: #f4f7f6;
            margin-top: 100px; 
        }
        .container {
            background-color: white;
            display: inline-block;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border-top: 8px solid #FF9900; /* AWS Orange */
        }
        h1 { color: #232F3E; margin-bottom: 10px; }
        p { color: #555; }
        .az-label { 
            font-size: 2.5em; 
            font-weight: bold; 
            color: #FF9900; 
            margin: 20px 0;
            padding: 10px;
            background-color: #fffaf0;
            border-radius: 10px;
        }
        .footer { font-size: 0.9em; color: #888; margin-top: 30px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>AWS Project #1</h1>
        <p>3-Tier Architecture Connectivity Test</p>
        <hr style="border: 0.5px solid #eee;">
        <p>Currently responding from Availability Zone:</p>
        <div class="az-label">$AZ</div>
        <p>Managed by <b>Auto Scaling Group</b> & <b>ALB</b></p>
        <div class="footer">
            Status: Healthy | Connection: SSM Managed
        </div>
    </div>
</body>
</html>
EOF

# 5. 권한 설정 확인
sudo chmod 644 /usr/share/nginx/html/index.html

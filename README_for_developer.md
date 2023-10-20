# How to contribute
- Project link: https://codeup.aliyun.com/5f3f374f6207a1a8b17f933f/carsmos/docs
- Steps:
    - Clone the project
    - Checkout a new branch
    - Modify the code
    - Commit and push the code
    - Waiting for merging to master
    - After merging to master, the code will be updated automatically on the server in 5 minutes


# 配置 HTTPS
 server {
   listen 443 ssl;
   server_name yourdomain.com;  # 替换为你的域名

   # SSL 证书和密钥文件路径
   ssl_certificate /home/ecs-user/race/cert.pem;
   ssl_certificate_key /home/ecs-user/race/cert.key;

   # 配置静态网页根目录
   root /home/ecs-user/race;

   location / {
     try_files $uri $uri/ =404;
   }
 }
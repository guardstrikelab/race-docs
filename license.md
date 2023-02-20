### 1、手动执行脚本生成机器码

机器码默认情况下是自动生成回填的，如果不能自动生成，需要手动生成机器码，操作步骤如下所示。

1.1环境要求

ubuntu 20.04（执行脚本的账户需要sudo权限，可以执行sudo -i测试。添加sudo权限，在root用户下，用vi编辑 /etc/sudoers文件，添加如下配置，然后wq!保存退出

`you_account_name   ALL=(ALL)     NOPASSWD: ALL` ）

python 3.8（仅供参考：Anaconda下载地址：[__https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh__](https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh)）

#验证conda是否安装正常，通过获取版本号

`conda --version 或 conda -V`

#创建制定python版本的环境

`conda create --name py38 python=3.8`

#使用如下命令即可激活创建的虚拟环境

`conda activate py38`

### 1.2执行命令生成机器码(*只能在python3.8上运行*)

![](https://tcs-devops.aliyuncs.com/storage/112q723ce83d1c00d64d4fc100f391ed3865?Signature=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcHBJRCI6IjVlNzQ4MmQ2MjE1MjJiZDVjN2Y5YjMzNSIsIl9hcHBJZCI6IjVlNzQ4MmQ2MjE1MjJiZDVjN2Y5YjMzNSIsIl9vcmdhbml6YXRpb25JZCI6IiIsImV4cCI6MTY3NzQ2NzIxNSwiaWF0IjoxNjc2ODYyNDE1LCJyZXNvdXJjZSI6Ii9zdG9yYWdlLzExMnE3MjNjZTgzZDFjMDBkNjRkNGZjMTAwZjM5MWVkMzg2NSJ9.wojmKLOIZ0LcSdfDBb_lYOLcV2FF6yR-Eh4pPl30hqs&download=image.png "")

机器码生成脚本下载链接: [__https://pan.baidu.com/s/1mSF9hFtRhSr7ZrPuWKzwQA__](https://pan.baidu.com/s/1mSF9hFtRhSr7ZrPuWKzwQA) 提取码: 8ra7 

复制这段内容后打开百度网盘手机App，操作更方便哦
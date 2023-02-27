## 8 报名系统操作说明

### 8.1 参赛流程
1. 利用邮箱地址注册或登录
![](js/images/baoming/1.png)
2. 在您填写的邮箱中点击链接进行验证
![](js/images/baoming/2.png)

3. 进入系统，选择 carsos 2023 开源智驾算法大赛
![](js/images/baoming/3.png)

4. 输入队伍名，创建队伍
![](js/images/baoming/5.png)

5. 选择刚刚创建的队伍，输入团队介绍和参赛说明，点击申请参赛
![](js/images/baoming/6.png)

6. 等待审核通过
![](js/images/baoming/7.png)

7. 审核通过后，刷新页面，即可开始提交镜像
![](js/images/baoming/8.png)


### 8.2 提交流程

1. 点击新增提交，获取指令，首先在本地安装 AWS CLI，以及配置相关的环境变量，登录容器仓库
![](js/images/baoming/9.png)

2. 构建镜像
- 如果未基于 Dora 开发，直接复制下图命令执行；
- 如果基于 Dora 开发，在下图命令最后添加：-d 或者 --dora

    ![](js/images/baoming/10.png)

3. 构建镜像成功后，提交镜像
![](js/images/baoming/11.png)
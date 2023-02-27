[上一页：比赛规则](rules.md)

***

## 4.1 环境准备
请确保您的环境变量 `TEAM_CODE_ROOT` 指向了您的代码文件夹，否则请参考 [测试您的算法](install.md#24-训练和测试您的算法) 配置环境变量
```bash
export TEAM_CODE_ROOT={YOUR_PATH}/team_code
```

将您的 agent 文件 YOUR_AGENT.py 以及相关的代码放入`${TEAM_CODE_ROOT}`文件夹中。

> 注意：您对Oasis、Simulate的任何修改在提交后将不会被应用和运行。

打开用于构建镜像的文件：

```bash
vim Dockerfile
```

在dockerfile中，修改如下内容，以指定您的agent路径：并且加上相关配置

**请注意：环境变量 TEAM_AGENT 不要带有路径**

```bash
ENV TEAM_AGENT YOUR_AGENT.py
```

## 4.2. 构建并提交镜像

1. 进入[比赛报名系统](https://race.carsmos.cn/)，点击Get Started，然后**利用您的常用邮箱注册**或者登录

2. 点击“carsmos 2023 开源智驾算法大赛”

3. 点击 "申请参数"，在 “Team Name“ 输入框中输入队伍名字，点击创建您的队伍

4. 等待审核，审核通过后进行下一步

5. 审核成功后，会在您的邮件发送短信提示。此时进入报名系统提交页面，点击“新增提交”，可获取提交镜像的命令。

6. **逐条复制命令到您的电脑，并且执行**

> 如果以后多次提交镜像，您只需要执行登录命令、打包镜像命令和推送镜像命令

7. **镜像上传成功之后，云端即开始运行您的算法。**

> 您需要等待一段时间（10分钟至1小时，取决于您的算法），然后您可以在：[**比赛报名系统**](https://race.carsmos.cn/) - carsmos 2023 春季赛事 - Submissions - History
看到您本次提交的运行结果。


***

[上一页：比赛规则](rules.md)

[下一页：声明条款](clause.md)
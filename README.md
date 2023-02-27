***

## 1.1 比赛介绍

元遨 Carsmos 开源智驾算法大赛的主要目标是评估自动驾驶算法在现实交通场景中的驾驶能力。您只需要在 [**比赛报名系统**](https://race.carsmos.cn/) 上注册，提供您的团队信息并通过审核即可参与。

本次比赛由西安深信科创信息技术有限公司。

## 1.2 比赛任务

比赛基于 [**Oasis自动驾驶仿真平台**](https://guardstrike.com/tech.html)，比赛通过一组预定义的 [**场景**](rules.md#32-比赛场景) 对自动驾驶算法进行测试。

对于每个场景，由您的算法控制的自动驾驶车辆将在一个起点被初始化，并被指示开往预定义的终点。 场景包含天气、光照条件、交通流（车辆、行人）、红绿灯、交通标志、路障等各种元素。

您的算法需要合理利用系统提供的各种 [**场景信息**](scenarios.md) 和 [**传感器信息**](install.md#223-覆盖-sensors-方法)，使您的自动驾驶车辆顺利通过这些预定义场景，并且争取在各个 [**评价指标**](rules.md#311-评价指标) 上获得更高的得分。

## 1.3 比赛日程

- 3.15 开始报名

- 4.20 提交截至

- 5.10 线下比赛开始

- 6.20 线下比赛结束

- 6.30 颁奖

## 1.4 比赛奖励

- 冠军：1支队伍，奖金**￥200,000**

- 亚军：2支队伍，每支队伍奖金**￥50,000**

- 季军：3支队伍，每支队伍奖金**￥20,000**

- 7-10名：每支队伍奖金。。。

## 1.5 如何开始

1. 在比赛报名系统注册，创建队伍并邀请队友或加入队伍，参与比赛。

2. 下载 [**Oasis竞赛版**](https://carsmos.oss-cn-chengdu.aliyuncs.com/oasis-bisai.tar.gz) 

3. 根据oasis竞赛版 [__安装部署文档__](install.md#21-开发环境配置)，安装运行oasis竞赛版系统，通过Oasis客户端中的 `oasis用户手册`，熟悉系统功能。

4. 根据 [__carsmos开发指引__](install.md#22-开始开发)，基于oasis竞赛版，开发和测试您的程序。

5. 在 [**比赛报名系统**](https://race.carsmos.cn/) 按照提示，打包算法到镜像，并提交镜像到云端，等待运行结果和得分。

## 1.6 比赛帮助和答疑

如果您对本次开源自动驾驶算法大赛有任何意见或建议，请通过以下渠道与我们联系。

- 邮箱：carsmos@guardstrike.com

如果您在参赛过程中有任何疑问，欢迎加群讨论

- 微信/钉钉答疑群：
  - 微信/钉钉搜索群号：666666
  - 微信/钉钉扫描下方二维码入群：
  
  ![二维码](js/images/QRcode.png)

## 1.7 文档目录

- [开发指引](install.md#21-开发环境配置)

- [比赛规则](rules.md#31-评分机制)

- [提交说明](submit.md#41-环境准备)

- [声明条款](clause.md#5-声明条款)

- [场景说明](scenarios.md#6-比赛场景)

***

[下一页：开发环境](install.md#21-开发环境配置)
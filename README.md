***

## 1.1 比赛介绍

元遨 Carsmos 开源智驾算法大赛的主要目标是评估自动驾驶算法在现实交通场景中的驾驶能力。参赛选手只需要在 [**比赛报名系统**](https://race.carsmos.cn/) 上注册，提供团队信息并通过审核即可参与。

本次比赛由[**西安深信科创信息技术有限公司**](https://guardstrike.com/)举办。

## 1.2 比赛任务

比赛基于 [**Oasis自动驾驶仿真平台**](https://guardstrike.com/tech.html)，比赛通过一组预定义的 [**场景**](rules.md#_31-比赛场景) 对自动驾驶算法进行测试。

对于每个场景，由参赛选手的算法控制的自动驾驶车辆将在一个起点被初始化，并被指示开往预定义的终点。 场景包含天气、光照条件、交通流（车辆、行人）、红绿灯、交通标志、路障等各种元素。

参赛选手的算法需要合理利用系统提供的各种 [**场景信息**](scenarios.md) 和 [**传感器信息**](install.md#_223-覆盖-sensors-方法)，使算法控制的主车顺利通过这些预定义场景，并且争取在各个 [**评价指标**](rules.md#_321-评价指标) 上获得更高的得分。

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

1. 在比赛报名系统注册，创建队伍并邀请队友或加入队伍，参与比赛。参考 [**报名系统操作流程**](baoming.md)。

2. [**点击此处下载Oasis竞赛版**](https://carsmos.oss-cn-chengdu.aliyuncs.com/Oasis-bisai.tar.gz) 

3. 根据Oasis竞赛版 [__安装部署文档__](install.md#_21-开发环境配置)，安装运行Oasis竞赛版系统。

4. 根据参赛选手在 [**比赛报名系统**](https://race.carsmos.cn) 注册的邮箱地址，申请Oasis竞赛版的License。参考：[**License导入说明**](license.md)

5. 通过Oasis竞赛版中的 `Oasis用户手册`，熟悉系统功能。

6. 根据 [__carsmos开发指引__](install.md#_22-开始开发)，基于Oasis竞赛版，开发和测试自动驾驶算法。

7. 在 [**比赛报名系统**](https://race.carsmos.cn/) 中按照提示，参考[**提交镜像**](submit.md)，将算法打包到镜像，并提交镜像到云端，等待运行结果和得分。

## 1.6 比赛帮助和答疑

如果参赛选手对本次开源自动驾驶算法大赛有任何意见或建议，请通过以下渠道与我们联系。

- 邮箱：carsmos@guardstrike.com

如果参赛选手在参赛过程中有任何疑问，欢迎加群讨论

- 微信/钉钉答疑群：
  - 微信/钉钉搜索群号：666666
  - 微信/钉钉扫描下方二维码入群：
  
  ![二维码](js/images/QRcode.png)

## 1.7 文档目录

- [开发指引](install.md)

- [比赛规则](rules.md)

- [提交说明](submit.md)

- [场景说明](scenarios.md)

- [License导入说明](license.md)

- [声明条款](clause.md)

- [报名系统操作说明](baoming.md)

***

[下一页：开发环境](install.md#21-开发环境配置)
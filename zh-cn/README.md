
# 1 比赛概览

## 1.1 比赛介绍

元遨 Carsmos 开源智驾算法大赛的主要目标是评估自动驾驶算法在现实交通场景中的驾驶能力。参赛选手只需要在 [**比赛报名系统**](https://race.carsmos.cn/) 上注册，提供团队信息并通过审核即可参与。

## 1.2 比赛任务

比赛基于 [**Oasis自动驾驶仿真平台**](https://www.carsmos.cn/projects/oasis/)，比赛通过一组预定义的 [**场景**](zh-cn/rules.md#_31-比赛场景) 对自动驾驶算法进行测试。

对于每个场景，由参赛选手的算法控制的自动驾驶车辆将在一个起点被初始化，并被指示开往预定义的终点。 场景包含天气、光照条件、交通流（车辆、行人）、红绿灯、交通标志、路障等各种元素。

参赛选手的算法需要合理利用系统提供的各种 [**场景信息**](zh-cn/scenarios.md) 和 [**传感器信息**](zh-cn/start.md#_223-重写-sensors-方法)，使算法控制的主车顺利通过这些预定义场景，并且争取在各个 [**评价指标**](zh-cn/rules.md#_321-评价指标) 上获得更高的得分。

## 1.3 如何开始

1. 在 [**比赛报名系统**](https://race.carsmos.cn) 注册，创建队伍并邀请队友或加入队伍，参与比赛。参考 [**报名系统操作流程**](zh-cn/signup.md)。

2. 根据Oasis竞赛版 [__安装部署文档__](zh-cn/install.md)，安装运行Oasis竞赛版系统，[点击此处下载Oasis竞赛版](https://carsmos.oss-cn-chengdu.aliyuncs.com/carsmos.tar.gz)。

3. 根据 [__carsmos开发指引__](zh-cn/start.md#_22-开始开发)，熟悉Oasis竞赛版，并基于此开发和测试自动驾驶算法。

4. 在 [**比赛报名系统**](https://race.carsmos.cn/) 中按照提示，参考[**提交镜像**](zh-cn/submit.md)，将算法打包到镜像，并提交镜像到云端，等待运行结果和得分。

## 1.4 比赛帮助和答疑

如果参赛选手对本次开源自动驾驶算法大赛有任何意见或建议，请通过以下渠道与我们联系。

- 邮箱：race@carsmos.ai

如果参赛选手在参赛过程中有任何疑问，欢迎加群讨论

- **钉钉**扫描下方二维码入群：
  
  ![二维码](../images/QRcode.png)

## 1.5 文档目录

- [安装部署](zh-cn/install.md)

- [开发指引](zh-cn/start.md)

- [比赛规则](zh-cn/rules.md)

- [提交说明](zh-cn/submit.md)

- [场景说明](zh-cn/scenarios.md)

- [License导入说明](zh-cn/license.md)

- [报名系统操作说明](zh-cn/signup.md)

- [声明条款](zh-cn/clause.md)

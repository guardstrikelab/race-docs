# 5 提交算法

## 5.1 构建并提交镜像

> 在提交之前，请确保在本地运行了至少一次，否则云端将无法识别 *my_agent.py*、*my_agent.yaml* 的路径

> 第一次提交会耗费比较长的时间，之后的提交会很快完成

- 在 [**比赛报名系统**](https://race.carsmos.cn/) 中进行操作，如有问题，参考 [**报名系统操作说明**](zh-cn/signup.md#_82-提交流程)

<!-- - 在构建好镜像之后，**建议您在本地先进行测试**，确认无误后再提交到云端，启动镜像的参考命令如下：

```bash
docker run --gpus all --runtime=nvidia --net=host -it --shm-size=2g --memory=10g --name dora-oasis-container carsmos_dora:0.1 /bin/bash
``` -->

- 镜像上传成功之后，云端会自动运行参赛选手的算法并提供实时的运行状态

- 参赛选手需要等待一段时间（12小时以内），然后可以在：[比赛报名系统](https://race.carsmos.cn/) - 赛事 - 提交 - 提交历史 看到本次提交的运行结果。

- 每次提交的结果需要后台专家组审核通过之后，才可以参与排名
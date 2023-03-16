[上一页：比赛规则](rules.md)

***

## 4.1 环境准备
- 设置环境变量指向 Oasis 竞赛版提供的 team_code 文件夹
```bash
export TEAM_CODE_ROOT={YOUR_PATH}/team_code
```

## 4.2 构建并提交镜像

- 在 [**比赛报名系统**](https://race.carsmos.cn/) 中进行操作，如有问题，参考 [**报名系统操作说明**](baoming.md#_82-提交流程)

- 在构建好镜像之后，**建议您在本地先进行测试**，确认无误后再提交到云端，启动镜像的参考命令如下：

```bash
docker run --gpus all --runtime=nvidia --net=host -it --shm-size=2g --memory=10g --name dora-oasis-container carsmos_dora:0.1 /bin/bash
```



- 镜像上传成功之后，云端会自动运行参赛选手的算法并提供实时的运行状态

- 参赛选手需要等待一段时间（10分钟至1小时，取决于参赛选手的算法），然后可以在：[**比赛报名系统**](https://race.carsmos.cn/) - 赛事 - 提交 - 提交历史
看到本次提交的运行结果。

- 每次提交的结果需要后台专家组审核通过之后，才可以参与排名


***

[上一页：比赛规则](rules.md)

[下一页：场景说明](scenarios.md)
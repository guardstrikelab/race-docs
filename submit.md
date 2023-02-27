[上一页：比赛规则](rules.md)

***

## 4.1 环境准备
- 设置环境变量指向 Oasis竞赛版提供的 team_code 文件夹
```bash
export TEAM_CODE_ROOT={YOUR_PATH}/oasis/team_code
```

修改 Oasis 竞赛版安装包里提供的 Dockerfile：

- 如果您基于Dora开发，请修改 `Dockerfile.dora`：
```bash
vim Dockerfile.dora
```

- 如果您未基于 Dora 开发，请修改 `Dockerfile`：
```bash
vim Dockerfile
```

在 `Dockerfile` 或 `Dockerfile.dora` 中，修改如下内容，以指定您的 your_agent.py 路径：并且加上相关配置

```bash
ENV TEAM_AGENT ${TEAM_CODE_ROOT}/your_agent.py
```

## 4.2 构建并提交镜像

- 参考 [**报名系统操作说明**](baoming.md#_82-提交流程)

- **镜像上传成功之后，云端即开始运行您的算法。您可以实时看到运行状态**

- 您需要等待一段时间（10分钟至1小时，取决于您的算法），然后您可以在：[**比赛报名系统**](https://race.carsmos.cn/) - carsmos 2023 春季赛事 - Submissions - History
看到您本次提交的运行结果。

- 每次提交的结果需要后台专家组审核通过之后，才可以参与排名


***

[上一页：比赛规则](rules.md)

[下一页：场景说明](scenarios.md)
[Previous page: Competition Rules](rules-en.md)

***
# 5 Submit Algorithm

## 5.1 Environment Preparation
- Set Environment Variables to Point To Oasis The Competition Version Provides team_code Folders
```bash
export TEAM_CODE_ROOT={Your Path}/carsmos/team_code
```
- Add Execution Permission to the Mirror Build Script
```bash
cd {Your Path}/carsmos
sudo chmod +x make_docker.sh
```

## 5.2 Build and Submit the Mirror

> Before submitting, please make sure to run it at least once locally，Otherwise, the cloud will not be able to recognize it *your_agent.py*、*your_agent.yaml* the Path

- In the [**Competition Registration System**](https://race.carsmos.cn/) Operations can be performed in it，If you have any questions，Reference [**Registration System Operation Instructions**](baoming.md#_82-提交流程)

<!-- - After building the mirror，**we recommend testing it locally first**，Once you have confirmed that it is working correctly, you can submit it to the cloud，The reference command to start the mirror is as follows：

```bash
docker run --gpus all --runtime=nvidia --net=host -it --shm-size=2g --memory=10g --name dora-oasis-container carsmos_dora:0.1 /bin/bash
​``` -->

- After the mirror upload is successful，the cloud will automatically run the participant's algorithm and provide real-time running status

- The participants need to wait for a period of time（Within a few hours），Then you can check the results in the：[competition registration system](https://race.carsmos.cn/) - Competition - Submit - Submission History You can see the running results of this submission。

- The results of each submission need to be approved by the back-end expert group before they are available，Only after approval can the submission be included in the ranking

***

[Previous page:Competition Rules](rules-en.md)

[Next page:Scenario Description](scenarios-en.md)
```
[上一页：提交说明](submit.md)

***

# 6. 比赛场景

## 6.1. 训练场景

| 场景名称                                         | 场景描述                                                                | 天气光照  | 预期里程 | 预期用时 |
| -------------------------------------------- | ------------------------------------------------------------------- | ----- | ---- | ---- |
| train1-leading_vehicle_brake                 | 主车同车道前方车辆制动                                                         | 白天、晴朗 |      |      |
| train2-leading_vehicle_brake                 | 主车同车道前方车辆制动                                                         | 白天、下雨 |      |      |
| train3-leading_vehicle_slow                  | 主车同车道前方车辆慢行                                                         | 白天、有雾 |      |      |
| train4-leading_vehicle_slow                  | 主车同车道前方车辆慢行                                                         | 夜间、晴朗 |      |      |
| train5-front_obstacle                        | 主车同车道前方有障碍物                                                         | 白天、晴朗 |      |      |
| train6-front_obstacle                        | 主车同车道前方有障碍物                                                         | 夜间、下雨 |      |      |
| train7-front_opposite_vehicle_turnaround     | 主车前方有对向车辆掉头                                                         | 白天、晴朗 |      |      |
| train8-front_opposite_vehicle_turnaround     | 主车前方有对向车辆掉头                                                         | 白天、有雾 |      |      |
| train9-left_vehicle_cutin                    | 主车左侧车辆切入                                                            | 夜间、有雾 |      |      |
| train10-right_vehicle_cutin                  | 主车右侧车辆切入                                                            | 夜间、晴朗 |      |      |
| train11-front_vru_cross                      | 主车前方有弱势道路使用者横穿马路                                                    | 白天、晴朗 |      |      |
| train12-front_vru_cross                      | 主车前方有弱势道路使用者横穿马路                                                    | 夜间、晴朗 |      |      |
| train13-gostraight_left_vehicle_runred       | 主车路口直行，路口左侧车辆闯红灯                                                    | 白天、晴朗 |      |      |
| train14-gostraight_left_vehicle_runred       | 主车路口直行，路口右侧车辆闯红灯                                                    | 白天、下雨 |      |      |
| train15-turnright_left_vehicle_gostaright    | 主车路口右转，路口左侧有直行车                                                     | 夜间、晴朗 |      |      |
| train16-turnright_left_vehicle_gostaright    | 主车路口右转，路口左侧有直行车                                                     | 夜间、下雨 |      |      |
| train17-turnleft_opposite_vehicle_gostaright | 主车路口左转，路口对向有直行车                                                     | 白天、晴朗 |      |      |
| train18-turnleft_opposite_vehicle_gostaright | 主车路口左转，路口对向有直行车                                                     | 夜间、有雾 |      |      |
| train19-turnright_right_vru_cross            | 主车路口右转，路口右侧弱势道路使用者横穿马路                                              | 夜间、晴朗 |      |      |
| train20-turnright_right_vru_cross            | 主车路口右转，路口右侧弱势道路使用者横穿马路                                              | 白天、下雨 |      |      |
| train21-front_occluded_vru_appear            | 主车前方盲区弱势道路使用者横穿马路                                                   | 夜间、晴朗 |      |      |
| train22-front_occluded_vru_appear            | 主车前方盲区弱势道路使用者横穿马路                                                   | 白天、有雾 |      |      |
| train23-enter_roundabout                     | 主车驶入环岛                                                              | 夜间、下雨 |      |      |
| train24-exist_roundabout                     | 主车驶出环岛                                                              | 白天、下雨 |      |      |
| train25-enter_ramp                           | 主车驶入匝道                                                              | 白天、有雾 |      |      |
| train26-exit_ramp                            | 主车驶出匝道                                                              | 夜间、晴朗 |      |      |
| train27-advanced1                            | 四个有序事件：1.主车右侧车辆切入2.主车前方有弱势道路使用者横穿马路3.主车同车道前方有障碍物4.主车前方盲区弱势道路使用者横穿马路 | 白天、晴朗 |      |      |
| train28-advanced2                            | 三个有序事件：1.主车前方有对向车辆掉头2.主车前方有弱势道路使用者横穿马路3.主车同车道前方车辆逆行                 | 夜间、下雨 |      |      |
| train29-advanced3                            | 两个有序事件：1.主车路口左转，路口对向有直行车2.主车前方有弱势道路使用者横穿马路                          | 白天、有雾 |      |      |
| train30-advanced4                            | 两个有序事件：1.主车路口左转，路口右侧有左转车辆2.主车路口右转，路口右侧弱势道路使用者横穿马路                   | 夜间、晴朗 |      |      |

## 6.2. 测试场景

| 场景名称   | 场景描述                                                    | 天气光照  | 预期里程 | 预期用时 |
| ------ | ------------------------------------------------------- | ----- | ---- | ---- |
| test1  | 三个有序事件：1.主车左侧车辆切入2.主车路口右转，路口右侧弱势道路使用者横穿马路3.主车前方有对向车辆掉头  | 白天、晴朗 |      |      |
| test2  | 两个有序事件：1.主车路口直行，路口右侧车辆闯红灯2.主车前方盲区弱势道路使用者横穿马路            | 夜间、晴朗 |      |      |
| test3  | 三个有序事件：1.主车驶入环岛2.主车驶出环岛3.主车同车道前方有障碍物                    | 白天、有雾 |      |      |
| test4  | 四个有序事件：1.主车左侧车辆切入2.主车驶入匝道3.主车驶出匝道4.主车汇入道路后方来车           | 夜间、下雨 |      |      |
| test5  | 两个有序事件：1.主车左侧车辆切入2.主车同车道前方有障碍物                          | 白天、下雨 |      |      |
| test6  | 两个有序事件：1.主车右侧车辆切入2.主车前方有弱势道路使用者横穿马路                     | 夜间、晴朗 |      |      |
| test7  | 两个有序事件：1.主车路口左转，路口右侧有左转车辆2.主车同车道前方有障碍物                  | 白天、晴朗 |      |      |
| test8  | 两个有序事件：1.主车路口左转，路口对向有直行车2.主车车道部分被停止车辆占用                 | 白天、有雾 |      |      |
| test9  | 三个有序事件：1.主车前方有弱势道路使用者横穿马路2.主车前方有对向车辆侵入主车车道3.主车同车道前方车辆慢行 | 夜间、下雨 |      |      |
| test10 | 三个有序事件：1.主车同车道前方车辆切出2.主车同车道前方车辆制动3.主车同车道前方车辆慢行          | 夜间、晴朗 |      |      |

 

![image](https://thoughts.aliyun.com/workspaces/637c38cb629007001a0ccd96/images/6.gif "")

***

[上一页：提交说明](submit.md)

[下一页：声明条款](clause.md)
[上一页：安装部署](install.md)

***
# 3 开发指南

## 3.1 开发概述

### 3.1.1 dora-drives 简介

`dora`（Dataflow Oriented Robotic Architecture）的目标是提供低延迟、可组合、分布式的数据流（`data-flow`）。

`dora-drives` 是一款基于 `dora` 的自动驾驶软件入门套件，本次比赛使用 `dora-drives` 进行开发。通过将自动驾驶分解为`感知`、`映射`、`规划`和`控制`等几个子问题，旨在降低自动驾驶系统开发门槛，让所有人都能开发自己的自驾系统。

### 3.1.2 需要做什么

示例代码已经实现了完整的自动驾驶系统，您可以对其进行优化，也可以引入自己的模型，甚至可以重新开发一套新的自动驾驶系统。

要在 `oasis` 中实现您的自动驾驶算法，需要开发的内容主要包括：

`my_operator.py`

包装算法的算子（`operators`）。`dora-drives` 提供了若干个 `operator` 以供使用。您可以实现自己的 `operator`，用于实现您的算法，详情见后文。

`my_agent.py`

启动文件，可直接修改并使用默认的 `carsmos/team_code/dora-drives/carla/oasis_agent.py`，详情见后文。

`my_data_flow.yaml`

数据流文件，可直接修改并使用默认的 `carsmos/team_code/dora-drives/graphs/oasis/oasis_agent.yaml`，详情见后文。

`my_agent_config`：（可选）配置文件。

> 以上文件名都可以自定义，需要在 `carsmos/team_code` 目录下进行开发。

## 3.2 开发示例

### 3.2.1 dora 使用说明

`dora` 的数据流通过一个 `.yaml` 文件定义，示例如下：

```yaml
communication: 
  zenoh:
    prefix: dora-zenoh-example

nodes:
  - id: oasis_agent # 当前 .yaml 文件中的唯一 id
    custom: # 自定义节点的输入与输出
      inputs: # 定义输入
        tick: dora/timer/millis/400
      outputs: # 定义输出
        - opendrive
        - objective_waypoints
        - ...
      source: shell
      args: >
        python3 $SIMULATE ...
 
  - id: carla_gps_op
    operator: # 表示单个 python 文件定义的 operator
      python: ../../carla/carla_gps_op.py # 实现算法逻辑的 python 代码文件
      outputs: # 定义 operator 的输出
        - gps_waypoints
        - ready
      inputs: # 定义 operator 的输入
        opendrive: oasis_agent/opendrive # oasis_agent 节点的 opendrive 输出作为此节点的一个输入
        objective_waypoints: oasis_agent/objective_waypoints # oasis_agent 节点的 objective_waypoints 输出作为此节点的一个输入
        ...
```

在节点中定义好 `id`、`inputs`、`outputs`、`python` 之后，就可以在对应的 `python` 代码文件中处理输入并将结果输出。

实现 `carla_gps_op` 的 `carla_gps_op.py` 代码文件的整体结构如下

```python

from typing import Callable
from dora import DoraStatus

class Operator:

  def __init__(self):
    # 执行一些初始化
  
  # on_event 方法在每次接收到 dora 事件时会调用，dora 事件包括 “INPUT”、“STOP” 以及其他，但是我们只需要用到 “INPUT”。您可以在下面的 on_input 方法实现算法逻辑并输出，也可以直接在 on_event 方法中实现算法并输出。
  def on_event(
      self,
      dora_event: dict,
      send_output: Callable[[str, bytes], None],
  ) -> DoraStatus:
      # 只需要处理 “INPUT” 类型的 dora 事件
      if dora_event["type"] == "INPUT":
          # 可以在这里替换掉 on_input，然后处理输入，实现算法并输出，也可以在 on_input 方法中实现，建议采用后者。
          return self.on_input(dora_event, send_output)
      # DoraStatus 包括 CONTINUE 和 STOP，只需要返回 return DoraStatus.CONTINUE ，表示算法继续执行即可，不需要用到 DoraStatus.STOP
      return DoraStatus.CONTINUE

  # on_input 方法用于处理输入、实现算法并且输出结果
  def on_input(
        self,
        dora_input: dict,
        send_output: Callable[[str, bytes], None],
    ) -> DoraStatus:
    
    # dora_input 是一个 dict
    # dora_input["id"] 是一个字符串，等于 .yaml 文件中 inputs 中定义的输入的id
    # dora_input["data"] 是一个字节数组（bytes），即输入的数据
    if dora_input["id"] == "objective_waypoints":
      self.objective_waypoints = np.frombuffer(
                dora_input["data"], np.float32
            ).reshape((-1, 3))[self.completed_waypoints :]

    if dora_input["id"] == "opendrive":
      # 处理 opendrive 输入的数据

    # 实现一些算法与逻辑

    # 调用参数中的 send_output 接口方法，将结果输出
    # send_output("string", b"string", {"foo": "bar"})
    # 第一个参数是一个字符串，等于“outputs” 中定义的输出的id
    # 第二个参数是一个字节数组（bytes），即输出的数据
    # 第三个参数是一些元数据
    send_output(
                    "gps_waypoints",
                    self.waypoints.tobytes(),
                    dora_input["metadata"],
                )
    return DoraStatus.CONTINUE

```

以上代码的重点：

- **定义输入与输出**：在 `.yaml` 文件中定义输入与输出，比如 `oasis_agent` 节点的输出 `opendrive`、`objective_waypoints`，分别传给了 `carla_gps_op` 节点的 `opendrive`、`objective_waypoints`
- **处理输入并输出**：利用 Python 处理输入并输出结果。

### 3.2.2 oasis-agent 简介

以 `oasis-agent.yaml` 与 `oasis-agent.py` 为例，以下将详细说明示例算法是如何被开发的。阅读并了解之后，您可以基于此进行优化，或者参考示例开发新的自驾系统。

首先， `oasis-agent.py` 中实现了以下功能：

- 在 `setup()` 方法中执行若干初始化，包括设置目的地、检查 `dora` 节点状态等

- 在 `sensors()` 方法中定义了传感器

- `run_step()` 方法总体实现了4个功能：

  - 接收传感器原始数据，例如获取摄像头的帧：

    ```python
    frame_raw_data = input_data["camera.center"][1]
    ```

  - 对传感器原始数据进行预处理，例如将帧原始数据转为字节数组：

    ```python
    camera_frame = frame_raw_data.tobytes()
    ```

  - 将预处理后的传感器数据发送到输出端口，例如发送预处理后的帧数据到 `id=image` 的输出端口：

    ```python
    node.send_output("image", camera_frame)
    ```

  - 接收从 `PID Control operator` 发送的控制信息（油门、方向、刹车）并返回：

    ```python
    value = event["data"]
    [throttle, target_angle, brake] = np.frombuffer(value, np.float16)
    ```

示例自驾系统整体分为：`全局路径规划` - `障碍物检测` - `障碍物定位` - `局部路径规划` - `控制`，每个部分分别通过一个 `operator` 实现：

  - `GPS operator`
  
    输入 opendrive 格式的高精地图、主车坐标及目的地坐标，可计算并输出 gps 路点。路径：`carsmos/team_code/dora-drives/carla/carla_gps_op.py`

  - `Yolov5 operator`
  
    输入实时图片，可利用 yolov5 算法模型计算并输出 bounding boxes（以下简称 `bbox`）。路径：`carsmos/team_code/dora-drives/operators/yolov5_op.py`

  - `Obstacle location operator`
  
    输入主车坐标、bbox以及激光雷达产生的 point cloud，可计算并输出障碍物的信息。路径：`carsmos/team_code/dora-drives/operators/obstacle_location_op.py`

  - `FOT operator`
   
    输入主车坐标、速度、障碍物信息以及 gps 路点，可计算并输出真实的路点。比如前方有车挡住路线，这个 `operator` 可以计算出绕过前方车辆的路线。路径：`carsmos/team_code/dora-drives/operators/fot_op.py`

  - `PID Control operator`
  
    输入主车坐标、速度及 `FOT operator` 计算出的路点，可计算并输出对主车的控制信息（油门、方向、刹车）。路径：`carsmos/team_code/dora-drives/operators/pid_control_op.py`

### 3.2.1 全局路径规划

示例算法使用 `GPS operator` 实现全局路径规划，其方法是利用 `carla.GlobalRoutePlanner`，根据给定的起始点和目标点，以及高精地图，生成一条安全、平滑、高效的路径，并考虑到车辆的物理特性、道路限制、交通规则等因素。同时，它还可以实时地根据车辆的实际行驶情况，动态地调整路径规划，以保证车辆始终行驶在最佳的路径上。其关键代码如下：

- _hd_map.py：
  ```python
  # 实例化 GlobalRoutePlanner
  self._grp = GlobalRoutePlanner(
      self._map, 1.0
  )  # Distance between waypoints

  # 利用 GlobalRoutePlanner 计算全局路线
  route = self._grp.trace_route(
              start_waypoint.transform.location, end_waypoint.transform.location
          )
  ```

- carla_gps_op.py
  ```python
  waypoints = self.hd_map.compute_waypoints(
      [
          x,
          y,
          self._goal_location[2],
      ],
      self._goal_location,
  )[:NUM_WAYPOINTS_AHEAD]
  ```

### 3.2.2 障碍物检测

示例算法使用 `Yolov5 operator` 实现障碍物感知，它可以检测输入图片上的物体并输出 `bbox`，用于标记物体的位置。*示例算法只实现了障碍物的检测，没有实现交通信号灯、交通标志的校测。*

```python
results = self.model(frame) # 利用 yolov5 模型计算 bbox
...
send_output("bbox", arrays, dora_input["metadata"]) # 输出处理后的结果
```

### 3.2.3 障碍物定位

示例算法使用 `Obstacle location operator` 实现障碍物定位。它利用激光雷达生成的点云和 `Yolov5 operator` 生成的 `bbox`，采取映射的方式，将三维点云映射到二维的 `bbox` 中，从而测算出障碍物的距离。具体的方式是，首先将点云的坐标转换为摄像头的坐标，然后取出在 `bbox` 内的点，选取其*z轴坐标等于四分位数*的点作为距离测算点，从而计算出障碍物的距离。关键代码如下：

```python
# 将点云坐标转换成摄像头坐标
camera_point_cloud = local_points_to_camera_view(
                point_cloud, INTRINSIC_MATRIX
            )

# 从点云中选取位于 bbox 框内的点
[min_x, max_x, min_y, max_y, confidence, label] = obstacle_bb
z_points = self.point_cloud[
    np.where(
        (self.camera_point_cloud[:, 0] > min_x)
        & (self.camera_point_cloud[:, 0] < max_x)
        & (self.camera_point_cloud[:, 1] > min_y)
        & (self.camera_point_cloud[:, 1] < max_y)
    )
]

# 选择 "z轴坐标=四分位数" 的点作为最近的点，用于定位障碍物（这样做是为了排除噪声）
if len(z_points) > 0:
    closest_point = z_points[
        z_points[:, 2].argsort()[int(len(z_points) / 4)]
    ]
```

### 3.2.4 局部路径规划

示例算法使用 `FOT operator` 实现局部路径规划。它通过一系列初始参数，通过计算得到局部路径，初始参数如下：
```python
initial_conditions = {
    "ps": 0,
    "target_speed": # 目标速度
    "pos": # 当前的 x, y 坐标
    "vel": # 当前 x、y 方向的速度 vx, vy
    "wp": # [[x, y], ... n_waypoints ]，通过 `GPS operator` 计算出的原始路点
    "obs": # [[min_x, min_y, max_x, max_y], ... ] 路上的障碍物坐标
}
```

由于上一步计算得出的障碍物坐标是三维的，因此需要将其转换为二维坐标，通过 `fot_op.py` - `get_obstacle_list` 实现了这个功能。

另外，这个算法模型包含许多超参数（Hyperparameter）：
```python
max_speed (float): 最大速度 [m/s]
max_accel (float): 最大加速度 [m/s^2]
max_curvature (float): 最大曲率 [1/m]
max_road_width_l (float): 左侧最大路宽 [m]
max_road_width_r (float): 右侧最大路宽 [m]
d_road_w（float）：道路宽度采样离散化[m]
dt（float）：时间采样离散化[s]
maxt（float）：最大预测时间[s]
mint（float）：最小预测时间[s]
d_t_s（float）：目标速度采样离散化[m/s]
n_s_sample（float）：目标速度采样数
obstacle_clearance（float）：障碍物半径[m]
kd（float）：位置偏差成本
kv（float）：速度成本
ka（float）：加速度成本
kj（float）：加加速度成本
kt（float）：时间成本
ko（float）：到障碍物距离成本
klat（float）：横向成本
klon（float）：纵向成本
```

您可以调整这些参数来优化这个局部规划算法。更多详情请参考：[erdos-project/frenet_optimal_trajectory_planner](https://github.com/erdos-project/frenet_optimal_trajectory_planner/)

### 3.2.5 控制

示例算法使用 `PID Control operator` 实现控制，它根据以前的输入对车辆当前速度、方向和位置做出反应，以加速、转向或刹车。

要了解 `dora-drives` 更多内容请参考：

- [**dora 主页**](https://dora.carsmos.ai/)

- [**dora dataflow 文档**](https://dora.carsmos.ai/dora/dataflow-config.html)

- [**dora-drives 文档**](https://dora.carsmos.ai/dora-drives)

## 3.3 agent 开发指南

### 3.3.1 创建 **my_agent.py** 或基于 **oasis_agent.py** 开发

在 **carsmos/team_code/dora-drives/carla** 目录下，创建 **my_agent.py** 作为启动文件（文件名可自定义），用于执行自动驾驶算法，可参考同目录下的示例 **oasis_agent.py** 。

也可以直接修改 **oasis_agent.py** 进行开发。

**my_agent.py** 需要通过继承 **AutonomousAgent** 类进行开发，可以在 **autoagents/autonomous_agent.py** 中找到 **AutonomousAgent** 类，这里定义了所有需要实现的方法，需要在 **my_agent.py** 中实现来接入自动驾驶算法模块。

比赛系统将会使用算法依次运行多个预置的场景，生成任务结果，评估参赛选手的自动驾驶算法。

```python
from autoagents.autonomous_agent import AutonomousAgent

class YourAgent(AutonomousAgent):
    def __init__(self, debug=False):
```

### 3.2.4 初始化配置 *setup*

参赛选手需要在 **my_agent.py** 中重写 *setup* 方法，此方法会在场景任务运行之前，执行 *agent* 所需要的所有初始化，它将在每次加载新的场景时被自动调用。

如果需要通过 *配置文件* 的方式来初始化配置，需要在 **carsmos/team_code/dora-drives/carla** 目录下创建配置文件，该配置文件的绝对路径会通过 *path_to_conf_files* 传入 *setup* 方法。否则请忽略。

同时，如果需要，可以将经纬度参考属性加载到 *setup* 方法中，它们会在 *setup* 运行之前就被更新，这两个属性是将 *waypoint* 坐标转换成 *carla* 坐标的参考值。

```python
#latitude and longitude reference
lat_ref = None
lon_ref = None
class YourAgent(AutonomousAgent):
    def __init__(self, debug=False):
		``````
    def setup(self, destination, path_to_conf_file):
        """
        Setup the agent parameters
        """
        global lat_ref, lon_ref
        lat_ref = self.lat_ref
        lon_ref = self.lon_ref
        ........

```

可以参考以下函数 `from_gps_to_world_coordinate` 将 gps 数据转换为世界坐标：

```python
def from_gps_to_world_coordinate(lat, lon):
    global lat_ref, lon_ref

    EARTH_RADIUS_EQUA = 6378137.0  # pylint: disable=invalid-name
    scale = math.cos(lat_ref * math.pi / 180.0)
    mx_initial = scale * lon_ref * math.pi * EARTH_RADIUS_EQUA / 180.0
    my_initial = (
        scale
        * EARTH_RADIUS_EQUA
        * math.log(math.tan((90.0 + lat_ref) * math.pi / 360.0))
    )

    mx = lon / 180.0 * (math.pi * EARTH_RADIUS_EQUA * scale)
    my = math.log(math.tan((lat + 90.0) * math.pi / 360.0)) * (
        EARTH_RADIUS_EQUA * scale
    )
    x = mx - mx_initial
    y = -(my - my_initial)

    return [x, y]

```

### 3.2.5 设置传感器

参赛选手必须要重写 sensors 方法，该方法定义了 agent 能够使用的所有传感器。

在 Oasis 竞赛版中，传感器可直接在 Oasis 竞赛版系统 - 资源库中进行配置，以调试得到适合参赛选手算法的最优传感器配置，**在提交到云端参赛时，需要将最优的传感器配置写入 my_agent.py 中的 sensors 方法中，进行提交。示例如下**

```python
def sensors(self):
        """Define the sensor suite required by the agent"""
        sensors = [
                {'type': 'sensor.camera.rgb', 'x': 0.7, 'y': 0.0, 'z': 1.60, 'roll': 0.0, 'pitch': 0.0, 'yaw': 0.0,
                'width': 800, 'height': 600, 'fov': 100, 'id': 'Center'},
                {'type': 'sensor.lidar.ray_cast', 'x': 0.7, 'y': -0.4, 'z': 1.60, 'roll': 0.0, 'pitch': 0.0,
                'yaw': -45.0, 'id': 'LIDAR'},
                {"type": "sensor.speedometer", "id": "Speed"},
                {'type': 'sensor.opendrive_map', 'reading_frequency': 1, 'id': 'OpenDRIVE'},
                {'type': 'sensor.other.radar', 'x': 0.7, 'y': -0.4, 'z': 1.60, 'roll': 0.0, 'pitch': 0.0,
                'yaw': -45.0, 'id': 'RADAR1','horizontal_fov':30,'vertical_fov':30},
                {'type': 'sensor.other.gnss', 'x': 0.7, 'y': -0.4, 'z': 1.60, 'id': 'GPS'},
                {'type': 'sensor.other.imu', 'x': 0.7, 'y': -0.4, 'z': 1.60, 'roll': 0.0, 'pitch': 0.0,
                'yaw': -45.0, 'id': 'IMU'},
            ]
        return sensors
```

每个传感器由一个 dict 表示，包含以下字段：

- `type`：要添加的传感器的类型。

- `id`：将被赋予传感器的标签，以便以后访问。

- `attributes`：这些属性与传感器有关，例如：外在因素和视野等。
  
参赛选手可以设置每个传感器的内在参数和外在参数（位置和方向），以相对于车辆的中心坐标为准。请注意，CARLA 使用 UE4 的左手坐标系统，即：X-前，Y-右，Z-上。

传感器参数配置可以参考 AutonomousAgent 中的示例内容进行配置，同时我们对传感器的可选类型与可配置数量做了限制，请参考下述内容

| 可搭载传感器                | 可搭载数量 |
| --------------------- | ----- |
| sensor.camera.rgb     | 4     |
| sensor.other.radar    | 2     |
| sensor.other.gnss     | 1     |
| sensor.other.imu      | 1     |
| sensor.opendrive_map  | 1     |
| sensor.lidar.ray_cast | 1     |
| sensor.speedometer    | 1     |

传感器具体解释如下：

- [`sensor.camera.rgb`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#rgb-camera) - 捕捉图像的普通相机。

- [`sensor.lidar.ray_cast`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#lidar-sensor) - Velodyne 64 激光雷达。

- [`sensor.other.radar`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#radar-sensor) - 远程雷达（最远100米）。

- [`sensor.other.gnss`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#gnss-sensor) - 返回地理位置数据的GPS传感器。

- [`sensor.other.imu`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#imu-sensor) - 六轴惯性测量单元。

- `sensor.opendrive_map` - 伪传感器，以OpenDRIVE格式解析为字符串的高清地图。

- `sensor.speedometer` - 伪传感器，提供线性速度的近似值。

> 如果尝试使用其他传感器或传感器参数名称错误，会使传感器设置失败。

> 如果在提交中使用了超量的传感器，传感器配置验证失败，运行会出错。

此外，还有一些空间限制，限制了传感器在车辆包围盒内的位置。如果一个传感器在任何轴线上与主车相距超过3米（例如：`[3.1,0.0,0.0]`），设置将失败。

### 3.2.6 重写 run_step 方法

这个方法将在每个 *world tick* 被调用一次，产生一个新的动作，其形式为 `carla.VehicleControl` 对象。确保该函数返回控制对象，该对象将被用于更新仿真主车。

参赛选手可以在 *run_step* 中开发算法，并必须确保函数返回的是 `carla.VehicleControl` 对象，该返回对象将用于控制仿真主车运动。

```python
    def run_step(self, input_data, timestamp):
        """
        Execute one step of navigation.
        :return: control
        """
        # do something smart

        control = carla.VehicleControl()
        control.steer = 0.0
        control.throttle = 0.0
        control.brake = 0.0
        control.hand_brake = False

        return control

```

- `world.tick()`：仿真世界运行一个步长，目前仿真世界运行频率为20hz，每一个时间步长为0.05s

- `run_step()`：每一个时间步长调用一次，接收所搭载传感器的输出信息，进行算法处理后，输出车辆的控制信息

- `input_data`: 是一个在每一个 world tick 中返回所搭载的传感器数据的字典。这些数据以 numpy 数组的形式给出。 这个字典由传感器方法中定义的 id 来索引。

- `Timestamp`：当前仿真世界时间帧号。

### 3.2.7 重写 destroy 方法

在每个场景任务结束时，destroy 方法将被调用，需要参赛选手重写 destroy 方法来结束相应的进程或线程。

```python
def destroy(self):
    # destroy process 
    pass
```

### 3.2.8 创建算子（`operator`）

建议将算法包装成为一个算子（`operator`），创建一个python文件：如 `my_operator.py`。

我们以添加 *yolov5* 目标检测算子为例，该算法已经在 *dora-drives/operators/yolov5_op.py* 中编写好。

```python
import os
from typing import Callable

import cv2
import numpy as np
import torch
from dora import DoraStatus

DEVICE = os.environ.get("PYTORCH_DEVICE") or "cpu"

class Operator:
    """
    Infering object from images
    """

    def __init__(self):
        self.model = torch.hub.load(
            "ultralytics/yolov5",
            "yolov5n",
        )
        self.model.to(torch.device(DEVICE))
        self.model.eval()

    def on_input(
        self,
        dora_input: dict,
        send_output: Callable[[str, bytes], None],
    ) -> DoraStatus:
        """Handle image
        Args:
            dora_input["id"](str): Id of the input declared in the yaml configuration
            dora_input["data"] (bytes): Bytes message of the input
            send_output (Callable[[str, bytes]]): Function enabling sending output back to dora.
        """

        frame = cv2.imdecode(
            np.frombuffer(
                dora_input["data"],
                dtype="uint8",
            ),
            -1,
        )
        frame = frame[:, :, :3]

        results = self.model(frame)  # includes NMS
        arrays = np.array(results.xyxy[0].cpu())[
            :, [0, 2, 1, 3, 4, 5]
        ]  # xyxy -> xxyy
        arrays[:, 4] *= 100
        arrays = arrays.astype(np.int32)
        arrays = arrays.tobytes()
        send_output("bbox", arrays, dora_input["metadata"])
        return DoraStatus.CONTINUE
```

添加YOLOv5对象检测处理节点作为一个算子，只需要重写 ____init____ 方法和 **on_input** 方法，

____init____ 方法会在初始化节点调用，执行算子所需要的所有初始化和定义；

**on_input** 方法会在每个时间步长中调用一次，

参赛选手需要在配置数据流的 *yaml* 文件中定义入参 *inputs* 和输出 *outputs* 的内容。

如果成功，返回 CONTINUE 标志；

### 3.2.9 创建数据流

Dora 需要通过数据流文件启动各个节点，完成感知，定位，规划，控制等 `operators` 的运行启动。

您可以修改 `oasis_agent.yaml` 中的内容，将 `my_operator.py` 作为一个节点加入其中，也可以自己创建一个新的数据流文件 `my_data_flow.yaml`。
 
如果想运行算法算子，只需要将它们添加到节点图中去：

```yaml
communication:
  iceoryx:
    app_name_prefix: dora-iceoryx-example

nodes:
  - id: my_algorithm
    operator:
      python: my_operator.py
      outputs:
        ...
      inputs:
        ...

  # 以下为示例

  - id: webcam
    operator:
      python: ../../operators/webcam_op.py
      inputs:
        tick: dora/timer/millis/100
      outputs:
        - image

  - id: yolov5
    operator: 
      outputs:
        - bbox
      inputs:
        image: webcam/image
      python: ../../operators/yolov5_op.py

  - id: plot
    operator:
      python: ../../operators/plot.py
      inputs:
        image: webcam/image
        obstacles_bbox: yolov5/bbox
        tick: dora/timer/millis/100
```

输入以节点名为前缀，以便能够避免名称冲突。

## 3.3 训练和调试算法

### 3.3.1 在 Oasis 中运行您的算法

- 在 `Oasis 竞赛版 - 资源库 - 车辆控制系统 - Dora` 中，将 *oasis_agent.py* 替换为 *my_agent.py*，将 *oasis_agent.yaml* 替换为 *my_data_flow.yaml*，如果有配置文件，请选择，否则可忽略。

  ![Oasis选取my_agent.py，开启作业](images/start/12.png)

- Oasis 竞赛版中准备了一套预定义的场景，可以使用这些场景来训练和调试算法。
  
- 场景可以在 *Oasis 竞赛版 - 场景库* 中找到。具体的场景说明请参考[场景说明](scenarios.md)。

### 3.3.2 如何调试

- 实时查看运行日志

```bash
docker logs -f oasis-dora
```

## 3.4 关于Dora-drives源代码管理（SCM）
### 3.4.1 如何贡献代码
设置Git：
- Git fork项目。转到：[dora-drives/fork](https://github.com/dora-rs/dora-drives/fork)

- 在您的 `dora-drives` 文件夹中设置源代码配置：

```bash
# cd dora-drives
git remote rm origin
git remote add dora https://github.com/dora-rs/dora-drives.git
git remote add origin https://github.com/<USERNAME>/dora-drives.git 
```

- 如果您想从 `dora-drives` 获取更新：

```bash
git fetch dora
git checkout main
git rebase dora/main
```

你可以通过创建一个 Pull Request 将你的更改推送到 dora-drives：
```bash
git checkout -b my_branch # 创建一个新分支
git add `...changes...` # 添加你的更改
git commit -m "message"
git push --set-upstream origin my_branch
# 前往：https://github.com/dora-rs/dora-drives/compare/main...<USERNAME>:dora-drives:<my_branch>
```

我们感激任何形式的贡献。我们知道 `dora-drives` 仍然存在许多问题，我们很抱歉。但是，我们希望逐步、逐次地让它成为一个伟大的开源自动驾驶起步工具包。

### 3.4.2 On Issues 
如果您在使用 `dora-drives` 时遇到任何问题，请在我们的 Github 页面上提出问题：https://github.com/dora-rs/dora-drives/issues
您也可以在讨论区联系我们，讨论 `dora-drives` 的使用：https://github.com/dora-rs/dora-drives/discussions。


***

[上一页：开发指引](install.md)

[下一页：比赛规则](rules.md)
[上一页：比赛介绍](README.md)

***

## 2.1 开发环境配置

### 2.1.1 拉取oasis竞赛版压缩包 # 安装手册、使用手册

根据下述地址，拉取oasis竞赛版压缩包，该压缩包包含 安装所需镜像tar包，一键部署脚本，oasis竞赛版使用手册，oasis竞赛版部署要求文档 等。

### 2.1.2 运行一键部署脚本，安装oasis竞赛版系统

- 根据部署要求文档，准备oasis竞赛版所要安装的环境

- 运行一键部署脚本，即可将oasis竞赛版安装完毕

### 2.1.3 运行示例

- 可直接通过桌面图标OASIS 进入oasis竞赛版

- 配置场景，加载预置或者自定义agent文件，创建任务即可运行

- 运行结束，可查看任务运行结果，评价指标，获取传感器数据，查看任务运行视频

## 2.2 开始开发

### 2.2.1 基于 Autonomous Agent 创建您的 Agent

你的 Agent **your_agent.py** 应该作为你的代码主入口，用于执行你的自动驾驶算法。比赛系统将会让你的算法在多个规定的场景下依次运行，生成任务结果，评估车辆的行为。

你的Agent类需要通过继承我们的AutonomousAgent类进行对接开发，你可以在autoagents/autonomous_agent.py中找到AutonomousAgent类，这里规定了所有必须的接口，你需要在自己的agent中重写这些接口。

```python
from autoagents.autonomous_agent import AutonomousAgent

class YourAgent(AutonomousAgent):
    def __init__(self, debug=False):
```

### 2.2.2 覆盖 setup 方法

你需要在你的agent中重写setup方法，此方法会在场景任务运行之前，执行agent所需要的所有初始化和定义，它将在每次加载新的场景时被自动调用. 它可以接收一个指向配置文件的可选参数。 

```python
--agentConfig your_agent_config_file
```

同时，如果需要，你可以将经纬度参考属性加载到你的setup方法中，他们会在setup运行之前就被更新，这两个属性是你将waypoint坐标转换成carla坐标的参考值。

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

您可以参考以下函数`from_gps_to_world_coordinate`将gps数据转换为世界坐标：

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

    # lon = mx * 180.0 / (math.pi * EARTH_RADIUS_EQUA * scale)
    # lat =   360.0 * math.atan(math.exp(my / (EARTH_RADIUS_EQUA * scale))) / math.pi - 90.0

    mx = lon / 180.0 * (math.pi * EARTH_RADIUS_EQUA * scale)
    my = math.log(math.tan((lat + 90.0) * math.pi / 360.0)) * (
        EARTH_RADIUS_EQUA * scale
    )
    x = mx - mx_initial
    y = -(my - my_initial)

    return [x, y]

```

### 2.2.3 覆盖 sensors 方法

您必须要重写sensors方法，该方法定义了agent能够使用的所有传感器。

传感器参数配置可以参考AutonomousAgent中的示例内容进行配置，同时我们对传感器的可选类型与添加数量做了限制，请参考下述内容

| 可搭载传感器                | 可搭载数量 |
| --------------------- | ----- |
| sensor.camera.rgb     | 4     |
| sensor.other.radar: 2 | 2     |
| sensor.other.gnss:    | 1     |
| sensor.other.imu      | 1     |
| sensor.opendrive_map  | 1     |
| sensor.lidar.ray_cast | 1     |
| sensor.speedometer    | 1     |

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

每个传感器由一个dict表示，包含以下字段：

- `type`：要添加的传感器的类型。

- `id`：将被赋予传感器的标签，以便以后访问。

- `attributes`：这些属性与传感器有关，例如：外在因素和视野等。

用户可以设置每个传感器的内在参数和外在参数（位置和方向），以相对于车辆的中心坐标为准。请注意，CARLA使用UE4的左手坐标系统，即：X-前，Y-右，Z-上。

传感器具体解释如下：

- [`sensor.camera.rgb`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#rgb-camera) - 捕捉图像的普通相机。

- [`sensor.lidar.ray_cast`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#lidar-sensor) - Velodyne 64 激光雷达。

- [`sensor.other.radar`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#radar-sensor) - 远程雷达（最远100米）。

- [`sensor.other.gnss`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#gnss-sensor) - 返回地理位置数据的GPS传感器。

- [`sensor.other.imu`](https://carla.readthedocs.io/en/0.9.10/ref_sensors/#imu-sensor) - 六轴惯性测量单元。

- `sensor.opendrive_map` - 伪传感器，以OpenDRIVE格式解析为字符串的高清地图。

- `sensor.speedometer` - 伪传感器，提供线性速度的近似值。

> 如果您尝试使用其他传感器或传感器参数名称错误，会使传感器设置失败。

> 如果在提交中您使用了超量的传感器，传感器配置验证失败，运行会出错。

此外，还有一些空间限制，限制了传感器在车辆体积内的位置。如果一个传感器在任何轴线上与您的主车相距超过3米（例如：`[3.1,0.0,0.0]`），设置将失败。

### 2.2.4 覆盖 run_step 方法

这个方法将在每个world tick被调用一次，产生一个新的动作，其形式为 `carla.VehicleControl` 对象。确保该函数返回控制对象，该对象将被用于更新仿真主车。

该方法会在每个时间步长中调用一次，返回一个VehicleControl对象。你可以在run_step中开发你的算法，并必须确保你返回的是以carla形式的VehicleControl对象`carla.VehicleControl` ，该返回对象将用于控制仿真主车运动。

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

- `input_data`: 是一个在每一个world tick中返回所搭载的传感器的数据的字典。这些数据以 numpy 数组的形式给出。 这个字典由传感器方法中定义的id来索引。

- `Timestamp`：当前仿真世界时间帧号。

### 2.2.5 覆盖destroy方法

在每个场景任务结束时，destroy 方法将被调用，需要注意的是，每个场景任务结束，我们会清理掉Carla世界内的主车与NPC车辆，所以我们需要您重写destroy方法来结束你的进程或线程。

```python
def destroy(self):
    pass
```

## 2.3 在simulate中使用dora示例

### 2.3.1 dora简介
!> 待补充dora简介

### 2.3.2 在dora中替换你的算法

想要将自己的算法（操作符）添加到节点流中，只需要在数据流中创建新的节点即可。我们以添加yolov5目标检测操作符为例，该算法已经在dora-drives/operators/yolov5_op.py中编写好。

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

您只需要重写__init__方法和on_input方法，init方法会在初始化节点调用，执行操作符所需要的所有初始化和定义；on_input方法会在每个时间步长中调用一次，您需要在yaml文件中定义入参inputs和输出outputs的内容。如果成功，返回CONTINUE 标志；

如果你想运行你的算法操作符，你只需要将它们添加到节点图中去：

```yaml
communication:
  iceoryx:
    app_name_prefix: dora-iceoryx-example

nodes:
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

- `nodes`：您要运行的节点群

- `id`    ：您的节点id

- `python`：您的代码入口

- `inputs`： 当前节点的输入

- `outputs`：当前节点的输出

输入以节点名为前缀，以便能够分离名称冲突。

你可以在docker中使用以下命令，来运行您的算法：

```bash
./scripts/launch.sh -b -g tutorials/webcam_yolov5.yaml
```

> 更加详细的有关dora的内容请参考：[**Dora 文档**](https://dora-rs.github.io/dora-drives/introduction.html)

## 2.4 训练和测试您的算法

- 将您的 your_agent.py 和相关配置以及代码复制到 TEAM_CODE_ROOT 目录下

```bash
cp your_agent.py ${TEAM_CODE_ROOT}
cp YOUR_CONFIG ${TEAM_CODE_ROOT}
```

- 设置环境变量并开始运行

```bash
export TEAM_AGENT=your_agent.py
bash ${TEAM_CODE_ROOT}/start.sh
```

我们准备了一套预定义的场景，您可以使用这些场景来训练和验证您的算法的性能。场景可以在oasis-simulate容器的`/carsmos/simulate/scenarios`文件夹中找到。

***

[上一页：比赛介绍](README.md)

[下一页：比赛规则](rules.md)
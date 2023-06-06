# 3 Development Guidelines

## 3.1 Overview

### 3.1.1 Brief to DORA-drives

The goal of `DORA` (Dataflow Oriented Robotic Architecture) is to provide low-latency, composable, and distributed *data-flow*. 

`DORA-Drives` is an introductory kit for autonomous driving software based on `DORA`, which will be used in this competition. By breaking down autonomous driving into sub-problems such as `perception`, `localization`, `planning`, and `control`, the aim is to lower the barrier to entry for autonomous driving system development and enable anyone to develop their own self-driving system.

### 3.1.2 What to do

The sample code has already implemented a complete autonomous driving system, which you can optimize, introduce your own model, or even develop a new autonomous driving system. 

To implement your autonomous driving algorithm in `oasis`, the main content you need to develop includes:

`my_operator.py`

The operators of packaging algorithm (`operators`). `DORA-drives` provides several operators for use. You can implement your own operator to implement your algorithm.

See details in the following text.

`my_agent.py`

The startup file can be directly modified and used with the default `carsmos/team_code/dora-drives/carla/oasis_agent.py`. 

See details in the following text.

`my_data_flow.yaml`

Data flow files that can be directly modified and used with the default `carsmos/team_code/dora-drives/graphs/oasis/oasis_agent.yaml`. 

See details in the following text.

`my_agent_config`：(optional) configuration file.

> The above file names can all be customized and development must be carried out in the `carsmos/team_code` directory.

## 3.2 Development example.

### 3.2.1 DORA brief manual

The data flow of `DORA` is defined through a `.yaml` file, as shown in the example below:


```yaml
communication: 
  zenoh:
    prefix: dora-zenoh-example

nodes:
  - id: oasis_agent # The unique ID in the current .yaml file.
    custom: # Customize the input and output of the node
      inputs: # Define the input
        tick: dora/timer/millis/400
      outputs: # Define the output
        - opendrive
        - objective_waypoints
        - ...
      source: shell
      args: >
        python3 $SIMULATE ...
 
  - id: carla_gps_op
    operator: # Represents an operator defined by a single python file
      python: ../../carla/carla_gps_op.py # python code file that implements algorithmic logic
      outputs: # Define the output of the operator
        - gps_waypoints
        - ready
      inputs: # Define the input of the operator
        opendrive: oasis_agent/opendrive # The output opendrive of oasis_agent node is one of the inputs of this node
        objective_waypoints: oasis_agent/objective_waypoints # The output objective_waypoints of oasis_agent is one of the inputs of this node
        ...
```

Once `id`, `inputs`, `outputs`, and `python` are defined in the node, input can be processed and results can be output in the corresponding `python` code file.
The overall structure of the `carla_gps_op.py` code file for implementing `carla_gps_op` is as follows.

```python

from typing import Callable
from dora import DoraStatus

class Operator:

  def __init__(self):
  # Perform some initialization.
  
  # The on_event method will be called every time a DORA event is received, including "INPUT", "STOP", and others, but we only need to use "INPUT". You can implement the algorithm logic and output in the on_input method below, or directly implement the algorithm and output in the on_event method.
  # 
  def on_event(
      self,
      dora_event: dict,
      send_output: Callable[[str, bytes], None],
  ) -> DoraStatus:
      # Only need to handle "INPUT" type DORA events.
      if dora_event["type"] == "INPUT":
          # You can replace on_input here, then process the input, implement the algorithm and output it, or you can implement it in the on_input method, and the latter is recommended.
          return self.on_input(dora_event, send_output)
      # DoraStatus is an enumeration variable which includes CONTINUE and STOP. You only need to return DoraStatus.CONTINUE to indicate that the algorithm should continue to execute. You do not need to use DoraStatus.STOP.
      return DoraStatus.CONTINUE

  # The on_input method is used to handle input, implement algorithms, and output results.
  def on_input(
        self,
        dora_input: dict,
        send_output: Callable[[str, bytes], None],
    ) -> DoraStatus:
    
    # dora_input is a dict
    # dora_input["id"] is a string that is equal to the ID of the input defined in the "inputs" section of the .yaml file.
    # dora_input["data"] is a byte array, which means the input data.
    if dora_input["id"] == "objective_waypoints":
      self.objective_waypoints = np.frombuffer(
                dora_input["data"], np.float32
            ).reshape((-1, 3))[self.completed_waypoints :]

    if dora_input["id"] == "opendrive":
      # Processing data input from OpenDRIVE.

    # Implement some algorithms and logic here

    # Call the send_output method in the parameter to output the result
    # send_output("string", b"string", {"foo": "bar"})
    # The first argument is a string equal to the id of the output defined in the outputs
    # The second argument is a byte array (bytes), which is the output data
    # The third parameter is some metadata
    send_output(
                    "gps_waypoints",
                    self.waypoints.tobytes(),
                    dora_input["metadata"],
                )
    return DoraStatus.CONTINUE

```

The point of the above code：

- **Define inputs and outputs**：The input and output are defined in the `.yaml` file, such as the output of the `oasis_agent` node, which includes `opendrive` and `objective_waypoints`, which are respectively passed to the `carla_gps_op` node as `opendrive` and `objective_waypoints`.
- **Process input and output**：Use Python to process the input and output the result.

### 3.2.2 Brief to oasis-agent

Using `oasis-agent.yaml` and `oasis-agent.py` as examples, the following will provide a detailed explanation of how the sample algorithm was developed. After reading and understanding this, you can use it as a basis for optimization or reference when developing new autonomous driving systems.

First, the `oasis-agent.py` implements the following functions:
- Executes several initializations in the `setup()` method, including setting the destination, checking the status of the `dora` node, etc.
- Defines sensors in the `sensors()` method.
- The `run_step()` method implements four functions in general:
  - Receives raw data from sensors, such as frames from the camera.

    ```python
    frame_raw_data = input_data["camera.center"][1]
    ```

  - The sensor raw data is preprocessed, for example, the frame raw data is converted into byte array

    ```python
    camera_frame = frame_raw_data.tobytes()
    ```

  - Send preprocessed sensor data to the output port, for example, send preprocessed frame data to the output port of `id=image`:

    ```python
    node.send_output("image", camera_frame)
    ```

  - Receive control information (throttle, steer, brake) sent from the PID Control operator and return:

    ```python
    value = event["data"]
    [throttle, target_angle, brake] = np.frombuffer(value, np.float16)
    ```

The overall structure of the self-driving system is divided into global path planning, obstacle detection, obstacle localization, local path planning, and control, each of which is implemented through an operator.

  - `GPS operator`
  
     Inputting high-precision maps in OpenDRIVE format, as well as the coordinates of the main vehicle and destination, can calculate and output GPS waypoints. The code file path is: `carsmos/team_code/dora-drives/carla/carla_gps_op.py`.

  - `Yolov5 operator`
  
    Real-time images can be input and YOLOv5 algorithm model can be used to calculate and output bounding boxes (referred to as `bbox` hereafter). The code file path is: `carsmos/team_code/dora-drives/operators/yolov5_op.py`.

  - `Obstacle location operator`
  
    By inputting the main vehicle's coordinates, bbox, and point cloud generated by the LiDAR, it is possible to calculate and output information about obstacles. The code file path is: `carsmos/team_code/dora-drives/operators/obstacle_location_op.py`.

  - `FOT operator`
   
    By inputting the main vehicle's coordinates, speed, obstacle information, and GPS waypoints, it is possible to calculate and output the actual waypoints. For example, if there is a vehicle blocking the route ahead, this operator can calculate a route to bypass the vehicle. The code file path is: `carsmos/team_code/dora-drives/operators/fot_op.py`.

  - `PID Control operator`
  
    Input the coordinates and speed of the main vehicle, as well as the waypoints calculated by the FOT operator, and output control information for the main vehicle (throttle, steering, brakes) can be calculated and generated.） The code file path is: `carsmos/team_code/dora-drives/operators/pid_control_op.py`.

### 3.2.1 Global Route Planning

The example algorithm uses `GPS operator` to implement global path planning, which utilizes `carla.GlobalRoutePlanner` to generate a safe, smooth, and efficient path based on the given starting and ending points, as well as the high-precision map, while considering factors such as the vehicle's physical characteristics, road restrictions, and traffic rules. At the same time, it can dynamically adjust the path planning based on the actual driving situation of the vehicle in real time, to ensure that the vehicle always travels on the optimal path. The key code is as follows:

- _hd_map.py：
  ```python
  # Instantiate GlobalRoutePlanner
  self._grp = GlobalRoutePlanner(
      self._map, 1.0
  )  # Distance between waypoints

  # Calculate global routes using GlobalRoutePlanner
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

### 3.2.2 Obstacle Detection

The example algorithm uses the `Yolov5 operator` to achieve obstacle perception. It can detect objects in the input image and output `bbox` to mark the position of the object. The example algorithm only implements obstacle detection and does not implement the calibration of traffic signals and signs.

```python
results = self.model(frame) # bbox was calculated using yolov5 model
...
send_output("bbox", arrays, dora_input["metadata"]) # Output the processed result
```

### 3.2.3 Obstacle Locating

The example algorithm uses the `Obstacle location operator` to locate obstacles. It uses the point cloud generated by the LIDAR and the `bbox` generated by the `Yolov5 operator`. By mapping the three-dimensional point cloud to the two-dimensional `bbox`, the distance of the obstacle can be calculated. Specifically, the coordinates of the point cloud are first converted to the coordinates of the camera, and then the points within the `bbox` are selected. The points with *z-axis coordinates equal to the quartile* are selected as distance measurement points, and the distance of the obstacle is calculated. The key code is as follows:

```python
# Convert point cloud coordinates to camera coordinates
camera_point_cloud = local_points_to_camera_view(
                point_cloud, INTRINSIC_MATRIX
            )

# Select the point in the bbox from the point cloud
[min_x, max_x, min_y, max_y, confidence, label] = obstacle_bb
z_points = self.point_cloud[
    np.where(
        (self.camera_point_cloud[:, 0] > min_x)
        & (self.camera_point_cloud[:, 0] < max_x)
        & (self.camera_point_cloud[:, 1] > min_y)
        & (self.camera_point_cloud[:, 1] < max_y)
    )
]

# Select the point with "Z-axis coordinate = quartile" as the nearest point for locating obstacles (this is done to eliminate noise)
if len(z_points) > 0:
    closest_point = z_points[
        z_points[:, 2].argsort()[int(len(z_points) / 4)]
    ]
```

### 3.2.4 Local Path Planning

The example algorithm uses `FOT operator` to implement local path planning. It computes the local path through a series of initial parameters. The initial parameters are as follows:
```python
initial_conditions = {
    "ps": 0,
    "target_speed": 
    "pos": # current x, y coordinate
    "vel": # current speed on x、y axis
    "wp": # [[x, y], ... n_waypoints ]，conpute the origin waypoints by `GPS operator`
    "obs": # [[min_x, min_y, max_x, max_y], ... ] obstacles' coordinate on the road
}
```

Because the obstacle coordinates calculated in the previous step are three-dimensional, they need to be converted to two-dimensional coordinates, which is achieved through `fot_op.py` - `get_obstacle_list`.

In addition, the algorithm model contains many hyperparameters： 
```python
max_speed (float): [m/s]
max_accel (float): [m/s^2]
max_curvature (float): [1/m]
max_road_width_l (float): Maximum left-side width [m]
max_road_width_r (float): Maximum right-side width [m]
d_road_w（float）：Road width sampling discretization[m]
dt（float）：Time sampling discretization [s]
maxt（float）：Maximum prediction time [s]
mint（float）：Minimum prediction time [s]
d_t_s（float）：Target velocity sampling discretization [m/s]
n_s_sample（float）：Target velocity sampling number
obstacle_clearance（float）：Radius of obstacle [m]
kd（float）：Location deviation cost
kv（float）：Speed cost
ka（float）：Acceleration cost
kj（float）：Cost of rate of change in acceleration
kt（float）：Time cost
ko（float）：Distance to obstacle cost
klat（float）：Horizontal cost
klon（float）：Vertical cost
```

You can tune these parameters to optimize the local programming algorithm。 For more details: [erdos-project/frenet_optimal_trajectory_planner](https://github.com/erdos-project/frenet_optimal_trajectory_planner/)

### 3.2.5 Control

The example algorithm uses the PID Control operator to achieve control, which responds to the current speed, direction, and position of the vehicle based on previous inputs to accelerate, turn, or brake.

For more information about 'dora-drives' please refer to：

- [**dora homepage**](https://dora.carsmos.ai/)

- [**dora dataflow document**](https://dora.carsmos.ai/dora/dataflow-config.html)

- [**dora-drives document**](https://dora.carsmos.ai/dora-drives)

## 3.3 Developed based on an agent

### 3.3.1 Create an agent

Participants need to create **my_agent.py** as the startup file in the **team_code/dora-drives/carla** directory specified in the Oasis Competition Version to execute the autonomous driving algorithm, and can refer to the example **oasis_agent.py**.

The **my_agent.py** created by participants needs to be developed by inheriting the **AutonomousAgent** class, and the **AutonomousAgent** class can be found in **autoagents/autonomous_agent.py**. This class defines all the methods that need to be implemented, which need to be implemented in **my_agent.py** to access the autonomous driving algorithm module.

The competition system will use the algorithm to run multiple preset scenes in sequence, generate task results, and evaluate the participant's autonomous driving algorithm.

```python
from autoagents.autonomous_agent import AutonomousAgent

class YourAgent(AutonomousAgent):
    def __init__(self, debug=False):
```

### 3.3.2 Initialize the configuration *setup*

Participants need to override the *setup* method in **my_agent.py**. This method performs all the initialization required by the *agent* before the scene task is run and is automatically called each time a new scene is loaded.

If you need to initialize the configuration through a *configuration file*, you need to create a configuration file in the **team_code/dora-drives/carla** directory specified in the Oasis Competition Version. The absolute path of the configuration file will be passed to the *setup* method through *path_to_conf_files*. Otherwise, please ignore.

At the same time, if necessary, you can load the latitude and longitude reference attributes into the *setup* method. These two attributes are reference values for converting *waypoint* coordinates to *carla* coordinates and will be updated before the *setup* runs.

```python
#latitude and longitude reference
lat_ref = None
lon_ref = None
class YourAgent(AutonomousAgent):
    def __init__(self, debug=False):

    def setup(self, destination, path_to_conf_file):
        """
        Setup the agent parameters
        """
        global lat_ref, lon_ref
        lat_ref = self.lat_ref
        lon_ref = self.lon_ref
```

You can refer to the following function `from_gps_to_world_coordinate` to convert GPS data to world coordinates:

​```python
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

### 3.3.3 Setting Up Sensors

Participants must rewrite the code to set up the  sensors Method，This method defines all the sensors that the agent can use.

In the Oasis Competition Version，Sensors can be directly configured in the Oasis Competition Version system's resource library to debug the optimal sensor configuration suitable for the participant's algorithm. **When submitting to the cloud for the competition, you need to write the optimal sensor configuration into the sensors method in my_agent.py and submit it. An example is as follows**

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

Each sensor is represented by a dictionary containing the following fields：

- `type`: The type of sensor to be added.

- `id`: The label that will be assigned to the sensor for later access.

- `attributes`: These attributes are related to the sensor, such as external factors and field of view.

Participants can set the intrinsic and extrinsic parameters (position and direction) of each sensor relative to the center coordinates of the vehicle. Please note that CARLA uses the left-handed coordinate system of UE4, that is: X-forward, Y-right, Z-up.

Sensor parameter configuration can refer to the example content in AutonomousAgent for configuration. At the same time, we have limited the types and number of sensors that can be configured. Please refer to the following content

| Sensors can be installed | The number of vehicles that can be carried |
| ------------------------ | ------------------------------------------ |
| sensor.camera.rgb        | 4                                          |
| sensor.other.radar       | 2                                          |
| sensor.other.gnss        | 1                                          |
| sensor.other.imu         | 1                                          |
| sensor.opendrive_map     | 1                                          |
| sensor.lidar.ray_cast    | 1                                          |
| sensor.speedometer       | 1                                          |

Sensors are explained as follows:

- [`sensor.camera.rgb`](https://carla.readthedocs.io/en/0.9.13/ref_sensors/#rgb-camera) - A regular camera that captures images.
- [`sensor.lidar.ray_cast`](https://carla.readthedocs.io/en/0.9.13/ref_sensors/#lidar-sensor) - Velodyne 64 lidar.
- [`sensor.other.radar`](https://carla.readthedocs.io/en/0.9.13/ref_sensors/#radar-sensor) - Remote radar (maximum distance of 100 meters).
- [`sensor.other.gnss`](https://carla.readthedocs.io/en/0.9.13/ref_sensors/#gnss-sensor) - GPS sensor that returns geographical location data.
- [`sensor.other.imu`](https://carla.readthedocs.io/en/0.9.13/ref_sensors/#imu-sensor) - Six-axis inertial measurement unit.
- `sensor.opendrive_map` - A pseudo sensor that parses a high-definition map in OpenDRIVE format into a string.
- `sensor.speedometer` - A pseudo sensor that provides an approximate value of linear speed.

> Trying to use other sensors or sensor parameter names incorrectly will cause sensor settings to fail.

> If an excessive number of sensors are used in the submission, the sensor configuration validation will fail and the program will crash.

In addition, there are some spatial restrictions that limit the position of the sensor inside the vehicle bounding box. If a sensor is more than 3 meters away from the main vehicle on any axis (for example: `[3.1,0.0,0.0]`), the setting will fail.

### 3.3.4 Override the run_step method

The *run_step* method will be called once per *world tick* and generates a new action in the form of a `carla.VehicleControl` object. Make sure to return the control object from this function, which will be used to update the simulation's ego vehicle.

Participants can develop their algorithm in the *run_step* method and must ensure that the function returns a `carla.VehicleControl` object, which will be used to control the movement of the simulation's ego vehicle.

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

- `world.tick()`: Runs the simulation world for one time step. Currently, the simulation world runs at a frequency of 20Hz, with each time step being 0.05s

- `run_step()`: Called once per time step, receives the output information of the loaded sensors, processes it with the algorithm, and outputs the vehicle's control information

- `input_data`: A dictionary that returns the output data of the loaded sensors in numpy array format at each *world tick*. This dictionary is indexed by the ID defined in the sensor method.

- `Timestamp`: The current simulation world time frame number.

### 3.3.5 Override the destroy method

At the end of each scene task, the `destroy` method will be called, and participants need to override the `destroy` method to end the corresponding processes or threads.

```python
def destroy(self):
    # destroy process 
    pass
```

## 3.4 On Dora-drives Source Code Management (SCM)

### 3.4.1 How to Contribute

To set up git:
- Git fork the project. Go to: [dora-drives/fork](https://github.com/dora-rs/dora-drives/fork)

- Set the source code configuration in your `dora-drives` folder:

```bash
# cd dora-drives
git remote rm origin
git remote add dora https://github.com/dora-rs/dora-drives.git
git remote add origin https://github.com/<USERNAME>/dora-drives.git 
```

- In case you want to fetch updates from `dora-drives`:

```bash
git fetch dora
git checkout main
git rebase dora/main
```

- You can push your changes to dora-drives` by creating a Pull Request:
```bash
git checkout -b my_branch # Create a new branch
git add `...changes...` # Add your changes
git commit -m "message"
git push --set-upstream origin my_branch
# go to: https://github.com/dora-rs/dora-drives/compare/main...<USERNAME>:dora-drives:<my_branch>
```

- We are greatful for any kind of contribution. We know that `dora-drives` still has many issues and we're sorry. But,
we hope that step-by-step, commit-by-commit, we can make it a great open source self-driving starter kit.

### 3.4.2 On Issues 

- If you have any issue using `dora-drives`, please raise an issue on our github page: https://github.com/dora-rs/dora-drives/issues
- You can also reach out to discuss `dora-drives` in the discussion section: https://github.com/dora-rs/dora-drives/discussions


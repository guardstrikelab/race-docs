
# 4 Competition Rules

## 4.1 Competition Scenarios

Simulation testing is a fundamental and critical technology for autonomous driving development. Compared with the high cost, limitations, and low efficiency of real-world testing, the [**Oasis Autonomous Driving Simulation Platform**](https://guardstrike.com/sim.html) can provide a more diverse range of static environments and continuous dynamic design/intelligent traffic flows. It can significantly increase the density of high-value scenarios in limited simulation testing, improving the efficiency and effectiveness of autonomous driving simulation testing.

This competition mainly tests the perception, planning, and decision-making abilities of autonomous driving algorithms in various complex traffic environments in urban areas. All the scenarios used in the competition belong to the Operational Design Domain (ODD) of low-speed working conditions with interactions among various traffic participants in urban areas under various weather and lighting conditions.

The competition will provide multiple training scenarios on the Oasis Autonomous Driving Simulation Platform for participants to develop and debug their autonomous driving algorithms. The testing scenarios used in the competition will be used to evaluate the submitted autonomous driving algorithms of participants and rank them according to the scoring mechanism. The training and testing scenarios use the same set of maps.

### 4.1.1 Maps

According to the Operational Design Domain (ODD) to which the scenarios belong, the maps used in this competition contain various types of urban roads, such as two-way two-lane, two-way four-lane, non-intersection straight roads, curves, crossroads and T-junctions with traffic lights, roundabouts, and overpasses connected by ramps. The specific information of each map can be viewed in the scenario editor.

### 4.1.2 Training Scenarios

The training scenarios consist of 28 atomic scenes, which are provided to the participants for the development and debugging of their autonomous driving algorithms. All training scenarios can be viewed and used as seed scenarios to derive more scenarios through the scene generalization function to meet the requirements of data collection and scenario diversity for autonomous driving algorithm development.

On the [**Scenarios Page - Training Scenarios**](en/scenarios_en.md#61-Training Scene), each training scenario is detailed and introduced.

### 4.1.3 Test Scenarios

The test scenarios consist of 10 complex scenes, each consisting of 2-4 atomic scenes, which are used to evaluate the autonomous driving algorithms submitted by the participants. All test scenarios are deployed on the cloud and cannot be viewed. After submitting their autonomous driving algorithm, the participants will run tests on the test scenarios in sequence and the results will be displayed on the page.

On the [**Scenarios Page - Test Scenarios**](en/scenarios_en.md#62-Testing-Scenarios), each test scenario is detailed and introduced, including the scene name, scene type, main features, usage, and reference materials.

### 4.1.4 Scenario Rules

1. In order to avoid vehicle instability caused by the main car having initial velocity when entering the autonomous driving system being tested, the main cars in all training and test scenarios enter the system with zero initial velocity at 0.1 seconds after the start of the scenario.

2. Using the Hybrid A* algorithm, the shortest path is planned for all scenarios based on the starting and ending points of the main car. The maximum time limit for each scenario is calculated based on the shortest path and the corresponding minimum average speed. The expected mileage and expected time can be viewed on the [**Scenarios Page**](en/scenarios_en.md). If the main car does not reach the end point within the maximum time limit, it is considered a timeout.

3. In order to prevent participants from using different path planning algorithms that may cause the main car to travel through uninteresting areas, stationary obstructing vehicles may be placed in irrelevant directions at intersections in the training and test scenarios.

4. The scene editor is open to all participants, who can edit any number of scenes as needed to meet the requirements of scenario diversity and data collection.

   

## 4.2 Scoring Mechanism

The main concepts of the scoring mechanism for the competition are explained as follows:

- A scenario is also known as a challenge. Each scenario has a ` scenario score `，and the`final score ` of the competition is the **average score** of all `scenario score`.
- The score of each scenario is the **weighted average** of several specific [**evaluation metrics**](en/rules_en.md#311-evaluation-metrics).
- The specific parameters of the evaluation metrics for each scene may be different.
- All scores are on a scale of 0 to 100. The higher the score, the better the performance.

### 4.2.1 Evaluation Metrics

The driving ability of autonomous vehicles can be reflected by multiple indicators. In this competition, we have designed and implemented a multi-angle and multi-level scoring mechanism, which enables us to have a comprehensive and fair evaluation of the participants' autonomous driving algorithms. The specific **evaluation metrics** and their corresponding **weights** (in parentheses) are as follows. The higher the weight, the more important the metric is in the total score calculation:

- `Scenario Time`(0.6): Each scenario has a maximum running time limit, and the specific time limit will be adjusted according to the scene situation. If the time limit is exceeded, **the total score of the scene will be 0**. If the time to reach the end point is less than the time limit, the shorter the time consumed within a certain range, the higher the score will be. The weight of this metric is 0.6.

- `Arrival at Endpoint`(1): Whether the main car has reached the predetermined end point of the scene. If the scene ends and the main car does not reach the end point, **the total score of the scene will be 0**. If the main car successfully reaches the end point, the score will be 100. The weight of this metric is 1.

- `Running Red Light`(1): If the main car crosses the stop line when the traffic light in the direction of travel at the intersection is red, the score for this metric will be 0. If there is no violation, the score will be 100. The weight of this metric is 1.

- `Leaving the Driving Lane`(1): If the main car drives into the parking lane, pedestrian lane, etc. by mistake, the score for this metric will be 0. If there is no violation, the score will be 100. The weight of this metric is 1.

- `Crossing Solid Lines`(1): If the main car crosses solid lines during driving, the score for this metric will be 0. If there is no violation, the score will be 100. The weight of this metric is 1.

- `Collision`(1): If the main car collides with a vehicle, pedestrian, or obstacle, the total score of the scene will be 0. If there is no collision, the score will be 100. The weight of this metric is 1.

- `Speed Limit`(0.8): A maximum speed limit is specified for the vehicle. If the main car exceeds the maximum speed limit, the corresponding metric will be 0. If there is no violation of the speed limit, within a certain range, the lower the speed, the higher the score will be. The weight of this metric is 0.8.

- `Acceleration`(0.5): It is the derivative of speed with respect to time and includes two indicators: longitudinal acceleration and lateral acceleration, which reflect the comfort of driving.

- `Jerk`(0.3): It is the derivative of acceleration with respect to time and includes two indicators: longitudinal acceleration change rate and lateral acceleration change rate, which also reflect the comfort of driving. The weight of this metric is 0.3.

### 4.2.2 Scoring Calculation Details

Here is a detailed explanation of several scoring calculations. It should be noted that both the metric score and the total score are on a scale of 0 to 100. If the score calculated by the formula exceeds this range, the score will be truncated to 0 or 100.

Let *T* be the expected value and *x* be the measured real value of the metric.

For the metrics of`scenario time` and`speed limit`, if the actual value is greater than the expected value, the score is 0. Conversely, if the actual value is less than or equal to the expected value, the score for that metric is:

$score = 60+40*\frac{|T-x|}{0.4*T}$

For the metrics of`acceleratio` and`jerk`,the calculation method is slightly different. If the actual value is greater than the expected value, the score for that metric is:

$score = 60+40*\frac{|T-x|}{0.4*T}$

If the actual value is less than the expected value, the score for that metric is calculated in the same way as the 'scenario time' metric.

## 4.3 Important Notice

> To balance computing power, the number of accesses to each sensor unit is limited. Each submitted file in the competition will be evaluated using the [g4dn.4xlarge](https://aws.amazon.com/ec2/instance-types/g4/) instance on AWS.

> Malicious use or attacks on the infrastructure of the Openatom Carsmos Global Open Source Autonomous Driving Algorithm Competition, including all software and hardware used to run the service, are strictly prohibited. These actions may result in teams being banned from participating in the competition.

Each team has a limited number of submission opportunities within one month or one day(up to `2` times per day).

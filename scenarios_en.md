[Previous page: Competition Rules](rules_en.md)

***

# 6 Competition Scenarios

## 6.1 Training Scenarios

| Scene Name                               | Scene Description                                               | Weather Lighting | Expected Mileage(m) | Expected Time Usage(s) |
| -------------------------------------------- | ------------------------------------------------------------------- | ----- | ---- | ---- |
| train1-leading_vehicle_brake                 | The Lead Vehicle in the Same Lane as the Host Vehicle Brakes. | Day、Sunny |131.85|53    |
| train2-leading_vehicle_brake                 | The Lead Vehicle in the Same Lane as the Host Vehicle Brakes. | Day、Rainy |97.99 |40    |
| train3-leading_vehicle_slow                  | The Lead Vehicle in the Same Lane as the Host Vehicle is Slowing Down. | Day、Foggy |108.66|44    |
| train4-leading_vehicle_slow                  | The Lead Vehicle in the Same Lane as the Host Vehicle is Slowing Down. | Night、Sunny |198.00|80    |
| train5-front_obstacle                        | There is an Obstacle Ahead in the Same Lane as the Host Vehicle. | Day、Sunny |106.02|43    |
| train6-front_obstacle                        | There is an Obstacle Ahead in the Same Lane as the Host Vehicle. | Night、Rainy |85.89 |35    |
| train7-front_opposite_vehicle_turnaround     | There is an Oncoming Vehicle Turning Around Ahead of the Host Vehicle. | Day、Sunny |97.56 |40    |
| train8-front_opposite_vehicle_turnaround     | There is an Oncoming Vehicle Turning Around Ahead of the Host Vehicle. | Day、Foggy |88.00 |36    |
| train9-left_vehicle_cutin                    | A Vehicle Cuts in from the Left Side of the Host Vehicle.   | Night、Foggy |154.15|62    |
| train10-right_vehicle_cutin                  | A Vehicle Cuts in from the Left Side of the Host Vehicle.   | Night、Sunny |162.00|65    |
| train11-front_vru_cross                      | A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle. | Day、Sunny |131.99|53    |
| train12-front_vru_cross                      | A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle. | Night、Foggy |72.07 |29    |
| train13-gostraight_left_vehicle_runred       | The Host Vehicle is Going Straight Through an Intersection, and a Vehicle on the Left Runs a Red Light. | Day、Sunny |88.04 |36    |
| train14-gostraight_left_vehicle_runred       | The Host Vehicle is Going Straight Through an Intersection, and a Vehicle on the Left Runs a Red Light. | Day、Rainy |97.46 |39    |
| train15-turnright_left_vehicle_gostaright    | The Host Vehicle is Making a Right Turn at an Intersection, and there is a Vehicle Going Straight on the Left Side. | Night、Sunny |85.91 |35    |
| train16-turnright_left_vehicle_gostaright    | The Host Vehicle is Making a Right Turn at an Intersection, and there is a Vehicle Going Straight on the Left Side. | Night、Rainy     |92.66 |38    |
| train17-turnleft_opposite_vehicle_gostaright | The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Going Straight Across on the Opposite Side. | Day、Sunny |79.65 |32    |
| train18-turnleft_opposite_vehicle_gostaright | The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Going Straight Across on the Opposite Side. | Night、Foggy |96.87 |39    |
| train19-turnright_right_vru_cross            | The Host Vehicle is Making a Right Turn at an Intersection, and a Vulnerable Road User is Crossing the Road on the Right Side of the Intersection. | Night、Sunny |93.48 |38    |
| train20-turnright_right_vru_cross            | The Host Vehicle is Making a Right Turn at an Intersection, and a Vulnerable Road User is Crossing the Road on the Right Side of the Intersection. | Day、Rainy |85.48 |35    |
| train21-front_occluded_vru_appear            | A Vulnerable Road User is Crossing the Road in the Blind Spot Ahead of the Host Vehicle. | Night、Sunny |133.99|54    |
| train22-front_occluded_vru_appear            | A Vulnerable Road User is Crossing the Road in the Blind Spot Ahead of the Host Vehicle. | Day、Foggy |115.58|47    |
| train23-enter_ramp                           | The Host Vehicle Enters a Ramp.                               | Day、Foggy |117.89|48    |
| train24-exit_ramp                            | The Host Vehicle Enters a Ramp.                               | Night、Sunny |172.73|70    |
| train25-advanced1                            | Four Sequential Events:<br /> 1. A Vehicle Cuts in from the Right Side of the Host Vehicle;<br />2.A Vulnerable Road User is Crossing the Road in Front of the Host VehicleThere is an Obstacle Ahead in the Same Lane as the Host Vehicle;<br />3. A Vulnerable Road User is Crossing the Road in the Blind Spot Ahead of the Host Vehicle;<br />4.A Vulnerable Road User is Crossing the Road in the Blind Spot Ahead of the Host Vehicle. | Day、Sunny |181.91|73    |
| train26-advanced2                            | Three Sequential Events:<br />1.An Oncoming Vehicle is Turning Around Ahead of the Host Vehicle;<br />2.A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle;<br />3.A Vehicle is Driving in the Opposite Direction in the Same Lane as the Host Vehicle. | Night、Rainy |138.00|56    |
| train27-advanced3                            | Two Sequential Events:<br />1.The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Going Straight Across on the Opposite Side;<br />2.A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle. | Day、Foggy |81.52 |33    |
| train28-advanced4                            | Two Sequential Events:1.The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Turning Left on the Right Side of the Intersection;<br />2.The Host Vehicle is Making a Right Turn at an Intersection, and a Vulnerable Road User is Crossing the Road on the Right Side of the Intersection. | Night、Sunny |100.42|41    |

## 6.2 Testing Scenarios

| Scene Name | Scene Description                                   | Weather Lighting | Expected Mileage(m) | Expected Time Usage(s) |
| ------ | ------------------------------------------------------- | ----- | ---- | ---- |
| test1  | Three Sequential Events:<br />1.A Vehicle Cuts in from the Left Side of the Host Vehicle;<br />2.The Host Vehicle is Making a Right Turn at an Intersection, and a Vulnerable Road User is Crossing the Road on the Right Side of the Intersection;<br />3.An Oncoming Vehicle is Turning Around Ahead of the Host Vehicle. | Day、Sunny |118.88|40    |
| test2  | Two Sequential Events:<br />1.The Host Vehicle is Going Straight Through an Intersection, and a Vehicle on the Right Runs a Red Light;<br />2.A Vulnerable Road User is Crossing the Road in the Blind Spot Ahead of the Host Vehicle. | Night、Sunny |109.65|37    |
| test3  | Three Sequential Events:<br />1.A Vehicle Cuts in from the Right Side of the Host Vehicle;<br />2.The Lead Vehicle in the Same Lane as the Host Vehicle Brakes;<br />3.There is an Obstacle Ahead in the Same Lane as the Host Vehicle. | Day、Foggy |217.18|87    |
| test4  | Four Sequential Events:<br />1.A Vehicle Cuts in from the Left Side of the Host Vehicle;<br />2.The Host Vehicle Enters a Ramp;<br />3.The Host Vehicle Exits the Ramp;<br />4.There is a Vehicle Approaching from Behind After the Host Vehicle Merges onto the Road. | Night、Rainy |349.07|140   |
| test5  | Two Sequential Events:<br />1.A Vehicle Cuts in from the Left Side of the Host Vehicle;<br />2.There is an Obstacle Ahead in the Same Lane as the Host Vehicle. | Day、Rainy |142.77|48    |
| test6  | Two Sequential Events:<br />1.A Vehicle Cuts in from the Right Side of the Host Vehicle;<br />2.  A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle. | Night、Sunny |134.00|45    |
| test7  | Two Sequential Events:<br />1.The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Turning Left on the Right Side of the Intersection;<br />2.There is an Obstacle Ahead in the Same Lane as the Host Vehicle. | Day、Sunny |94.42 |32    |
| test8  | Two Sequential Events:<br />1.The Host Vehicle is Making a Left Turn at an Intersection, and there is a Vehicle Going Straight Across on the Opposite Side;<br />2.The Lane of the Host Vehicle is Partially Occupied by a Stopped Vehicle. | Day、Foggy |76.55 |26      |
| test9  | Three Sequential Events:<br />1.A Vulnerable Road User is Crossing the Road in Front of the Host Vehicle;<br />2.An Oncoming Vehicle is Encroaching into the Lane of the Host Vehicle;<br />3.The Lead Vehicle in the Same Lane as the Host Vehicle is Slowing Down. | Night、Rainy |139.99|56    |
| test10 | Three Sequential Events:<br />1.A Vehicle Cuts out of the Same Lane as the Host Vehicle;<br />2.The Lead Vehicle in the Same Lane as the Host Vehicle Brakes;<br />3.The Lead Vehicle in the Same Lane as the Host Vehicle is Slowing Down. | Night、Sunny |192.36|65    |

***

[Previous page: Competition Rules](rules_en.md)

[Next page: License Import Instructions](license_en.md)
# 10 Frequently Asked Questions
## 10.1 About the Competition

- Is the competition about perception or decision-making?

    This competition consists of closed-loop testing, and you can freely choose to optimize perception or decision-making. The system will include a complete set of basic perception and decision-making algorithms, and you can choose the part you are good at for optimization and replacement.

## 10.2 Registration for the Competition

- Who can register?

    Anyone with basic programming skills and an interest in autonomous driving technology is welcome to register.

- Is there a limit on the number of team members?

    Currently, there is no limit on the number of team members for each team. You can add members according to your own preferences.

- Where can I see the team information after successful registration?

    You can see your team and member information here: Algorithm Submission Platform

- Can I add new team members after successful registration?

    Currently, this feature is not supported. If your friends wish to participate in the competition, they can register separately to form a new team.

## 10.3 Installation and Running of Oasis

- How to apply for a license?

    Double click on the desktop icon to enter the Oasis system, click the "Apply for License" button, and enter the relevant information. The license file will be automatically sent to the email address you provided. Download the license file from the email and import it into Oasis.

- What should I do if I get a "Network Connection Failed" message when entering Oasis?

    This is because some ports required by Oasis are being occupied by other programs. Before installation, you need to check if the ports are occupied. Please refer to the Installation Steps for more details.

    Once the network issue is resolved, you can use Ctrl+Shift+R to refresh the page.

- Why does the task always show "In Queue"?

    1. Installation is not successful (normally, there should be 11 operational containers). Please pay attention to the installation progress and check if all containers are running properly using docker ps -a.
    2. Also, check the error logs using 
        ```
        docker logs -f oasis-task-manager
        ```
    3. Make sure that the installation machine has the Nvidia driver installed. You can check if the driver is installed using 
        ```
        nvidia-smi
        ```

- Why is the task running "Abnormally"?

    1. It may be due to code errors. You can check if there are any syntax errors in your code.
    2. It may be due to task timeout (timeout is set to 8 minutes), which means the main vehicle did not reach the destination within the specified time.
    3. It may be due to unsuccessful initialization of Carla. Check if Carla is properly initialized (check if Nvidia driver is installed properly using nvidia-smi):
        ```
        docker logs -f oasis_carla_0.9.13-0407
        ```
    4. Check if Carla has restarted during the task execution using docker ps -a (check STATUS column).


# CS312Final

Deploying a Minecraft Server on AWS with terraform and ansible

**Background**

 To run the ansible and terraform scripts, they first must be downloaded from this github repo and some of the files(mentioned later) will need to be adjusted. The folder marked “MCAnsible” should go in the directory you have ansible available in and want to run in. The folder marked “lterraform” should go in the directory that has terraform and aws cli available in and want to run in. Once changes are made and the files installed you can run some commands to create the ec2 instance on AWS and to have files and minecraft server download on that ec2 instance, these commands will be mentioned later.  
**Requirements**

The user needs to have the following installed/access to. 

- The Terraform CLI (1.2.0+) installed.
- The AWS CLI installed.
- AWS account and associated credentials that allow you to create resources.
- Ansible installed either on the same machine or Ubuntu VM

**Major Steps(Broad Overview)**
1. Install the two folders in the github repo in appropriate places that can run Terraform and Ansible respectively.   
2. Change the credentials located in the ‘./aws’ folder located in the ‘lterraform’ folder to your AWS credentials.  
3. Initialize Terraform and run the Terraform Script  
4. Get the public-ip address outputted by the Terraform script and add that into the Inventory.ini file located in the MCAnsible folder.  
5. Run the Ansible playbook script  
6. Connect to the Minecraft Server  

**List of Commands to Run**

**1. Install the two folders from the github repo in appropriate places that can run Terraform and Ansible respectively.**
1. Go to this github repo and download the zip file.  
2. Extract the zip file.  
3. Place the contents of the ‘lterraform’ folder into the place that has access to Terraform and AWS CLI commands.  
4. Place the contents of the ‘MCAnsible’ folder into the place that has access to Ansible Commands.  
5. Download any necessary requirements as listed in the “Requirements” section.  
Explanation: This step has you setup your environment with the requirements needed to run the scripts and place the folders in places that you want them to be and can also run them.

**2. Change the credentials located in the './aws’ folder located in the ‘lterraform’ folder to your AWS credentials.**
1. Go to the “./aws” folder and open the credentials file.  
2. Go to your AWS account and copy your AWS account credentials. Should look like the format below:  
```
[default]

aws_access_key_id=

aws_secret_access_key=

aws_session_token=
```  
3. Paste the AWS credentials in the credentials file and save.  
4. In the ‘lterraform’ folder the mykeyfile.pem replace it with a valid keyfile that your AWS account will accept.  
5. Go into the ‘main.tf’ and change the keyname from mykeyfile to the name of your keyfile pair that AWS will accept and use.  
6. In the same ‘main.tf’ change the location of the credentials to path your “/.aws/credentials” file is located in.  
Explanation: You have your own set of AWS credentials that you need to use in order to set up the your new EC2 instance using Terraform.

**3. Initialize Terraform and run the Terraform Script. The commands listed below.**
1. Open a command prompt/terminal  
2. Change directories to the location of the ‘lterraform’ folder  
3. Run the command below to initialize Terraform:  
```
Terraform init  
```
4. Run the command below to run the Terraform to create the EC2 instance. The command will set up an EC2 instance  
```
Terraform apply  
```
Explanation: The Terraform script ‘main.tf’ will be the main Terraform script being run. It will create an EC2 Linux instance with the necessary settings such as security groups, key pairs, etc. This instance will appear on your AWS account.

**4. Get the public-ip address outputted by the Terraform script and add that into the Inventory.ini file located in the Ansible folder.**
1. In the ‘MCAnsible’ folder the mykeyfile.pem replace it with a valid keyfile that your AWS account will accept.
2.Copy the public-ip address from the Terraform script that ran in the previous step.  
3. Go to the location of the ‘MCAnsible’ folder  
4. Open the inventory.ini file and paste the ip address in there, the format should look like:
5. In the inventory.ini file change the keyname from mykeyfile to the name of your keyfile pair that AWS will accept and use.  
Explanation: This step is to set up and configure the Ansible script to match your credentials and your keyfile pair.  

**5. Run the Ansible playbook script.**
1. Open a command prompt/terminal  
2. Change directories to the location of the ‘MCAnsible’ folder  
3. Run the command below to run the Ansible Playbook:  
```
ansible-playbook -i inventory.ini minecraft.yaml  
```
Explanation: This step runs the ansible playbook for the server specifically. It will go through multiple steps of connecting to the ec2 instance, installing and updating packages such as java and screen, it will create a directory on the ec2, download the server.jar, edit the eula.txt file on the instance, then will create a systemd file for minecraft to allow for automatic restarts and proper shutdown of the server, then it will enable and run that systemd file, and it will also use screen to check for running sessions and run the server if need be.

**6. Connect to the Minecraft Server.** 

1\. Open the Minecraft Java Edition client on your local machine.

2\. Click on Play.

3\. Click on Multiplayer.

4\. Click on Add Server.

5\. Enter a name for the server in the Server Name field.

6\. Enter the public IP address of your EC2 instance in the Server Address field.

7\. Click on Done.

8\. Select the server you just added from the server list and click on Join Server.

9\. If everything was set up correctly, you should now be connected to your Minecraft server and ready to play.

Note: You may need to adjust firewall settings on your local machine or network to allow outbound connections to the Minecraft

server port (default is 25565).

10\. If you do not have minecraft you can telnet to it by using the following command. The port is 25565 as our default for minecraft and

what we set in the security settings.
```
telnet \[public ip of ec2 instance] \[25565]  
```
Or Use
```
nmap -sV -Pn -p T:25565 &lt;instance_public_ip>  
```
Explanation: Steps to actual use and play on the Minecraft server you made through Ansible and Terraform. 

**Sources Used**

<https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build>   
<https://jhooq.com/terraform-ssh-into-aws-ec2/>   
<https://medium.com/@alexlnguyen/deploying-a-minecraft-1-12-1-server-with-ansible-a1bc03c948b3>   
<https://unix.stackexchange.com/questions/302733/minecraft-server-startup-shutdown-with-systemd>   
<https://www.youtube.com/watch?v=73pgFXLYrfk> 


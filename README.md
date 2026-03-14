# Project-1-Automation
CCGC 5502 Automation Assignment Project 1


CCGC 5502 Automation Professor Asghar Ghori
Assignment
Automation with Terraform
Marks: 25
Assignment Overview
This assignment provides learners with a real-world challenging scenario of codifying infrastructure
and provisioning it in the Azure cloud. The assignment challenges them to apply their Terraform and
Microsoft Azure knowledge and skills gained from the course to build a highly available, scalable,
and secure infrastructure using a variety of Azure services, resources, and features across multiple
availability zones. Learners are expected to use a development platform of their choice—Visual
Studio Code, WSL (Windows Subsystem for Linux), GitBash, or a VM installed locally on their own
laptop computers—to complete the assignment. They need to frequently access the Azure portal.
Technical Skills Assessed
Terraform skills assessed in the assignment include:
• Code development for a variety of Azure resources
• Management of single and multiple instances of infrastructure resources
• Parameterization via input variables
• Parameterization via locals block
• Parameterization via output values
• Modular architecture
• The use of the null provisioner
• Configuration and use of remote backend
Azure services, resources, and features assessed in the assignment include:
• Identity and Access (Microsoft Entra ID)
• Networking (virtual networks, subnets, etc.)
• Security (network security groups, etc.)
• Storage (storage accounts, Azure Files, blob containers, etc.)
• Compute (Windows and Linux virtual machines, managed disks)
• Network Traffic Management (load balancers)
• Monitoring (Microsoft Monitor)
• Cost Management (cost analysis)
• Azure Interfaces (Portal, AZ CLI)
Page 1 of 8
CCGC 5502 Automation Soft Skills Assessed
• Critical thinking
• Researching
• Troubleshooting
• Problem-solving
• Decision-making
• Self-judgement
• Organization
• Stress management
• Independent and collaborative working
Professor Asghar Ghori
Assignment Requirements
Use a free-tier or pay-as-you-go (preferred) Azure account to accomplish the assignment deliverables.
Recommendations
Implement the assignment in 1 Azure region that has availability zones (Canada Central, Australia
Central, UK West, etc.).
Deliverables
See end of this document.
Warning
Copying and pasting the work of other students and submitting it as one’s own is a serious academic
misconduct. All involved parties will get a ZERO, no exceptions.
Feedback
We look forward to receiving your constructive feedback in terms of assignment flow, errors
encountered, fixes you applied to make things functional, and so on. Please record your comments
where they apply in your assignment document.
Page 2 of 8
CCGC 5502 Automation Professor Asghar Ghori
Rubric and Passing Marks
The following rubric will be used to grant marks to the assignment work. Each task under Assignment
Details has maximum marks shown in parentheses. The Hands-On Implementation is worth 90 marks
and the Presentation 10 marks.
Hands-On Implementation Max Marks Your Marks
Backend 10
Use of remote backend 10
Parameterization 10
Heavy input parameterization 10
Medium input parameterization 6
Light input parameterization 3
Locals 3
Use of locals for tagging 3
Scalability 20
Use of scalable code for Linux VMs (must use for_each) 10
Use of scalable code for Windows VMs (must use count) 10
Availability 4
Linux VMs in availability set 2
Windows VM in availability set 2
Provisioner 3
Provisioner displaying the hostnames of the provisioned VMs 3
Resource Creation and Outputs 30
Linux and Windows hostnames 4
Linux and Windows FQDNs 4
Linux and Windows private IP addresses 2
Linux and Windows public IP addresses 2
Virtual network and subnet created successfully, and their names displayed 2
Recovery services vault, storage account, and log analytics workspace created
successfully, and their names displayed
3
Load balancer created successfully, and its name displayed 8
Database created successfully, and its name displayed 5
100% Non-Interactive and Flawless Provisioning 10
10
Sub-Total 90
Presentation
10
Sub-Total 10
GRAND TOTAL 100
Note: The final marks will be divided by 4 as the maximum for the assignment are 25.
Page 3 of 8
CCGC 5502 Automation Professor Asghar Ghori
Instructions
1. 2. 3. 4. 5. 6. Create a repo in GitHub to store code
You should be able to run the code from your automation VM
Select 1 CPU VM size (B1ms), LRS storage SKU, and cheapest DB options
Use logical names for all your resources. Prepend all resource names with the last 4 digits of your
Humber ID to ensure uniqueness.
Parametrize Terraform configuration as much as possible
Store Terraform state information in Azure backend
7. 8. 9. Naming for root module files: providers.tf, backend.tf, main.tf, and outputs.tf
Naming for child module files: main.tf, variables.tf, outputs.tf, and provisioner.tf
Hardcode values in child modules that you do not expect to change often
10. Use your knowledge and comprehension to make configuration choice decisions where enough
information is not provided
11. Shut down the VMs when not in use to save cost
12. Use the following tags for all your resources:
Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
Page 4 of 8
CCGC 5502 Automation Professor Asghar Ghori
Assignment Details
Phase I - Development
Develop a Child Module for Resource Group:
Develop a Terraform child module called rgroup-HumberID to provision 1 resource group called HumberID-
RG. This module should return the name of the resource group to the root module.
Develop a Child Module for Networking:
Develop a Terraform child module called network-HumberID to provision 1 virtual network called
HumberID-VNET along with 1 subnet called HumberID-SUBNET in HumberID-RG resource group. Add a
network security group with 4 inbound access rules to allow traffic over ports 22, 3389, 5985, and 80. This
network security group must be associated with the subnet. This module should return the names of the virtual
network and the subnet to the root module.
Develop a Child Module for Common Services:
Develop a Terraform child module called common-HumberID to provision 1 log analytics workspace, 1
recovery services vault, and 1 standard storage account with LRS redundancy. This storage account MUST be
different from the one with Terraform backend located. This module should return the names of the three
resources to the root module.
Develop a Child Module for Linux Virtual Machines:
Develop a Terraform child module called vmlinux-HumberID to provision 3 CentOS 8.2 Linux VMs with
public IP addresses created in 1 availability set (use for_each to ensure the code is scalable). Each VM must use
the storage account created above for VM boot diagnostics. Each VM must have a unique DNS label assigned.
The VMs must have 2 extensions installed: (1) Network Watcher extension [publisher:
Microsoft.Azure.NetworkWatcher; name: NetworkWatcherAgentLinux; version 1.0] and (2) Azure Monitor
extension [publisher: Microsoft.Azure.Monitor; name: AzureMonitorLinuxAgent; version 1.0]. Use the remote-
exec null provisioner to display the hostnames of all 3 VMs. This module must return the hostnames, domain
names, private IP addresses, and public IP addresses of the VMs to the root module.
Page 5 of 8
CCGC 5502 Automation Professor Asghar Ghori
Develop a Child Module for Windows Virtual Machines:
Develop a Terraform child module called vmwindows-HumberID to provision 1 Windows Server 2016 VM
with public IP address created in 1 availability set (use count to ensure the code is scalable). The VM must have
Antimalware extension installed. The VM must use the storage account created above for VM boot diagnostics.
The VM must have a unique DNS label assigned. This module must return the hostname, domain name, private
IP address, and public IP address of the VM to the root module.
Develop a Child Module for Data Disks:
Develop a Terraform child module called datadisk-HumberID to provision 4 x 10GB disks and attach them to
the 4 VMs.
Develop a Child Module for Load Balancer:
Develop a Terraform child module called loadbalancer-HumberID to provision 1 public-facing basic load
balancer with all 3 Linux VMs behind it. This module should return the name of the load balancer to the root
module.
Develop a Child Module for Database:
Develop a Terraform child module called database-HumberID to provision 1 Azure DB for PostgreSQL Single
Server instance. This module should return the name of the DB instance to the root module.
Develop the Root Module:
Develop a Terraform root module called assignment1-HumberID and define all child modules in it. This
module should print on the screen the outputs received from child modules on a successful deployment.
Page 6 of 8
CCGC 5502 Automation 1. 2. 3. Professor Asghar Ghori
Phase II – Pre-Provisioning Validation
Run terraform init to initialize the plugins and backend, and download modules.
Run terraform validate to confirm there are no typos and syntax errors.
Run terraform plan and review the entire plan to confirm the deployment.
1. Phase III – Provisioning
The entire infrastructure as code (Terraform) developed above must be provisioned flawlessly and non-
interactively when terraform apply --auto-approve is issued.
1. 2. Phase IV – Post-Provisioning Validation
Run the terraform state list | nl command. This should show exactly 48 lines in the output.
Run the terraform output command.
Assessment Requirements
1. If you are satisfied with your assignment, run terraform destroy --auto-approve to
remove the entire infrastructure.
2. Start video recording while executing the following commands one by one:
terraform init
terraform validate
terraform apply --auto-approve
terraform state list | nl
terraform output
Phase V – Submission
1. 2. Share the GitHub assignment repo with the instructor
Submit the video in Blackboard under Terraform Assignment
End of Assignment
Page 7 of 8
CCGC 5502 Automation Professor Asghar Ghori
DESTROY THE INFRASTRUCTURE AFTER YOUR
ASSIGNMENT HAS BEEN MARKED TO SAVE COST
DO NOT REMOVE THE TERRAFORM CODE
Page 8 of 8

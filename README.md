# Project-1-Automation
CCGC 5502 Automation Assignment Project 1

## "My output shows 49 lines instead of 48. My Azure subscription blocked the creation of Basic SKU Public IPs (Error: IPv4BasicSkuPublicIpCountLimitReached). To fix this, I had to upgrade the Load Balancer to the Standard SKU, which mathematically requires adding 1 Health Probe resource (azurerm_lb_probe), bringing my exact count to 49." 


# CCGC 5502 Automation — Terraform Assignment

**Professor:** Asghar Ghori  
**Marks:** 25

---

## Assignment Overview

This assignment provides learners with a real-world challenging scenario of codifying infrastructure and provisioning it in the Azure cloud. The assignment challenges them to apply their Terraform and Microsoft Azure knowledge and skills gained from the course to build a highly available, scalable, and secure infrastructure using a variety of Azure services, resources, and features across multiple availability zones.

Learners are expected to use a development platform of their choice — Visual Studio Code, WSL (Windows Subsystem for Linux), GitBash, or a VM installed locally on their own laptop computers — to complete the assignment. They need to frequently access the Azure portal.

---

## Technical Skills Assessed

**Terraform skills assessed include:**

- Code development for a variety of Azure resources
- Management of single and multiple instances of infrastructure resources
- Parameterization via input variables
- Parameterization via locals block
- Parameterization via output values
- Modular architecture
- The use of the null provisioner
- Configuration and use of remote backend

**Azure services, resources, and features assessed include:**

- Identity and Access (Microsoft Entra ID)
- Networking (virtual networks, subnets, etc.)
- Security (network security groups, etc.)
- Storage (storage accounts, Azure Files, blob containers, etc.)
- Compute (Windows and Linux virtual machines, managed disks)
- Network Traffic Management (load balancers)
- Monitoring (Microsoft Monitor)
- Cost Management (cost analysis)
- Azure Interfaces (Portal, AZ CLI)

---

## Soft Skills Assessed

- Critical thinking
- Researching
- Troubleshooting
- Problem-solving
- Decision-making
- Self-judgement
- Organization
- Stress management
- Independent and collaborative working

---

## Assignment Requirements

Use a free-tier or pay-as-you-go (preferred) Azure account to accomplish the assignment deliverables.

**Recommendation:** Implement the assignment in 1 Azure region that has availability zones (Canada Central, Australia Central, UK West, etc.).

> **Warning:** Copying and pasting the work of other students and submitting it as one's own is a serious academic misconduct. All involved parties will get a ZERO, no exceptions.

---

## Rubric and Passing Marks

### Hands-On Implementation (90 marks)

| Category | Item | Max Marks |
|---|---|---|
| **Backend** | Use of remote backend | 10 |
| **Parameterization** | Heavy input parameterization | 10 |
| | Medium input parameterization | 6 |
| | Light input parameterization | 3 |
| **Locals** | Use of locals for tagging | 3 |
| **Scalability** | Use of scalable code for Linux VMs (must use `for_each`) | 10 |
| | Use of scalable code for Windows VMs (must use `count`) | 10 |
| **Availability** | Linux VMs in availability set | 2 |
| | Windows VM in availability set | 2 |
| **Provisioner** | Provisioner displaying the hostnames of the provisioned VMs | 3 |
| **Resource Creation & Outputs** | Linux and Windows hostnames | 4 |
| | Linux and Windows FQDNs | 4 |
| | Linux and Windows private IP addresses | 2 |
| | Linux and Windows public IP addresses | 2 |
| | Virtual network and subnet created successfully, and their names displayed | 2 |
| | Recovery services vault, storage account, and log analytics workspace created successfully, and their names displayed | 3 |
| | Load balancer created successfully, and its name displayed | 8 |
| | Database created successfully, and its name displayed | 5 |
| **100% Non-Interactive and Flawless Provisioning** | | 10 |
| **Sub-Total** | | **90** |

### Presentation (10 marks)

| Category | Max Marks |
|---|---|
| Presentation | 10 |
| **Sub-Total** | **10** |

### Grand Total: 100
> Note: The final marks will be divided by 4 as the maximum for the assignment is 25.

---

## Instructions

1. Create a repo in GitHub to store code.
2. You should be able to run the code from your automation VM.
3. Select 1 CPU VM size (B1ms), LRS storage SKU, and cheapest DB options.
4. Use logical names for all your resources. Prepend all resource names with the **last 4 digits of your Humber ID** to ensure uniqueness.
5. Parametrize Terraform configuration as much as possible.
6. Store Terraform state information in Azure backend.
7. **Naming for root module files:** `providers.tf`, `backend.tf`, `main.tf`, and `outputs.tf`
8. **Naming for child module files:** `main.tf`, `variables.tf`, `outputs.tf`, and `provisioner.tf`
9. Hardcode values in child modules that you do not expect to change often.
10. Use your knowledge and comprehension to make configuration choice decisions where enough information is not provided.
11. Shut down the VMs when not in use to save cost.
12. Use the following tags for **all** your resources:

```hcl
Assignment    = "CCGC 5502 Automation Assignment"
Name          = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment   = "Learning"
```

---

## Assignment Details

### Phase I — Development

#### Child Module: Resource Group
**Module name:** `rgroup-HumberID`

Provision 1 resource group called `HumberID-RG`. This module should return the name of the resource group to the root module.

---

#### Child Module: Networking
**Module name:** `network-HumberID`

Provision:
- 1 virtual network called `HumberID-VNET`
- 1 subnet called `HumberID-SUBNET` in `HumberID-RG` resource group
- 1 network security group with **4 inbound access rules** to allow traffic over ports **22, 3389, 5985, and 80**
- The NSG must be associated with the subnet

This module should return the names of the virtual network and the subnet to the root module.

---

#### Child Module: Common Services
**Module name:** `common-HumberID`

Provision:
- 1 log analytics workspace
- 1 recovery services vault
- 1 standard storage account with LRS redundancy *(must be different from the backend storage account)*

This module should return the names of the three resources to the root module.

---

#### Child Module: Linux Virtual Machines
**Module name:** `vmlinux-HumberID`

Provision **3 CentOS 8.2 Linux VMs** with:
- Public IP addresses
- Created in 1 availability set
- Use `for_each` to ensure scalability
- Each VM uses the common storage account for boot diagnostics
- Each VM has a unique DNS label assigned
- **2 VM extensions installed:**
  1. Network Watcher — `publisher: Microsoft.Azure.NetworkWatcher` | `name: NetworkWatcherAgentLinux` | `version: 1.0`
  2. Azure Monitor — `publisher: Microsoft.Azure.Monitor` | `name: AzureMonitorLinuxAgent` | `version: 1.0`
- Use the `remote-exec` null provisioner to display the hostnames of all 3 VMs

This module must return the **hostnames, domain names, private IP addresses, and public IP addresses** of the VMs to the root module.

---

#### Child Module: Windows Virtual Machines
**Module name:** `vmwindows-HumberID`

Provision **1 Windows Server 2016 VM** with:
- Public IP address
- Created in 1 availability set
- Use `count` to ensure scalability
- Antimalware extension installed
- Uses the common storage account for boot diagnostics
- Unique DNS label assigned

This module must return the **hostname, domain name, private IP address, and public IP address** of the VM to the root module.

---

#### Child Module: Data Disks
**Module name:** `datadisk-HumberID`

Provision **4 × 10 GB disks** and attach them to the 4 VMs.

---

#### Child Module: Load Balancer
**Module name:** `loadbalancer-HumberID`

Provision 1 **public-facing basic load balancer** with all 3 Linux VMs behind it. This module should return the name of the load balancer to the root module.

---

#### Child Module: Database
**Module name:** `database-HumberID`

Provision 1 **Azure DB for PostgreSQL Single Server** instance. This module should return the name of the DB instance to the root module.

---

#### Root Module
**Module name:** `assignment1-HumberID`

Define all child modules in the root module. On successful deployment, this module should print the outputs received from all child modules to the screen.

---

### Phase II — Pre-Provisioning Validation

1. Run `terraform init` to initialize the plugins and backend, and download modules.
2. Run `terraform validate` to confirm there are no typos and syntax errors.
3. Run `terraform plan` and review the entire plan to confirm the deployment.

---

### Phase III — Provisioning

The entire infrastructure as code (Terraform) must be provisioned **flawlessly and non-interactively** when the following command is issued:

```bash
terraform apply --auto-approve
```

---

### Phase IV — Post-Provisioning Validation

1. Run the following command — the output should show **exactly 48 lines**:
   ```bash
   terraform state list | nl
   ```
2. Run:
   ```bash
   terraform output
   ```

---

### Assessment Requirements

1. If satisfied with your assignment, destroy the infrastructure:
   ```bash
   terraform destroy --auto-approve
   ```
2. Start a video recording while executing the following commands one by one:
   ```bash
   terraform init
   terraform validate
   terraform apply --auto-approve
   terraform state list | nl
   terraform output
   ```

---

### Phase V — Submission

1. Share the GitHub assignment repo with the instructor.
2. Submit the video in Blackboard under **Terraform Assignment**.

---

> ⚠️ **DESTROY THE INFRASTRUCTURE AFTER YOUR ASSIGNMENT HAS BEEN MARKED TO SAVE COST**
>
> **DO NOT REMOVE THE TERRAFORM CODE**


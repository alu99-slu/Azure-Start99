# Week 1–2: Understanding Real Infrastructure
## Complete Study Notes — Detailed Explanations & Integration Guide

> **How to use this guide:** Each topic is explained in depth, followed by practical examples and, critically, an **Integration** section showing how it connects with every other tool in this week's stack. Read top-to-bottom for the first pass, then use section links as a reference.

---

## Table of Contents

1. [Hybrid Infrastructure](#1-hybrid-infrastructure)
   - [Hybrid Cloud Architecture (AWS)](#11-hybrid-cloud-architecture-aws)
   - [Hybrid Cloud Architecture (Azure)](#12-hybrid-cloud-architecture-azure)
   - [Multi-Cloud Strategy (GCP)](#13-multi-cloud-strategy-gcp)
2. [On-Premises: VMs & Bare Metal](#2-on-premises-vms--bare-metal)
   - [VirtualBox](#21-virtualbox)
   - [VMware](#22-vmware)
   - [Virtualization Fundamentals (Red Hat)](#23-virtualization-fundamentals-red-hat)
3. [Networking Refresher](#3-networking-refresher)
   - [Networking Fundamentals (Kunal Kushwaha)](#31-networking-fundamentals-kunal-kushwaha)
   - [TCP/IP Basics (Cloudflare)](#32-tcpip-basics-cloudflare)
   - [Subnetting and VLANs](#33-subnetting-and-vlans)
4. [Cloud Provider Intro](#4-cloud-provider-intro)
   - [AWS Getting Started](#41-aws-getting-started)
   - [Azure Fundamentals](#42-azure-fundamentals)
   - [Google Cloud Training](#43-google-cloud-training)
   - [Oracle Cloud (My Learn)](#44-oracle-cloud-my-learn)
5. [Tool Setup: Docker](#5-tool-setup-docker)
   - [Docker Install](#51-docker-install)
   - [Docker for Beginners (Nana)](#52-docker-for-beginners-nana)
   - [FreeCodeCamp Docker Course](#53-freecodecamp-docker-course)
6. [Tool Setup: Terraform](#6-tool-setup-terraform)
   - [Terraform Tutorials](#61-terraform-tutorials)
   - [Terraform Beginner (FreeCodeCamp)](#62-terraform-beginner-freecodecamp)
   - [Abhishek – Terraform Zero to Hero](#63-abhishek--terraform-zero-to-hero)
7. [Tool Setup: Vagrant + VirtualBox](#7-tool-setup-vagrant--virtualbox)
   - [Vagrant Getting Started](#71-vagrant-getting-started)
   - [Vagrant Tutorial](#72-vagrant-tutorial)
8. [Tool Setup: VS Code + Copilot](#8-tool-setup-vs-code--copilot)
9. [Master Integration Map](#9-master-integration-map)
10. [Practical Lab: Full Stack Setup](#10-practical-lab-full-stack-setup)

---

## 1. Hybrid Infrastructure

### 1.1 Hybrid Cloud Architecture (AWS)

#### What is it?

A **hybrid cloud architecture** is an IT environment that combines an organisation's **on-premises infrastructure** (physical servers, private datacentres) with **public cloud resources** (AWS, Azure, GCP) and allows data and applications to move freely between them.

Think of it like this: your company's most sensitive database lives in your own locked office (on-premises), but when your website gets a burst of traffic, it automatically borrows computing power from a rented warehouse (AWS) — then releases it when the traffic dies down. The two environments talk to each other as if they were one.

#### Why it exists

Pure on-premises is expensive and inflexible. Pure cloud raises data sovereignty and latency concerns. Hybrid is the pragmatic middle ground used by the majority of large enterprises.

#### AWS Hybrid Tools You Must Know

| AWS Service | What it does | Where it fits |
|---|---|---|
| **AWS Outposts** | Brings AWS infrastructure physically into your on-prem datacentre. Actual AWS servers in your building. | On-prem workloads that need AWS APIs |
| **AWS Direct Connect** | A private, dedicated fibre connection from your datacentre directly to AWS — not over the public internet | High-bandwidth, low-latency hybrid connectivity |
| **AWS VPN (Site-to-Site)** | Encrypted tunnel over the internet connecting your on-prem network to your AWS VPC | Lower-cost alternative to Direct Connect |
| **AWS Storage Gateway** | Connects on-prem apps to AWS cloud storage (S3, Glacier) as if it were a local NAS device | Backup, archiving, tiered storage |
| **AWS Systems Manager** | Manage both on-prem servers AND EC2 instances from a single pane of glass | Hybrid operations, patching, inventory |

#### Architecture Pattern: Hybrid Web Application

```
[User's browser]
      |
      | HTTPS
      v
[AWS CloudFront CDN] — caches static content globally
      |
      | Dynamic requests
      v
[AWS Application Load Balancer] — in AWS VPC (cloud)
      |
[AWS EC2 Auto Scaling Group] — web/app tier in cloud
      |
      | AWS Direct Connect (private fibre)
      v
[On-Premises Database Cluster] — stays on-prem for compliance
[On-Premises Active Directory] — identity stays local
```

#### Key Concepts to Understand

**VPC (Virtual Private Cloud):** A logically isolated section of AWS where you launch resources. Think of it as your private network inside AWS. You define the IP range, subnets, routing tables, and security rules.

**Subnets:** Sub-divisions of your VPC IP range. Public subnets have routes to the internet. Private subnets do not. Your sensitive workloads go in private subnets.

**Security Groups:** Virtual firewalls attached to EC2 instances. They control inbound and outbound traffic at the instance level (stateful — return traffic is automatically allowed).

**NACL (Network Access Control Lists):** Firewalls at the subnet level (stateless — you must explicitly allow both inbound and outbound).

#### Integration

- **With Terraform:** You provision the entire AWS hybrid architecture — VPCs, subnets, Direct Connect gateways, VPN tunnels — using Terraform code. Infrastructure as Code means you can reproduce the entire hybrid setup in minutes.
- **With Docker:** Your containerised applications run on EC2 instances or AWS ECS in the cloud side of the hybrid. The same Docker image can also run on on-prem VMs managed by VirtualBox or VMware.
- **With VirtualBox/VMware:** On-premises VMs are the "on-prem" side of the hybrid. They connect to AWS via Site-to-Site VPN or Direct Connect.
- **With Networking:** Understanding subnets, routing, and VLANs is essential — hybrid connectivity requires careful IP address planning so on-prem ranges don't conflict with cloud VPC ranges.

---

### 1.2 Hybrid Cloud Architecture (Azure)

#### What is it?

Azure hybrid cloud architecture combines your **on-premises infrastructure** with **Microsoft Azure** public cloud resources. Microsoft has invested more deeply in hybrid scenarios than any other cloud provider — largely because its enterprise customers run massive Windows Server, SQL Server, and Active Directory estates on-premises and need a smooth path to cloud without ripping everything out.

The Azure hybrid story is built on one key platform: **Azure Arc**. While AWS hybrid is largely about connectivity (Direct Connect, VPN, Outposts), Azure goes further by letting you *manage* on-prem and multi-cloud resources as if they were Azure resources — same portal, same policies, same monitoring.

#### Why Azure Hybrid is Different from AWS Hybrid

| Aspect | AWS Hybrid | Azure Hybrid |
|---|---|---|
| **Primary strength** | Connectivity (Direct Connect, VPN) + Outposts hardware | Management plane (Arc) — manage anything from Azure |
| **Identity** | AWS IAM (separate from on-prem AD) | Azure AD / Entra ID natively extends on-prem Active Directory |
| **Flagship tool** | AWS Outposts (physical AWS hardware on-prem) | Azure Arc (extend Azure management everywhere) |
| **SQL Server story** | RDS (managed service, new deployment) | Azure SQL Managed Instance, Arc-enabled SQL Server |
| **Windows workloads** | Good support | Best support — Microsoft owns Windows |
| **Pricing benefit** | None specifically | Azure Hybrid Benefit — reuse existing licenses |

#### Azure Hybrid Tools You Must Know

| Azure Service | What it does | Where it fits |
|---|---|---|
| **Azure Arc** | Extend Azure management, governance, and security to any infrastructure — on-prem servers, Kubernetes clusters, SQL servers, even VMs on AWS or GCP | The central hub of all Azure hybrid |
| **Azure ExpressRoute** | Private dedicated fibre connection from your datacentre to Azure — NOT over the public internet. Like AWS Direct Connect. | High-bandwidth, low-latency, mission-critical connectivity |
| **Azure VPN Gateway** | Encrypted Site-to-Site VPN tunnel over the internet between on-prem and Azure VNet | Lower-cost connectivity for lower-throughput workloads |
| **Azure Stack Hub** | Full Azure software stack running on your own hardware in your datacentre | Disconnected/air-gapped environments, data sovereignty |
| **Azure Stack HCI** | Hyperconverged infrastructure for running VMs and containers on-prem, managed from Azure | Modernise on-prem datacentre without full cloud migration |
| **Azure Stack Edge** | Azure-managed edge computing device — a physical appliance Microsoft ships to you | AI/ML inference at the edge, remote/branch offices |
| **Azure AD Connect / Entra Connect** | Syncs on-premises Active Directory users and groups to Azure AD | Unified identity — users log in once for on-prem and cloud |
| **Azure File Sync** | Sync on-premises Windows file servers to Azure Files — cloud becomes a tier of your file server | Centralise file storage, keep local cache for performance |
| **Azure Migrate** | Assess and migrate on-premises VMs, databases, and web apps to Azure | Discovery, assessment, migration planning |
| **Azure Site Recovery (ASR)** | Disaster recovery — replicate on-prem VMs to Azure and fail over if your datacentre goes down | Business continuity, DR |

#### Azure ExpressRoute — Deep Dive

ExpressRoute is Azure's private connectivity service. Your traffic never touches the public internet — it travels on dedicated circuits through a connectivity provider (like AT&T, Equinix, or BT).

```
Your On-Premises Datacentre
        |
        | Private circuit (via connectivity provider)
        | (e.g. Equinix co-location facility)
        |
[ExpressRoute Circuit]
        |
        | Microsoft Enterprise Edge (MSEE) routers
        |
[Azure Virtual Network (VNet)]
        |
    Azure resources (VMs, databases, storage)
```

**ExpressRoute tiers:**

| Tier | Bandwidth | Use case |
|---|---|---|
| ExpressRoute Local | Up to 10 Gbps | Connect to a single Azure region near your datacentre |
| ExpressRoute Standard | Up to 10 Gbps | Connect to Azure regions in your geopolitical area |
| ExpressRoute Premium | Up to 100 Gbps | Global connectivity across all Azure regions |

**ExpressRoute vs VPN Gateway:**

| | ExpressRoute | VPN Gateway |
|---|---|---|
| Path | Private circuit (not internet) | Encrypted tunnel over internet |
| Bandwidth | Up to 100 Gbps | Up to 10 Gbps |
| Latency | Consistent, low | Variable (internet) |
| Reliability | Higher (dedicated circuit) | Lower (internet dependency) |
| Cost | Higher (circuit rental fees) | Lower |
| SLA | 99.95% | 99.9% |
| Setup time | Weeks (circuit provisioning) | Minutes |

#### Azure Arc — The Management Revolution

Azure Arc is what makes Azure hybrid truly unique. It lets you project non-Azure resources into Azure Resource Manager — so you manage everything from the Azure portal with the same tools, policies, and RBAC you use for native Azure resources.

**What Azure Arc can manage:**

```
Azure Arc
├── Arc-enabled Servers
│   ├── On-premises Windows Server VMs (VMware, Hyper-V)
│   ├── On-premises Linux servers (bare metal or VMs)
│   ├── AWS EC2 instances
│   └── GCP Compute Engine instances
│
├── Arc-enabled Kubernetes
│   ├── On-premises Kubernetes (kubeadm, k3s, etc.)
│   ├── AWS EKS clusters
│   ├── GCP GKE clusters
│   └── Azure Stack HCI clusters
│
├── Arc-enabled SQL Server
│   ├── SQL Server on on-prem VMs
│   └── SQL Server on any cloud VM
│
└── Arc-enabled Data Services
    ├── Azure SQL Managed Instance (runs on-prem via Arc)
    └── PostgreSQL (Arc-enabled)
```

**What you get for Arc-managed servers:**

- **Azure Policy:** Apply compliance rules (e.g. "all servers must have antivirus") across on-prem and cloud uniformly
- **Microsoft Defender for Cloud:** Security posture management and threat detection for on-prem servers
- **Azure Monitor:** Collect logs and metrics from on-prem servers into Azure Monitor — one dashboard for everything
- **Update Management:** Schedule OS patches for both Azure VMs and on-prem servers from one place
- **RBAC:** Use Azure role-based access control to manage who can access on-prem servers
- **Inventory:** See all your servers (anywhere) in one Azure Resource Graph query

**Installing Arc agent on an on-prem server:**

```bash
# On your on-prem Linux server:
# Download and run the Arc onboarding script (generated from Azure portal)

# 1. In Azure Portal → Azure Arc → Servers → Add
# 2. Choose "Add a single server"
# 3. Generate the onboarding script
# 4. Run on your server:

curl -o /tmp/OnboardingScript.sh \
  "https://aka.ms/azcmagent-linux"

bash /tmp/OnboardingScript.sh

# Connect to Azure Arc
azcmagent connect \
  --resource-group "hybrid-rg" \
  --tenant-id "your-tenant-id" \
  --location "eastus" \
  --subscription-id "your-subscription-id"

# Verify
azcmagent show
```

After this, your on-prem server appears in the Azure Portal under Azure Arc → Servers. You can run Azure Policy on it, monitor it with Azure Monitor, and manage it with RBAC — exactly like a native Azure VM.

#### Azure Stack — Running Azure On-Premises

**Azure Stack Hub:**

A complete Azure environment running in your own datacentre. You buy validated hardware from OEM partners (Dell, HPE, Lenovo), Microsoft ships the Azure Stack Hub software, and you run a mini-Azure in your building.

- Same Azure portal, same APIs, same services as public Azure
- Suitable for disconnected/air-gapped environments (military, submarines, remote sites)
- Data never leaves your datacentre
- Limitation: Only a subset of Azure services available

**Azure Stack HCI:**

Hyperconverged infrastructure — compute and storage in the same cluster of physical servers, managed from Azure. Runs your VMs and containers on-prem but with Azure management, billing, and support.

```
Azure Stack HCI Cluster (your datacentre)
├── Node 1: HPE ProLiant DL380 (16 cores, 256GB RAM, 2TB NVMe)
├── Node 2: HPE ProLiant DL380 (16 cores, 256GB RAM, 2TB NVMe)
└── Node 3: HPE ProLiant DL380 (16 cores, 256GB RAM, 2TB NVMe)
    ↕ (managed from Azure portal via Arc)
Azure Portal
├── VM management (create, resize, snapshot)
├── Azure Monitor (performance, logs)
├── Microsoft Defender (security)
└── Azure Update Manager (OS patches)
```

#### Azure AD Connect / Microsoft Entra Connect — Unified Identity

One of the most important hybrid components. Your employees have Active Directory accounts on-premises (used to log into Windows PCs, file shares, on-prem apps). Azure AD Connect syncs those identities to Azure AD.

```
On-Premises Active Directory
├── User: john.doe@company.local
├── User: jane.smith@company.local
└── Group: Finance-Team
        |
        | Azure AD Connect (sync engine, runs on a Windows Server)
        | Syncs: users, groups, password hashes (or just identity for SSO)
        ↓
Azure Active Directory / Microsoft Entra ID
├── User: john.doe@company.com  ← Same user, cloud identity
├── User: jane.smith@company.com
└── Group: Finance-Team
        |
        ↓ Single Sign-On
Microsoft 365, Azure Portal, Salesforce, GitHub, any SAML/OIDC app
```

**Authentication modes:**

| Mode | How it works | Password stored in cloud? |
|---|---|---|
| **Password Hash Sync (PHS)** | Hash of password hash synced to Azure AD. Auth happens in cloud. | Yes (hash of hash) |
| **Pass-through Authentication (PTA)** | Azure AD passes auth request to on-prem AD agent. Auth happens on-prem. | No |
| **Federation (ADFS)** | Dedicated federation server handles auth. Azure AD trusts it. | No |

Most organisations use Password Hash Sync — simplest, most resilient (works even if on-prem is down).

#### Architecture Pattern: Azure Hybrid Enterprise

```
[Users — anywhere]
        |
        | HTTPS (Azure AD authentication)
        ↓
[Azure AD / Entra ID] ←—sync—— [On-prem Active Directory]
        |
        | Authenticated session
        ↓
[Azure Application Gateway + WAF] — public entry point
        |
[Azure App Service] — web/API tier (PaaS, in Azure)
        |
        | ExpressRoute private circuit
        ↓
[On-Premises SQL Server] — data stays on-prem (compliance)
[On-Premises File Server] ←—sync—— [Azure File Sync → Azure Files]

Managed by Azure Arc:
[On-prem servers] → same Azure Monitor, Defender, Policy as Azure VMs
```

#### Azure Hybrid Benefit — Significant Cost Saving

A purely Azure-specific financial advantage. If your organisation has existing **Windows Server** or **SQL Server** licences with Software Assurance (SA), you can bring those licences to Azure and pay significantly reduced rates.

| Scenario | Without Hybrid Benefit | With Hybrid Benefit | Saving |
|---|---|---|---|
| Windows Server VM (D4s v3) | ~$280/month | ~$170/month | ~40% |
| SQL Server on VM (Standard) | ~$900/month | ~$450/month | ~50% |
| Azure SQL Managed Instance | Full price | Up to 40% off | ~40% |

This is a major reason enterprises choose Azure for lift-and-shift migrations of Windows/SQL workloads — they don't pay for licences they already own.

#### Comparing AWS vs Azure Hybrid — Side by Side

| Scenario | AWS Solution | Azure Solution |
|---|---|---|
| Private dedicated connection | AWS Direct Connect | Azure ExpressRoute |
| Site-to-site VPN | AWS Site-to-Site VPN | Azure VPN Gateway |
| Cloud hardware on-prem | AWS Outposts | Azure Stack Hub / HCI |
| Unified management of on-prem + cloud | AWS Systems Manager | Azure Arc |
| Edge computing | AWS Snowball Edge | Azure Stack Edge |
| Disaster recovery to cloud | AWS CloudEndure | Azure Site Recovery |
| Identity sync | AWS Directory Service | Azure AD Connect / Entra Connect |
| On-prem file storage + cloud tier | AWS Storage Gateway | Azure File Sync |
| Migration assessment | AWS Migration Hub | Azure Migrate |
| Reuse existing licences | No equivalent | Azure Hybrid Benefit |

#### Practical: Simulate Azure Hybrid Locally with Vagrant

Just as you can simulate AWS hybrid with on-prem VMs + VPN, you can simulate Azure hybrid locally:

```ruby
# Vagrantfile — Simulates on-prem server + "Azure" app server

Vagrant.configure("2") do |config|

  # Simulates your on-prem server (managed by Azure Arc in real life)
  config.vm.define "onprem" do |s|
    s.vm.box = "ubuntu/jammy64"
    s.vm.hostname = "onprem-server"
    s.vm.network "private_network", ip: "192.168.56.200"
    s.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    s.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      apt-get install -y docker.io
      systemctl start docker
      # Simulated on-prem database
      docker run -d --name sqlserver \
        -e ACCEPT_EULA=Y \
        -e SA_PASSWORD=DevPassword123! \
        -p 1433:1433 \
        mcr.microsoft.com/mssql/server:2022-latest
      echo "On-prem SQL Server running at 192.168.56.200:1433"
    SHELL
  end

  # Simulates the Azure App Service (cloud side)
  config.vm.define "azure-app" do |s|
    s.vm.box = "ubuntu/jammy64"
    s.vm.hostname = "azure-app-service"
    s.vm.network "private_network", ip: "192.168.56.201"
    s.vm.network "forwarded_port", guest: 8080, host: 8080
    s.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    s.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      apt-get install -y docker.io
      systemctl start docker
      # App connects back to on-prem SQL Server (192.168.56.200)
      docker run -d -p 8080:80 nginx
      echo "Azure App Service simulation running at localhost:8080"
      echo "App would connect to on-prem DB at 192.168.56.200:1433"
    SHELL
  end

end
```

```bash
vagrant up
# Test connectivity between "cloud" and "on-prem":
vagrant ssh azure-app
ping 192.168.56.200         # Can the "cloud" app reach "on-prem" DB?
nc -zv 192.168.56.200 1433  # Can it reach the SQL port?
exit
```

This demonstrates the core challenge of hybrid: the cloud app needs to reach the on-prem database across a network boundary — which in real life is solved by ExpressRoute or VPN Gateway.

#### Terraform for Azure Hybrid

```hcl
# Provision Azure hybrid connectivity with Terraform

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "hybrid" {
  name     = "hybrid-infrastructure-rg"
  location = "East US"
}

# Virtual Network (equivalent of AWS VPC)
resource "azurerm_virtual_network" "main" {
  name                = "hybrid-vnet"
  resource_group_name = azurerm_resource_group.hybrid.name
  location            = azurerm_resource_group.hybrid.location
  address_space       = ["10.0.0.0/16"]
}

# Gateway Subnet — required for VPN/ExpressRoute gateways
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"   # MUST be named exactly this
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.255.0/27"]
}

# App subnet
resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Data subnet
resource "azurerm_subnet" "data" {
  name                 = "data-subnet"
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Public IP for VPN Gateway
resource "azurerm_public_ip" "vpn" {
  name                = "vpn-gateway-pip"
  resource_group_name = azurerm_resource_group.hybrid.name
  location            = azurerm_resource_group.hybrid.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# VPN Gateway — connects on-prem to Azure
resource "azurerm_virtual_network_gateway" "vpn" {
  name                = "hybrid-vpn-gateway"
  resource_group_name = azurerm_resource_group.hybrid.name
  location            = azurerm_resource_group.hybrid.location
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"
  active_active       = false
  enable_bgp          = true

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }
}

# Local Network Gateway — represents your on-prem network
resource "azurerm_local_network_gateway" "onprem" {
  name                = "onprem-local-gateway"
  resource_group_name = azurerm_resource_group.hybrid.name
  location            = azurerm_resource_group.hybrid.location
  gateway_address     = "203.0.113.10"    # Your on-prem public IP
  address_space       = ["192.168.0.0/16"] # Your on-prem IP range
}

# VPN Connection — the actual tunnel
resource "azurerm_virtual_network_gateway_connection" "onprem" {
  name                       = "onprem-to-azure"
  resource_group_name        = azurerm_resource_group.hybrid.name
  location                   = azurerm_resource_group.hybrid.location
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id
  shared_key                 = "SuperSecurePreSharedKey123!"
}

# Azure Arc — onboard on-prem server (resource placeholder in Azure)
resource "azurerm_resource_group" "arc" {
  name     = "arc-servers-rg"
  location = "East US"
}

# Output gateway IP (needed to configure on-prem VPN device)
output "vpn_gateway_public_ip" {
  value       = azurerm_public_ip.vpn.ip_address
  description = "Configure this IP on your on-prem VPN device"
}

output "azure_vnet_cidr" {
  value       = azurerm_virtual_network.main.address_space
  description = "Azure VNet address space — add to on-prem routing table"
}
```

#### Integration

- **With Terraform:** The `azurerm` provider manages everything — VNets, VPN gateways, ExpressRoute circuits, Arc resources. Terraform is the right tool to version-control and automate Azure hybrid infrastructure.
- **With Docker/Kubernetes:** Azure Arc-enabled Kubernetes lets you deploy containerised apps to on-prem Kubernetes clusters from Azure — using `kubectl` against Arc or Azure GitOps (Flux). Your Docker images push to Azure Container Registry (ACR) and deploy to both Azure AKS and on-prem Arc-enabled K8s.
- **With VirtualBox/Vagrant:** Your Vagrant-managed VMs represent the on-prem side. In a real scenario, you'd install the Azure Arc agent on those VMs to bring them under Azure management. The Vagrant multi-machine setup mirrors the on-prem side of a real Azure hybrid deployment.
- **With Networking:** ExpressRoute and VPN Gateway are purely network constructs — BGP routing, CIDR ranges, route tables. Everything from the subnetting and TCP/IP sections applies directly when configuring hybrid connectivity.
- **With Azure Fundamentals (AZ-900):** Azure hybrid is a significant part of the AZ-900 exam. Understanding Arc, ExpressRoute, VPN Gateway, Azure AD Connect, Azure Site Recovery, and Azure Migrate directly maps to exam domains.
- **With AWS Hybrid:** The two approaches are complementary knowledge. AWS hybrid = great for net-new cloud workloads with some on-prem connectivity. Azure hybrid = great for enterprises with existing Microsoft investments wanting unified management. Real-world multi-cloud hybrid environments often use both.

---

### 1.3 Multi-Cloud Strategy (GCP)

#### What is it?

**Multi-cloud** means using services from two or more cloud providers simultaneously — for example, running databases on AWS, machine learning workloads on GCP, and enterprise applications on Azure. Unlike hybrid (on-prem + cloud), multi-cloud is cloud + cloud.

#### Why organisations go multi-cloud

- **Avoid vendor lock-in:** If AWS raises prices or has an outage, you're not stuck.
- **Best of breed:** GCP has arguably the best ML/AI services (Vertex AI, BigQuery). AWS has the widest service breadth. Azure integrates best with Microsoft enterprise tools.
- **Regulatory requirements:** Some data must stay in specific countries — different providers have different regional presence.
- **Acquired companies:** Mergers often bring different cloud environments into one organisation.

#### GCP's Multi-Cloud Tools

| GCP Service | What it does |
|---|---|
| **Anthos** | GCP's flagship multi-cloud platform. Run and manage containerised workloads consistently across GCP, AWS, Azure, and on-premises. Uses Kubernetes under the hood. |
| **BigQuery Omni** | Run BigQuery analytics queries directly on data stored in AWS S3 or Azure Blob Storage — without moving the data |
| **Apigee** | API management platform that works across clouds — publish, secure, and analyse APIs regardless of where they run |
| **Cloud Interconnect** | Private dedicated connection from on-premises to GCP (equivalent to AWS Direct Connect) |
| **VPN (Cloud VPN)** | Site-to-site VPN between GCP VPC and other environments |

#### Multi-Cloud Challenges You Must Understand

**Complexity:** Every cloud has different networking models, security models, pricing, and APIs. Operating all three requires deep expertise or significant tooling investment.

**Networking between clouds:** Traffic between AWS and GCP goes over the public internet unless you set up private interconnects through a co-location facility. This adds latency and cost.

**Identity management:** Each cloud has its own IAM system. You need a federated identity solution (like Okta or a corporate IdP) to give users consistent access across clouds.

**Tooling for consistency:** This is where Terraform becomes critical — it abstracts over all cloud providers with a consistent language.

#### The Role of Kubernetes in Multi-Cloud

Kubernetes (K8s) is the universal container orchestration layer. Because Docker containers are portable and Kubernetes is supported on all clouds (AKS on Azure, EKS on AWS, GKE on GCP), you can run the same containerised application anywhere. This is the technical foundation of multi-cloud application portability.

```
Developer writes app → packages as Docker image → deploys via Kubernetes manifest
→ Works on GKE (GCP), EKS (AWS), AKS (Azure), or on-prem K8s equally
```

#### Integration

- **With Terraform:** Terraform's provider model is designed for multi-cloud. You write `provider "aws" {}` and `provider "google" {}` in the same Terraform configuration and manage both clouds from one codebase.
- **With Docker/Kubernetes:** Docker containers are the unit of portability that makes multi-cloud practical. The same image runs on any cloud.
- **With VS Code + Copilot:** Writing multi-cloud Terraform and Kubernetes YAML is where Copilot saves enormous time — it knows the APIs of all providers.

---

## 2. On-Premises: VMs & Bare Metal

### 2.1 VirtualBox

#### What is it?

**VirtualBox** is a free, open-source **Type 2 hypervisor** made by Oracle. It runs on your existing operating system (Windows, macOS, Linux) and lets you create and run **virtual machines** — isolated computer environments — inside your physical machine.

#### Hypervisor Types — Critical Distinction

| Type | Also called | How it works | Examples | Performance |
|---|---|---|---|---|
| **Type 1** | Bare-metal hypervisor | Runs directly on hardware — it IS the OS | VMware ESXi, Hyper-V, KVM | High — no host OS overhead |
| **Type 2** | Hosted hypervisor | Runs as an application on top of a host OS | VirtualBox, VMware Workstation | Lower — host OS takes resources first |

VirtualBox is Type 2. This makes it perfect for **development and learning** on your laptop, but not suitable for production enterprise virtualisation (that's VMware ESXi or KVM).

#### Core VirtualBox Concepts

**VM (Virtual Machine):** A software emulation of a complete computer. It has its own virtual CPU, RAM, disk, and network adapters. The host machine shares its physical resources with the VM.

**Snapshot:** A saved state of a VM at a specific point in time. You can roll back to a snapshot if something breaks. Invaluable for testing — take a snapshot before installing software, then roll back if it breaks.

**Guest Additions:** Software installed inside the VM that enables better integration with the host — shared clipboard, shared folders, better display resolution, drag-and-drop.

**Network Modes:**

| Mode | VM can reach internet? | VM can reach host? | Host can reach VM? | VMs can reach each other? | Use case |
|---|---|---|---|---|---|
| NAT | Yes | No (by default) | No (without port forwarding) | No | Simple internet access |
| Bridged | Yes | Yes | Yes | Yes | VM gets its own IP on your network |
| Host-only | No | Yes | Yes | Yes | Isolated lab network |
| Internal | No | No | No | Yes | Completely isolated multi-VM networks |

**Shared Folders:** Map a folder from your host machine into the guest VM. Changes in either location are reflected in the other. Great for editing code on the host and running it in the VM.

#### What you'll actually do

```bash
# Install VirtualBox, then:
# 1. Download an Ubuntu Server ISO
# 2. Create a new VM: 2 CPU, 2GB RAM, 20GB disk
# 3. Boot from ISO, install Ubuntu
# 4. Install Guest Additions
# 5. Set up SSH access from host to VM
# 6. Take a snapshot (your "clean baseline")

# SSH from host to VM (bridged or host-only mode)
ssh username@192.168.56.101
```

#### Integration

- **With Vagrant:** Vagrant is a tool that automates VirtualBox VM creation. Instead of clicking through the VirtualBox GUI to set up a VM, you write a `Vagrantfile` and run `vagrant up`. VirtualBox is the engine; Vagrant is the automation layer on top.
- **With Docker:** You can run Docker inside a VirtualBox VM. This is how developers on Windows/Mac used to run Docker before Docker Desktop existed. Even now, running Docker inside a Linux VM gives you a more Linux-native experience.
- **With Networking:** VirtualBox's network modes directly implement the networking concepts (subnets, NAT, bridging) you study in the networking refresher. This is where theory becomes hands-on.
- **With Terraform:** Terraform has a VirtualBox provider (though limited). More practically, you provision cloud VMs with Terraform and understand the concepts through VirtualBox experimentation.

---

### 2.2 VMware

#### What is it?

VMware is the industry-leading enterprise virtualisation company. In a production datacentre, "the servers are running on VMware" is one of the most common sentences in IT. Understanding VMware is essential for infrastructure roles.

#### VMware Product Family

| Product | Type | What it does | Context |
|---|---|---|---|
| **VMware Workstation** | Type 2 hypervisor | Like VirtualBox but more powerful and polished. Runs on Windows/Linux. | Developer workstations, testing |
| **VMware Fusion** | Type 2 hypervisor | Mac version of Workstation | Mac developers |
| **VMware ESXi** | Type 1 bare-metal hypervisor | Enterprise hypervisor that runs directly on server hardware. The foundation of VMware datacentres. | Production datacentres |
| **vCenter Server** | Management platform | Centrally manage multiple ESXi hosts, clusters, and VMs from one interface | Enterprise VM management |
| **vSphere** | Full product suite | ESXi + vCenter + all enterprise features. The flagship VMware platform. | Enterprise IT infrastructure |
| **VMware NSX** | Network virtualisation | Software-defined networking for VMware environments — virtual networks, firewalls, load balancers | Advanced networking |
| **VMware vSAN** | Storage virtualisation | Pools disks across multiple servers into shared storage | Software-defined storage |

#### Key VMware Concepts

**vMotion:** Live migration of a running VM from one physical ESXi host to another with zero downtime. The VM keeps running while its memory state is transferred. This is magic the first time you see it.

**High Availability (HA):** If an ESXi host fails, VMs automatically restart on other hosts in the cluster. Provides automatic failover.

**Distributed Resource Scheduler (DRS):** Automatically load-balances VMs across ESXi hosts in a cluster based on CPU and memory usage. Uses vMotion to move VMs without interruption.

**Datastore:** Storage location for VM files (disk images, configuration). Can be local disk, NFS share, or SAN storage.

**VM Templates:** A golden image of a VM that you use to rapidly clone new VMs. Instead of installing Ubuntu from scratch every time, you maintain a pre-configured template and clone from it in seconds.

#### VMware vs VirtualBox — When to use which

| Scenario | Use |
|---|---|
| Learning at home, laptop experiments | VirtualBox (free, good enough) |
| Professional developer workstation | VMware Workstation/Fusion (better performance, USB passthrough, etc.) |
| Production server virtualisation | VMware ESXi / vSphere (or KVM for Linux/open-source shops) |
| Working in an enterprise IT role | You will almost certainly encounter vSphere |

#### Integration

- **With Hybrid Cloud:** VMware Cloud on AWS (VMC on AWS) is a dedicated service that runs VMware vSphere software on AWS bare metal. This is how many enterprises migrate to cloud — they don't rewrite their applications, they just move their entire VMware environment to AWS. VMware HCX enables live migration of VMs from on-prem VMware to cloud.
- **With Terraform:** The `vsphere` Terraform provider lets you automate the creation of VMs, networks, and datastores in a vSphere environment. Enterprise infrastructure teams use Terraform to provision VMware VMs at scale.
- **With Networking:** VMware environments heavily use VLANs. Each VM is connected to a virtual switch (vSwitch) which connects to physical NICs. Understanding VLANs is prerequisite knowledge.

---

### 2.3 Virtualization Fundamentals (Red Hat)

#### What is virtualisation?

Virtualisation is the technology that creates virtual (software-based) versions of physical resources — compute, storage, networking. Instead of one physical server running one operating system doing one job, virtualisation lets one physical server run multiple isolated operating systems simultaneously.

#### Why it transformed IT

Before virtualisation (pre-2000s): one application per physical server. Data centres were full of servers running at 5-15% CPU utilisation. Massive waste of space, power, and money.

With virtualisation: one powerful server can host 20-50 VMs, each running its own OS and applications. Utilisation jumps to 60-80%. Server sprawl is eliminated. Provisioning a new server takes minutes (clone a VM), not weeks (order, rack, cable, configure hardware).

#### Key Virtualisation Concepts

**Hypervisor:** The software layer that creates and manages VMs. It sits between the hardware and the VMs, allocating resources.

**Guest OS:** The operating system running inside a VM. Completely unaware it's virtualised (in most cases).

**Host OS:** The operating system of the physical machine (for Type 2). Or just the physical hardware (for Type 1).

**CPU Virtualisation:** Modern Intel and AMD processors have hardware-assisted virtualisation extensions (Intel VT-x, AMD-V) that make it possible to run a guest OS at near-native speed.

**Memory Virtualisation:** The hypervisor manages a virtual address space for each VM. Techniques like memory ballooning and transparent page sharing allow overcommitting memory (assigning more RAM to VMs than physically exists) when not all VMs need their full allocation simultaneously.

**Storage Virtualisation:** VM disks are typically files (.vmdk, .vdi, .qcow2) on the host filesystem. From the VM's perspective, it sees a real hard drive.

#### KVM — The Linux Kernel Hypervisor

Red Hat's virtualisation platform is built on **KVM (Kernel-based Virtual Machine)**, which is built into the Linux kernel. It makes Linux itself a Type 1 hypervisor.

```
Physical Server
└── Linux Kernel (with KVM module loaded)
    ├── QEMU (provides device emulation)
    ├── VM 1: Ubuntu Server (running web app)
    ├── VM 2: CentOS (running database)
    └── VM 3: Windows Server (running legacy app)
```

**Red Hat Virtualisation (RHV) / oVirt:** Red Hat's enterprise virtualisation manager — equivalent to VMware vSphere but open-source and Linux-based.

#### Containers vs VMs — The Critical Distinction

This distinction is one of the most important concepts in modern infrastructure:

| Aspect | Virtual Machine | Container (Docker) |
|---|---|---|
| **Isolation level** | Complete OS-level isolation | Process-level isolation |
| **What's virtualised** | Full hardware stack | Just the OS userspace |
| **Guest OS** | Full OS per VM (GBs) | Shared host kernel (MBs) |
| **Boot time** | Seconds to minutes | Milliseconds |
| **Size** | GBs (includes full OS) | MBs (just app + dependencies) |
| **Security** | Stronger isolation (separate kernel) | Weaker isolation (shared kernel) |
| **Use case** | Run different OSes, legacy apps, strong isolation | Microservices, CI/CD, modern apps |

A VM has its own kernel. A container shares the host's kernel but has isolated filesystems and processes.

```
VMs:
[App A] [App B] [App C]
[Guest OS] [Guest OS] [Guest OS]   ← Full OS per VM
[Hypervisor]
[Physical Hardware]

Containers:
[App A] [App B] [App C]
[Container Runtime (Docker)]       ← No separate OS per container
[Host OS Kernel]                   ← Shared kernel
[Physical Hardware]
```

#### Integration

- **With Docker:** VMs provide the environment that Docker runs inside. On a developer laptop, Docker Desktop runs Docker inside a lightweight Linux VM. On servers, Docker typically runs on Linux VMs. Understanding VMs is prerequisite to understanding containers.
- **With Cloud:** Cloud VMs (EC2, Azure VM) are the same concept — just the hypervisor is managed by the cloud provider on their hardware. When you launch an EC2 instance, you're getting a VM on AWS's hardware.
- **With Vagrant:** Vagrant automates the creation of local VMs. Understanding virtualisation fundamentals helps you configure Vagrantfiles correctly (memory, CPU, networking).

---

## 3. Networking Refresher

### 3.1 Networking Fundamentals (Kunal Kushwaha)

#### Why networking matters for DevOps/Infrastructure

Every cloud resource, every container, every VM — they all communicate over networks. Without networking knowledge, you cannot debug connectivity issues, design secure architectures, or understand why things break. This is foundational.

#### The OSI Model — 7 Layers

The OSI model is a conceptual framework that describes how network communication happens in seven distinct layers. Each layer has a specific job and communicates with the layers above and below it.

```
Layer 7 — Application   HTTP, HTTPS, DNS, FTP, SMTP
Layer 6 — Presentation  SSL/TLS encryption, data encoding
Layer 5 — Session       Session management, authentication
Layer 4 — Transport     TCP, UDP — port numbers, reliability
Layer 3 — Network       IP addresses, routing
Layer 2 — Data Link     MAC addresses, switches, VLANs
Layer 1 — Physical      Cables, signals, hardware
```

**Memory trick:** "All People Seem To Need Data Processing" (Application, Presentation, Session, Transport, Network, Data Link, Physical) — or reversed: "Please Do Not Throw Sausage Pizza Away."

#### Practical Layer Breakdown

**Layer 3 (Network) — IP Addressing:**
Every device on a network has an IP address. IPv4 addresses are 32-bit numbers written as four octets: `192.168.1.100`. IPv6 uses 128-bit addresses: `2001:0db8:85a3::8a2e:0370:7334`.

Private IP ranges (not routable on the internet):
- `10.0.0.0/8` — large corporate networks
- `172.16.0.0/12` — medium networks
- `192.168.0.0/16` — home and small office networks

**Layer 4 (Transport) — TCP vs UDP:**

| TCP | UDP |
|---|---|
| Connection-oriented — establishes a connection before sending data | Connectionless — just fires data, no handshake |
| Reliable — guarantees delivery, retransmits lost packets | Unreliable — no delivery guarantee |
| Ordered — packets arrive in order | Unordered — packets can arrive out of order |
| Slower — handshaking and acknowledgements add overhead | Faster — no overhead |
| Uses: HTTP, HTTPS, SSH, databases | Uses: DNS, video streaming, gaming, VoIP |

**Layer 7 (Application) — HTTP:**

HTTP (HyperText Transfer Protocol) is the foundation of the web. Every API call, every webpage load, is HTTP.

- `GET` — retrieve a resource
- `POST` — send data to create a resource
- `PUT`/`PATCH` — update a resource
- `DELETE` — remove a resource

**DNS (Domain Name System):**

DNS translates human-readable names (`google.com`) to IP addresses (`142.250.74.46`). Without DNS, you'd need to memorise IP addresses for every website.

```
You type: www.google.com
Browser asks your DNS resolver (usually your router): "What's the IP for www.google.com?"
Resolver asks root nameservers → .com nameservers → google.com nameservers
Answer: 142.250.74.46
Browser connects to 142.250.74.46
```

#### Ports — Critical Knowledge

| Port | Protocol | Used by |
|---|---|---|
| 22 | TCP | SSH — secure remote access to Linux |
| 80 | TCP | HTTP — unencrypted web traffic |
| 443 | TCP | HTTPS — encrypted web traffic |
| 3306 | TCP | MySQL database |
| 5432 | TCP | PostgreSQL database |
| 6379 | TCP | Redis |
| 27017 | TCP | MongoDB |
| 8080 | TCP | Common alternative HTTP port |
| 2376/2377 | TCP | Docker daemon / Docker Swarm |

#### Integration

- **With VirtualBox/VMware:** VM networking (NAT, bridged, host-only) is directly applying Layer 2/3 networking knowledge. When you configure a host-only network at `192.168.56.0/24`, you're applying subnetting.
- **With Docker:** Docker creates its own virtual networks (`docker0` bridge by default). Understanding how Docker networking works (bridge, host, overlay networks) requires understanding the OSI model and IP routing.
- **With AWS/Azure/GCP:** Every cloud network concept (VPC, subnets, security groups, NACLs, load balancers) maps directly to networking fundamentals. A VPC subnet is literally just a subnet with a CIDR range.
- **With Terraform:** You configure all of the above (VPCs, subnets, routing tables, security groups) using Terraform. You can't write correct Terraform networking code without understanding what you're configuring.

---

### 3.2 TCP/IP Basics (Cloudflare)

#### The TCP/IP Model

The TCP/IP model is a more practical, simpler version of OSI with 4 layers (OSI's 7 layers mapped into 4):

```
Application Layer  (OSI layers 5, 6, 7) — HTTP, DNS, FTP, SMTP
Transport Layer    (OSI layer 4)         — TCP, UDP
Internet Layer     (OSI layer 3)         — IP, ICMP, routing
Network Access     (OSI layers 1, 2)     — Ethernet, Wi-Fi, MAC
```

#### The TCP Three-Way Handshake

Before any data is sent, TCP establishes a connection through a three-step process:

```
Client                    Server
  |                          |
  |-------- SYN ----------->|   "I want to connect, my seq# is X"
  |                          |
  |<------- SYN-ACK ---------|   "OK, my seq# is Y, acknowledge X"
  |                          |
  |-------- ACK ----------->|   "Acknowledge Y — connection established"
  |                          |
  |<=== Data flows both ways ===>|
```

**SYN** = Synchronise. **ACK** = Acknowledge. This handshake ensures both sides are ready to communicate.

#### IP Addressing and Routing Deep Dive

**How routing works:**

When you send a packet to `8.8.8.8` (Google's DNS), your computer checks its routing table:
1. Is `8.8.8.8` on my local subnet? No.
2. Is there a more specific route in my routing table? No.
3. Send to the default gateway (your router).
4. Your router repeats the process, eventually reaching Google's network.

```bash
# View routing table on Linux
ip route show
# or
route -n

# Example output:
# 192.168.1.0/24 dev eth0  → local network, send directly
# 0.0.0.0/0 via 192.168.1.1  → everything else, send to router
```

**ICMP (Internet Control Message Protocol):**

Used for network diagnostics. The `ping` command uses ICMP Echo Request/Reply:

```bash
ping google.com          # Test connectivity
traceroute google.com    # Show path packets take (each hop)
```

#### DHCP vs Static IPs

**DHCP (Dynamic Host Configuration Protocol):** Automatically assigns IP addresses to devices when they join a network. Your home router runs a DHCP server that gives your laptop its `192.168.1.x` address.

**Static IP:** Manually configured, never changes. Used for servers (you need to know exactly where to find them), printers, network infrastructure.

In cloud environments: instances can have private static IPs (within the VPC), but public IPs are often dynamic. **Elastic IPs** (AWS) or **Static IPs** (GCP) give you a fixed public IP address.

#### Integration

- **With Docker:** Docker containers get IP addresses assigned by Docker's internal DHCP-like system. Container-to-container communication uses Docker's virtual network. Understanding IP routing explains why containers can (or can't) reach each other.
- **With AWS VPC:** Every concept from TCP/IP applies directly in cloud VPCs: CIDR ranges, routing tables, internet gateways (the "default gateway" for your VPC), DHCP option sets for DNS. The cloud is just TCP/IP running on virtualised hardware.
- **With Terraform:** Terraform resources like `aws_route_table`, `aws_subnet`, `aws_internet_gateway` directly implement the routing concepts from TCP/IP basics.

---

### 3.3 Subnetting and VLANs

#### Subnetting — Dividing Networks

**CIDR (Classless Inter-Domain Routing) notation:** `192.168.1.0/24`

The `/24` is the **prefix length** — the number of bits used for the network portion. The remaining bits are for host addresses.

| CIDR | Subnet Mask | Usable Hosts | Common use |
|---|---|---|---|
| /8 | 255.0.0.0 | ~16.7 million | Large enterprises, cloud VPCs |
| /16 | 255.255.0.0 | ~65,534 | Medium organisations, large VPCs |
| /24 | 255.255.255.0 | 254 | Typical office subnet |
| /25 | 255.255.255.128 | 126 | Split a /24 in half |
| /26 | 255.255.255.192 | 62 | Small subnets |
| /28 | 255.255.255.240 | 14 | Tiny subnets (VPN gateway subnets) |
| /30 | 255.255.255.252 | 2 | Point-to-point links |
| /32 | 255.255.255.255 | 1 (single host) | Security group rules for one IP |

**Why subnet?**

- **Security:** Separate sensitive workloads (database subnet) from public-facing ones (web subnet). Apply different firewall rules to each subnet.
- **Organisation:** Group resources logically (app tier subnet, data tier subnet).
- **Routing:** Traffic between subnets is controlled and inspectable.

**Cloud Subnet Example (AWS):**

```
VPC: 10.0.0.0/16  (65,534 IPs available)
├── Public Subnet A:  10.0.1.0/24  (AZ us-east-1a) — web servers
├── Public Subnet B:  10.0.2.0/24  (AZ us-east-1b) — web servers (HA)
├── Private Subnet A: 10.0.10.0/24 (AZ us-east-1a) — app servers
├── Private Subnet B: 10.0.11.0/24 (AZ us-east-1b) — app servers (HA)
├── Data Subnet A:    10.0.20.0/24 (AZ us-east-1a) — databases
└── Data Subnet B:    10.0.21.0/24 (AZ us-east-1b) — databases (HA)
```

Public subnets have a route to an Internet Gateway. Private/data subnets do not — they access the internet only through a NAT Gateway if needed.

#### VLANs — Virtual Local Area Networks

**What is a VLAN?**

A VLAN is a logical subdivision of a physical network. It allows you to group devices on the same physical switch as if they were on separate networks — without running separate cables.

Imagine a building where IT staff and HR staff share the same physical network switches, but you want them on separate networks for security. VLANs let you do this in software.

**How VLANs work:**

Each port on a managed switch can be assigned a VLAN ID (1-4094). Packets tagged with VLAN 10 can only communicate with other devices on VLAN 10, even if they're on the same physical switch as VLAN 20 devices.

```
Physical Switch
├── Port 1-10  → VLAN 10 (IT department)
├── Port 11-20 → VLAN 20 (HR department)
└── Port 21    → VLAN 10 + 20 (trunk port to router — carries multiple VLANs)
```

**Trunk ports:** A port that carries traffic for multiple VLANs between switches or to a router. Tagged with 802.1Q headers that identify which VLAN each frame belongs to.

**Inter-VLAN routing:** VLANs are isolated by default. To allow communication between VLANs (e.g., HR needs to reach a printer on the IT VLAN), traffic must be routed through a Layer 3 device (router or Layer 3 switch).

**VLANs in VMware:**

VMware virtual switches (vSwitches) support VLANs. You assign VLAN tags to VM port groups, and the physical switch must have trunk ports configured to pass those VLAN tags.

#### Integration

- **With VirtualBox/VMware:** VM network adapters are effectively VLAN-aware. VMware's virtual switches directly implement VLAN tagging. VirtualBox's internal network and host-only modes create isolated network segments (conceptually similar to VLANs).
- **With AWS:** AWS subnets are the cloud equivalent of VLANs — they isolate network segments. Security groups and NACLs play the role of inter-VLAN routing rules.
- **With Terraform:** The Terraform `aws_subnet`, `aws_vpc`, and `aws_route_table` resources implement the subnetting design in code.
- **With Docker:** Docker's bridge networks, overlay networks, and macvlan drivers all implement similar isolation principles to VLANs.

---

## 4. Cloud Provider Intro

### 4.1 AWS Getting Started

#### What is AWS?

Amazon Web Services (AWS) is the world's largest cloud platform with 200+ services across compute, storage, networking, databases, AI/ML, security, and more. Launched in 2006, it has the largest market share (~32%) and the broadest set of services.

#### Core Services You Must Know

**Compute:**
- **EC2 (Elastic Compute Cloud):** Virtual machines in the cloud. Choose from hundreds of instance types. The most fundamental AWS service.
- **Lambda:** Serverless compute — upload code, it runs in response to events. Pay per millisecond of execution. No servers to manage.
- **ECS (Elastic Container Service):** AWS-managed container orchestration. Run Docker containers without managing the orchestration layer yourself.
- **EKS (Elastic Kubernetes Service):** AWS-managed Kubernetes. The control plane is managed by AWS.

**Storage:**
- **S3 (Simple Storage Service):** Object storage. Store any file, any size, at virtually unlimited scale. Retrieve via HTTP. Extremely cheap per GB. Used for backups, static websites, data lakes, and as the backend for many AWS services.
- **EBS (Elastic Block Store):** Block storage attached to EC2 instances. Like a hard drive for your VM. Persists independently of the instance.
- **EFS (Elastic File System):** Managed NFS shared file system. Multiple EC2 instances can mount the same EFS volume simultaneously.

**Networking:**
- **VPC:** Your private network in AWS.
- **Route 53:** AWS's DNS service and traffic routing.
- **CloudFront:** CDN — cache content globally at AWS edge locations.
- **ELB (Elastic Load Balancing):** Distribute traffic across multiple EC2 instances.

**Databases:**
- **RDS:** Managed relational databases (MySQL, PostgreSQL, SQL Server, Oracle).
- **DynamoDB:** Managed NoSQL key-value database. Single-digit millisecond latency.
- **ElastiCache:** Managed Redis and Memcached.

**IAM (Identity and Access Management):**
The foundation of AWS security. Users, groups, roles, and policies define who can do what. Every action in AWS is authorised through IAM.

```
IAM User: johndoe
  └── Member of: Developers Group
      └── Policy: AllowEC2ReadOnly
          └── Effect: Allow, Action: ec2:Describe*, Resource: *
```

#### AWS Free Tier

AWS offers a free tier with:
- 750 hours/month of t2.micro or t3.micro EC2 (Linux or Windows) for 12 months
- 5GB S3 storage
- 750 hours RDS (db.t2.micro) for 12 months
- 1 million Lambda invocations per month (always free)

#### Integration

- **With Terraform:** Terraform's AWS provider is the most mature and widely-used provider. You write `resource "aws_instance" "web" {}` to create EC2 instances, `resource "aws_s3_bucket" "data" {}` for S3, etc.
- **With Docker:** AWS ECS and EKS run Docker containers. You push Docker images to ECR (Elastic Container Registry) and deploy them to ECS or EKS.
- **With Hybrid (Direct Connect/VPN):** Your on-prem VirtualBox or VMware VMs connect to AWS via VPN. Practice routing traffic between your local VMs and an AWS VPC.

---

### 4.2 Azure Fundamentals

#### What is Azure?

Microsoft Azure is Microsoft's cloud platform, second in market share (~22%). It has the strongest integration with Microsoft products (Active Directory, Windows Server, SQL Server, .NET, Microsoft 365) making it dominant in enterprise environments.

#### Core Concepts (AZ-900 Alignment)

| Concept | Azure term | AWS equivalent |
|---|---|---|
| Virtual machine | Azure VM | EC2 instance |
| Object storage | Azure Blob Storage | S3 |
| Private network | Virtual Network (VNet) | VPC |
| Managed Kubernetes | AKS | EKS |
| Serverless functions | Azure Functions | Lambda |
| Managed SQL | Azure SQL Database | RDS |
| Identity platform | Azure AD / Entra ID | IAM + Cognito |
| Resource grouping | Resource Group | Tags + AWS Organizations |
| IaC templates | ARM Templates / Bicep | CloudFormation |

#### Azure Resource Hierarchy

```
Azure AD Tenant
└── Management Groups
    └── Subscriptions (billing boundary)
        └── Resource Groups (logical container)
            └── Resources (VMs, storage, databases, etc.)
```

#### Integration

- **With Terraform:** The `azurerm` Terraform provider manages all Azure resources. Multi-cloud Terraform configs manage AWS and Azure side-by-side.
- **With Docker:** Azure Container Instances (ACI) runs Docker containers. AKS runs Kubernetes. ACR (Azure Container Registry) stores images.
- **With Hybrid:** Azure Arc extends Azure management to on-premises and AWS/GCP environments. Azure ExpressRoute provides dedicated private connectivity from on-prem to Azure.

---

### 4.3 Google Cloud Training

#### What is GCP?

Google Cloud Platform is Google's cloud offering (~11% market share). Known for its strength in data analytics (BigQuery), machine learning (Vertex AI, TPUs), and Kubernetes (Google invented Kubernetes and GKE is the most mature managed K8s).

#### Core GCP Services

| Category | GCP Service | Notes |
|---|---|---|
| Compute | Compute Engine | VMs (equivalent to EC2) |
| Compute | Cloud Run | Serverless containers — run any Docker image without managing servers |
| Compute | GKE | Google Kubernetes Engine — the original managed K8s |
| Storage | Cloud Storage | Object storage (equivalent to S3) |
| Storage | Persistent Disk | Block storage for VMs |
| Database | Cloud SQL | Managed MySQL/PostgreSQL |
| Database | Bigtable | Massive-scale NoSQL |
| Database | BigQuery | Serverless data warehouse — SQL queries on petabytes |
| Networking | VPC | Virtual Private Cloud |
| Networking | Cloud Load Balancing | Global load balancer |
| AI/ML | Vertex AI | Managed ML platform |

#### GCP Unique Strengths

**BigQuery:** Query terabytes of data in seconds using standard SQL. Completely serverless — no infrastructure to manage. This is why data teams often choose GCP even if the rest of their infrastructure is on AWS or Azure.

**Cloud Run:** Run any containerised application serverlessly. You build a Docker image, deploy to Cloud Run, it auto-scales from zero, and you pay only when requests are served. Arguably the most developer-friendly way to deploy containers.

**GKE Autopilot:** Fully managed Kubernetes where Google manages even the worker nodes. You just deploy workloads.

#### Integration

- **With Terraform:** The `google` Terraform provider manages all GCP resources. In multi-cloud setups, a single Terraform codebase can manage GCP and AWS/Azure.
- **With Docker:** Cloud Run and GKE are Docker-native. Push to GCR (Google Container Registry) or Artifact Registry, deploy to Cloud Run in one command.

---

### 4.4 Oracle Cloud (My Learn)

#### What is OCI?

Oracle Cloud Infrastructure (OCI) is Oracle's cloud platform, known for:
- **Database strength:** Oracle DB, MySQL HeatWave, Autonomous Database
- **Pricing:** Significantly cheaper compute than AWS/Azure/GCP
- **Always Free Tier:** More generous free resources than competitors (2 AMD VMs, 4 ARM VMs, 200GB storage — forever free)

#### OCI Core Services

| Service | Equivalent | Notes |
|---|---|---|
| Compute Instances | EC2 | Bare metal and VM options |
| Object Storage | S3 | |
| VCN (Virtual Cloud Network) | VPC | |
| Autonomous Database | RDS | Self-managing Oracle DB |
| Container Engine for Kubernetes (OKE) | EKS | Managed K8s |

#### Why it matters

OCI's always-free tier is excellent for learning. You get 4 ARM-based VMs (Ampere A1) with 24GB RAM total for free, forever. This is far more than AWS/Azure/GCP free tiers. Great for running your own Kubernetes cluster or Docker swarm at no cost.

#### Integration

- **With Terraform:** OCI has a full Terraform provider (`oci`). The free tier resources can be managed entirely with Terraform — great practice.
- **With Kubernetes:** OKE (Oracle Kubernetes Engine) is free tier eligible. Run a real K8s cluster at no cost.

---

## 5. Tool Setup: Docker

### 5.1 Docker Install

#### What is Docker?

Docker is a platform for packaging, distributing, and running applications in **containers**. A container packages your application code together with all its dependencies (libraries, runtime, config) into a single unit that runs consistently on any machine with Docker installed.

The key promise: "It works on my machine" is no longer an excuse. If it runs in a Docker container on your laptop, it runs identically on a server, in the cloud, in a CI/CD pipeline, or on a colleague's computer.

#### Installation

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add your user to docker group (avoids needing sudo)
sudo usermod -aG docker $USER
newgrp docker

# Verify
docker run hello-world
```

#### Core Architecture

```
Docker Client (CLI)     Docker Host              Registry (Docker Hub)
     |                      |                           |
     |--- docker build ---> |                           |
     |--- docker run -----> |  [Docker Daemon]          |
     |--- docker pull ----> | -------pull image-------> |
     |                      |  [Containers]             |
     |                      |  [Images]                 |
```

**Docker Daemon (`dockerd`):** The background service that manages containers and images.
**Docker Client (`docker`):** The CLI you use to talk to the daemon.
**Docker Hub:** The default public registry where images are stored and shared.

---

### 5.2 Docker for Beginners (Nana)

#### Core Concepts

**Image:** A read-only template with instructions for creating a container. Like a class definition in programming. Contains the filesystem, application code, dependencies, and metadata.

**Container:** A running instance of an image. Like an object instantiated from a class. Multiple containers can run from the same image simultaneously.

**Dockerfile:** Instructions for building a custom image. Layer by layer.

**Volume:** Persistent storage for containers. Containers are ephemeral — data written inside a container is lost when the container stops. Volumes persist on the host.

**Network:** Docker containers communicate through virtual networks. By default, containers on the same network can talk to each other by container name.

#### Essential Docker Commands

```bash
# Images
docker pull nginx                        # Download image from Docker Hub
docker images                            # List local images
docker build -t myapp:1.0 .             # Build image from Dockerfile in current directory
docker rmi myapp:1.0                     # Remove image

# Containers
docker run nginx                         # Run container (foreground)
docker run -d nginx                      # Run in background (detached)
docker run -d -p 8080:80 nginx          # Map host port 8080 to container port 80
docker run -d --name webserver nginx    # Name the container
docker run -d -v /host/data:/app/data nginx  # Mount volume

docker ps                                # List running containers
docker ps -a                             # List all containers (including stopped)
docker stop webserver                    # Stop container gracefully
docker rm webserver                      # Remove container

# Logs and exec
docker logs webserver                    # View container logs
docker logs -f webserver                 # Follow/stream logs
docker exec -it webserver bash          # Open shell inside running container

# Network
docker network create mynetwork         # Create custom network
docker run -d --network mynetwork --name db postgres   # Run on network
docker run -d --network mynetwork --name app myapp     # App can reach 'db' by name
```

#### Dockerfile — Building Your Own Images

```dockerfile
# Start from an official base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first (for layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the port your app listens on (documentation only)
EXPOSE 8000

# Set environment variables
ENV APP_ENV=production

# Command to run when container starts
CMD ["python", "app.py"]
```

**Layer caching:** Each `RUN`, `COPY`, `ADD` instruction creates a new layer. Docker caches layers — if a layer hasn't changed, Docker reuses the cached version. This is why you copy `requirements.txt` and install dependencies before copying your code — code changes often, dependencies change rarely. This keeps builds fast.

#### Docker Compose — Multi-Container Applications

Real applications have multiple services (web, database, cache). Docker Compose defines and runs multi-container applications with a single YAML file.

```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    build: ./web                 # Build from Dockerfile in ./web
    ports:
      - "8080:8000"             # host:container
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/mydb
      - REDIS_URL=redis://cache:6379
    depends_on:
      - db
      - cache
    networks:
      - app-network

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - postgres-data:/var/lib/postgresql/data   # Persist DB data
    networks:
      - app-network

  cache:
    image: redis:7
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  postgres-data:      # Named volume persists between container restarts
```

```bash
docker compose up -d      # Start all services in background
docker compose down       # Stop and remove containers
docker compose logs -f    # Follow all service logs
docker compose ps         # Status of all services
```

#### Integration

- **With VirtualBox/Vagrant:** Install Docker inside a Vagrant-managed VirtualBox VM. Your `Vagrantfile` can automatically provision Docker, giving you a consistent Linux environment for Docker development on any host OS.
- **With Terraform:** Terraform's Docker provider can manage containers and images. More importantly, you use Terraform to provision the cloud infrastructure (EC2, ECS, Kubernetes cluster) that your Docker containers run on.
- **With AWS/Azure/GCP:** Push your Docker images to ECR (AWS), ACR (Azure), or GCR (GCP). Deploy containers to ECS, AKS, or GKE.
- **With VS Code + Copilot:** VS Code's Docker extension lets you browse and manage containers visually. Copilot assists writing Dockerfiles and docker-compose.yml files.

---

### 5.3 FreeCodeCamp Docker Course

#### Advanced Docker Concepts

**Multi-stage builds — optimise image size:**

```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build        # Compile TypeScript, bundle assets, etc.

# Stage 2: Production image (only the compiled output)
FROM node:18-slim AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist    # Copy only built output
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

The final image doesn't include the build tools, source files, or dev dependencies — only what's needed to run. Can reduce image size from 1GB+ to under 100MB.

**Docker networking deep dive:**

```
bridge (default): Containers on same host can communicate
host: Container uses host's network stack directly (no isolation)
none: No networking
overlay: Multi-host networking for Docker Swarm / Kubernetes
macvlan: Container gets its own MAC address, appears on physical network
```

**Security best practices:**

```dockerfile
# Run as non-root user
RUN addgroup --system appgroup && adduser --system appuser --ingroup appgroup
USER appuser

# Don't store secrets in images
# Bad:
ENV DATABASE_PASSWORD=supersecret
# Good: pass at runtime
# docker run -e DATABASE_PASSWORD=$DB_PASS myimage
# Or use Docker secrets / Kubernetes secrets / AWS Secrets Manager

# Scan images for vulnerabilities
docker scout cves myimage:latest
```

#### Integration

- **With Vagrant:** `vagrant up` can execute a shell provisioner that runs `docker pull` and `docker compose up` automatically. Your entire dev environment — VM + Docker services — comes up with one command.
- **With Terraform:** You use Terraform to deploy an ECS task definition (which is essentially a Dockerised application definition), ECR repository, and all supporting infrastructure.

---

## 6. Tool Setup: Terraform

### 6.1 Terraform Tutorials

#### What is Terraform?

Terraform is an open-source **Infrastructure as Code (IaC)** tool by HashiCorp. It lets you define your entire infrastructure — cloud VMs, networking, databases, Kubernetes clusters, DNS records, firewall rules — as code in configuration files. Then Terraform creates, updates, and destroys that infrastructure to match your configuration.

**Why IaC matters:**
- **Reproducibility:** Create identical environments (dev, staging, prod) reliably.
- **Version control:** Infrastructure changes go through Git — reviewed, tracked, auditable.
- **Automation:** No manual clicking in cloud consoles — everything is code.
- **Documentation:** Your infrastructure IS your code — no separate docs to go stale.

#### Terraform Core Concepts

**Provider:** A plugin that lets Terraform manage a specific platform's resources. There are providers for AWS, Azure, GCP, Kubernetes, Docker, GitHub, Datadog, and hundreds more.

**Resource:** A specific piece of infrastructure managed by Terraform. `aws_instance`, `azurerm_virtual_machine`, `google_compute_instance`.

**State:** Terraform tracks what it has created in a **state file** (`terraform.tfstate`). This is how Terraform knows what exists and what needs to change. In teams, this is stored remotely in S3, Azure Blob, or Terraform Cloud.

**Plan:** `terraform plan` shows you exactly what Terraform will create, change, or destroy before doing it. Like a dry run.

**Apply:** `terraform apply` executes the changes shown in the plan.

#### HCL (HashiCorp Configuration Language) — The Syntax

```hcl
# Configure the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Store state remotely (team environments)
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# Variable declaration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# Data source — look up existing resources
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"]
  }
}

# Resource — create an EC2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name        = "WebServer"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Output — display values after apply
output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web_server.public_ip
}
```

#### Terraform Workflow

```bash
terraform init      # Download providers, initialise backend
terraform validate  # Check configuration syntax
terraform plan      # Preview changes
terraform apply     # Apply changes (prompts for confirmation)
terraform apply -auto-approve  # Apply without prompting (CI/CD)
terraform destroy   # Destroy all managed infrastructure
terraform show      # Show current state
terraform output    # Show output values
```

#### Integration

- **With AWS/Azure/GCP:** Terraform's primary purpose is provisioning cloud infrastructure. A single Terraform config can create VPCs, subnets, EC2 instances, security groups, RDS databases, S3 buckets, IAM roles — your entire cloud environment — consistently and repeatably.
- **With Docker:** Terraform's Docker provider manages Docker containers locally. More importantly, Terraform creates the cloud infrastructure (ECS clusters, Kubernetes node pools, ECR repositories) that Docker containers run on.
- **With VirtualBox/Vagrant:** Conceptually similar — Vagrant does for local VMs what Terraform does for cloud resources. You'll understand Terraform better if you've used Vagrant first.
- **With VS Code + Copilot:** The HashiCorp Terraform extension for VS Code adds syntax highlighting, auto-completion, and inline documentation. Copilot writes Terraform resource blocks accurately because it has seen enormous amounts of Terraform code.

---

### 6.2 Terraform Beginner (FreeCodeCamp)

#### Complete Working Example — AWS Web Server

```hcl
# main.tf — Complete web server setup

provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "main-vpc" }
}

# Internet Gateway (allows public internet access)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "main-igw" }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet" }
}

# Route Table — route internet traffic to IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group — allow SSH and HTTP
resource "aws_security_group" "web" {
  name   = "web-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # In practice: restrict to your IP
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "web-sg" }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = "ami-0c02fb55956c7d316"  # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install docker -y
    service docker start
    usermod -a -G docker ec2-user
    docker run -d -p 80:80 nginx
  EOF

  tags = { Name = "web-server" }
}

output "web_public_ip" {
  value = aws_instance.web.public_ip
}
```

---

### 6.3 Abhishek – Terraform Zero to Hero

#### Advanced Terraform Patterns

**Modules — reusable infrastructure components:**

```hcl
# modules/vpc/main.tf — Reusable VPC module
variable "vpc_cidr" {}
variable "environment" {}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.environment}-vpc" }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

# root/main.tf — Use the module
module "prod_vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  environment = "production"
}

module "dev_vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.1.0.0/16"
  environment = "development"
}
```

**Workspaces — manage multiple environments:**

```bash
terraform workspace new dev       # Create dev workspace
terraform workspace new staging   # Create staging workspace
terraform workspace new prod      # Create prod workspace
terraform workspace select dev    # Switch to dev
terraform workspace list          # List all workspaces
```

Each workspace has its own state file, allowing you to manage multiple environment deployments from the same configuration.

**`terraform_remote_state` — share state between configurations:**

```hcl
# In another Terraform config, read outputs from the VPC config
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "app" {
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_id
  # ...
}
```

#### Integration — Full Stack Example

```hcl
# Multi-cloud: provision AWS and GCP in one config
terraform {
  required_providers {
    aws    = { source = "hashicorp/aws",    version = "~> 5.0" }
    google = { source = "hashicorp/google", version = "~> 5.0" }
    docker = { source = "kreuzwerker/docker", version = "~> 3.0" }
  }
}

provider "aws"    { region  = "us-east-1" }
provider "google" { project = "my-project"; region = "us-central1" }

# AWS: build infrastructure for Docker app
resource "aws_ecs_cluster" "main" {
  name = "production"
}

# GCP: BigQuery for analytics
resource "google_bigquery_dataset" "analytics" {
  dataset_id = "analytics"
  location   = "US"
}
```

---

## 7. Tool Setup: Vagrant + VirtualBox

### 7.1 Vagrant Getting Started

#### What is Vagrant?

Vagrant is a tool by HashiCorp for building and managing **reproducible, portable virtual machine environments**. It sits on top of hypervisors (VirtualBox, VMware, Hyper-V) and provides a simple, unified workflow for creating and configuring VMs.

Without Vagrant: click through VirtualBox GUI, install OS from ISO, manually configure networking, install software, pray your colleague can reproduce it.

With Vagrant: write a `Vagrantfile`, run `vagrant up`, get an identical VM every time on any machine.

#### The Vagrantfile

```ruby
# Vagrantfile

Vagrant.configure("2") do |config|
  
  # Base box — a pre-built VM image from Vagrant Cloud
  config.vm.box = "ubuntu/jammy64"     # Ubuntu 22.04
  
  # Network configuration
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Shared folder: host ./code → guest /vagrant/code
  config.vm.synced_folder "./code", "/vagrant/code"
  
  # VirtualBox-specific settings
  config.vm.provider "virtualbox" do |vb|
    vb.name   = "dev-server"
    vb.memory = 2048
    vb.cpus   = 2
  end
  
  # Shell provisioner — runs on first `vagrant up`
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update -y
    apt-get install -y docker.io docker-compose-plugin git curl
    systemctl enable docker
    systemctl start docker
    usermod -aG docker vagrant
    echo "VM provisioned with Docker!"
  SHELL

end
```

#### Essential Vagrant Commands

```bash
vagrant up          # Create and start VM (provision if first time)
vagrant halt        # Stop VM (saves state)
vagrant destroy     # Delete VM entirely
vagrant suspend     # Pause VM (save RAM state to disk)
vagrant resume      # Resume from suspend

vagrant ssh         # SSH into the VM
vagrant reload      # Restart VM, re-apply config changes
vagrant provision   # Re-run provisioners without recreating VM

vagrant box list    # List downloaded base boxes
vagrant box add ubuntu/jammy64   # Download a base box manually
vagrant status      # Show VM status
```

---

### 7.2 Vagrant Tutorial

#### Multi-Machine Vagrantfile

Define multiple VMs in one Vagrantfile — perfect for simulating real infrastructure (web server + database server + load balancer):

```ruby
Vagrant.configure("2") do |config|
  
  # ── Load Balancer ──────────────────────────────────
  config.vm.define "lb" do |lb|
    lb.vm.box = "ubuntu/jammy64"
    lb.vm.hostname = "load-balancer"
    lb.vm.network "private_network", ip: "192.168.56.10"
    lb.vm.network "forwarded_port", guest: 80, host: 8080
    lb.vm.provider "virtualbox" do |vb|
      vb.memory = 512; vb.cpus = 1
    end
    lb.vm.provision "shell", inline: <<-SHELL
      apt-get update -y && apt-get install -y nginx
      echo "upstream backend { server 192.168.56.11:80; server 192.168.56.12:80; }
      server { listen 80; location / { proxy_pass http://backend; } }" > /etc/nginx/sites-available/lb
      ln -sf /etc/nginx/sites-available/lb /etc/nginx/sites-enabled/
      nginx -t && systemctl reload nginx
    SHELL
  end

  # ── Web Server 1 ───────────────────────────────────
  config.vm.define "web1" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server-1"
    web.vm.network "private_network", ip: "192.168.56.11"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    web.vm.provision "shell", inline: <<-SHELL
      apt-get update -y && apt-get install -y docker.io
      systemctl start docker
      docker run -d -p 80:80 -e SERVER_ID=web1 nginx
    SHELL
  end

  # ── Web Server 2 ───────────────────────────────────
  config.vm.define "web2" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server-2"
    web.vm.network "private_network", ip: "192.168.56.12"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    web.vm.provision "shell", inline: <<-SHELL
      apt-get update -y && apt-get install -y docker.io
      systemctl start docker
      docker run -d -p 80:80 nginx
    SHELL
  end

  # ── Database ───────────────────────────────────────
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "database"
    db.vm.network "private_network", ip: "192.168.56.20"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = 2048; vb.cpus = 2
    end
    db.vm.provision "shell", inline: <<-SHELL
      apt-get update -y && apt-get install -y docker.io
      systemctl start docker
      docker run -d --name postgres \
        -e POSTGRES_PASSWORD=devpassword \
        -e POSTGRES_DB=appdb \
        -p 5432:5432 \
        -v pgdata:/var/lib/postgresql/data \
        postgres:15
    SHELL
  end

end
```

```bash
vagrant up               # Start all VMs
vagrant up web1          # Start only web1
vagrant ssh lb           # SSH into load balancer
vagrant destroy -f       # Destroy all VMs without prompting
```

This simulates a real 3-tier architecture (load balancer → app servers → database) entirely on your laptop.

#### Integration

- **With Docker:** The Vagrantfile provisions Docker inside each VM. This is the canonical development workflow: Vagrant manages the VM, Docker manages the application containers inside the VM.
- **With Terraform:** Vagrant is to local VMs as Terraform is to cloud VMs. Once you understand the Vagrantfile → `vagrant up` → VM workflow, the Terraform HCL → `terraform apply` → cloud VM workflow feels immediately familiar. The mental model is the same.
- **With Networking:** The multi-machine setup gives you hands-on experience with private networking, routing between VMs, and load balancing — all concepts you need for cloud architecture.
- **With AWS:** The multi-machine Vagrant setup (LB + web1 + web2 + db) maps directly to an AWS architecture (ALB + EC2 Auto Scaling Group + RDS). Build it in Vagrant first, understand it, then recreate it in AWS with Terraform.

---

## 8. Tool Setup: VS Code + Copilot

#### VS Code as Your Infrastructure IDE

VS Code is far more than a text editor for infrastructure work. With the right extensions, it becomes a full IDE for Terraform, Docker, Kubernetes, cloud CLI tools, and Git.

#### Essential Extensions for Infrastructure Work

| Extension | What it adds |
|---|---|
| **HashiCorp Terraform** | Syntax highlighting, auto-complete, inline docs, `terraform validate` on save |
| **Docker** | Visual container/image browser, Dockerfile syntax, Compose file support |
| **Kubernetes** | YAML schema validation, cluster explorer, kubectl integration |
| **YAML** | Schema-aware YAML editing for Kubernetes, GitHub Actions, docker-compose |
| **GitLens** | Enhanced Git blame, history, visualisation |
| **Remote - SSH** | Open a remote server (or Vagrant VM) in VS Code as if it were local |
| **Remote - Containers** | Develop inside a Docker container with full VS Code UI |
| **AWS Toolkit** | Browse S3, Lambda, CloudFormation directly from VS Code |
| **Azure Tools** | Deploy to Azure, manage resources from VS Code |
| **Shell Check** | Lint your bash scripts for errors |

#### GitHub Copilot — AI Pair Programmer for Infrastructure

Copilot is trained on billions of lines of code including Terraform, Dockerfiles, Kubernetes YAML, bash scripts, and cloud configurations. It dramatically speeds up infrastructure coding.

**What Copilot does well for infrastructure:**

```hcl
# Type this comment, press Tab to autocomplete:
# Create an AWS S3 bucket with versioning enabled and server-side encryption

# Copilot suggests:
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  tags = var.common_tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

**Copilot in Dockerfiles:**

```dockerfile
# Write a multi-stage Dockerfile for a Go application
# Copilot writes the entire build + slim runtime stage correctly
```

**Copilot Chat (Ctrl+Shift+I):**

Ask questions about your code: "Why might this Terraform resource fail?", "Explain this Kubernetes YAML", "Write a bash script that..."

#### Remote SSH — Developing Directly on VMs

```bash
# In VS Code: Ctrl+Shift+P → "Remote-SSH: Connect to Host"
# Enter: vagrant@192.168.56.10
# VS Code opens on the remote machine — full editor experience on the VM
```

This is how you develop on Vagrant VMs, remote servers, or cloud instances as if they were local — full syntax highlighting, file explorer, terminal, extensions, all working on the remote machine.

#### Integration

- **With Vagrant:** Use Remote - SSH to connect VS Code directly to your Vagrant VMs. Edit files on the VM with full IDE support.
- **With Terraform:** The HashiCorp extension + Copilot makes writing Terraform dramatically faster. Copilot auto-completes resource blocks, variables, and outputs.
- **With Docker:** The Docker extension gives you a GUI to manage containers, images, and volumes without remembering CLI commands. Copilot writes Dockerfiles and docker-compose files.
- **With All Cloud Providers:** Copilot knows the AWS, Azure, and GCP Terraform providers deeply. Describe what you want in a comment, and it generates the resource block.

---

## 9. Master Integration Map

This section shows how every tool in Week 1-2 connects with every other tool. The integration story is the most important concept to understand — no tool exists in isolation.

```
┌─────────────────────────────────────────────────────────────────────┐
│                     YOUR DEVELOPMENT MACHINE                        │
│                                                                     │
│  ┌─────────────┐    provisions    ┌─────────────────────────────┐  │
│  │  Terraform  │───────────────── │      VirtualBox VMs         │  │
│  │  (IaC)      │  (local + cloud) │   (managed by Vagrant)      │  │
│  └──────┬──────┘                  └──────────┬──────────────────┘  │
│         │                                    │                      │
│         │ also provisions                    │ Docker runs inside   │
│         │                                    │                      │
│  ┌──────▼──────────────────────────┐  ┌──────▼──────────────────┐  │
│  │         Cloud Providers          │  │       Docker            │  │
│  │  ┌────────┐ ┌───────┐ ┌──────┐ │  │  Containers + Compose   │  │
│  │  │  AWS   │ │ Azure │ │ GCP  │ │  └─────────────────────────┘  │
│  │  └────────┘ └───────┘ └──────┘ │                               │
│  │       (Hybrid & Multi-cloud)    │                               │
│  └─────────────────────────────────┘                               │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  VS Code + Copilot  —  writes all of the above               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  Foundation: Networking (TCP/IP, subnets, VLANs)                   │
│  Everything above sits on top of networking concepts                │
└─────────────────────────────────────────────────────────────────────┘
```

### The Learning Progression

```
Week 1 Foundation:
Networking concepts → VirtualBox (apply networking) → Vagrant (automate VMs)
       ↓                         ↓                          ↓
  Subnetting           Host-only networks            Multi-VM labs
  TCP/IP               VM isolation                  LB + Web + DB

Week 1–2 Cloud:
Cloud intro (AWS/Azure/GCP) → Terraform (provision cloud)
       ↓                              ↓
  Understand services           Infrastructure as Code
  Free tier exploration         Reproduce with code

Week 2 Containers:
Docker fundamentals → Docker Compose → Deploy to cloud
       ↓                    ↓                ↓
  Single containers    Multi-service     ECS / AKS / GKE
  Dockerfiles          Local apps        Production

Throughout:
VS Code + Copilot — accelerates writing all configuration files
```

### Key Integration Flows

**Flow 1: Local Development**
```
VS Code + Copilot (write Vagrantfile)
→ Vagrant up (creates VirtualBox VMs)
→ VMs provisioned with Docker
→ Docker Compose runs your app stack
→ Test on localhost:8080
```

**Flow 2: Cloud Deployment**
```
VS Code + Copilot (write Terraform)
→ terraform apply (creates AWS VPC, EC2, RDS)
→ EC2 user_data installs Docker
→ Docker runs your app containers
→ App accessible at EC2 public IP
```

**Flow 3: Hybrid Architecture**
```
On-prem: Vagrant VM (simulating on-prem server)
    ↕ (VirtualBox host-only network)
    ↕ (in reality: VPN or Direct Connect)
Cloud: Terraform-provisioned AWS VPC
→ App servers in AWS, database stays "on-prem" (Vagrant VM)
→ This is exactly how real hybrid architectures work
```

---

## 10. Practical Lab: Full Stack Setup

This lab walks through setting up the complete Week 1-2 toolchain and exercises integrations.

### Lab 1: Local VM Network (Vagrant + VirtualBox)

```bash
mkdir ~/infra-lab && cd ~/infra-lab

# Create Vagrantfile with 2 VMs
cat > Vagrantfile << 'EOF'
Vagrant.configure("2") do |config|
  
  config.vm.define "server1" do |s|
    s.vm.box = "ubuntu/jammy64"
    s.vm.network "private_network", ip: "192.168.56.101"
    s.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    s.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      apt-get install -y docker.io docker-compose-plugin
      systemctl start docker
      usermod -aG docker vagrant
    SHELL
  end

  config.vm.define "server2" do |s|
    s.vm.box = "ubuntu/jammy64"
    s.vm.network "private_network", ip: "192.168.56.102"
    s.vm.provider "virtualbox" do |vb|
      vb.memory = 1024; vb.cpus = 1
    end
    s.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      apt-get install -y docker.io
      systemctl start docker
      usermod -aG docker vagrant
    SHELL
  end

end
EOF

vagrant up
vagrant ssh server1
# From server1, verify you can reach server2:
ping 192.168.56.102
# This tests your host-only network is working
exit
```

### Lab 2: Docker App in VM

```bash
vagrant ssh server1

# Create a simple app
mkdir ~/myapp && cd ~/myapp

cat > docker-compose.yml << 'EOF'
version: '3.8'
services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: labpassword
      POSTGRES_DB: labdb
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:
EOF

docker compose up -d
docker compose ps
curl localhost:80   # Should return nginx welcome page
exit

# From host machine:
curl 192.168.56.101:80   # Access VM's nginx via host-only network
```

### Lab 3: Terraform + AWS

```bash
# On your host machine, install Terraform
wget https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_amd64.zip
unzip terraform_1.6.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Configure AWS credentials
aws configure
# Enter: Access Key ID, Secret Key, Region (us-east-1), Output (json)

mkdir ~/terraform-lab && cd ~/terraform-lab

cat > main.tf << 'EOF'
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "lab" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "lab-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.lab.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "lab-public-subnet" }
}

output "vpc_id" {
  value = aws_vpc.lab.id
}

output "subnet_cidr" {
  value = aws_subnet.public.cidr_block
}
EOF

terraform init
terraform plan
terraform apply
# Observe: Terraform creates VPC and subnet in AWS
# Then clean up:
terraform destroy
```

### Lab 4: Full Integration

Extend the Terraform config to deploy Docker on EC2:

```hcl
# Add to main.tf from Lab 3

resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lab.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "lab" {
  vpc_id = aws_vpc.lab.id
  ingress {
    from_port   = 22; to_port = 22; protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80; to_port = 80; protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0; to_port = 0; protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lab" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.lab.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install docker -y
    systemctl start docker
    docker run -d -p 80:80 nginx
  EOF

  tags = { Name = "lab-ec2-with-docker" }
}

output "ec2_public_ip" {
  value = aws_instance.lab.public_ip
}
```

```bash
terraform apply
# Wait 2-3 minutes, then:
curl $(terraform output -raw ec2_public_ip)
# You should see the nginx welcome page!
# This is Terraform (IaC) + AWS (cloud) + Docker (container) all working together.
terraform destroy
```

---

## Quick Reference Cheat Sheet

### Commands at a Glance

```bash
# VirtualBox (via Vagrant)
vagrant up / halt / destroy / ssh / status / reload

# Docker
docker build -t name:tag .
docker run -d -p host:container --name name image
docker exec -it name bash
docker logs -f name
docker compose up -d / down / logs -f / ps

# Terraform
terraform init / validate / plan / apply / destroy / output / show

# Networking diagnostics
ping <host>              # Test reachability
traceroute <host>        # Show network path
nslookup <domain>        # DNS lookup
curl -I <url>            # HTTP headers
netstat -tlnp            # Show listening ports
ss -tlnp                 # Modern netstat
ip addr show             # Show network interfaces
ip route show            # Show routing table
```

### Key Ports Reference

| Port | Service | Remember |
|---|---|---|
| 22 | SSH | Always restrict source IP in production |
| 80 | HTTP | Redirect to 443 in production |
| 443 | HTTPS | Your default web port |
| 2376 | Docker TLS | Docker daemon remote API |
| 5432 | PostgreSQL | Never expose to internet |
| 3306 | MySQL | Never expose to internet |
| 6379 | Redis | Never expose to internet |
| 8080 | Alt HTTP | Common dev/test port |

### CIDR Quick Reference

| Notation | Hosts | Use for |
|---|---|---|
| /8 | 16.7M | Large cloud VPC |
| /16 | 65,534 | Medium VPC |
| /24 | 254 | Single subnet |
| /28 | 14 | Small subnet |
| /32 | 1 | Single IP in security rules |

---

*End of Week 1–2 Study Notes*

> **Next steps (Week 3+):** Kubernetes fundamentals, CI/CD with GitHub Actions, Ansible for configuration management, monitoring with Prometheus + Grafana, and advanced cloud architectures.
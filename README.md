**NT132_Networks-And-Systems-Administration-Project**

## PROJECT TITLE: EXPLORING AND IMPLEMENTING THE KVM VIRTUALIZATION

**Instructor:** Đỗ Hoàng Hiển
**Completed by Group 6, Class NT132.P12.ANTT:**

* Lại Quan Thiên – 22521385
* Mai Nguyễn Nam Phương – 22521164
* Lê Minh Quân – 22521181
* Hồ Diệp Huy – 22520541
* Đặng Đức Tài – 22521270

---

## OVERVIEW

Virtualization is a core technology in data centers and cloud computing infrastructures. Today’s growing trend of virtualization is transforming how organizations and enterprises manage, deploy, and optimize their IT resources. Virtualization platforms continue to evolve to meet demands for flexibility, efficiency, and security in an ever-changing technological landscape. Popular solutions include VMware, Microsoft Hyper-V, Xen, and KVM.

Thanks to its open-source nature and tight integration with the Linux kernel, KVM has captured a significant share of the cloud infrastructure market and is widely used in platforms such as OpenStack and Proxmox. In addition, KVM benefits from strong international and local open-source community support. Numerous guides and discussion forums are available to help users deploy and optimize KVM.

---

## INTRODUCTION TO KVM

Kernel-based Virtual Machine (KVM) is an open-source virtualization solution built directly into the Linux kernel. Since its introduction in 2007, KVM has ushered in a new era of virtualization by enabling Linux to function as a hypervisor. KVM transforms the Linux kernel into a virtualization platform where each virtual machine (VM) operates as an independent, fully functional system. VMs share physical resources—such as CPU, RAM, storage, and network—but remain isolated from one another.

![KVM Architecture](https://github.com/user-attachments/assets/589dafe1-784b-4083-8f4d-480fab4bd53d)

KVM is implemented as a kernel module, leveraging hardware virtualization features (Intel VT-x or AMD-V) for enhanced performance and stability. Rather than creating a separate hypervisor layer, KVM turns Linux into a Type‑1 hypervisor, integrating virtualization directly within the operating system.

---

## VIRTUALIZATION CONCEPTS

Virtualization platforms are categorized into two main types based on how the hypervisor is deployed:

* **Type‑1 Hypervisor (Bare-Metal):** Runs directly on the physical hardware without an intermediate host OS, delivering high performance by minimizing latency and software-layer interference. Although KVM relies on the Linux kernel, it qualifies as a Type‑1 hypervisor because it operates as an integrated kernel module. Other examples include VMware ESXi, Microsoft Hyper-V, and Xen.

* **Type‑2 Hypervisor (Hosted):** Runs on top of a host operating system. Easier to deploy but generally offers lower performance due to the additional host OS layer. Often used by individuals or small organizations for testing and development. Examples include VMware Workstation, Oracle VirtualBox, and Parallels Desktop.

![Hypervisor Types](https://github.com/user-attachments/assets/82149412-1423-454b-942d-57eb3cfdb634)

### Comparison: KVM (Type‑1) vs. VMware Workstation (Type‑2)

* **KVM (Type‑1):** Utilizes the Linux kernel to manage VMs, delivering high performance and strong resource isolation. Well-suited for enterprise and cloud environments, supported by open-source tools like Virt-Manager, libvirt, and QEMU.
* **VMware Workstation (Type‑2):** Installed on a host OS, easy to use and ideal for testing or applications not requiring maximum performance. However, it underperforms compared to KVM due to the extra host OS layer.

---

## PERFORMANCE COMPARISON BETWEEN KVM AND VMWARE

*Please refer to the detailed comparison section in the full report.*

---

## KVM DEPLOYMENT SCENARIOS

### Scenario 1: Creating a VM via Virt-Manager GUI ([Video Demo](https://youtu.be/drvLAiasklw?si=dxriV0I-Epw343Vj))

Virt-Manager (Virtual Machine Manager) is a user‑friendly graphical interface for managing virtual machines on Linux. Instead of complex command‑line operations, Virt-Manager offers a visual GUI that simplifies VM creation, configuration, and management. Advanced features include resource allocation, network configuration, and storage management.

In this deployment, our team used a physical host running Kali Linux 2024.3 with KVM installed. On that host, we deployed an Ubuntu Server 22.04 VM and managed it entirely through Virt‑Manager, leveraging KVM’s performance and Virt‑Manager’s intuitive interface.

### Scenario 2: Creating a VM with User Data via Virt-Manager CLI ([Video Demo](https://youtu.be/Fq4xx8sPwY0?si=qTg-OXBcHViiCTsC))

In this scenario, our goal was to deploy an Ubuntu Server 22.04 VM on KVM using user‑data and metadata for initial configuration, all via the command line with Virt‑Manager. The setup included:

* **Host:** A Kali Linux 2024.3 server with preconfigured KVM and libvirt.
* **VM:** Created using two ISO files—a seed ISO containing user‑data and metadata (for accounts, hostname, etc.) and the standard Ubuntu Server 22.04 ISO.

### Scenario 3: SSH Between Two VMs on KVM ([Video Demo](https://youtu.be/Ikg9hnbTIPg?si=uIcLVr9yWjLuaJ-j))

This scenario demonstrates a virtual network setup on KVM with two Ubuntu Desktop 22.04.5 LTS VMs. VM1 hosts a GitHub project, and VM2 uses SSH to access VM1 and perform necessary operations, illustrating internal VM networking and SSH configuration on KVM.

### Scenario 4: Deploying MySQL Database and Data Backup ([Video Demo](https://youtu.be/H2wxqkXcCxw?si=HEV6J0h5cv87rTQz))

In this model, we used two KVM VMs:

* **Database Server:** Hosts a MySQL database, allowing a client VM to perform CRUD operations.
* **Backup Server:** Connects over TLS/SSL for encrypted data transfer, has read‑only access, and continuously backs up the database.

### Scenario 5: Building an Internal Network with Web Server, Data Server, and Clients ([Video Demo](https://youtu.be/kj0qxaAmQhg?si=Tw_1pk-Xz9Mq6wlX))

In today’s digital and interconnected world, organizations need scalable, secure internal networks. This scenario illustrates a KVM-based internal network with three main components:

* **Web Server:** A KVM VM running Ubuntu 20.04, serving internal web applications with security and performance.
* **Data Server:** A KVM VM running Ubuntu Server 20.04, storing and serving database content for web applications.
* **Client:** Another KVM VM running Ubuntu 20.04.06, accessing the internal web services for daily tasks.

---

## CONCLUSION

Our project "Exploring and Implementing the KVM Virtualization Tool" for the Networks and Systems Administration course has deepened our understanding of virtualization fundamentals, the differences between Type‑1 and Type‑2 hypervisors, and core IT concepts like hardware and software interaction. The hands‑on exercises not only clarified KVM’s internal mechanics but also expanded our skills in resource management, security, and real‑world application.

Performance comparisons showed KVM’s clear advantage in optimizing system resources and handling heavy workloads on the same hardware, reducing latency and maximizing performance. However, installing Linux in a dual‑boot configuration and configuring KVM via the command line requires advanced IT skills. In contrast, VMware offers ease of use and cross‑platform flexibility (macOS and Windows) for tasks that do not demand top performance.

Through five practical scenarios—including GUI and CLI VM creation, SSH networking, database deployment and backup, and building an internal web/data server network—our team achieved all technical objectives and validated KVM’s performance and applicability. KVM proved stable, reliable, and scalable, with robust resource control and security measures like firewalls and data encryption, making it an ideal solution for testing, development, and enterprise or educational virtualization infrastructures.

Our work confirms KVM’s value in IT operations—from internal resource management to complex system deployments—striking a balance between performance, security, and usability.

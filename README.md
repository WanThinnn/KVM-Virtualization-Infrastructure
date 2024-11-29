# NT132_Networks-And-Systems-Administration-Project
## ĐỀ TÀI: TÌM HIỂU VÀ TRIỂN KHAI CÔNG CỤ ẢO HOÁ KVM
Giảng viên hướng dẫn: Đỗ Hoàng Hiển
Thực hiện bởi Nhóm 6, gồm: 
- LẠI QUAN THIÊN - 22521385
- MAI NGUYỄN NAM PHƯƠNG - 22521164
- LÊ MINH QUÂN - 22521181
- HỒ DIỆP HUY - 22520541
- ĐẶNG ĐỨC TÀI - 22521270 
**Lớp: NT132.P12.ANTT**


## TỔNG QUAN
  Ảo hóa là một công nghệ cốt lõi trong các trung tâm dữ liệu và hạ tầng điện toán đám mây. Vì thế xu hướng sử dụng ảo hóa hiện nay đang thay đổi cách các tổ chức và doanh nghiệp quản lý, triển khai, và tối ưu hóa tài nguyên công nghệ thông tin. Các công nghệ ảo hóa ngày càng phát triển để đáp ứng nhu cầu linh hoạt, hiệu quả, và bảo mật trong bối cảnh công nghệ thay đổi nhanh chóng. Các công nghệ phổ biến bao gồm VMware, Microsoft Hyper-V, Xen và KVM
  KVM, nhờ tính mã nguồn mở và tích hợp chặt chẽ với nhân Linux, đang chiếm một phần đáng kể trong lĩnh vực hạ tầng đám mây (được sử dụng rộng rãi trong OpenStack và Proxmox). Ngoài ra KVM còn nhận được sự hỗ trợ mạnh mẽ từ cộng đồng mã nguồn mở quốc tế và trong nước. Nhiều tài liệu hướng dẫn, diễn đàn thảo luận đã có sẵn để hỗ trợ người dùng triển khai và tối ưu hóa KVM.

## GIỚI THIỆU KVM
  KVM (Kernel-based Virtual Machine) là một giải pháp ảo hóa mã nguồn mở, được tích hợp trực tiếp vào nhân Linux. Ra mắt vào năm 2007, KVM đã mở ra một kỷ nguyên mới trong lĩnh vực ảo hóa, cho phép hệ điều hành Linux hoạt động như một hypervisor (phần mềm giám sát máy ảo). KVM giúp chuyển đổi kernel Linux thành một nền tảng quản lý và triển khai máy ảo (Virtual Machines - VM), nơi mà mỗi máy ảo có thể hoạt động độc lập như một hệ thống hoàn chỉnh. Các máy ảo này có thể chia sẻ tài nguyên phần cứng như CPU, RAM, ổ cứng và mạng với các hệ điều hành khác chạy trên cùng một máy chủ vật lý, nhưng vẫn đảm bảo sự cô lập giữa chúng.
  ![image](https://github.com/user-attachments/assets/589dafe1-784b-4083-8f4d-480fab4bd53d)
  KVM được triển khai dưới dạng một module trong nhân Linux, tận dụng các tính năng ảo hóa phần cứng (Intel VT-x hoặc AMD-V) của CPU để cải thiện hiệu suất và độ ổn định. Thay vì xây dựng một hypervisor riêng biệt, KVM biến Linux thành một hypervisor loại 1 (Type 1 Hypervisor), cho phép ảo hóa được tích hợp ngay trong hệ điều hành.

## KHÁI NIỆM LIÊN QUAN VỀ ẢO HOÁ
  Ảo hóa được chia thành hai loại chính dựa trên cách triển khai hypervisor:
- Hypervisor Type 1 (Bare-Metal Hypervisor): Hypervisor Type 1 chạy trực tiếp trên phần cứng vật lý của máy chủ mà không cần thông qua hệ điều hành trung gian. Loại này cung cấp hiệu suất cao nhờ giảm thiểu độ trễ và sự can thiệp từ các tầng phần mềm khác. KVM, mặc dù phụ thuộc vào nhân Linux, vẫn được xếp vào Type 1 do nó hoạt động như một module tích hợp trong kernel Linux. Một số ví dụ phổ biến khác của hypervisor Type 1 là VMware ESXi, Microsoft Hyper-V, và Xen.
- Hypervisor Type 2 (Hosted Hypervisor): Hypervisor Type 2 hoạt động trên một hệ điều hành chủ (host OS). Loại này dễ triển khai hơn nhưng có hiệu suất thấp hơn do phụ thuộc vào hệ điều hành trung gian. Đây thường là lựa chọn của cá nhân hoặc các tổ chức nhỏ, phù hợp để thử nghiệm hoặc phát triển. Các ví dụ điển hình bao gồm VMware Workstation, Oracle VirtualBox và Parallels Desktop.
![image](https://github.com/user-attachments/assets/82149412-1423-454b-942d-57eb3cfdb634)
  So sánh giữa KVM (Type 1) và VMware (Type 2):
- KVM (Type 1): KVM hoạt động như một hypervisor Type 1, tận dụng nhân Linux để quản lý các máy ảo. Điều này giúp KVM đạt được hiệu suất cao và khả năng cô lập tài nguyên tốt. KVM thích hợp để triển khai trong môi trường doanh nghiệp hoặc đám mây với sự hỗ trợ mạnh mẽ từ các công cụ mã nguồn mở như Virt-Manager, libvirt và QEMU.
- VMware (Type 2): VMware Workstation là một hypervisor Type 2, được cài đặt trên một hệ điều hành chủ. VMware thường dễ sử dụng và phù hợp để thử nghiệm hoặc chạy các ứng dụng không yêu cầu hiệu suất cao. Tuy nhiên, hiệu suất của VMware thấp hơn KVM do phụ thuộc vào hệ điều hành trung gian và tài nguyên bị phân chia thêm một tầng.

## MÔ HÌNH, KỊCH BẢN VÀ KẾT QUẢ TRIỂN KHAI KVM




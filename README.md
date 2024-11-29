# NT132_Networks-And-Systems-Administration-Project
## ĐỀ TÀI: TÌM HIỂU VÀ TRIỂN KHAI CÔNG CỤ ẢO HOÁ KVM
Giảng viên hướng dẫn: Đỗ Hoàng Hiển
Thực hiện bởi Nhóm 6, lớp NT132.P12.ANTT, gồm: 
- LẠI QUAN THIÊN - 22521385
- MAI NGUYỄN NAM PHƯƠNG - 22521164
- LÊ MINH QUÂN - 22521181
- HỒ DIỆP HUY - 22520541
- ĐẶNG ĐỨC TÀI - 22521270 



## TỔNG QUAN
  Ảo hóa là một công nghệ cốt lõi trong các trung tâm dữ liệu và hạ tầng điện toán đám mây. Vì thế xu hướng sử dụng ảo hóa hiện nay đang thay đổi cách các tổ chức và doanh nghiệp quản lý, triển khai, và tối ưu hóa tài nguyên công nghệ thông tin. Các công nghệ ảo hóa ngày càng phát triển để đáp ứng nhu cầu linh hoạt, hiệu quả, và bảo mật trong bối cảnh công nghệ thay đổi nhanh chóng. Các công nghệ phổ biến bao gồm VMware, Microsoft Hyper-V, Xen và KVM
  KVM, nhờ tính mã nguồn mở và tích hợp chặt chẽ với nhân Linux, đang chiếm một phần đáng kể trong lĩnh vực hạ tầng đám mây (được sử dụng rộng rãi trong OpenStack và Proxmox). Ngoài ra KVM còn nhận được sự hỗ trợ mạnh mẽ từ cộng đồng mã nguồn mở quốc tế và trong nước. Nhiều tài liệu hướng dẫn, diễn đàn thảo luận đã có sẵn để hỗ trợ người dùng triển khai và tối ưu hóa KVM.

## GIỚI THIỆU KVM
  KVM (Kernel-based Virtual Machine) là một giải pháp ảo hóa mã nguồn mở, được tích hợp trực tiếp vào nhân Linux. Ra mắt vào năm 2007, KVM đã mở ra một kỷ nguyên mới trong lĩnh vực ảo hóa, cho phép hệ điều hành Linux hoạt động như một hypervisor (phần mềm giám sát máy ảo). KVM giúp chuyển đổi kernel Linux thành một nền tảng quản lý và triển khai máy ảo (Virtual Machines - VM), nơi mà mỗi máy ảo có thể hoạt động độc lập như một hệ thống hoàn chỉnh. Các máy ảo này có thể chia sẻ tài nguyên phần cứng như CPU, RAM, ổ cứng và mạng với các hệ điều hành khác chạy trên cùng một máy chủ vật lý, nhưng vẫn đảm bảo sự cô lập giữa chúng.

  ![image](https://github.com/user-attachments/assets/589dafe1-784b-4083-8f4d-480fab4bd53d)
  
  KVM được triển khai dưới dạng một module trong nhân Linux, tận dụng các tính năng ảo hóa phần cứng (Intel VT-x hoặc AMD-V) của CPU để cải thiện hiệu suất và độ ổn định. Thay vì xây dựng một hypervisor riêng biệt, KVM biến Linux thành một hypervisor loại 1 (Type 1 Hypervisor), cho phép ảo hóa được tích hợp ngay trong hệ điều hành.

## KHÁI NIỆM LIÊN QUAN VỀ ẢO HOÁ
### Ảo hóa được chia thành hai loại chính dựa trên cách triển khai hypervisor:
- Hypervisor Type 1 (Bare-Metal Hypervisor): Hypervisor Type 1 chạy trực tiếp trên phần cứng vật lý của máy chủ mà không cần thông qua hệ điều hành trung gian. Loại này cung cấp hiệu suất cao nhờ giảm thiểu độ trễ và sự can thiệp từ các tầng phần mềm khác. KVM, mặc dù phụ thuộc vào nhân Linux, vẫn được xếp vào Type 1 do nó hoạt động như một module tích hợp trong kernel Linux. Một số ví dụ phổ biến khác của hypervisor Type 1 là VMware ESXi, Microsoft Hyper-V, và Xen.
- Hypervisor Type 2 (Hosted Hypervisor): Hypervisor Type 2 hoạt động trên một hệ điều hành chủ (host OS). Loại này dễ triển khai hơn nhưng có hiệu suất thấp hơn do phụ thuộc vào hệ điều hành trung gian. Đây thường là lựa chọn của cá nhân hoặc các tổ chức nhỏ, phù hợp để thử nghiệm hoặc phát triển. Các ví dụ điển hình bao gồm VMware Workstation, Oracle VirtualBox và Parallels Desktop.
![image](https://github.com/user-attachments/assets/82149412-1423-454b-942d-57eb3cfdb634)
  
### So sánh giữa KVM (Type 1) và VMware (Type 2):
- KVM (Type 1): KVM hoạt động như một hypervisor Type 1, tận dụng nhân Linux để quản lý các máy ảo. Điều này giúp KVM đạt được hiệu suất cao và khả năng cô lập tài nguyên tốt. KVM thích hợp để triển khai trong môi trường doanh nghiệp hoặc đám mây với sự hỗ trợ mạnh mẽ từ các công cụ mã nguồn mở như Virt-Manager, libvirt và QEMU.
- VMware (Type 2): VMware Workstation là một hypervisor Type 2, được cài đặt trên một hệ điều hành chủ. VMware thường dễ sử dụng và phù hợp để thử nghiệm hoặc chạy các ứng dụng không yêu cầu hiệu suất cao. Tuy nhiên, hiệu suất của VMware thấp hơn KVM do phụ thuộc vào hệ điều hành trung gian và tài nguyên bị phân chia thêm một tầng.

## SO SÁNH HIỆU SUẤT GIỮA KVM VÀ VMWARE
*(Vui lòng xem chi tiết phần so sánh này trong báo cáo.)*


## MÔ HÌNH, KỊCH BẢN TRIỂN KHAI KVM
### Kịch bản 1: Tạo máy ảo thông qua GUI Virt Manager ([Video demo](https://youtu.be/drvLAiasklw?si=dxriV0I-Epw343Vj))

Virt Manager (Virtual Machine Manager) là một công cụ giao diện đồ họa thân thiện, được sử dụng rộng rãi để quản lý máy ảo trên các hệ điều hành nhân Linux, đặc biệt với công nghệ KVM. Thay vì thao tác qua các lệnh dòng lệnh phức tạp, Virt Manager cung cấp một giao diện GUI trực quan, giúp người dùng dễ dàng tạo, cấu hình và quản lý máy ảo. Công cụ này hỗ trợ các chức năng nâng cao như quản lý tài nguyên hệ thống, kết nối mạng, và lưu trữ máy ảo.

Trong mô hình triển khai này, nhóm chúng em sử dụng một máy thật chạy Kali Linux 2024.3 được cài đặt KVM làm môi trường ảo hóa. Trên máy thật đó, một máy ảo sử dụng hệ điều hành Ubuntu Server 22.04 sẽ được triển khai và quản lý hoàn toàn thông qua Virt Manager. Mô hình này tận dụng sự tối ưu của KVM kết hợp với giao diện thân thiện của Virt Manager.

### Kịch bản 2: Tạo máy ảo có User Data thông qua CLI Virt Manager ([Video demo](https://youtu.be/Fq4xx8sPwY0?si=qTg-OXBcHViiCTsC))
Trong kịch bản này, mục tiêu của nhóm là tạo một máy ảo KVM – Ubuntu Server 22.04 sử dụng user-data và metadata để tự động hóa cấu hình ban đầu thông qua giao diện dòng lệnh (CLI) với Virt Manager. Mô hình bao gồm:
- Host chính: Máy chủ chạy Kali Linux 2024.3 với KVM và libvirt đã được cấu hình sẵn.
- Máy ảo: Được tạo dựa trên 2 tệp ISO chứa thông tin tự động hóa (seed ISO) cùng với các tệp user-data và metadata, cung cấp các thông tin như tài khoản người dùng, hostname, và các thông số khác + tệp ISO ubuntu-server-2204 để cài máy ảo.


### Kịch bản 3: SSH giữa 2 máy ảo trong KVM ([Video demo](https://youtu.be/Ikg9hnbTIPg?si=uIcLVr9yWjLuaJ-j))
Trong kịch bản này, nhóm sẽ triển khai một mô hình mạng ảo hóa sử dụng KVM (Kernel-based Virtual Machine) để tạo ra hai máy ảo Ubuntu Desktop (22.04.5 LTS). Mục đích là mô phỏng tình huống khi máy ảo VM 1 cần cài đặt một dự án từ GitHub bằng máy ảo khác (VM 2). Máy ảo VM 2 thông qua kết nối SSH, giúp truy cập đến máy ảo VM 1 và thực hiện các thao tác cần thiết.

Mô hình này sẽ cho phép thực hiện các thao tác mạng giữa các máy ảo trong môi trường KVM, đồng thời kiểm tra khả năng cấu hình và các tính năng của kết nối SSH giữa các máy ảo.


### Kịch bản 4: Triển khai CSDL MySQL và sao lưu dữ liệu của CSDL đó ([Video demo](https://youtu.be/H2wxqkXcCxw?si=HEV6J0h5cv87rTQz))
Trong kịch bản này, nhóm sẽ triển khai một mô hình gồm 2 máy chủ sử dụng KVM, trong đó:
- Một máy ảo đóng vai trò là Database Server được sử dụng để chứa CSDL MySQL, đồng thời đóng vai trò lưu trữ chính, cho phép Client thực hiện các thao tác CRUD (Create, Read, Update, Delete). 
- Máy ảo còn lại sẽ có vai trò là Backup Server, sử dụng TLS/SSL để mã hóa kết nối giữa 2 máy, máy này chỉ có quyền Read trên CSDL và sẽ liên tục sao lưu bản sao của CSDL.


### Kịch bản 5: Xây dựng mạng nội bộ gồm WebServer, DataServer, Clients ([Video demo](https://youtu.be/kj0qxaAmQhg?si=Tw_1pk-Xz9Mq6wlX))
Trong thời đại số hóa và kết nối toàn cầu, nhu cầu triển khai các hệ thống mạng nội bộ hiệu quả, bảo mật và có khả năng mở rộng là một thách thức đối với các tổ chức và doanh nghiệp. Trong kịch bản này, mục tiêu của nhóm là xây dựng một mô hình mạng nội bộ, sử dụng công nghệ ảo hóa KVM (Kernel-based Virtual Machine) để đảm bảo tính linh hoạt, hiệu quả trong việc quản lý tài nguyên, và khả năng tích hợp với các hệ thống hiện có.

Mạng nội bộ bao gồm một hạ tầng máy chủ nội bộ mạnh mẽ, trong đó các máy chủ ảo được triển khai để thực hiện các nhiệm vụ riêng biệt. Các máy chủ này được triển khai trên nền tảng KVM, một giải pháp ảo hóa cấp độ kernel được tích hợp trong Linux, giúp tận dụng tối đa hiệu năng phần cứng. Hệ thống mạng nội bộ có ba thành phần chính:
- Web Server: Một máy ảo KVM chạy hệ điều hành Ubuntu 20.04. Chịu trách nhiệm cung cấp dịch vụ web cho các ứng dụng nội bộ, đảm bảo truy cập nhanh chóng và bảo mật.
- Data Server: Một máy ảo KVM chạy hệ điều hành Ubuntu Server 20.04 chứa cơ sở dữ liệu nội bộ, lưu trữ thông tin và phục vụ dữ liệu cho các ứng dụng web.
- Client: Máy ảo KVM khác chạy hệ điều hành Ubuntu 20.04.06, có thể truy cập vào các website nội bộ để thực hiện công việc được giao.


## TỔNG KẾT
Đề tài Tìm Hiểu Và Triển Khai Công Cụ Ảo Hoá KVM của môn học Quản trị mạng và Hệ thống đã giúp chúng em đã nắm được các khái niệm cơ bản về ảo hóa, sự khác biệt giữa ảo hóa Type 1 và Type 2, củng cố lại những kiến thức trong ngành CNTT như phần cứng, phần mềm…. Quá trình thực hiện đồ án môn học không chỉ giúp chúng em hiểu rõ về nguyên lý hoạt động của KVM mà còn mở rộng kiến thức về việc quản lý tài nguyên ảo hóa, bảo mật, và ứng dụng trong môi trường thực tiễn. Những kiến thức như quản lý CPU, RAM, lưu trữ và mạng trong hệ thống ảo hóa được ứng dụng triệt để, giúp tạo nên các kịch bản triển khai thực tiễn, từ xây dựng máy chủ dữ liệu đến thiết lập mạng nội bộ bảo mật.

Qua so sánh hiệu suất giữa KVM và VMWare, ta có thể thấy rằng trên cùng 1 phần cứng máy tính, KVM đã thể hiện ưu thế hơn trong việc tối ưu tài nguyên hệ thống và xử lý các tác vụ nặng. Đây là lợi thế rõ rệt giúp giảm độ trễ và tận dụng tối đa hiệu suất máy tính. Tuy nhiên, việc cài đặt dual-boot 1 hệ điều hành nhân Linux lên máy tính rồi sau đó cấu hình KVM thông qua các dòng lệnh Linux thì khá phức tạp, cần nhiều kỹ năng và kiến thức về IT hơn. Ngược lại, VMWare thì lại dễ sử dụng, linh hoạt trong môi trường đa nền tảng hơn (ta có thể cài VMWare lên cả macOS và Windows), phù hợp cho những ứng dụng yêu cầu giao diện trực quan, không đòi hỏi hiệu suất quá cao.

Đồ án của nhóm chúng em đã hoàn thành việc nghiên cứu và triển khai hệ thống ảo hóa KVM. Thông qua năm kịch bản thực tiễn, bao gồm tạo máy ảo GUI & CLI, thiết lập kết nối SSH, triển khai cơ sở dữ liệu MySQL và xây dựng Web Server kết hợp Data Server trong mạng nội bộ. Mỗi kịch bản không chỉ đạt được các mục tiêu kỹ thuật mà nhóm kỳ vọng mà còn cung cấp một nền tảng tốt để kiểm nghiệm hiệu suất và tính ứng dụng của KVM.

Ta thấy, KVM không chỉ đáp ứng các yêu cầu triển khai mà còn thể hiện tính ổn định, độ tin cậy và khả năng mở rộng. Khả năng kiểm soát tài nguyên, cùng các biện pháp bảo mật như tường lửa và mã hóa dữ liệu, đã đảm bảo an toàn trong môi trường mạng nội bộ. Hệ thống này là giải pháp lý tưởng để phục vụ mục đích thử nghiệm, phát triển, và triển khai hạ tầng ảo hóa cho doanh nghiệp lẫn tổ chức giáo dục.

Việc ứng dụng KVM trong thực tiễn đã khẳng định giá trị của nó trong các hoạt động công nghệ thông tin, từ quản lý tài nguyên nội bộ đến xây dựng các hệ thống phức tạp hơn, mang lại sự cân bằng giữa hiệu suất, bảo mật và khả năng sử dụng.



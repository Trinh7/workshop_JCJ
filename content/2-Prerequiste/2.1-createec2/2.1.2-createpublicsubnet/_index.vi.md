---
title : "Tạo thùng Amazon S3"
date: "2023-07-15" 
weight : 2
chapter : false
pre : " <b> 3.1.2 </b> "
---

#### Tạo thùng Amazon S3

##### Bạn cần tạo một thùng Amazon S3 để lưu trữ tất cả các tệp âm thanh do ứng dụng tạo ra. Bạn tạo một thùng với tên duy nhất, chẳng hạn như audioposts-123456789 .

1. Ở đầu AWS Management Console, trong thanh tìm kiếm, hãy tìm kiếm và chọn S3.

2. Chọn **Tạo thùng** và cấu hình các thông tin chi tiết sau:

- Tên thùng: **audioposts-NUMBER**
    - Thay thế NUMBER bằng một số ngẫu nhiên
    - Sao chép tên nhóm vào trình soạn thảo văn bản khi bạn sử dụng tên nhóm sau này.
- Trong Quyền sở hữu đối tượng , chọn ACL được bật
- Trong phần Cài đặt chặn quyền truy cập công khai cho nhóm này, hãy bỏ chọn tùy chọn Chặn tất cả quyền truy cập công khai , sau đó bỏ chọn tất cả các tùy chọn khác .
 
**Lưu ý**: tất cả các tùy chọn riêng lẻ vẫn được bỏ chọn. Khi bỏ chọn tất cả quyền truy cập công khai, bạn phải chọn các tùy chọn riêng lẻ áp dụng cho tình huống và mục tiêu bảo mật của mình. Trong môi trường sản xuất, nên sử dụng cài đặt ít quyền hạn nhất có thể.

Một hộp cảnh báo xuất hiện với nội dung: Việc tắt tùy chọn chặn tất cả quyền truy cập công khai có thể khiến bucket này và các đối tượng bên trong trở thành công khai. AWS khuyến nghị bạn nên bật tùy chọn chặn tất cả quyền truy cập công khai, trừ khi quyền truy cập công khai là bắt buộc cho các trường hợp sử dụng cụ thể và đã được xác minh, chẳng hạn như lưu trữ trang web tĩnh.

- Chọn hộp kiểm bên cạnh Tôi xác nhận rằng các cài đặt hiện tại có thể khiến nhóm này và các đối tượng bên trong trở nên công khai .
- Chọn **Tạo thùng**.

**Lưu ý**: Mỗi thùng Amazon S3 phải có tên duy nhất.

Thận trọng: Nếu bạn nhận được lỗi có nội dung Tên thùng được yêu cầu không khả dụng, hãy chọn liên kết Chỉnh sửa ở trên cùng, thay đổi tên thùng và thử lại cho đến khi hoạt động.
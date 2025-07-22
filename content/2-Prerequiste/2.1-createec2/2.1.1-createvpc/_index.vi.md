---
title : "Tạo bảng DynamoDB "
date: "2023-07-15" 
weight : 1 
chapter : false
pre : " <b> 3.1.1 </b> "
---


#### Tạo bảng DynamoDB **Lab DynamoDB**
1. Ở đầu AWS Management Console, trong thanh tìm kiếm, hãy tìm kiếm và chọn DynamoDB.

2. Chọn **tạo bảng**.
  
3. Tạo một bảng DynamoDB mới với:

   Tên bảng: **posts**

   Khóa phân vùng: (Chuỗi)**id**

   Cài đặt bảng : **Cài đặt mặc định**

4. Chọn : **Tạo bảng**


Bây giờ không cần phải định nghĩa toàn bộ cấu trúc của bảng. Sau khi hoàn tất thiết lập ứng dụng, thông tin sau sẽ được lưu trữ trong bảng DynamoDB:

- id: ID của bài đăng.
- trạng thái: ĐÃ CẬP NHẬT hoặc ĐANG XỬ LÝ , tùy thuộc vào việc tệp MP3 đã được tạo hay chưa.
- văn bản: Văn bản của bài đăng mà tệp âm thanh đang được tạo.
- giọng nói: Giọng nói Amazon Polly được sử dụng để tạo tệp âm thanh.
- url: Liên kết đến thùng S3 nơi lưu trữ tệp âm thanh.


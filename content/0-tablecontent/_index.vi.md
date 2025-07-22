---
title : "Mục Lục"
date : "2023-07-15" 
weight : 1 
chapter : false
pre : " <b> 1. </b> "
---

**Mục tiêu**
Khi hoàn thành wordshop này bạn sẽ có thể:

Tạo bảng Amazon DynamoDB để lưu trữ dữ liệu
Tạo API RESTful của Amazon API Gateway
Tạo các hàm AWS Lambda được kích hoạt bởi API Gateway
Kết nối các chức năng AWS Lambda với Amazon Simple Notification Service (SNS)
Sử dụng Amazon Polly để tổng hợp giọng nói bằng nhiều ngôn ngữ và giọng nói khác nhau

Thờ gian
Buổi hội thảo này mất khoảng 90 phút để hoàn thành.

Môi trường và hướng đi
Bạn xây dựng một ứng dụng không máy chủ , nghĩa là bạn không cần phải làm việc với máy chủ — không cần cung cấp, không cần vá lỗi, không cần mở rộng quy mô. AWS Cloud sẽ tự động xử lý việc này, cho phép bạn tập trung vào ứng dụng của mình.

Ứng dụng cung cấp hai phương thức – một để gửi thông tin về bài đăng mới, sau đó chuyển đổi thành tệp MP3, và một để truy xuất thông tin về bài đăng (bao gồm liên kết đến tệp MP3 được lưu trữ trong kho lưu trữ Amazon S3). Cả hai phương thức đều được triển khai dưới dạng dịch vụ web RESTful thông qua Amazon API Gateway.
![FWD](/images/0.tablecontent/architecture.png)

**Khi ứng dụng gửi thông tin về bài đăng mới:**

1.Thông tin được tiếp nhận bởi dịch vụ web RESTful được Amazon API Gateway cung cấp. Dịch vụ web này được gọi bởi một trang web tĩnh được lưu trữ trên Amazon Simple Storage Service (Amazon S3).

2.Amazon API Gateway kích hoạt hàm AWS Lambda, New Post , có nhiệm vụ khởi tạo quá trình tạo tệp MP3.

3.Hàm Lambda chèn thông tin về bài đăng vào bảng Amazon DynamoDB, nơi lưu trữ thông tin về tất cả các bài đăng.

4.Để chạy toàn bộ quy trình một cách không đồng bộ, bạn sử dụng Amazon Simple Notification Service (Amazon SNS) để tách quá trình nhận thông tin về bài đăng mới và bắt đầu chuyển đổi âm thanh của chúng.

5.Một chức năng Lambda khác, Chuyển đổi thành Âm thanh , được đăng ký theo chủ đề SNS của bạn và được kích hoạt bất cứ khi nào có tin nhắn mới xuất hiện (có nghĩa là bài đăng mới sẽ được chuyển đổi thành tệp âm thanh).

6.Chức năng Chuyển đổi sang âm thanh Lambda sử dụng Amazon Polly để chuyển đổi văn bản thành tệp âm thanh bằng ngôn ngữ đã chỉ định (cùng ngôn ngữ với ngôn ngữ của văn bản).

7.Tệp MP3 mới được lưu trong thùng S3 chuyên dụng.

8.Thông tin về bài đăng được cập nhật trong bảng DynamoDB. URL đến tệp âm thanh được lưu trữ trong thùng S3 được lưu cùng với dữ liệu đã lưu trữ trước đó.

**Khi ứng dụng lấy thông tin về bài đăng:**

1.Dịch vụ web RESTful được triển khai bằng Amazon API Gateway. Amazon API Gateway cung cấp phương thức truy xuất thông tin về các bài đăng. Các phương thức này chứa nội dung bài đăng và liên kết đến kho lưu trữ S3 nơi lưu trữ tệp MP3. Dịch vụ web được gọi bởi một trang web tĩnh được lưu trữ trên Amazon S3.

2.Amazon API Gateway gọi hàm Get Post Lambda, triển khai logic để truy xuất dữ liệu bài đăng.

3.Hàm Get Post Lambda sẽ truy xuất thông tin về bài đăng (bao gồm tham chiếu đến Amazon S3) từ bảng DynamoDB và trả về thông tin.
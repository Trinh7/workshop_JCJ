+++
title = "Kết luận và dọn dẹp tài nguyên"
date = 2021
weight = 5
chapter = false
pre = "<b>4. </b>"
+++



### Phần kết luận

**Bạn đã thực hiện thành công các bước sau:**

- Đã tạo một bảng Amazon DynamoDB để lưu trữ dữ liệu
- Đã tạo API RESTful của Amazon API Gateway
- Đã tạo các hàm AWS Lambda được kích hoạt bởi API Gateway
- Các chức năng AWS Lambda được kết nối với Amazon Simple Notification Service (SNS)
- Sử dụng Amazon Polly để tổng hợp giọng nói bằng nhiều ngôn ngữ và giọng nói khác nhau

Trong phòng thí nghiệm này, bạn đã tạo một ứng dụng chuyển đổi văn bản thành giọng nói ở hàng chục ngôn ngữ và giọng nói. Mặc dù ứng dụng này chuyển đổi bài đăng trên blog thành giọng nói, nó có thể được sử dụng cho nhiều mục đích khác, chẳng hạn như chuyển đổi văn bản trên trang web hoặc thêm chức năng giọng nói vào các ứng dụng web.

Ứng dụng hoàn toàn không cần máy chủ. Không cần bảo trì hoặc vá lỗi máy chủ. Theo mặc định, ứng dụng có tính khả dụng cao vì AWS Lambda, Amazon API Gateway, Amazon S3 và Amazon DynamoDB sử dụng nhiều Vùng Khả dụng.

Vậy bây giờ thì sao? Hãy sử dụng phương pháp này để hình dung và xây dựng các ứng dụng mới mang lại trải nghiệm người dùng tốt hơn nhiều so với trước đây.


**Tài nguyên bổ sung**

[Xem bài viết Amazon Polly](https://aws.amazon.com/blogs/machine-learning/build-your-own-text-to-speech-applications-with-amazon-polly/)

[Amazon Polly là gì?](https://docs.aws.amazon.com/polly/latest/dg/what-is.html)

[Amazon API Gateway là gì?](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

[AWS Lambda là gì?](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)


#### Dọn dẹp

**Bạn đang tổ chức hội thảo này trên tài khoản AWS của mình, vui lòng xóa ngăn xếp CloudFormation để tránh bất kỳ khoản phí bất ngờ nào trên hóa đơn AWS của bạn.**
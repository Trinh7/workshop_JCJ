---
title : "Tạo chủ đề SNS"
date: "2023-07-15" 
weight : 3
chapter : false
pre : " <b> 3.1.3 </b> "
---

#### Tạo chủ đề SNS

Như bạn có thể đã thấy trong sơ đồ kiến trúc, logic chuyển đổi bài đăng (văn bản) thành tệp âm thanh được chia thành hai hàm AWS Lambda. Điều này được thực hiện vì một vài lý do.

Đầu tiên, nó cho phép ứng dụng sử dụng các lệnh gọi bất đồng bộ để người dùng gửi bài đăng mới đến ứng dụng sẽ nhận được ngay ID của mục DynamoDB mới, nhờ đó ứng dụng biết cần yêu cầu gì sau đó mà không cần phải chờ quá trình chuyển đổi hoàn tất. Với các bài đăng nhỏ, quá trình chuyển đổi thành tệp âm thanh có thể mất vài mili giây, nhưng với các bài đăng lớn hơn (100.000 từ trở lên), việc chuyển đổi văn bản có thể mất nhiều thời gian hơn. Trong các trường hợp sử dụng khác, chẳng hạn như phát trực tuyến thời gian thực, kích thước không phải là vấn đề vì Amazon Polly bắt đầu phát trực tuyến giọng nói ngay khi có byte đầu tiên.

Thứ hai, hệ thống sử dụng hàm Lambda để chuyển đổi các bài đăng.

Vì quy trình đã được chia thành hai quy trình, cần phải có cách để tích hợp chúng lại với nhau. Bạn sử dụng Amazon SNS để gửi thông báo về bài đăng mới từ chức năng đầu tiên đến chức năng thứ hai.

1.Ở đầu AWS Management Console, trong thanh tìm kiếm, hãy tìm kiếm và chọn .Simple Notification Service

2.Trong ngăn điều hướng bên trái, chọn **Chủ đề** .

**Lưu ý**: Bạn có thể cần mở rộng ngăn điều hướng bằng cách chọn biểu tượng menu.
1.ChọnTạo chủ đềvà cấu hình các thông tin chi tiết sau:
   - Loại: **Chọn Tiêu chuẩn**
   - Tên: **new_posts**
   - Tên hiển thị: **New Posts**


1.Ở cuối trang, chọn **Tạo chủ đề**.


2.Sao chép ARN chủ đề và dán vào trình soạn thảo văn bản để sử dụng sau.

**Đầu ra dự kiến:**
  arn:aws:sns:us-west-2:123456789012:new_posts

**Lưu ý**: Bạn cấu hình các hàm Lambda để sử dụng Topic ARN này sau trong phòng thí nghiệm.
![FWD](/images/sns.png)


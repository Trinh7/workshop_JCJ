---
title : "Các bước chuẩn bị và thực hiện"
date: "2023-07-15" 
weight : 4 
chapter : false
pre : " <b> 3. </b> "
---

{{% notice info %}}
Bạn cần chuẩn bị tài khoản AWS với quyền quản trị có thể truy cập vào AWS Management Console để bắt đầu dự án
{{% /notice %}}

**Khởi chạy ngăn xếp CloudFormation**

Mẫu AWS CloudFormation được sử dụng để thiết lập tài nguyên phòng thí nghiệm trong Khu vực AWS mà bạn chọn. Bước này là bắt buộc vì các hướng dẫn sau sẽ dựa trên các tài nguyên này. Mẫu CloudFormation cung cấp các tài nguyên sau:

- Vai trò IAM.

- Bảng Amazon DynamoDB.

- Máy trạng thái chức năng bước AWS.

1.Tải xuống mẫu CloudFormation

2.Lưu trữ tệp mẫu YAML trong một thư mục trên máy cục bộ của bạn.

3.Điều hướng đến CloudFormation trong AWS Management Console .

4.Trên bảng điều khiển CloudFormation, chọn Tải lên tệp mẫu .

5.Chọn mẫu mà bạn vừa tải xuống, sau đó chọn Tiếp theo .

![FWD](/images/own-account-upload-cfn.png)

6.Đặt tên cho ngăn xếp, chẳng hạn nhưpolly-serverless-stack

7.Đối với tùy chọn Cấu hình ngăn xếp , hãy giữ nguyên giá trị mặc định và chọn Tiếp theo .

8.Trong Khả năng và chuyển đổi , hãy thừa nhận tất cả.

![FWD](/images/own-account-iam.png)

9.Để triển khai mẫu, hãy chọn Gửi .

10.Sau khi mẫu được triển khai, để xem lại các tài nguyên đã tạo, hãy điều hướng đến Tài nguyên CloudFormation và sau đó chọn ngăn xếp CloudFormation mà bạn đã tạo.

Việc triển khai Cloud Formation mất khoảng 1–2 phút để hoàn tất.

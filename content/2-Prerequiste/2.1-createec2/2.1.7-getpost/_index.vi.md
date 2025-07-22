---
title : "Tạo hàm Lambda get posts"
date: "2023-07-15"
weight : 7
chapter : false
pre : " <b> 3.1.7 </b> "
---

Hàm *Get Post Lambda* cuối cùng cung cấp phương pháp để lấy thông tin về các bài đăng từ cơ sở dữ liệu.

1.Ở đầu AWS Management Console, trong thanh tìm kiếm, hãy tìm kiếm và chọn Lambda.

2.Chọn **Tạo hàm**.

3.Chọn **Tác giả từ đầu** và sử dụng các cài đặt sau:

- Tên hàm: **PostReader_GetPost**
- Thời gian chạy: **Python 3.12**
- Mở rộng Thay đổi vai trò thực thi mặc định
- Vai trò thực thi: Chọn **Sử dụng vai trò hiện có**
- Vai trò hiện tại: Chọn **Lab-Lambda-Role**

1.Cuộn xuống và chọn **Tạo hàm.**

2.Nhập mã: Xóa mã hiện có và dán mã sau:


        import boto3
        import os
        from boto3.dynamodb.conditions import Key, Attr
        
        def lambda_handler(event, context):
        
            postId = event["postId"]
        
            dynamodb = boto3.resource('dynamodb')
            table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
        
            if postId=="*":
                items = table.scan()
            else:
                items = table.query(
                    KeyConditionExpression=Key('id').eq(postId)
                )
        
            return items["Items"]

Lần này, mã rất ngắn. Hàm này dự kiến sẽ lấy ID bài đăng (ID mục DynamoDB) và dựa trên ID này, nó sẽ truy xuất tất cả thông tin (bao gồm cả liên kết S3 đến tệp âm thanh nếu có) rồi trả về. Để thân thiện hơn với người dùng nếu tham số đầu vào là dấu sao (*), hàm Lambda sẽ trả về tất cả các mục từ cơ sở dữ liệu. Đối với cơ sở dữ liệu có nhiều mục, hãy tránh sử dụng phương pháp này vì nó có thể làm giảm hiệu suất và có thể mất nhiều thời gian.

1.Chọn **Triển khai.**

Một lần nữa, bạn cần cung cấp tên bảng **DynamoDB** làm biến môi trường cho hàm.

1.Chọn tab **Cấu hình** để cấu hình các biến môi trường.

2.Trong ngăn điều hướng bên trái, chọn **Biến môi trường** .

3.Trong phần **Biến môi trường** , hãy chọn **Biên tập**.

- Chọn **Thêm biến môi trường**

   - Phím: Nhập **DB_TABLE_NAME**
   - Giá trị: Nhập **posts**

1.Chọn **Lưu**.
![FWD](/images/lambda11.png)

Bây giờ bạn có thể kiểm tra chức năng này!

1.Trong tab 88 , hãy tạo sự kiện kiểm tra của bạn bằng các tham số sau:
   - Tên sự kiện **AllPosts**
   - Nhập mã: Thay thế mã hiện tại bằng mã sau:


          {
               "postId": "*"
          }

1.Chọn **Lưu**.
2.Chọn **Bài kiểm tra** để chạy sự kiện thử nghiệm.

Bạn sẽ thấy thông báo: Kết quả thực hiện: **thành công **

Nếu bạn mở rộng phần **Chi tiết **, bạn sẽ thấy danh sách tất cả các bản ghi từ bảng **DynamoDB.**
![FWD](/images/lambda12.png)
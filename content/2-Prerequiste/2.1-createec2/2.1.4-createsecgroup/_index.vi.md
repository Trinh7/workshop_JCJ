---
title : "Tạo hàm Lambda "
date: "2023-07-15" 
weight : 4
chapter : false
pre : " <b> 3.1.4 </b> "
---

#### Tạo hàm Lambda cho bài đăng mới

Hàm Lambda đầu tiên bạn tạo là điểm vào cho ứng dụng. Nó nhận thông tin về các bài đăng mới cần được chuyển đổi thành tệp âm thanh.

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn **Lambda**.

2.Chọn **Tạo hàm**.

3.Chọn **Tác giả từ đầu** và sử dụng các cài đặt sau:

- Tên hàm: **PostReader_NewPost**
- Thời gian chạy: **Python 3.12**
- Mở rộng **Thay đổi vai trò thực thi mặc định**
- Vai trò thực thi: Chọn **Sử dụng vai trò hiện có**
- Vai trò hiện tại: Chọn **Lab-Lambda-Role**

1.Chọn Tạo hàm.

2.Nhập mã: Xóa mã hiện có và dán mã sau:

      import boto3
      
      import os
      
      import uuid
      
      def lambda_handler(event, context):
      
          recordId = str(uuid.uuid4())
          voice = event["voice"]
          text = event["text"]
      
          print('Generating new DynamoDB record, with ID: ' + recordId)
          print('Input Text: ' + text)
          print('Selected voice: ' + voice)
      
          # Creating new record in DynamoDB table
          dynamodb = boto3.resource('dynamodb')
          table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
          table.put_item(
              Item={
                  'id' : recordId,
                  'text' : text,
                  'voice' : voice,
                  'status' : 'PROCESSING'
              }
          )
      
          # Sending notification about new post to SNS
          client = boto3.client('sns')
          client.publish(
              TopicArn = os.environ['SNS_TOPIC'],
              Message = recordId
          )
      
          return recordId    
![FWD](/images/lambda2.png)

Kiểm tra mã. Hàm Lambda thực hiện các chức năng sau:

- Lấy hai tham số đầu vào:
    - Giọng nói: Một trong hàng chục giọng nói được Amazon Polly hỗ trợ.
    - Văn bản: Văn bản của bài đăng mà chúng ta muốn chuyển đổi thành tệp âm thanh.
- Tạo một bản ghi mới trong bảng DynamoDB với thông tin về bài đăng mới.
- Xuất bản thông tin về bài đăng mới lên SNS (ID của mục/ID bài đăng DynamoDB được xuất bản ở đó dưới dạng tin nhắn).
- Trả về ID của mục DynamoDB cho người dùng.

1. Chọn **Triển khai**.

**Lưu ý**: Hàm Lambda cần biết tên bảng DynamoDB và chủ đề SNS. Để cung cấp các giá trị này, bạn sử dụng biến môi trường. Đây là một cách tuyệt vời để truyền thông tin đến một hàm mà không cần mã hóa cứng các giá trị vào chính hàm đó.

1.Chọn tab **Cấu hình** để cấu hình các biến môi trường.

2.Trong ngăn điều hướng bên trái, chọn **Biến môi trường** .

3.Trong phần Biến môi trường , chọn **Biên tập**.


- Chọn **Thêm biến môi trường.**
    - Phím: Nhập **DB_TABLE_NAME**
    - Giá trị: Nhập **posts**

1.Chọn **lưu**.
2.Trong ngăn điều hướng bên trái của tab Cấu hình , chọn **Cấu hình chung** .

- Cập nhật thời gian chờ thành 10 giây

1.Chọn **lưu**.

Hàm **New Post Lambda** đã sẵn sàng! Bây giờ bạn có thể kiểm tra xem hàm có hoạt động không.

1.Chọn tab Kiểm tra và cấu hình các thông tin chi tiết sau:

- Tên sự kiện: Joanna
- Nhập mã: Xóa mã hiện có và dán mã sau:


      {
         "voice": "Joanna",
         "text": "This is working!"
      }



1.Chọn **Lưu**.

2.Chọn **Bài kiểm tra** để chạy sự kiện thử nghiệm của bạn.

Bạn sẽ thấy thông báo: **Kết quả thực hiện: thành công** .

Bạn có thể mở rộng phần **Chi tiết** để xem nhật ký thực thi.

![FWD](/images/lambda3.png)

Hàm **New Post Lambda** trả về một ID và bạn có thể thấy các giá trị đầu vào trong đầu ra **Nhật ký** .
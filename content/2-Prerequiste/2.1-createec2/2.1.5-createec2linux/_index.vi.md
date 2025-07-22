---
title : "Tạo hàm Lambda chuyển đổi sang âm thanh"
date: "2023-07-15" 
weight : 5
chapter : false
pre : " <b> 3.1.5 </b> "
---

**Bây giờ bạn tạo một hàm Lambda để chuyển đổi văn bản được lưu trữ trong bảng DynamoDB thành tệp âm thanh.**

1.Chọn **Chức năng** ở ngăn điều hướng phía trên bên trái.

Lưu ý: Bạn có thể cần mở rộng ngăn điều hướng bằng cách chọn biểu tượng menu.

1.Chọn **Tạo hàm.**
2.Chọn **Tác giả từ đầu** và sử dụng các cài đặt sau:

- Tên hàm: ConvertToAudio
- Thời gian chạy: Python 3.12
- Mở rộng Thay đổi vai trò thực thi mặc định
- Vai trò thực thi: Chọn Sử dụng vai trò hiện có
- Vai trò hiện tại: Chọn Lab-Lambda-Role

1.Cuộn xuống và chọn **Tạo hàm.**
2.Nhập mã: Xóa mã hiện có và dán mã sau:


       import boto3
       import os
       from contextlib import closing
       from boto3.dynamodb.conditions import Key, Attr
       
          def lambda_handler(event, context):
          
              postId = event["Records"][0]["Sns"]["Message"]
          
              print ("Text to Speech function. Post ID in DynamoDB: " + postId)
          
              # Retrieving information about the post from DynamoDB table
              dynamodb = boto3.resource('dynamodb')
              table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
              postItem = table.query(
                  KeyConditionExpression=Key('id').eq(postId)
              )
          
          
              text = postItem["Items"][0]["text"]
              voice = postItem["Items"][0]["voice"]
          
              rest = text
          
              # Because single invocation of the polly synthesize_speech api can
              # transform text with about 3000 characters, we are dividing the
              # post into blocks of approximately 2500 characters.
              textBlocks = []
              while (len(rest) > 2600):
                  begin = 0
                  end = rest.find(".", 2500)
          
                  if (end == -1):
                      end = rest.find(" ", 2500)
          
                  textBlock = rest[begin:end]
                  rest = rest[end:]
                  textBlocks.append(textBlock)
              textBlocks.append(rest)
          
              # For each block, invoke Polly API, which transforms text into audio
              polly = boto3.client('polly')
              for textBlock in textBlocks:
                  response = polly.synthesize_speech(
                      OutputFormat='mp3',
                      Text = textBlock,
                      VoiceId = voice
                  )
          
                  # Save the audio stream returned by Amazon Polly on Lambda's temp
                  # directory. If there are multiple text blocks, the audio stream
                  # is combined into a single file.
                  if "AudioStream" in response:
                      with closing(response["AudioStream"]) as stream:
                          output = os.path.join("/tmp/", postId)
                          if os.path.isfile(output):
                              mode = "ab"  # Append binary mode
                          else:
                              mode = "wb"  # Write binary mode (create a new file)
                          with open(output, mode) as file:
                              file.write(stream.read())
          
              s3 = boto3.client('s3')
              s3.upload_file('/tmp/' + postId,
                os.environ['BUCKET_NAME'],
                postId + ".mp3")
              s3.put_object_acl(ACL='public-read',
                Bucket=os.environ['BUCKET_NAME'],
                Key= postId + ".mp3")
          
              location = s3.get_bucket_location(Bucket=os.environ['BUCKET_NAME'])
              region = location['LocationConstraint']
          
              if region is None:
                  url_beginning = "https://s3.amazonaws.com/"
              else:
                  url_beginning = "https://s3-" + str(region) + ".amazonaws.com/"
          
              url = url_beginning \
                      + str(os.environ['BUCKET_NAME']) \
                      + "/" \
                      + str(postId) \
                      + ".mp3"
          
              # Updating the item in DynamoDB
              response = table.update_item(
                  Key={'id':postId},
                    UpdateExpression=
                      "SET #statusAtt = :statusValue, #urlAtt = :urlValue",
                    ExpressionAttributeValues=
                      {':statusValue': 'UPDATED', ':urlValue': url},
                  ExpressionAttributeNames=
                    {'#statusAtt': 'status', '#urlAtt': 'url'},
              )
          
              return


Kiểm tra mã. Hàm Lambda thực hiện các chức năng sau:

- Truy xuất ID của mục DynamoDB (ID bài đăng) cần được chuyển đổi thành tệp âm thanh từ thông báo đầu vào (sự kiện SNS)
- Lấy mục từ DynamoDB
- Chuyển đổi văn bản thành luồng âm thanh
- Đặt tệp âm thanh (MP3) vào thùng S3
- Cập nhật bảng DynamoDB bằng tham chiếu đến thùng S3 và trạng thái mới

Phương thức **synthesize_speech** nhận văn bản cần chuyển đổi và giọng nói được sử dụng. Đổi lại, nó cung cấp **luồng âm thanh** . Vấn đề là văn bản đầu vào bị giới hạn ở 3000 ký tự. Vì một bài đăng có thể rất dài, các bài đăng cần được chia thành các khối khoảng 2500 ký tự, tùy thuộc vào vị trí kết thúc của từ cuối cùng trong khối. Sau khi chuyển đổi các khối thành luồng âm thanh, chúng sẽ được nối lại với nhau.

1.Chọn **Triển Khai**.
![FWD](/images/lambda4.1.png)
![FWD](/images/lambda4.png)
Tương tự như hàm New Post , bạn cần cho hàm Lambda này biết những dịch vụ nào mà nó có thể tương tác thông qua các biến Môi trường.

1.Chọn tab **Cấu hình** để cấu hình các biến môi trường.

2.Trong ngăn điều hướng bên trái, chọn **Biến môi trường** .

3.Trong phần **Biến môi trường** , hãy chọn **Biên tập**.

- Chọn Thêm biến môi trường

     - Phím: **NhậpDB_TABLE_NAME**
     - Giá trị: Nhập **posts**


- Chọn **Thêm biến môi trường**
     - Phím: Nhập **BUCKET_NAME**

     - Giá trị: Nhập tên của bucket bạn đã tạo trước đó. Tên sẽ trông tương tự như sau: **audioposts-123**

1.Chọn **Lưu**.

Các bài đăng cần chuyển đổi có thể khá lớn, vì vậy bạn cần kéo dài thời gian tối đa thực thi một mã lên 5 phút.

1.Trong phần **Cấu hình chung** , hãy chọn **Biên tập**.

- Cập nhật thời gian chờ thành 5phút.

1.Chọn **Lưu**.

Bây giờ bạn cấu hình chức năng để tự động kích hoạt khi có tin nhắn được gửi đến chủ đề SNS mà bạn đã tạo trước đó.

1.Trong phần **Triggers** , hãy chọn **Thêm kích hoạt** và sau đó cấu hình:

- Chọn nguồn :**SNS**
- Chủ đề SNS : Chọn từ các chủ đề có sẵn **.new_posts**

1.Chọn **Thêm vào**.

Bây giờ bạn đã sẵn sàng để kiểm tra xem hai hàm Lambda có giao tiếp thành công qua SNS hay không và tạo tệp âm thanh Polly.
![FWD](/images/lambda5.png)
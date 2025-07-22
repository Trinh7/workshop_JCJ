---
title : "Kiểm tra các chức năng"
date: "2023-07-15" 
weight : 6 
chapter : false
pre : " <b> 3.1.6 </b> "
---

**Bây giờ bạn hãy thử quy trình làm việc sau:**

- Kích hoạt thủ công chức năng New Post Lambda
- Nó lưu trữ dữ liệu trong DynamoDB và gửi tin nhắn đến chủ đề SNS
- SNS kích hoạt chức năng Chuyển đổi thành âm thanh , sử dụng Polly để tạo tệp âm thanh và lưu trữ trong thùng S3

1.Chọn **Chức năng** ở góc trên bên trái.

Lưu ý: Bạn có thể cần mở rộng ngăn điều hướng bằng cách chọn biểu tượng menu.

1.Chọn hàm **PostReader_NewPost** .

2.Chọn **Kiểm tra**.

Bạn sẽ thấy thông báo: Kết quả thực hiện: **thành công** .
![FWD](/images/lambda6.png)

Điều này cho biết hàm này đã được thực thi. Bây giờ bạn xác nhận rằng các bước khác cũng đã hoàn tất thành công.

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn **.DynamoDB**

2.Trong ngăn điều hướng bên trái, chọn **Khám phá mục** .

3.Chọn **bài đăng** .

Bạn sẽ thấy hai mục nhập vì bạn đã chạy thử nghiệm hai lần. Lần thực thi thứ hai cũng sẽ kích hoạt hàm Convert to Audio Lambda, do đó cũng có một mục nhập cho url .
![FWD](/images/lambda7.png)

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn **.Lambda**

2.Chọn chức năng **ConvertToAudio** .

3.Chọn tab **Giám sát** .

Biểu đồ giám sát phải chỉ ra rằng chức năng đã được gọi.
![FWD](/images/lambda8.png)

1.Chọn Xem nhật ký **CloudWatch**

2.Chọn Luồng nhật ký được hiển thị trong danh sách

3.Mở rộng các mục nhật ký để khám phá thông báo lỗi

Ví dụ, nếu bạn nhận được lỗi The specified bucket does not exist (Không tồn tại thùng được chỉ định) , thì bạn cần xác nhận rằng tên thùng bạn nhập vào Biến môi trường khớp với tên thùng S3 bạn đã tạo trước đó trong phòng thí nghiệm.
![FWD](/images/lambda9.png)

Nếu chức năng Chuyển đổi thành âm thanh được thực hiện thành công, bạn sẽ thấy tệp MP3 trong thùng S3 của mình.

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn .**S3**

2.Chọn nhóm bài đăng âm thanh của bạn .

Bạn sẽ thấy một tệp MP3. Tải xuống và nghe nội dung — bạn sẽ nghe thấy giọng Joanna của Polly nói "Cách này hiệu quả đấy!"
![FWD](/images/lambda10.png)


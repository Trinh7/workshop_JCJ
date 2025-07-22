---
title : "Tạo giao diện người dùng không có máy chủ"
date: "2023-07-15"
weight : 9
chapter : false
pre : " <b> 3.1.9 </b> "
---

**Mặc dù ứng dụng đã hoạt động đầy đủ, nhưng nó chỉ được hiển thị dưới dạng dịch vụ web RESTful. Bây giờ bạn triển khai một trang web nhỏ trên Amazon S3, một lựa chọn tuyệt vời để lưu trữ các trang web tĩnh. Trang web này sử dụng JavaScript để kết nối với API và cung cấp chức năng chuyển văn bản thành giọng nói trong trang web.**

1.Tải các tập tin này về máy tính của bạn, nhấp chuột phải và chọn "Lưu liên kết dưới dạng...".

- [index.html](/files/index.html)
- [scripts.js](/files/scripts.js)
- [styles.css](/files/styles.css)

Lưu ý: Đảm bảo rằng mỗi tệp đều giữ nguyên tên tệp, bao gồm cả phần mở rộng.

2.Chỉnh sửa tệp **scripts.js** của bạn bằng Trình soạn thảo văn bản, thay thế YOUR_API_GATEWAY_ENDPOINT (ở dòng đầu tiên) bằng **URL Invoke** mà bạn đã sao chép trước đó.

Đầu ra dự kiến:


               var API_ENDPOINT = "https://xxxxx.execute-api.us-west-2.amazonaws.com/Dev"


#### Bây giờ bạn tải các tệp này lên thùng Amazon S3.

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn **S3.**

2.Chọn **Tạo thùng** và cấu hình các thông tin chi tiết sau:

- Tên thùng: **www-BUCKET**
     - Thay thế BUCKET bằng tên thùng bài đăng âm thanh của bạn
     - Sao chép tên nhóm vào trình soạn thảo văn bản. Bạn sẽ sử dụng tên nhóm sau.
- Bạn thay đổi quyền của bucket để mọi người đều có thể truy cập trang web.
- Trong **Quyền sở hữu đối tượng** , chọn **ACL được bật**
- Trong phần **Cài đặt chặn quyền truy cập công khai cho nhóm này**, hãy bỏ chọn tùy chọn Chặn tất cả quyền truy cập công khai , sau đó bỏ chọn tất cả các tùy chọn khác .

**Lưu ý:** Lưu ý tất cả các tùy chọn riêng lẻ vẫn được bỏ chọn. Khi bỏ chọn tất cả quyền truy cập công khai, bạn phải chọn các tùy chọn riêng lẻ áp dụng cho tình huống và mục tiêu bảo mật của mình. Trong môi trường sản xuất, nên sử dụng cài đặt ít quyền hạn nhất có thể.

Một hộp cảnh báo xuất hiện với nội dung: Việc tắt tùy chọn chặn tất cả quyền truy cập công khai có thể khiến bucket này và các đối tượng bên trong trở thành công khai. AWS khuyến nghị bạn nên bật tùy chọn chặn tất cả quyền truy cập công khai, trừ khi quyền truy cập công khai là bắt buộc cho các trường hợp sử dụng cụ thể và đã được xác minh, chẳng hạn như lưu trữ trang web tĩnh.

- Chọn hộp kiểm bên cạnh **Tôi xác nhận rằng các cài đặt hiện tại có thể khiến nhóm này và các đối tượng bên trong trở nên công khai .**

- Chọn **Tạo thùng**

1.Sau khi tạo xong bucket, hãy chọn bucket đó từ danh sách bucket và tải ba tệp lên bucket www mới của bạn .

**Lưu ý:** Các tệp phải được đặt tên là: **index.html** , **scripts.js** và **styles.css**

1.Trên trang nhóm, chọn tab Quyền ở trên cùng.

2.Cuộn xuống phần **Chính sách nhóm** và chọn **Biên tập.**

3.Dán chính sách này vào trình soạn thảo:

        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "PublicReadGetObject",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": [
                        "s3:GetObject"
                    ],
                    "Resource": [
                        "arn:aws:s3:::www-BUCKET/*"
                    ]
                }
            ]
        }


1.Thay thế **www-BUCKET** bằng tên nhóm **www-audioposts** của bạn.

2.Chọn **Lưu thay đổi**.

**CẢNH BÁO:** Nếu bạn nhận được lỗi Chính sách có tài nguyên không hợp lệ , hãy xác nhận rằng bạn đã chỉnh sửa dòng Tài nguyên cho khớp với tên nhóm của mình.

**Lưu ý:** Bạn có thể bỏ qua cảnh báo This bucket has public access . Điều này là cố ý.

Cuối cùng, bạn kích hoạt **dịch vụ lưu trữ trang web tĩnh** , giúp cho bucket hoạt động giống như một trang web tĩnh.

1.Chọn tab **Thuộc tính** .

2.Bỏ qua lỗi **Quyền AWS CloudTrail** .

3.Cuộn xuống phần **Lưu trữ trang web tĩnh** và chọn **Biên tập**.

4.Chọn **Bật** cho dịch vụ lưu trữ trang web tĩnh .

- Tài liệu chỉ mục: index.html
- Tài liệu lỗi: index.html

**Lưu ý:** Hiện tại chúng tôi đang sử dụng tệp index.html làm tài liệu lỗi.

- Chọn: **Lưu thay đổi.**

1.Sao chép URL điểm cuối vào bảng tạm của bạn.

Vậy là xong! Bây giờ bạn có thể kiểm tra xem trang web có hoạt động không.


1.Mở một tab trình duyệt web mới và dán URL Điểm cuối mà bạn vừa sao chép.

Bạn sẽ thấy một trang trông như thế này:
![FWD](/images/lambda14.png)

Nếu bạn viết gì đó vào vùng văn bản và chọn **Nói đi**, sự kiện sẽ được gửi đến ứng dụng của bạn. Ứng dụng sẽ chuyển đổi văn bản thành tệp âm thanh một cách không đồng bộ. Tùy thuộc vào kích thước văn bản bạn cung cấp, quá trình chuyển đổi có thể mất vài giây hoặc vài phút.


Để xem các bài đăng và tệp âm thanh của chúng, hãy nhập ID bài đăng hoặc *vào hộp Tìm kiếm:
![FWD](/images/lambda15.png)

1.Nhấn nút Phát để nghe âm thanh.
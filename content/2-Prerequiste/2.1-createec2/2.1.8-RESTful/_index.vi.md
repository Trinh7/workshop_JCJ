---
title : "Trình bày chức năng Lambda như một dịch vụ web RESTful"
date: "2023-07-15"
weight : 8
chapter : false
pre : " <b> 3.1.8 </b> "
---

Điều cuối cùng bạn cần làm là triển khai logic ứng dụng dưới dạng dịch vụ web RESTful để có thể dễ dàng gọi bằng giao thức HTTP chuẩn. Để làm điều này, bạn sử dụng Amazon API Gateway.

1.Ở đầu **AWS Management Console**, trong thanh tìm kiếm, hãy tìm kiếm và chọn **.API Gateway**

2.Trong bảng điều khiển Rest API , hãy chọn **Xây dựng.**

3.Trong phần **Tạo API REST** , để biết chi tiết về API , hãy sử dụng các tham số sau:

- Chọn **API mới**
- Tên API: **PostReaderAPI**
- Sự miêu tả: **API for PostReader Application**
- Loại điểm cuối: **Khu vực**

1.Chọn **Tạo API.**

Sau khi API được tạo, bạn cần tạo hai **phương thức HTTP .**

#### Bạn bắt đầu bằng cách cấu hình phương thức **POST** để gọi hàm Lambda **PostReader_NewPost** .

1.Trong ngăn Phương pháp , hãy chọn **Tạo phương thức.**

2.Đối với loại **Phương thức** , hãy chọn **POST** .

3.Đối với Hàm Lambda , hãy chọn hàm có chứa **PostReader_NewPost** trong tên.

4.Chọn **Tạo phương thức.**



#### Đối với phương thức **GET** , API sẽ gọi hàm Lambda PostReader_GetPost .

1.Trong ngăn **Tài nguyên** , chọn biểu tượng **/** phía trên **POST** .

2.Trong ngăn Phương pháp , hãy chọn **Tạo phương thức**.

3.Đối với loại **Phương thức** , chọn **GET** .

4.Đối với Hàm Lambda , hãy chọn hàm có chứa **PostReader_GetPost** trong tên.

5.Chọn **Tạo phương thức.**

#### Phương pháp cuối cùng cần cấu hình là CORS (Chia sẻ tài nguyên xuyên nguồn). Phương pháp này cho phép gọi API từ một trang web có tên máy chủ khác.

1.Trong ngăn T**ài nguyên** , chọn biểu tượng **/** phía trên **GET** .

2.Trong ngăn Chi tiết tài nguyên , hãy chọn **Kích hoạt CORS**.

3.Đối với phản hồi của Gateway , hãy chọn Mặc định **4XX** và Mặc định **5XX** .

4.Đối với **Access-Control-Allow-Methods** , hãy chọn **GET và POST** .

5.Chọn **Lưu.**
![FWD](/images/lambda13.png)


#### Bây giờ bạn cấu hình phương thức GET cho tham số truy vấn postId , cung cấp thông tin về id của bài đăng cần trả về.

1.Chọn phương thức **GET** .

2.Trong ngăn **Cài đặt** yêu cầu phương pháp , hãy chọn **Biên tập**.

3.Mở rộng phần tham số chuỗi truy vấn URL .

4.Chọn **Thêm chuỗi truy vấn**.

5.Đối với Tên , nhập .**postId**

6.Chọn **Lưu.**


#### Hàm Lambda PostReader_GetPost dự kiến sẽ nhận dữ liệu đầu vào ở định dạng JSON, do đó, API cần được cấu hình để ánh xạ tham số sang định dạng này. Để thực hiện việc này, bạn có thể thêm ánh xạ vào cấu hình Yêu cầu Tích hợp.

1.Chọn tab **Yêu cầu tích hợp** .

2.Trong ngăn cài đặt **Yêu cầu tích hợp** , hãy chọn **Biên tập.**

3.Đối với **Yêu cầu chuyển tiếp nội dung** , hãy chọn **Khi không có mẫu nào được xác định (được đề xuất) .**

4.Mở rộng **mẫu bản đồ .**

5.Chọn **Thêm mẫu ánh xạ.**

6.Đối với **Loại nội dung** , hãy nhập **.application/json**

7.Đối với **phần thân mẫu** , hãy nhập:

         {
             "postId" : "$input.params('postId')"
         }

1.Chọn **Lưu.**

#### API đã sẵn sàng để triển khai!

1.ChọnTriển khai API.

- **Giai đoạn**: Chọn **Giai đoạn mới**
- **Tên**: Dev
- ChọnTriển khai

1.Sao chép giá trị **Invoke URL** và lưu vào trình soạn thảo văn bản để sử dụng sau.


**Lưu ý:** URL được sử dụng sau này để tương tác với ứng dụng.

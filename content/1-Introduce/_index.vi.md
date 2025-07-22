---
title : "Giới thiệu"
date : "2023-07-15" 
weight : 2
chapter : false
pre : " <b> 2. </b> "
---
**Xây dựng ứng dụng chuyển văn bản thành giọng nói không cần máy chủ với Amazon Polly** 

Nhìn chung, việc tổng hợp giọng nói không hề dễ dàng. Bạn không thể cho rằng khi một ứng dụng đọc từng chữ cái của một câu, kết quả đầu ra sẽ có nghĩa. Một số thách thức thường gặp đối với các ứng dụng chuyển văn bản thành giọng nói bao gồm:

Các từ được viết theo cùng một cách nhưng phát âm khác nhau: Tôi sống ở Las Vegas so với Bài thuyết trình này được phát sóng trực tiếp từ Las Vegas .
Chuẩn hóa văn bản: Phân biệt các từ viết tắt, từ viết tắt và đơn vị: St. , có thể mở rộng thành Street hoặc Saint .
Chuyển đổi văn bản thành âm vị trong các ngôn ngữ có cách ánh xạ phức tạp, chẳng hạn như trong tiếng Anh, tough , through và though . Trong ví dụ này, các phần tương tự của các từ khác nhau có thể được phát âm khác nhau tùy thuộc vào từ và ngữ cảnh.
Từ nước ngoài ( déjà vu ), tên riêng ( François Hollande ) và tiếng lóng ( ASAP , LOL ).
Amazon Polly cung cấp chức năng tổng hợp giọng nói giúp khắc phục những thách thức này, cho phép bạn tập trung vào việc xây dựng các ứng dụng sử dụng công nghệ chuyển văn bản thành giọng nói thay vì giải quyết các thách thức về phiên dịch.

Amazon Polly biến văn bản thành giọng nói chân thực. Nó cho phép bạn tạo các ứng dụng nói chuyện tự nhiên, cho phép bạn xây dựng các danh mục sản phẩm hỗ trợ giọng nói hoàn toàn mới. Amazon Polly là một dịch vụ AI của Amazon sử dụng công nghệ học sâu tiên tiến để tổng hợp giọng nói nghe giống như giọng nói của con người. Hiện tại, nó bao gồm hàng chục giọng nói chân thực với hơn 20 ngôn ngữ, vì vậy bạn có thể chọn giọng nói lý tưởng và xây dựng các ứng dụng hỗ trợ giọng nói hoạt động ở nhiều quốc gia khác nhau.

Ngoài ra, Amazon Polly còn mang đến thời gian phản hồi nhanh chóng, ổn định, cần thiết để hỗ trợ hội thoại tương tác thời gian thực. Bạn có thể lưu trữ đệm và lưu trữ các tệp âm thanh của Polly để phát lại hoặc phân phối lại ngoại tuyến. Nói cách khác, những gì bạn chuyển đổi và lưu trữ là của bạn. Không có thêm phí chuyển đổi văn bản thành giọng nói khi sử dụng giọng nói. Polly cũng rất dễ sử dụng. Bạn chỉ cần gửi văn bản muốn chuyển đổi thành giọng nói đến API Amazon Polly. Amazon Polly sẽ ngay lập tức trả lại luồng âm thanh về ứng dụng của bạn để ứng dụng có thể phát trực tiếp hoặc lưu trữ ở định dạng tệp âm thanh tiêu chuẩn như MP3.

Trong buổi hội thảo này, bạn sẽ tạo một ứng dụng cơ bản, không cần máy chủ, sử dụng Amazon Polly để chuyển đổi văn bản thành giọng nói. Ứng dụng có giao diện người dùng đơn giản, chấp nhận văn bản ở nhiều ngôn ngữ khác nhau và sau đó chuyển đổi thành tệp âm thanh để bạn có thể phát từ trình duyệt web. Buổi hội thảo này sử dụng các bài đăng trên blog, nhưng bạn có thể sử dụng bất kỳ loại văn bản nào. Ví dụ: bạn có thể sử dụng ứng dụng để đọc công thức nấu ăn khi đang chuẩn bị bữa ăn, hoặc đọc tin tức hoặc sách khi đang lái xe hoặc đạp xe.
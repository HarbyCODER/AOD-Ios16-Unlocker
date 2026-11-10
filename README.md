# AODUnlock for RootHide

Bạn đúng: iOS 16 đã có AOD gốc của Apple trên các mẫu được hỗ trợ. Bản trước mình tạo là lớp đồng hồ tự vẽ, không đúng mục tiêu đó. Đây là dự án thay thế: nó thử mở đường AOD gốc bằng cách báo cho SpringBoard và Cài đặt rằng thiết bị hỗ trợ AOD; tweak không tự vẽ màn hình khóa.

## Cách hoạt động

Tweak can thiệp câu trả lời MobileGestalt cho `DeviceSupportsAlwaysOnTime` và `DeviceSupportsAlwaysOnDisplay`, rồi để iOS dựng màn hình khóa AOD nguyên bản. iPhone X có màn OLED, nhưng phần cứng của nó không có màn LTPO 1 Hz như nhóm iPhone có AOD chính thức. Tweak chỉ mở kiểm tra khả năng; nó không thể bổ sung phần cứng đó.

## Pin và lưu ảnh

Có thể bị lưu ảnh/burn-in. Apple cho biết burn-in có thể xảy ra khi ảnh tĩnh tương phản cao được hiển thị liên tục ở độ sáng cao trong thời gian dài. AODUnlock chỉ mở kiểm tra hỗ trợ; nó không tự hạ sáng, tắt hình nền/thông báo, dịch chuyển điểm ảnh hay đặt giới hạn thời gian. Chưa xác minh iOS 16.7.14 có áp dụng đủ các biện pháp nội bộ của AOD trên iPhone X.

Để giảm rủi ro, nếu mục AOD xuất hiện hãy tắt hình nền và thông báo, giảm độ sáng, dùng mặt đồng hồ ít chi tiết và tắt AOD khi không cần—đặc biệt qua đêm. Do iPhone X không có chế độ làm mới 1 Hz, mức hao pin và độ bền tấm nền khi ép AOD không được bảo đảm.

Giới hạn phần mềm ở 1 FPS chỉ làm chậm việc ứng dụng vẽ khung hình; nó không đổi tần số quét vật lý của tấm nền. Apple mô tả `CADisplayLink` là lời yêu cầu về nhịp callback, và hệ thống chọn nhịp dựa trên khả năng phần cứng cùng chính sách hiện tại. Vì tweak này mở AOD gốc thay vì tự vẽ giao diện, nó không thể ép panel iPhone X chạy ở 1 Hz. Để giảm thức CPU, AOD nên giữ nội dung tĩnh, cập nhật đồng hồ mỗi phút và tránh animation thay vì chạy callback mỗi giây.

## Cài và giới hạn

Cần Theos fork có hỗ trợ RootHide. Biên dịch bằng `make package`, cài gói bằng Sileo/Zebra, rồi bật injection cho cả SpringBoard và Cài đặt trong RootHide Bootstrap. Sau respring, kiểm tra Cài đặt > Màn hình & Độ sáng xem có mục Always-On Display hay không.

### Tạo gói `.deb` trên GitHub

Đặt nội dung thư mục này ở thư mục gốc của một GitHub repository. Workflow `.github/workflows/build-deb.yml` sẽ chạy khi push các file tweak hoặc khi chọn **Actions > Build RootHide DEB > Run workflow**. Khi build xong, tải file `.deb` tại mục **Artifacts** của lần chạy đó; artifact được giữ 30 ngày.

Đây là prototype chưa biên dịch hoặc chạy trên iPhone X/iOS 16.7.14. Nó dựa vào các câu hỏi MobileGestalt riêng của iOS; nếu iOS 16.7.x dùng đường kiểm tra khác hoặc đọc đáp án từ cache trước khi tweak được nạp, mục AOD có thể không xuất hiện. Khi đó cần xác nhận luồng kiểm tra trên đúng bản iOS rồi bổ sung hook tương ứng. Chưa nên coi gói này là bản cài đặt đã kiểm chứng.

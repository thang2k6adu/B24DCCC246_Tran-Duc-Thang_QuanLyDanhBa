# BÁO CÁO BÀI TẬP LỚN LẬP TRÌNH DI ĐỘNG (FLUTTER EDITION)
## ĐỀ TÀI: ỨNG DỤNG QUẢN LÝ DANH BẠ LIÊN HỆ

---

### THÔNG TIN SINH VIÊN
* **Họ và tên:** *[Điền Họ và tên của bạn vào đây]*
* **Mã sinh viên (MSSV):** *[Điền Mã sinh viên vào đây]*
* **Lớp:** *[Điền Tên lớp học phần vào đây]*
* **Link Git Repository:** *[Điền Link GitHub/GitLab của bạn vào đây]*

---

## I. TỔNG QUAN DỰ ÁN
* **Nền tảng & Framework:** **Flutter 3.47.1** (Dart 3.13.1), hỗ trợ chạy đa nền tảng (Android, iOS, Web, Windows).
* **Phong cách UI:** **Modern iOS 17 Bento & Frosted Glass (Deep Slate & Pure Mint)**:
  * Nền tối OLED thời thượng (`#0A0E1A`), các khối thẻ Bento bo tròn lớn (`20px` - `24px`) với viền mờ cao cấp (`#26354D`).
  * Màu chủ đạo: Xanh ngọc bích Emerald / Mint (`#10B981`) và Cyan (`#06B6D4`).
  * Khối thống kê Bento bất đối xứng (Bento Stats Cards).
  * Thanh trượt giới tính chuẩn iOS `CupertinoSlidingSegmentedControl`.
  * Công tắc gạt `CupertinoSwitch` cho trạng thái yêu thích.
  * Hiệu ứng chuyển cảnh mượt mà `Hero Animation` giữa danh sách và chi tiết.
* **Kiến trúc quản lý trạng thái:** `ChangeNotifier` quản lý kho dữ liệu in-memory `List<Contact>`, kết hợp điều hướng qua lại giữa 4 màn hình bằng Navigator/Routes.

---

## II. NỘI DUNG CHI TIẾT 4 MÀN HÌNH

### 1. Màn hình 1: Đăng nhập (`LoginScreen`)

#### 1.1. Hình ảnh chụp màn hình thực tế

| Giao diện Đăng nhập | Trường hợp báo lỗi (bỏ trống hoặc sai mật khẩu) |
| :---: | :---: |
| *(Dán ảnh chụp màn hình đăng nhập lúc ban đầu vào đây)* | *(Dán ảnh chụp màn hình khi bấm đăng nhập báo lỗi vào đây)* |
| *Hình 1.1. Giao diện Đăng nhập Bento* | *Hình 1.2. Thông báo lỗi khi nhập sai hoặc để trống* |

---

#### 1.2. Mô tả chi tiết kỹ thuật đã thực hiện
* **Thành phần giao diện:**
  * Logo Hero bo tròn gradient xanh ngọc với hiệu ứng đổ bóng phát sáng (Glow shadow).
  * Tiêu đề ứng dụng lớn font đậm và phụ đề hướng dẫn.
  * Thẻ Bento Card chứa:
    * Ô nhập **Tên đăng nhập** (`TextField`): bo góc `16px`, icon người dùng.
    * Ô nhập **Mật khẩu** (`TextField`): icon ổ khóa, hỗ trợ nút bấm con mắt bật/tắt ẩn hiện ký tự (`_obscurePassword`).
    * Dòng thông báo lỗi màu đỏ mềm kèm icon cảnh báo khi thông tin không hợp lệ.
    * Nút **Đăng nhập** dạng Gradient bo góc 16px.
* **Khai báo tài khoản cố định:**
  ```dart
  static const String _fixedUsername = 'admin';
  static const String _fixedPassword = '123456';
  ```
* **Xử lý sự kiện đăng nhập:**
  * Kiểm tra bỏ trống: Nếu username hoặc password rỗng -> gán `_errorMessage = 'Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu'`.
  * Nếu không khớp với `admin` / `123456` -> gán `_errorMessage = 'Sai tên đăng nhập hoặc mật khẩu'`.
  * Nếu hợp lệ -> Dùng `Navigator.pushReplacementNamed(context, '/contacts')` để chuyển sang màn hình danh bạ và hủy màn đăng nhập khỏi ngăn xếp, người dùng bấm phím Back sẽ không quay lại được.

---

### 2. Màn hình 2: Danh sách liên hệ & Thống kê (`ContactListScreen`)

#### 2.1. Hình ảnh chụp màn hình thực tế

| Danh sách ban đầu kèm Bento Stats | Sau khi chạm đổi dấu sao Yêu thích |
| :---: | :---: |
| *(Dán ảnh danh sách 3 liên hệ mẫu & 2 thẻ Bento thống kê)* | *(Dán ảnh sau khi bấm đổi sao yêu thích, số liệu tự nhảy)* |
| *Hình 2.1. Danh bạ và Bento Stats ban đầu* | *Hình 2.2. Trạng thái cập nhật sau khi đổi yêu thích* |

---

#### 2.2. Mô tả chi tiết kỹ thuật đã thực hiện
* **Thành phần giao diện:**
  * **Header Large Title:** "Danh Bạ" với badge đếm số lượng trực tiếp.
  * **Khối thống kê Bento (Bento Stats Section):**
    * Thẻ 1: "TỔNG LIÊN HỆ" (hiển thị số lớn, icon nhóm bạn neon).
    * Thẻ 2: "YÊU THÍCH" (hiển thị số lượng sao vàng gold).
  * **Danh sách liên hệ (`SliverList`):**
    * Mỗi item là một thẻ Bento bo cong `20px` với viền mờ.
    * Avatar tròn gradient chứa chữ cái đầu tiên của tên (được bao bọc trong `Hero` widget để tạo hiệu ứng phóng to/thu nhỏ mượt mà).
    * Họ tên đậm nét, số điện thoại rõ ràng.
    * Chip badge phân nhóm hình viên thuốc (Gia đình, Bạn bè, Công việc, Khác) với màu sắc riêng biệt.
    * Icon ngôi sao: chạm trực tiếp để bật/tắt yêu thích.
  * **Floating Action Button:** Nút tròn nổi bo mềm dạng viên thuốc "+ Thêm liên hệ".
* **Dữ liệu mẫu ban đầu:**
  Khởi tạo 3 liên hệ mẫu trong `ContactRepository`:
  1. Nguyễn Văn An | `0901234567` | Bạn bè | Nam | Không yêu thích | Ghi chú: "Bạn thân thời đại học."
  2. Trần Thị Bình | `0912345678` | Gia đình | Nữ | Có yêu thích | Ghi chú: "Chị gái ruột."
  3. Lê Minh Châu | `0987654321` | Công việc | Nam | Không yêu thích | Ghi chú: "Quản lý dự án Android."
* **Đồng bộ dữ liệu thời gian thực:**
  * Sử dụng `AnimatedBuilder` lắng nghe sự kiện từ `ContactRepository`. Mỗi khi có thao tác thêm, xóa hoặc toggle yêu thích, toàn bộ giao diện và 2 khối thống kê đều được cập nhật tức thì.

---

### 3. Màn hình 3: Thêm liên hệ mới (`AddContactScreen`)

#### 3.1. Hình ảnh chụp màn hình thực tế

| Nhập liệu báo lỗi (bỏ trống/sai SĐT/trùng SĐT) | Nhập liệu đầy đủ & Lưu thành công |
| :---: | :---: |
| *(Dán ảnh khi nhập thiếu hoặc sai SĐT/trùng số)* | *(Dán ảnh form nhập hợp lệ và thanh thông báo thành công)* |
| *Hình 3.1. Bắt lỗi validation form* | *Hình 3.2. Lưu liên hệ mới thành công* |

---

#### 3.2. Mô tả chi tiết kỹ thuật đã thực hiện
* **Thành phần giao diện:**
  * Thanh AppBar iOS có nút "Hủy" và tiêu đề "Thêm liên hệ".
  * Khối Bento 1: Ô **Họ và tên** (`TextField`) và ô **Số điện thoại** (`keyboardType: TextInputType.phone`).
  * Khối Bento 2:
    * **Nhóm liên hệ:** Menu thả xuống (`DropdownButton`) với 4 lựa chọn (*Gia đình, Bạn bè, Công việc, Khác*).
    * **Giới tính:** Thanh trượt đa năng chuẩn iOS `CupertinoSlidingSegmentedControl` gồm 3 tùy chọn (*Nam, Nữ, Khác* - mặc định là Nam).
  * Khối Bento 3:
    * Công tắc gạt `CupertinoSwitch` "Đánh dấu yêu thích".
    * Ô **Ghi chú** đa dòng (`maxLines: 3`).
  * Nút "Lưu liên hệ" dạng Gradient tràn viền.
* **Xử lý kiểm tra dữ liệu:**
  * **Họ tên không được để trống:** `name.isEmpty` -> báo lỗi.
  * **Số điện thoại 10 số bắt đầu bằng 0:** Sử dụng biểu thức chính quy `RegExp(r'^0[0-9]{9}$')`.
  * **Chống trùng số điện thoại:** Gọi `repository.isPhoneExists(phone)`.
  * Khi lưu hợp lệ: Khởi tạo đối tượng `Contact`, gọi `repository.addContact(newContact)`, hiển thị `SnackBar` thành công và `Navigator.pop(context)` trở về danh sách.

---

### 4. Màn hình 4: Chi tiết liên hệ (`ContactDetailScreen`)

#### 4.1. Hình ảnh chụp màn hình thực tế

| Giao diện Chi tiết liên hệ | Màn hình cuộc gọi (ACTION_DIAL) | Hộp thoại xác nhận Xóa liên hệ |
| :---: | :---: | :---: |
| *(Dán ảnh chi tiết thông tin, avatar)* | *(Dán ảnh ứng dụng gọi điện khi bấm Gọi)* | *(Dán ảnh hộp thoại xác nhận xóa)* |
| *Hình 4.1. Chi tiết thông tin liên hệ* | *Hình 4.2. Kích hoạt cuộc gọi qua tel:* | *Hình 4.3. Xác nhận xóa liên hệ* |

---

#### 4.2. Mô tả chi tiết kỹ thuật đã thực hiện
* **Thành phần giao diện:**
  * **Hero Avatar Profile:** Avatar tròn cỡ lớn 90px hiển thị chữ cái đầu, tên liên hệ và badge nhóm.
  * Thẻ Bento Số điện thoại.
  * Thẻ Bento Phân loại nhóm và Giới tính.
  * Thẻ Bento Ghi chú (nếu trống hiển thị "Không có ghi chú nào").
  * Thẻ Bento `CupertinoSwitch` trạng thái Yêu thích (cho phép đổi trực tiếp).
  * **Nút Gọi điện:** Nút gradient xanh ngọc với icon cuộc gọi.
  * **Nút Quay lại & Nút Xóa:** Cặp nút bo góc hiện đại.
* **Xử lý gọi điện:**
  * Sử dụng thư viện `url_launcher` mở giao thức `tel:<số_điện_thoại>`:
  ```dart
  final uri = Uri.parse('tel:$phone');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
  ```
* **Xử lý xóa liên hệ:**
  * Hiển thị hộp thoại phong cách Apple `CupertinoAlertDialog` hỏi người dùng: "Bạn có chắc chắn muốn xóa liên hệ này khỏi danh bạ?". Nếu bấm "Xóa" thì gọi `repository.deleteContact(id)`, hiển thị thông báo và đóng màn hình trở về danh bạ.

---

## III. TỔNG KẾT & ĐÁNH GIÁ MỨC ĐỘ HOÀN THÀNH

| STT | Yêu cầu trong đề bài | Tình trạng | Ghi chú trên bản Flutter |
| :---: | :--- | :---: | :--- |
| 1 | Màn hình Đăng nhập (admin/123456, báo lỗi rỗng/sai, không back lại được) | **100% Hoàn thành** | Đã triển khai bằng `LoginScreen`. |
| 2 | Màn hình Danh sách (đủ thông tin, avatar chữ cái đầu, badge nhóm, sao yêu thích) | **100% Hoàn thành** | Sử dụng phong cách Bento Card & Hero Animation. |
| 3 | Khối thống kê (Tổng liên hệ & Yêu thích tự cập nhật) | **100% Hoàn thành** | Tự động tính toán qua `ChangeNotifier`. |
| 4 | Màn hình Thêm liên hệ (đủ thành phần, regex 10 số bắt đầu bằng 0, chống trùng SĐT) | **100% Hoàn thành** | Tích hợp `CupertinoSlidingSegmentedControl` & `CupertinoSwitch`. |
| 5 | Màn hình Chi tiết (đủ thông tin, nút gọi điện, đổi yêu thích, xóa liên hệ) | **100% Hoàn thành** | Gọi điện qua `url_launcher` và hộp thoại `CupertinoAlertDialog`. |
| 6 | Unit Test tự động | **100% Hoàn thành** | Vượt qua **6/6 test** (`All tests passed!`). |

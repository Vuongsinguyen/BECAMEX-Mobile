# Đặc tả tính năng: Đăng nhập bằng Email và Mật khẩu

## Mục tiêu
Người dùng có thể đăng nhập vào ứng dụng bằng email và mật khẩu đã đăng ký trên hệ thống.

## Luồng chức năng
1. Người dùng nhập email và mật khẩu vào form đăng nhập.
2. Nhấn nút "Đăng nhập".
3. Ứng dụng gửi request đến API xác thực (Supabase hoặc API backend).
4. Nếu thông tin hợp lệ, chuyển sang màn hình chính của app.
5. Nếu sai thông tin, hiển thị thông báo lỗi.

## Yêu cầu giao diện
- Form gồm 2 trường: Email, Mật khẩu (ẩn ký tự).
- Nút "Đăng nhập".
- Hiển thị thông báo lỗi khi đăng nhập thất bại.

## Yêu cầu kỹ thuật
- Sử dụng API xác thực đã có (Supabase/Auth API).
- Xử lý trạng thái loading khi đang gửi request.
- Bảo mật: Không lưu mật khẩu dưới dạng plain text.

## API mẫu
```
POST /auth/login
{
  "email": "user@example.com",
  "password": "your_password"
}
```

## Kết quả trả về
- Thành công: Token, thông tin user.
- Thất bại: Thông báo lỗi (sai email/mật khẩu).

## Ghi chú
- Có thể bổ sung tính năng "Quên mật khẩu" sau.

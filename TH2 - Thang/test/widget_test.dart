import 'package:flutter_test/flutter_test.dart';
import 'package:quan_ly_danh_ba/data/contact_repository.dart';
import 'package:quan_ly_danh_ba/main.dart';

void main() {
  testWidgets('Khởi chạy ứng dụng hiển thị màn hình đăng nhập', (WidgetTester tester) async {
    final repository = ContactRepository();
    await tester.pumpWidget(ContactManagerApp(repository: repository));

    expect(find.text('Quản Lý Danh Bạ'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:quan_ly_danh_ba/data/contact_repository.dart';
import 'package:quan_ly_danh_ba/models/contact.dart';

void main() {
  late ContactRepository repository;

  setUp(() {
    repository = ContactRepository();
  });

  test('Kiểm tra dữ liệu mẫu ban đầu theo đề bài', () {
    expect(repository.contacts.length, 3);
    expect(repository.totalCount, 3);
    expect(repository.favoriteCount, 1);

    expect(repository.isPhoneExists('0901234567'), true);
    expect(repository.isPhoneExists('0912345678'), true);
    expect(repository.isPhoneExists('0987654321'), true);
  });

  test('Kiểm tra thuật toán trích xuất chữ cái đầu của tên', () {
    final c1 = Contact(
      id: '1',
      name: 'Nguyễn Văn An',
      phone: '0901234567',
      group: 'Bạn bè',
      gender: 'Nam',
      isFavorite: false,
      notes: '',
    );
    expect(c1.initialLetter, 'A');

    final c2 = Contact(
      id: '2',
      name: 'Trần Thị Bình',
      phone: '0912345678',
      group: 'Gia đình',
      gender: 'Nữ',
      isFavorite: true,
      notes: '',
    );
    expect(c2.initialLetter, 'B');

    final c3 = Contact(
      id: '3',
      name: 'Lê Minh Châu',
      phone: '0987654321',
      group: 'Công việc',
      gender: 'Nam',
      isFavorite: false,
      notes: '',
    );
    expect(c3.initialLetter, 'C');
  });

  test('Kiểm tra thêm liên hệ và chống trùng số điện thoại', () {
    final newContact = Contact(
      id: '100',
      name: 'Vũ Đức Huy',
      phone: '0933333333',
      group: 'Bạn bè',
      gender: 'Nam',
      isFavorite: true,
      notes: 'Ghi chú test',
    );
    repository.addContact(newContact);

    expect(repository.totalCount, 4);
    expect(repository.favoriteCount, 2);
    expect(repository.isPhoneExists('0933333333'), true);
    expect(repository.isPhoneExists('0933333333', excludeId: '100'), false);
  });

  test('Kiểm tra đổi trạng thái yêu thích', () {
    repository.toggleFavorite('1');
    expect(repository.getContactById('1')!.isFavorite, true);
    expect(repository.favoriteCount, 2);

    repository.toggleFavorite('1');
    expect(repository.getContactById('1')!.isFavorite, false);
    expect(repository.favoriteCount, 1);
  });

  test('Kiểm tra xóa liên hệ khỏi repository', () {
    final success = repository.deleteContact('1');
    expect(success, true);
    expect(repository.totalCount, 2);
    expect(repository.isPhoneExists('0901234567'), false);
  });
}

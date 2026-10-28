import 'package:flutter/foundation.dart';
import '../models/contact.dart';

class ContactRepository extends ChangeNotifier {
  final List<Contact> _contacts = [];

  ContactRepository() {
    _initSampleData();
  }

  List<Contact> get contacts => List.unmodifiable(_contacts);

  int get totalCount => _contacts.length;

  int get favoriteCount => _contacts.where((c) => c.isFavorite).length;

  void _initSampleData() {
    _contacts.addAll([
      Contact(
        id: '1',
        name: 'Nguyễn Văn An',
        phone: '0901234567',
        group: 'Bạn bè',
        gender: 'Nam',
        isFavorite: false,
        notes: 'Bạn thân thời đại học.',
      ),
      Contact(
        id: '2',
        name: 'Trần Thị Bình',
        phone: '0912345678',
        group: 'Gia đình',
        gender: 'Nữ',
        isFavorite: true,
        notes: 'Chị gái ruột.',
      ),
      Contact(
        id: '3',
        name: 'Lê Minh Châu',
        phone: '0987654321',
        group: 'Công việc',
        gender: 'Nam',
        isFavorite: false,
        notes: 'Quản lý dự án Android.',
      ),
    ]);
  }

  void addContact(Contact contact) {
    _contacts.insert(0, contact);
    notifyListeners();
  }

  Contact? getContactById(String id) {
    try {
      return _contacts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  bool deleteContact(String id) {
    final index = _contacts.indexWhere((c) => c.id == id);
    if (index != -1) {
      _contacts.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  void toggleFavorite(String id) {
    final contact = getContactById(id);
    if (contact != null) {
      contact.isFavorite = !contact.isFavorite;
      notifyListeners();
    }
  }

  void setFavorite(String id, bool isFavorite) {
    final contact = getContactById(id);
    if (contact != null && contact.isFavorite != isFavorite) {
      contact.isFavorite = isFavorite;
      notifyListeners();
    }
  }

  bool isPhoneExists(String phone, {String? excludeId}) {
    final cleanPhone = phone.trim();
    return _contacts.any((c) => c.id != excludeId && c.phone.trim() == cleanPhone);
  }
}

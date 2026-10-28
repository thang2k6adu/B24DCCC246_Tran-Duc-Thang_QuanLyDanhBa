import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/contact_repository.dart';
import '../models/contact.dart';
import '../theme/app_theme.dart';

class AddContactScreen extends StatefulWidget {
  final ContactRepository repository;

  const AddContactScreen({super.key, required this.repository});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedGroup = 'Bạn bè';
  String _selectedGender = 'Nam';
  bool _isFavorite = false;

  String? _nameError;
  String? _phoneError;

  final List<String> _groups = ['Gia đình', 'Bạn bè', 'Công việc', 'Khác'];

  void _handleSave() {
    setState(() {
      _nameError = null;
      _phoneError = null;
    });

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final notes = _notesController.text.trim();

    // 1. Kiểm tra rỗng Họ và tên
    if (name.isEmpty) {
      setState(() {
        _nameError = 'Họ và tên không được để trống';
      });
      return;
    }

    // 2. Kiểm tra số điện thoại: 10 chữ số, bắt đầu bằng 0
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    if (phone.isEmpty || !phoneRegex.hasMatch(phone)) {
      setState(() {
        _phoneError = 'Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0';
      });
      return;
    }

    // 3. Kiểm tra số điện thoại đã tồn tại trong danh bạ chưa
    if (widget.repository.isPhoneExists(phone)) {
      setState(() {
        _phoneError = 'Số điện thoại này đã tồn tại trong danh bạ';
      });
      return;
    }

    // Tạo đối tượng Contact mới và lưu
    final newContact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      group: _selectedGroup,
      gender: _selectedGender,
      isFavorite: _isFavorite,
      notes: notes,
    );

    widget.repository.addContact(newContact);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Text('Đã thêm liên hệ thành công'),
          ],
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Hủy',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          ),
        ),
        leadingWidth: 70,
        title: const Text(
          'Thêm liên hệ',
          style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bento Input Group 1: Name & Phone
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  // Họ và tên
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Họ và tên *',
                      labelStyle: const TextStyle(color: AppTheme.textSecondary),
                      prefixIcon: const Icon(Icons.person_outline_rounded, color: AppTheme.primary),
                      errorText: _nameError,
                      filled: true,
                      fillColor: AppTheme.surfaceElevated,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Số điện thoại
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại *',
                      labelStyle: const TextStyle(color: AppTheme.textSecondary),
                      prefixIcon: const Icon(Icons.phone_outlined, color: AppTheme.primary),
                      errorText: _phoneError,
                      filled: true,
                      fillColor: AppTheme.surfaceElevated,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Bento Group 2: Nhóm & Giới tính
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nhóm
                  const Text(
                    'NHÓM LIÊN HỆ',
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGroup,
                        isExpanded: true,
                        dropdownColor: AppTheme.surfaceElevated,
                        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
                        items: _groups.map((group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppTheme.getGroupTextColor(group),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(group),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedGroup = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Giới tính (Cupertino Segmented Control)
                  const Text(
                    'GIỚI TÍNH',
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<String>(
                      backgroundColor: AppTheme.surfaceElevated,
                      thumbColor: AppTheme.primary,
                      groupValue: _selectedGender,
                      children: const {
                        'Nam': Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Nam', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        'Nữ': Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Nữ', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        'Khác': Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Khác', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      },
                      onValueChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedGender = val);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Bento Group 3: Yêu thích & Ghi chú
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.star_rounded, color: AppTheme.starActive, size: 24),
                          SizedBox(width: 10),
                          Text(
                            'Đánh dấu yêu thích',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        activeColor: AppTheme.starActive,
                        value: _isFavorite,
                        onChanged: (val) {
                          setState(() => _isFavorite = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Ghi chú (không bắt buộc)',
                      labelStyle: const TextStyle(color: AppTheme.textSecondary),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 44),
                        child: Icon(Icons.notes_rounded, color: AppTheme.primary),
                      ),
                      filled: true,
                      fillColor: AppTheme.surfaceElevated,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Nút Lưu
            Container(
              height: 54,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.accentCyan],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Lưu liên hệ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

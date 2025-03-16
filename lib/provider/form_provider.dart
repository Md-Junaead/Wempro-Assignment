// 2. UPDATED FORM PROVIDER (lib/providers/form_provider.dart)
import 'package:flutter/foundation.dart';
import '../models/attribute.dart';

class FormProvider with ChangeNotifier {
  late List<Attribute> _attributes;
  final _formData = <String, dynamic>{};
  String? _errorMessage;

  List<Attribute> get attributes => _attributes;
  Map<String, dynamic> get formData => _formData;
  String? get errorMessage => _errorMessage;

  Future<void> loadFormData() async {
    try {
      final response = await ApiService.getFormAttributes();
      _attributes = response.jsonResponse.attributes;

      // Initialize default values
      for (final attr in _attributes) {
        if (attr.type == 'checkbox') {
          _formData[attr.id] = attr.options.contains('Yes') ? ['Yes'] : [];
        } else if (attr.selected != null) {
          _formData[attr.id] = attr.selected;
        } else if (attr.type == 'radio' && attr.options.isNotEmpty) {
          _formData[attr.id] = attr.options.first;
        }
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load form: $e';
    }
    notifyListeners();
  }

  void updateField(String id, dynamic value) {
    if (value != null) {
      _formData[id] = value;
    }
    notifyListeners();
  }

  bool validateForm() {
    bool isValid = true;

    for (final attr in _attributes) {
      if (_formData[attr.id] == null ||
          (attr.type == 'checkbox' && (_formData[attr.id] as List).isEmpty)) {
        isValid = false;
      }
    }

    return isValid;
  }
}

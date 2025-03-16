// 5. VALIDATION IMPROVEMENTS (lib/widgets/text_input_field.dart)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attribute.dart';
import '../providers/form_provider.dart';

class TextInputField extends StatelessWidget {
  final Attribute attribute;

  const TextInputField({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: attribute.title,
                hintText: attribute.placeholder,
                border: OutlineInputBorder(),
                errorText: provider.validateForm() &&
                        (provider.formData[attribute.id] ?? '').isEmpty
                    ? 'This field is required'
                    : null,
              ),
              onChanged: (value) => provider.updateField(attribute.id, value),
              initialValue: provider.formData[attribute.id] ?? '',
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

// 4. PERFECT CHECKBOX IMPLEMENTATION (lib/widgets/checkbox_group.dart)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attribute.dart';
import '../providers/form_provider.dart';

class CheckboxGroup extends StatelessWidget {
  final Attribute attribute;

  const CheckboxGroup({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        final currentValues = List<String>.from(
          provider.formData[attribute.id] ?? [],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                attribute.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ...attribute.options.map((option) => CheckboxListTile(
                  title: Text(option),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  value: currentValues.contains(option),
                  onChanged: (bool? checked) {
                    List<String> newValues = [];

                    // Handle Yes/No exclusive logic
                    if (attribute.options.length == 2) {
                      newValues = checked! ? [option] : [];
                    } else {
                      newValues = List.from(currentValues);
                      checked!
                          ? newValues.add(option)
                          : newValues.remove(option);
                    }

                    provider.updateField(attribute.id, newValues);
                  },
                )),
            if (provider.validateForm() && currentValues.isEmpty)
              Text(
                'This field is required',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

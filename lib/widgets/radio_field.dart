import 'package:assignment/provider/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attribute.dart';

class RadioField extends StatelessWidget {
  final Attribute attribute;

  const RadioField({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        return FormField<String>(
          validator: (value) => value == null ? 'Required field' : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attribute.title, style: const TextStyle(fontSize: 16)),
              ...attribute.options.map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: provider.formData[attribute.id],
                    onChanged: (value) {
                      provider.updateField(attribute.id, value);
                      field.didChange(value);
                    },
                  )),
              if (field.hasError)
                Text(field.errorText!,
                    style: const TextStyle(color: Colors.red)),
            ],
          ),
        );
      },
    );
  }
}

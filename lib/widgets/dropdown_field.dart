import 'package:assignment/provider/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attribute.dart';

class DropdownField extends StatelessWidget {
  final Attribute attribute;

  const DropdownField({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FormField<String>(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select ${attribute.title}';
              }
              return null;
            },
            builder: (formFieldState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: attribute.title,
                      border: const OutlineInputBorder(),
                      errorText: formFieldState.errorText,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: provider.formData[attribute.id] ??
                            attribute.selected,
                        isExpanded: true,
                        items: attribute.options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          provider.updateField(attribute.id, newValue);
                          formFieldState.didChange(newValue);
                        },
                      ),
                    ),
                  ),
                  if (formFieldState.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        formFieldState.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

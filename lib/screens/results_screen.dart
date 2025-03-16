import 'package:assignment/provider/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.formData.length,
        itemBuilder: (context, index) {
          final key = provider.formData.keys.elementAt(index);
          final value = provider.formData[key];
          final attribute = provider.attributes.firstWhere((a) => a.id == key);

          return ListTile(
            title: Text(attribute.title),
            subtitle: Text(
              value is List ? value.join(', ') : value.toString(),
            ),
          );
        },
      ),
    );
  }
}

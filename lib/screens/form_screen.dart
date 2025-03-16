// 3. COMPLETE FORM SCREEN (lib/screens/form_screen.dart)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormProvider>().loadFormData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        if (provider.attributes.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(title: Text('Cleaning Service Form')),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                ...provider.attributes.map((attr) => _buildField(attr)),
                _buildSubmitButton(context, provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(Attribute attr) {
    switch (attr.type) {
      case 'radio':
        return RadioField(attribute: attr);
      case 'dropdown':
        return DropdownField(attribute: attr);
      case 'checkbox':
        return CheckboxGroup(attribute: attr);
      case 'textfield':
        return TextInputField(attribute: attr);
      default:
        return SizedBox();
    }
  }

  Widget _buildSubmitButton(BuildContext context, FormProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          if (provider.validateForm()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please fill all required fields')),
            );
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}

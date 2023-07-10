import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.query,
    required this.onSearch,
    required this.placeholder,
    required this.controller,
  });

  final String query;
  final VoidCallback onSearch;
  final String? placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        hintText: placeholder,
        suffixIcon: IconButton(
          onPressed: onSearch,
          icon: const Icon(Icons.search),
        ),
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
    );
  }
}

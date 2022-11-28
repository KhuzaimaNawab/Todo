import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onPressed;
  const TodoFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTitle(),
        const SizedBox(
          height: 8,
        ),
        buildDescirption(),
        const SizedBox(
          height: 15,
        ),
        buildButton(),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        initialValue: title,
        onChanged: onChangedTitle,
        maxLines: 1,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );
  Widget buildDescirption() => TextFormField(
        initialValue: description,
        onChanged: onChangedDescription,
        maxLines: 3,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );
  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: const Text('Save'),
        ),
      );
}

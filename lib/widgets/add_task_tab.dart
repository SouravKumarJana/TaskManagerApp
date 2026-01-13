import 'package:flutter/material.dart';

class AddTaskTab extends StatefulWidget {
  final void Function(String title, DateTime dateTime) onAdd;

  const AddTaskTab({super.key, required this.onAdd});

  @override
  State<AddTaskTab> createState() => _AddTaskTabState();
}

class _AddTaskTabState extends State<AddTaskTab> {
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedDateTime;

  Future<void> pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void submitTask() {
    if (titleController.text.isEmpty || selectedDateTime == null) return;

    widget.onAdd(titleController.text, selectedDateTime!);

    titleController.clear();
    setState(() => selectedDateTime = null);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: pickDateTime,
            child: const Text('Select Date & Time'),
          ),

          if (selectedDateTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Selected: '
                '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} '
                '${selectedDateTime!.hour}:${selectedDateTime!.minute.toString().padLeft(2, '0')}',
              ),
            ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: submitTask,
              child: const Text('Add Task'),
            ),
          ),
        ],
      ),
    );
  }
}

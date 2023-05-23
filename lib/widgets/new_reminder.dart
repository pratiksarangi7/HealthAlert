import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class Reminder extends StatefulWidget {
  final Function(DateTime reminder) addNewReminder;

  const Reminder({super.key, required this.addNewReminder});

  @override
  State<Reminder> createState() => ReminderState();
}

class ReminderState extends State<Reminder> {
  DateTime? reminder = null;
  var _buttonEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      height: 50,
      child: Row(children: [
        const SizedBox(
          width: 7,
        ),
        Expanded(
            child: Text(
          reminder == null
              ? 'Add a reminder'
              : DateFormat('EE, MMMM d, yyyy: hh:mm a').format(reminder!),
          style: const TextStyle(fontSize: 17),
        )),
        TextButton.icon(
          onPressed: _buttonEnabled
              ? () async {
                  DateTime? dateTime =
                      await showOmniDateTimePicker(context: context);
                  if (dateTime == null) {
                    return;
                  }
                  setState(() {
                    reminder = dateTime;
                    _buttonEnabled = false;
                  });
                  widget.addNewReminder(reminder!);
                }
              : null,
          icon: Icon(reminder == null ? Icons.alarm_add_outlined : Icons.done),
          label: Text(
            reminder == null ? "Add A Reminder" : "Added",
          ),
        )
      ]),
    );
  }
}

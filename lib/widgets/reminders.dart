import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class Reminders extends StatefulWidget {
  final Function(DateTime reminder) addNewReminder;
  final List<DateTime> reminderData;

  const Reminders({
    super.key,
    required this.addNewReminder,
    required this.reminderData,
  });

  @override
  State<Reminders> createState() => ReminderState();
}

class ReminderState extends State<Reminders> {
  DateTime? reminder;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (70 * (widget.reminderData.length + 1)).toDouble(),
      child: Column(
        children: [
          // old reminders:
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(13),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    DateFormat('EEEE, d MMMM yyyy, hh:mm a')
                        .format(widget.reminderData[index]),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            itemCount: widget.reminderData.length,
          ),
          const SizedBox(
            height: 10,
          ),
          // new reminder:
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () async {
                      DateTime? newReminderDateTime =
                          await showOmniDateTimePicker(context: context);
                      if (newReminderDateTime == null) {
                        return;
                      }
                      setState(() {
                        widget.reminderData.add(newReminderDateTime);
                      });
                    },
                    icon: const Icon(Icons.add_alarm_rounded),
                    label: const Text("Add new reminder"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

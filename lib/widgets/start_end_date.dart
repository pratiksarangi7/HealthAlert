import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class StartOrEndButton extends StatefulWidget {
  final String dateContent;
  final Function(DateTime date) updateDateContent;

  const StartOrEndButton(
      {super.key, required this.dateContent, required this.updateDateContent});

  @override
  State<StartOrEndButton> createState() => _StartOrEndButtonState();
}

class _StartOrEndButtonState extends State<StartOrEndButton> {
  String _currentDateContent = '';
  @override
  void initState() {
    _currentDateContent = widget.dateContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // controls the position of the shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55,
      child: ElevatedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          onPressed: () async {
            var dateData = await showOmniDateTimePicker(context: context);
            if (dateData == null) {
              return;
            }
            setState(() {
              _currentDateContent = DateFormat('dd/MM/yyyy').format(dateData);
            });
            widget.updateDateContent(dateData);
          },
          label: Text(_currentDateContent),
          icon: const Icon(Icons.calendar_month)),
    );
  }
}

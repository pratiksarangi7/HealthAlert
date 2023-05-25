import 'package:flutter/material.dart';
import 'package:medico_app/widgets/custom_drop_down.dart';
import 'package:medico_app/widgets/item_card.dart';
import 'package:medico_app/widgets/reminders.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AddMedicoItemScreen extends StatefulWidget {
  const AddMedicoItemScreen({super.key});

  @override
  State<AddMedicoItemScreen> createState() => _AddMedicoItemScreenState();
}

class _AddMedicoItemScreenState extends State<AddMedicoItemScreen> {
  void _addAReminder(value) {
    reminders.add(value);
  }

  var _hintText = '';
  var _descriptionController = TextEditingController();
  var selectedValue = '1 per day';
  late List<bool> tappedData = List.generate(items.length, (index) => false);
  final List<DateTime> reminders = [];
  final List<String> hintTextData = [
    'Provide appointment details',
    'Enter medicine name',
    'Specify injection/vaccine name',
    'Describe checkup name',
    'Name the exercise',
    'Enter healthcare task',
  ];
  final List<String> beforeOrAfterFood = [
    'not chosen',
    'Before food',
    'After food',
    'any time',
  ];
  final List<String> dosageData = [
    'not chosen',
    '1 per day',
    '2 per day',
    '3 per day',
    '4/more per day',
  ];

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/doctorappointment.jpg',
      'label': 'appointment',
    },
    {
      'image': 'assets/pills.png',
      'label': 'Medicine',
    },
    {
      'image': 'assets/injection.png',
      'label': 'Injection',
    },
    {
      'image': 'assets/checkup.png',
      'label': 'Checkup',
    },
    {
      'image': 'assets/fitness.png',
      'label': 'fitness',
    },
    {
      'image': 'assets/others.png',
      'label': 'others',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 4, 104, 130),
                  Color.fromARGB(255, 80, 250, 208)
                ], // Replace with your desired colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Add Item",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "   Select category: ",
                style: TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 150,
                      child: InkWell(
                        child: ItemCard(
                          image: items[index]['image'],
                          label: items[index]['label'],
                          isTapped: tappedData[index],
                        ),
                        onTap: () {
                          setState(() {
                            _hintText = hintTextData[index];
                            tappedData[index] = true;
                            for (int i = 0; i < items.length; i++) {
                              if (i != index) {
                                tappedData[i] = false;
                              }
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: _screenWidth * 0.9,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 21),
                      decoration: InputDecoration(
                        hintText: _hintText,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Select dosage: ',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  DropDown(dropDownItems: dosageData),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "  Before/After food",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  DropDown(dropDownItems: beforeOrAfterFood),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Specify medication duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // controls the position of the shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 55,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  7), // Set your desired border radius here
                            ),
                          ),
                        ),
                        onPressed: () {
                          showOmniDateTimePicker(context: context);
                        },
                        label: const Text("Start date "),
                        icon: const Icon(Icons.calendar_month)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // controls the position of the shadow
                        ),
                      ],
                    ),
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  7), // Set your desired border radius here
                            ),
                          ),
                        ),
                        onPressed: () {
                          showOmniDateTimePicker(context: context);
                        },
                        label: const Text(
                          "End Date",
                        ),
                        icon: const Icon(Icons.calendar_month)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.6,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Reminders",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Reminders(addNewReminder: _addAReminder, reminderData: reminders),
            ],
          ),
        ));
  }
}

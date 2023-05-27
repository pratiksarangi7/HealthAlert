import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/data/data.dart';
import 'package:medico_app/models/medico_item.dart';
import 'package:medico_app/providers/medico_data.dart';
import 'package:medico_app/widgets/custom_drop_down.dart';
import 'package:medico_app/widgets/item_card.dart';
import 'package:medico_app/widgets/reminders.dart';
import 'package:medico_app/widgets/start_end_date.dart';

class AddMedicoItemScreen extends ConsumerStatefulWidget {
  const AddMedicoItemScreen({super.key});

  @override
  ConsumerState<AddMedicoItemScreen> createState() {
    return _AddMedicoItemScreenState();
  }
}

class _AddMedicoItemScreenState extends ConsumerState<AddMedicoItemScreen> {
  String? name;
  String medImagePath = items[0]['image'];
  DateTime? medicationStartDate;
  DateTime? medicationEndDate;
  String? dosagedropDownData;
  String? beforeAfterData;

  void _addAReminder(value) {
    reminders.add(value);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _dosageDropDownDataRetriever(String drpDwnDta) {
    dosagedropDownData = drpDwnDta;
  }

  void _beforeAfterDropDownDataRetriever(String drpDwnDta) {
    beforeAfterData = drpDwnDta;
  }

  void _updateDateContentOfStartDate(DateTime date) {
    medicationStartDate = date;
  }

  void _updateDateContentOfEndDate(DateTime date) {
    medicationEndDate = date;
  }

  var _hintText = hintTextData[0];
  final _descriptionController = TextEditingController();

  var selectedValue = '1 per day';
  late List<bool> tappedData =
      List.generate(items.length, (index) => index == 0 ? true : false);
  final List<DateTime> reminders = [];

  @override
  Widget build(BuildContext context) {
    final _medicoItemsNotifier = ref.read(medicoItemsProvider.notifier);
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
                        splashColor: Colors.transparent,
                        child: ItemCard(
                          image: items[index]['image'],
                          label: items[index]['label'],
                          isTapped: tappedData[index],
                        ),
                        onTap: () {
                          print("inside onTap");
                          medImagePath = items[index]['image'];
                          print("ontap:$medImagePath");
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: _descriptionController,
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  DropDown(
                      dropDownItems: dosageData,
                      dropDownDataUpdater: _dosageDropDownDataRetriever),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "  Before/After food:",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  DropDown(
                      dropDownItems: beforeOrAfterFood,
                      dropDownDataUpdater: _beforeAfterDropDownDataRetriever),
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
                  // Start button:
                  StartOrEndButton(
                    dateContent: "Start Date",
                    updateDateContent: _updateDateContentOfStartDate,
                  ),
                  StartOrEndButton(
                      dateContent: "End Date",
                      updateDateContent: _updateDateContentOfEndDate)
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
              Center(
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  width: 140,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (_descriptionController.text.trim().isEmpty ||
                            beforeAfterData == null ||
                            dosagedropDownData == null ||
                            medicationStartDate == null ||
                            medicationEndDate == null) {
                          return;
                        }
                        final newItem = MedicoItem(
                          name: _descriptionController.text.trim(),
                          medImagePath: medImagePath!,
                          beforeOrAfterFood: beforeAfterData!,
                          dosage: dosagedropDownData!,
                          medicationEndDate: medicationEndDate!,
                          medicationStartDate: medicationStartDate!,
                          reminders: reminders,
                        );
                        _medicoItemsNotifier.addMedicoItem(newItem);

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.done),
                      label: const Text("Done")),
                ),
              )
            ],
          ),
        ));
  }
}

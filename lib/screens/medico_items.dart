import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/models/medico_item.dart';
import 'package:medico_app/providers/medico_data.dart';
import 'package:medico_app/screens/add_medico.dart';

class MedicoItemsScreen extends ConsumerStatefulWidget {
  const MedicoItemsScreen({super.key});

  @override
  ConsumerState<MedicoItemsScreen> createState() {
    return _MedicoItemsScreenState();
  }
}

class _MedicoItemsScreenState extends ConsumerState<MedicoItemsScreen> {
  late List<MedicoItem> _medicoItems;

  @override
  void initState() {
    _medicoItems = ref.read(medicoItemsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final medItems = ref.watch(medicoItemsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medico Items",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: medItems.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
            medItems[index].title,
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddMedicoItemScreen())),
      ),
    );
  }
}

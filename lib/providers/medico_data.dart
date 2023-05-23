import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/models/medico_item.dart';

class MedicoItemsNotifier extends StateNotifier<List<MedicoItem>> {
  MedicoItemsNotifier() : super([]);
  void addMedicoItem(MedicoItem item) {
    state = [...state, item];
  }
}

final medicoItemsProvider =
    StateNotifierProvider<MedicoItemsNotifier, List<MedicoItem>>(
        (ref) => MedicoItemsNotifier());

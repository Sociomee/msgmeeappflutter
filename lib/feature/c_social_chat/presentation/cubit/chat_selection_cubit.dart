import 'package:bloc/bloc.dart';

// enum SelectMode { inactive, active }

enum SelectedState { selected, unselected }

class SelectionCubit extends Cubit<Map<int, SelectedState>> {
  SelectionCubit() : super({});

  void toggleSelection(int itemId) {
    if (state.containsKey(itemId)) {
      if (state[itemId] == SelectedState.selected) {
        emit(Map.from(state)..remove(itemId));
      } else {
        emit(Map.from(state)..[itemId] = SelectedState.selected);
      }
    } else {
      emit(Map.from(state)..[itemId] = SelectedState.selected);
    }
    print(state);
  }

  void clearSelection() {
    emit({});
  }
}

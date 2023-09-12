import 'package:bloc/bloc.dart';

enum SelectedGroupState { selected, unselected }

enum SelectionMode { normal, selection }

class SelectionGroupCubit extends Cubit<Map<int, SelectedGroupState>> {
  SelectionGroupCubit() : super({});


  void toggleItemSelection(int itemId) {
    if (state.containsKey(itemId)) {
      if (state[itemId] == SelectedGroupState.selected) {
        emit(Map.from(state)..remove(itemId));
      } else {
        emit(Map.from(state)..[itemId] = SelectedGroupState.selected);
      }
    } else {
      emit(Map.from(state)..[itemId] = SelectedGroupState.selected);
    }
  }

  void selectAllItems(int itemCount) {
    for (int i = 0; i < itemCount; i++) {
      emit(Map.from(state)..[i] = SelectedGroupState.selected);
    }
  }

  void clearGroupSelection() {
    emit({});
  }
}

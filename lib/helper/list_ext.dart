extension CustomSortListExtension<T> on List<T> {
  List<T> customSort() {
    var sortedList = List<T>.from(this);
    sortedList.sort((a, b) {
      if (a is String && b is String) {
        if (a.contains(RegExp(r'[a-zA-Z]')) &&
            !b.contains(RegExp(r'[a-zA-Z]'))) {
          return -1; // a comes before b
        } else if (!a.contains(RegExp(r'[a-zA-Z]')) &&
            b.contains(RegExp(r'[a-zA-Z]'))) {
          return 1; // b comes before a
        }
      }
      return a.toString().compareTo(b.toString());
    });
    return sortedList;
  }
}

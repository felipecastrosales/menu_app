extension ListX on List {

  List get clear => where((element) => element != null).toList();

}
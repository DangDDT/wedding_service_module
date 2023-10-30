import 'package:get/get.dart';

import '../../domain/domain.dart';

class StateModel<T> {
  final Rx<T> data;
  final Rxn<String> errorMessage;
  final Rx<LoadingState> state;

  StateModel({
    required this.data,
  })  : errorMessage = Rxn(),
        state = Rx<LoadingState>(LoadingState.idle);

  bool get isLoading => state.value.isLoading;

  bool get isSuccess => state.value.isSuccess;

  bool get isError => state.value.isError;

  bool get isEmpty => state.value.isEmpty;

  bool get isInitial => state.value.isInitial;
}

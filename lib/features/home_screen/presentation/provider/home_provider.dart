// lib/presentation/viewmodels/trips_vm.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/locator.dart';
import '../../data/models/trip_model.dart';
import '../../domain/usecases/get_trips_usecase.dart';
import 'home_state.dart';



class TripsNotifier extends StateNotifier<TripsState> {
  final GetTripsUseCase _getTripsUseCase = sl<GetTripsUseCase>();

  TripsNotifier() : super(const TripsState());

  Future<void> loadTrips() async {
    state = state.copyWith(loading: true, error: null);
    try {

      final trips = await _getTripsUseCase.call(); // ✅ use the use case
      state = state.copyWith(loading: false, trips: trips);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final tripsNotifierProvider =
StateNotifierProvider<TripsNotifier, TripsState>((ref) => TripsNotifier());

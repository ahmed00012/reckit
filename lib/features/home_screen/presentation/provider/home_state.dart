import '../../data/models/trip_model.dart';

class TripsState {
  final bool loading;
  final List<TripModel> trips;
  final String? error;
  const TripsState({this.loading = false, this.trips = const [], this.error});

  TripsState copyWith({
    bool? loading,
    List<TripModel>? trips,
    String? error,
  }) =>
      TripsState(
        loading: loading ?? this.loading,
        trips: trips ?? this.trips,
        error: error,
      );
}
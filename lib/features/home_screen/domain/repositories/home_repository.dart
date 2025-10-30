
import '../../data/data_sources/home_data_source.dart';
import '../../data/models/trip_model.dart';

abstract class TripsRepository {
  Future<List<TripModel>> getTrips();
}

class TripsRepositoryImpl implements TripsRepository {
  final TripsLocalDataSource local;
  TripsRepositoryImpl(this.local);

  @override
  Future<List<TripModel>> getTrips() => local.loadTrips();
}
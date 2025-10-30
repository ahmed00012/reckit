
import '../../data/models/trip_model.dart';
import '../repositories/home_repository.dart';


class GetTripsUseCase {
  final TripsRepository repository;

  GetTripsUseCase(this.repository);

  Future<List<TripModel>> call() async {

    return await repository.getTrips();
  }
}

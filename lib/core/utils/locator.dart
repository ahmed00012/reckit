
import 'package:get_it/get_it.dart';
import '../../features/home_screen/data/data_sources/home_data_source.dart';
import '../../features/home_screen/domain/repositories/home_repository.dart';
import '../../features/home_screen/domain/usecases/get_trips_usecase.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // ✅ Data Sources
  sl.registerLazySingleton<TripsLocalDataSource>(
        () => TripsLocalDataSourceImpl(),
  );

  // ✅ Repositories
  sl.registerLazySingleton<TripsRepository>(
        () => TripsRepositoryImpl(sl<TripsLocalDataSource>()),
  );

  // ✅ Use Cases
  sl.registerLazySingleton<GetTripsUseCase>(
        () => GetTripsUseCase(sl<TripsRepository>()),
  );
}

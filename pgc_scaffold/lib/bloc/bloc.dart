import '../../exports.dart';

abstract class TripInfoEvent {}

class LoadTripInfos extends TripInfoEvent {}

class AddTripInfoEvent extends TripInfoEvent {
  final String title;
  final String location;
  final String startDate;
  final String endDate;
  AddTripInfoEvent(
      {required this.title,
      required this.location,
      required this.startDate,
      required this.endDate});
}

abstract class TripInfoState {}

class TripInfoInitial extends TripInfoState {}

class TripInfoLoading extends TripInfoState {}

class TripInfoLoaded extends TripInfoState {
  final List<TripInfo> trips;
  TripInfoLoaded(this.trips);
}

class TripInfoError extends TripInfoState {
  final String error;
  TripInfoError(this.error);
}

class TripInfoBloc extends Bloc<TripInfoEvent, TripInfoState> {
  final TripInfoRepository repository;

  TripInfoBloc({required this.repository}) : super(TripInfoInitial()) {
    on<LoadTripInfos>((event, emit) async {
      emit(TripInfoLoading());
      try {
        // Get the Hive box and load the list of trips
        final box = Boxes.getTripInfo();
        final trips = box.values.toList();
        emit(TripInfoLoaded(trips));
      } catch (e) {
        emit(TripInfoError(e.toString()));
      }
    });

    on<AddTripInfoEvent>((event, emit) async {
      try {
        // Add new trip using the repository
        await repository.addTripInfo(
            event.title, event.location, event.startDate, event.endDate);
        // Reload the trips after the insertion
        final box = Boxes.getTripInfo();
        final trips = box.values.toList();
        emit(TripInfoLoaded(trips));
      } catch (e) {
        emit(TripInfoError(e.toString()));
      }
    });
  }
}

import '../exports.dart';

class Boxes {
  static Box<TripInfo> getTripInfo() => Hive.box<TripInfo>('trip_info');
}

class TripInfoRepository {
  Future<Box<TripInfo>> openBox() async {
    return await Hive.openBox<TripInfo>('myBox');
  }

  Future<void> addTripInfo(String title, String location) async {
    final tripInfo = TripInfo()
      ..title = title
      ..location = location;

    final box = Boxes.getTripInfo();
    await box.add(tripInfo);
  }
}

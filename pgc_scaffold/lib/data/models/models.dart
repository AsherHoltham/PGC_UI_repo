//*** Trips Hive DATABASE MODELS ***//
import "package:hive/hive.dart";

part 'models.g.dart';

@HiveType(typeId: 0)
class TripInfo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String location;

  @HiveField(2)
  late String startDate;

  @HiveField(3)
  late String endDate;
}

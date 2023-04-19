import 'package:stormberry/stormberry.dart';
part 'db_models.schema.dart';

@Model()
abstract class User {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  int get customerId;

  int get numberOfAdults;

  int get numberOfKids;

  int get numberOfParmanentMaids;

  String get apartmentSize;

  String get apartmentType;

  int get numberOfRooms;

  int get numberOfBathrooms;

  int get numberOfBalconies;

  bool? get isDeleted;

  DateTime get createdAt;

  DateTime get updatedAt;

  DateTime? get deletedAt;
}

// ignore_for_file: annotate_overrides

part of 'db_models.dart';

extension DbModelsRepositories on Database {
  UserRepository get users => UserRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<UserView?> queryUser(int id);
  Future<List<UserView>> queryUsers([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<UserView?> queryUser(int id) {
    return queryOne(id, UserViewQueryable());
  }

  @override
  Future<List<UserView>> queryUsers([QueryParams? params]) {
    return queryMany(UserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "users" ( "customer_id", "is_deleted", "created_at", "updated_at", "deleted_at", "number_of_adults", "number_of_kids", "number_of_parmanent_maids", "apartment_size", "apartment_type", "number_of_rooms", "number_of_bathrooms", "number_of_balconies" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.customerId)}:int8, ${values.add(r.isDeleted)}:boolean, ${values.add(r.createdAt)}:timestamp, ${values.add(r.updatedAt)}:timestamp, ${values.add(r.deletedAt)}:timestamp, ${values.add(r.numberOfAdults)}:int8, ${values.add(r.numberOfKids)}:int8, ${values.add(r.numberOfParmanentMaids)}:int8, ${values.add(r.apartmentSize)}:text, ${values.add(r.apartmentType)}:text, ${values.add(r.numberOfRooms)}:int8, ${values.add(r.numberOfBathrooms)}:int8, ${values.add(r.numberOfBalconies)}:int8 )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "users"\n'
      'SET "customer_id" = COALESCE(UPDATED."customer_id", "users"."customer_id"), "is_deleted" = COALESCE(UPDATED."is_deleted", "users"."is_deleted"), "created_at" = COALESCE(UPDATED."created_at", "users"."created_at"), "updated_at" = COALESCE(UPDATED."updated_at", "users"."updated_at"), "deleted_at" = COALESCE(UPDATED."deleted_at", "users"."deleted_at"), "number_of_adults" = COALESCE(UPDATED."number_of_adults", "users"."number_of_adults"), "number_of_kids" = COALESCE(UPDATED."number_of_kids", "users"."number_of_kids"), "number_of_parmanent_maids" = COALESCE(UPDATED."number_of_parmanent_maids", "users"."number_of_parmanent_maids"), "apartment_size" = COALESCE(UPDATED."apartment_size", "users"."apartment_size"), "apartment_type" = COALESCE(UPDATED."apartment_type", "users"."apartment_type"), "number_of_rooms" = COALESCE(UPDATED."number_of_rooms", "users"."number_of_rooms"), "number_of_bathrooms" = COALESCE(UPDATED."number_of_bathrooms", "users"."number_of_bathrooms"), "number_of_balconies" = COALESCE(UPDATED."number_of_balconies", "users"."number_of_balconies")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.customerId)}:int8::int8, ${values.add(r.isDeleted)}:boolean::boolean, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.updatedAt)}:timestamp::timestamp, ${values.add(r.deletedAt)}:timestamp::timestamp, ${values.add(r.numberOfAdults)}:int8::int8, ${values.add(r.numberOfKids)}:int8::int8, ${values.add(r.numberOfParmanentMaids)}:int8::int8, ${values.add(r.apartmentSize)}:text::text, ${values.add(r.apartmentType)}:text::text, ${values.add(r.numberOfRooms)}:int8::int8, ${values.add(r.numberOfBathrooms)}:int8::int8, ${values.add(r.numberOfBalconies)}:int8::int8 )').join(', ')} )\n'
      'AS UPDATED("id", "customer_id", "is_deleted", "created_at", "updated_at", "deleted_at", "number_of_adults", "number_of_kids", "number_of_parmanent_maids", "apartment_size", "apartment_type", "number_of_rooms", "number_of_bathrooms", "number_of_balconies")\n'
      'WHERE "users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserInsertRequest {
  UserInsertRequest({
    required this.customerId,
    this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.numberOfAdults,
    required this.numberOfKids,
    required this.numberOfParmanentMaids,
    required this.apartmentSize,
    required this.apartmentType,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
    required this.numberOfBalconies,
  });

  final int customerId;
  final bool? isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int numberOfAdults;
  final int numberOfKids;
  final int numberOfParmanentMaids;
  final String apartmentSize;
  final String apartmentType;
  final int numberOfRooms;
  final int numberOfBathrooms;
  final int numberOfBalconies;
}

class UserUpdateRequest {
  UserUpdateRequest({
    required this.id,
    this.customerId,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.numberOfAdults,
    this.numberOfKids,
    this.numberOfParmanentMaids,
    this.apartmentSize,
    this.apartmentType,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.numberOfBalconies,
  });

  final int id;
  final int? customerId;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? numberOfAdults;
  final int? numberOfKids;
  final int? numberOfParmanentMaids;
  final String? apartmentSize;
  final String? apartmentType;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final int? numberOfBalconies;
}

class UserViewQueryable extends KeyedViewQueryable<UserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "users".*'
      'FROM "users"';

  @override
  String get tableAlias => 'users';

  @override
  UserView decode(TypedMap map) => UserView(
      id: map.get('id'),
      customerId: map.get('customer_id'),
      isDeleted: map.getOpt('is_deleted'),
      createdAt: map.get('created_at'),
      updatedAt: map.get('updated_at'),
      deletedAt: map.getOpt('deleted_at'),
      numberOfAdults: map.get('number_of_adults'),
      numberOfKids: map.get('number_of_kids'),
      numberOfParmanentMaids: map.get('number_of_parmanent_maids'),
      apartmentSize: map.get('apartment_size'),
      apartmentType: map.get('apartment_type'),
      numberOfRooms: map.get('number_of_rooms'),
      numberOfBathrooms: map.get('number_of_bathrooms'),
      numberOfBalconies: map.get('number_of_balconies'));
}

class UserView {
  UserView({
    required this.id,
    required this.customerId,
    this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.numberOfAdults,
    required this.numberOfKids,
    required this.numberOfParmanentMaids,
    required this.apartmentSize,
    required this.apartmentType,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
    required this.numberOfBalconies,
  });

  final int id;
  final int customerId;
  final bool? isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int numberOfAdults;
  final int numberOfKids;
  final int numberOfParmanentMaids;
  final String apartmentSize;
  final String apartmentType;
  final int numberOfRooms;
  final int numberOfBathrooms;
  final int numberOfBalconies;
}

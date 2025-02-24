//*** Trips SQFLITE DATABASE SCHEMAS ***//
const String tableName = 'trips';

const String idField = '_id';
const String titleField = 'title';
const String descriptionField = 'description';

const List<String> tripColumns = [idField, titleField, descriptionField];

const String boolType = "BOOLEAN NOT NULL";
const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const String textTypeNullable = "TEXT";
const String textType = "TEXT NOT NULL";

class TripModel {
  int? id;
  String title;
  String description;

  TripModel({
    this.id,
    required this.title,
    required this.description,
  });
  // Convert a YourModel instance into a Map.
  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
      };

  // Create a YourModel instance from a Map.
  static TripModel fromJson(Map<String, dynamic> json) => TripModel(
        id: json['_id'] as int?,
        title: json['title'] as String,
        description: json['description'] as String,
      );

  TripModel copyWith({
    int? id,
    String? title,
    String? description,
  }) =>
      TripModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
}

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:totick/app/entity/task_entity.dart';

part 'work_entity.g.dart';

@JsonSerializable()
@Collection(inheritance: false)
class WorkEntity extends Equatable {
  final Id id;

  @Index(type: IndexType.value)
  final String? name;

  @Index(type: IndexType.value)
  final String? description;

  final List<TaskEntity>? tasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const WorkEntity({
    this.id = Isar.autoIncrement,
    this.name,
    this.description,
    this.tasks,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @ignore
  @override
  List<Object?> get props => [
        id,
        name,
        description,
        tasks,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  WorkEntity copyWith({
    Id? id,
    String? name,
    String? description,
    List<TaskEntity>? tasks,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return WorkEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      tasks: tasks ?? this.tasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory WorkEntity.fromJson(Map<String, dynamic> json) =>
      _$WorkEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WorkEntityToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_entity.g.dart';

@JsonSerializable()
@Embedded(inheritance: false)
class TaskEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? progress; // max is 100
  final bool? alert;
  final DateTime? startDate;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const TaskEntity({
    this.id,
    this.name,
    this.description,
    this.progress,
    this.alert,
    this.startDate,
    this.dueDate,
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
        progress,
        alert,
        startDate,
        dueDate,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  TaskEntity copyWith({
    Id? id,
    String? name,
    String? description,
    int? progress,
    bool? alert,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      alert: alert ?? this.alert,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);
}

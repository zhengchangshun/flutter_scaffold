import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department {
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "parentDepartmentId")
  String? parentDepartmentId;
  @JsonKey(name: "level")
  int? level;
  @JsonKey(name: "isProductionDepartment")
  bool? isProductionDepartment;
  @JsonKey(name: "statusEnum")
  int? statusEnum;
  @JsonKey(name: "validFromDate")
  DateTime? validFromDate;
  @JsonKey(name: "validToDate")
  DateTime? validToDate;
  @JsonKey(name: "concurrencyStamp")
  String? concurrencyStamp;
  @JsonKey(name: "remark")
  dynamic remark;
  @JsonKey(name: "creatorId")
  String? creatorId;
  @JsonKey(name: "creator")
  dynamic creator;
  @JsonKey(name: "lastModifierId")
  String? lastModifierId;
  @JsonKey(name: "lastModifier")
  dynamic lastModifier;
  @JsonKey(name: "isDeleted")
  bool? isDeleted;
  @JsonKey(name: "deleterId")
  dynamic deleterId;
  @JsonKey(name: "deletionTime")
  dynamic deletionTime;
  @JsonKey(name: "lastModificationTime")
  DateTime? lastModificationTime;
  @JsonKey(name: "creationTime")
  DateTime? creationTime;
  @JsonKey(name: "id")
  String? id;

  Department({
    this.code,
    this.name,
    this.parentDepartmentId,
    this.level,
    this.isProductionDepartment,
    this.statusEnum,
    this.validFromDate,
    this.validToDate,
    this.concurrencyStamp,
    this.remark,
    this.creatorId,
    this.creator,
    this.lastModifierId,
    this.lastModifier,
    this.isDeleted,
    this.deleterId,
    this.deletionTime,
    this.lastModificationTime,
    this.creationTime,
    this.id,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

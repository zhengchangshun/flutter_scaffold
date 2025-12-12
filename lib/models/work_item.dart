// To parse this JSON data, do
//
//     final workItem = workItemFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import './base/department.dart';

part 'work_item.g.dart';

WorkItem workItemFromJson(String str) => WorkItem.fromJson(json.decode(str));

String workItemToJson(WorkItem data) => json.encode(data.toJson());

@JsonSerializable()
class WorkItem {
    @JsonKey(name: "serialNumber")
    String? serialNumber;
    @JsonKey(name: "status")
    int? status;
    @JsonKey(name: "businessStatus")
    int? businessStatus;
    @JsonKey(name: "materialId")
    String? materialId;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "floatRatio")
    int? floatRatio;
    @JsonKey(name: "scheduledStartDate")
    DateTime? scheduledStartDate;
    @JsonKey(name: "scheduledCompletionDate")
    DateTime? scheduledCompletionDate;
    @JsonKey(name: "department")
    Department? department;
    @JsonKey(name: "customerId")
    dynamic customerId;
    @JsonKey(name: "customer")
    dynamic customer;
    @JsonKey(name: "projectId")
    dynamic projectId;
    @JsonKey(name: "project")
    dynamic project;
    @JsonKey(name: "creatorName")
    String? creatorName;
    @JsonKey(name: "lastModifierName")
    dynamic lastModifierName;
    @JsonKey(name: "type")
    int? type;
    @JsonKey(name: "erpDocument")
    String? erpDocument;
    @JsonKey(name: "warehousedQuantity")
    int? warehousedQuantity;
    @JsonKey(name: "version")
    String? version;
    @JsonKey(name: "extraProperties")
    dynamic extraProperties;
    @JsonKey(name: "bomType")
    int? bomType;
    @JsonKey(name: "documentType")
    int? documentType;
    @JsonKey(name: "fullMaterialId")
    dynamic fullMaterialId;
    @JsonKey(name: "fullMaterial")
    dynamic fullMaterial;
    @JsonKey(name: "extraUserName")
    String? extraUserName;
    @JsonKey(name: "executedQuantity")
    int? executedQuantity;
    @JsonKey(name: "apsId")
    String? apsId;
    @JsonKey(name: "processRouteVersion")
    String? processRouteVersion;
    @JsonKey(name: "processRouteStatus")
    dynamic processRouteStatus;
    @JsonKey(name: "bomStatus")
    dynamic bomStatus;
    @JsonKey(name: "mrpQuantity")
    int? mrpQuantity;
    @JsonKey(name: "mode")
    int? mode;
    @JsonKey(name: "processProductionGoals")
    dynamic processProductionGoals;
    @JsonKey(name: "productionOrderDetails")
    List<dynamic>? productionOrderDetails;
    @JsonKey(name: "isMaterialPrepared")
    bool? isMaterialPrepared;
    @JsonKey(name: "materialPreparationStatus")
    int? materialPreparationStatus;
    @JsonKey(name: "planShipmentTime")
    dynamic planShipmentTime;
    @JsonKey(name: "deliveryTime")
    DateTime? deliveryTime;
    @JsonKey(name: "demandCode")
    int? demandCode;
    @JsonKey(name: "ableInboundQuantity")
    dynamic ableInboundQuantity;
    @JsonKey(name: "unitId")
    String? unitId;
    @JsonKey(name: "isSourceExecution")
    bool? isSourceExecution;
    @JsonKey(name: "unitName")
    String? unitName;
    @JsonKey(name: "forecastOrderDeliveryTime")
    dynamic forecastOrderDeliveryTime;
    @JsonKey(name: "isSingleReport")
    bool? isSingleReport;
    @JsonKey(name: "concurrencyStamp")
    String? concurrencyStamp;
    @JsonKey(name: "remark")
    dynamic remark;
    @JsonKey(name: "creatorId")
    String? creatorId;
    @JsonKey(name: "lastModifierId")
    dynamic lastModifierId;
    @JsonKey(name: "lastModifier")
    dynamic lastModifier;
    @JsonKey(name: "isDeleted")
    bool? isDeleted;
    @JsonKey(name: "deleterId")
    dynamic deleterId;
    @JsonKey(name: "deletionTime")
    dynamic deletionTime;
    @JsonKey(name: "lastModificationTime")
    dynamic lastModificationTime;
    @JsonKey(name: "creationTime")
    DateTime? creationTime;
    @JsonKey(name: "id")
    String? id;

    WorkItem({
        this.serialNumber,
        this.status,
        this.businessStatus,
        this.materialId,
        this.quantity,
        this.floatRatio,
        this.scheduledStartDate,
        this.scheduledCompletionDate,
        this.department,
        this.customerId,
        this.customer,
        this.projectId,
        this.project,
        this.creatorName,
        this.lastModifierName,
        this.type,
        this.erpDocument,
        this.warehousedQuantity,
        this.version,
        this.extraProperties,
        this.bomType,
        this.documentType,
        this.fullMaterialId,
        this.fullMaterial,
        this.extraUserName,
        this.executedQuantity,
        this.apsId,
        this.processRouteVersion,
        this.processRouteStatus,
        this.bomStatus,
        this.mrpQuantity,
        this.mode,
        this.processProductionGoals,
        this.productionOrderDetails,
        this.isMaterialPrepared,
        this.materialPreparationStatus,
        this.planShipmentTime,
        this.deliveryTime,
        this.demandCode,
        this.ableInboundQuantity,
        this.unitId,
        this.isSourceExecution,
        this.unitName,
        this.forecastOrderDeliveryTime,
        this.isSingleReport,
        this.concurrencyStamp,
        this.remark,
        this.creatorId,
        this.lastModifierId,
        this.lastModifier,
        this.isDeleted,
        this.deleterId,
        this.deletionTime,
        this.lastModificationTime,
        this.creationTime,
        this.id,
    });

    factory WorkItem.fromJson(Map<String, dynamic> json) => _$WorkItemFromJson(json);

    Map<String, dynamic> toJson() => _$WorkItemToJson(this);
}
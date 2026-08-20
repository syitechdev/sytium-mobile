// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_space_dtos.freezed.dart';
part 'employee_space_dtos.g.dart';

@freezed
class EmployeeProfileDto with _$EmployeeProfileDto {
  const factory EmployeeProfileDto({
    required String id,
    String? matricule,
    @Default('') String nom,
    String? prenoms,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
    @Default(EmployeeIdentityDto()) EmployeeIdentityDto identite,
    @Default(EmployeeContractDto()) EmployeeContractDto contrat,
    @Default(EmployeePayDto()) EmployeePayDto remuneration,
    @Default(EmployeeContactsDto()) EmployeeContactsDto contacts,
  }) = _EmployeeProfileDto;

  factory EmployeeProfileDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeProfileDtoFromJson(json);
}

@freezed
class EmployeeIdentityDto with _$EmployeeIdentityDto {
  const factory EmployeeIdentityDto({
    @JsonKey(name: 'date_naissance') String? dateNaissance,
    @JsonKey(name: 'lieu_naissance') String? lieuNaissance,
    String? sexe,
    @JsonKey(name: 'situation_matrimoniale') String? situationMatrimoniale,
    String? nationalite,
    @JsonKey(name: 'dernier_diplome') String? dernierDiplome,
    @JsonKey(name: 'nombre_enfants') int? nombreEnfants,
  }) = _EmployeeIdentityDto;

  factory EmployeeIdentityDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeIdentityDtoFromJson(json);
}

@freezed
class EmployeeContractDto with _$EmployeeContractDto {
  const factory EmployeeContractDto({
    @JsonKey(name: 'date_embauche') String? dateEmbauche,
    @JsonKey(name: 'type_contrat') String? typeContrat,
    String? fonction,
    String? poste,
    String? departement,
    @JsonKey(name: 'categorie_salariale') String? categorieSalariale,
    @JsonKey(name: 'numero_cnps') String? numeroCnps,
  }) = _EmployeeContractDto;

  factory EmployeeContractDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeContractDtoFromJson(json);
}

@freezed
class EmployeePayDto with _$EmployeePayDto {
  const factory EmployeePayDto({
    @JsonKey(name: 'salaire_base') @Default(0) double salaireBase,
    @Default(0) double sursalaire,
    @JsonKey(name: 'salaire_net_actuel') @Default(0) double salaireNetActuel,
  }) = _EmployeePayDto;

  factory EmployeePayDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeePayDtoFromJson(json);
}

@freezed
class EmployeeContactsDto with _$EmployeeContactsDto {
  const factory EmployeeContactsDto({
    String? telephone,
    String? email,
    String? adresse,
    @JsonKey(name: 'contact_urgence_nom') String? contactUrgenceNom,
    @JsonKey(name: 'contact_urgence_telephone') String? contactUrgenceTelephone,
    @JsonKey(name: 'contact_urgence_lien') String? contactUrgenceLien,
  }) = _EmployeeContactsDto;

  factory EmployeeContactsDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeContactsDtoFromJson(json);
}

@freezed
class MyPayslipDto with _$MyPayslipDto {
  const factory MyPayslipDto({
    required String id,
    String? periode,
    String? statut,
    @Default(0) double gross,
    @JsonKey(name: 'taxable_gross') @Default(0) double taxableGross,
    @JsonKey(name: 'total_employee_deductions') @Default(0) double deductions,
    @JsonKey(name: 'net_to_pay') @Default(0) double netToPay,
    @JsonKey(name: 'payment_date') String? paymentDate,
  }) = _MyPayslipDto;

  factory MyPayslipDto.fromJson(Map<String, dynamic> json) =>
      _$MyPayslipDtoFromJson(json);
}

@freezed
class MyDocumentDto with _$MyDocumentDto {
  const factory MyDocumentDto({
    required String id,
    @Default('') String nom,
    String? categorie,
    String? description,
    @JsonKey(name: 'mime_type') String? mimeType,
    @Default(0) int taille,
    String? date,
    String? url,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
  }) = _MyDocumentDto;

  factory MyDocumentDto.fromJson(Map<String, dynamic> json) =>
      _$MyDocumentDtoFromJson(json);
}

@freezed
class InternalRegulationDto with _$InternalRegulationDto {
  const factory InternalRegulationDto({
    required String id,
    @Default('') String titre,
    String? version,
    String? description,
    @JsonKey(name: 'published_at') String? publishedAt,
    @JsonKey(name: 'document_name') String? documentName,
    @JsonKey(name: 'mime_type') String? mimeType,
    @Default(0) int taille,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
    RegulationAckDto? acknowledgement,
  }) = _InternalRegulationDto;

  factory InternalRegulationDto.fromJson(Map<String, dynamic> json) =>
      _$InternalRegulationDtoFromJson(json);
}

@freezed
class RegulationAckDto with _$RegulationAckDto {
  const factory RegulationAckDto({
    String? status,
    @JsonKey(name: 'viewed_at') String? viewedAt,
    @JsonKey(name: 'signed_at') String? signedAt,
  }) = _RegulationAckDto;

  factory RegulationAckDto.fromJson(Map<String, dynamic> json) =>
      _$RegulationAckDtoFromJson(json);
}

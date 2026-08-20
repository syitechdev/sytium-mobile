// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_space_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeProfileDtoImpl _$$EmployeeProfileDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeProfileDtoImpl(
  id: json['id'] as String,
  matricule: json['matricule'] as String?,
  nom: json['nom'] as String? ?? '',
  prenoms: json['prenoms'] as String?,
  photoUrl: json['photo_url'] as String?,
  statut: json['statut'] as String?,
  identite: json['identite'] == null
      ? const EmployeeIdentityDto()
      : EmployeeIdentityDto.fromJson(json['identite'] as Map<String, dynamic>),
  contrat: json['contrat'] == null
      ? const EmployeeContractDto()
      : EmployeeContractDto.fromJson(json['contrat'] as Map<String, dynamic>),
  remuneration: json['remuneration'] == null
      ? const EmployeePayDto()
      : EmployeePayDto.fromJson(json['remuneration'] as Map<String, dynamic>),
  contacts: json['contacts'] == null
      ? const EmployeeContactsDto()
      : EmployeeContactsDto.fromJson(json['contacts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$EmployeeProfileDtoImplToJson(
  _$EmployeeProfileDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'matricule': instance.matricule,
  'nom': instance.nom,
  'prenoms': instance.prenoms,
  'photo_url': instance.photoUrl,
  'statut': instance.statut,
  'identite': instance.identite,
  'contrat': instance.contrat,
  'remuneration': instance.remuneration,
  'contacts': instance.contacts,
};

_$EmployeeIdentityDtoImpl _$$EmployeeIdentityDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeIdentityDtoImpl(
  dateNaissance: json['date_naissance'] as String?,
  lieuNaissance: json['lieu_naissance'] as String?,
  sexe: json['sexe'] as String?,
  situationMatrimoniale: json['situation_matrimoniale'] as String?,
  nationalite: json['nationalite'] as String?,
  dernierDiplome: json['dernier_diplome'] as String?,
  nombreEnfants: (json['nombre_enfants'] as num?)?.toInt(),
);

Map<String, dynamic> _$$EmployeeIdentityDtoImplToJson(
  _$EmployeeIdentityDtoImpl instance,
) => <String, dynamic>{
  'date_naissance': instance.dateNaissance,
  'lieu_naissance': instance.lieuNaissance,
  'sexe': instance.sexe,
  'situation_matrimoniale': instance.situationMatrimoniale,
  'nationalite': instance.nationalite,
  'dernier_diplome': instance.dernierDiplome,
  'nombre_enfants': instance.nombreEnfants,
};

_$EmployeeContractDtoImpl _$$EmployeeContractDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeContractDtoImpl(
  dateEmbauche: json['date_embauche'] as String?,
  typeContrat: json['type_contrat'] as String?,
  fonction: json['fonction'] as String?,
  poste: json['poste'] as String?,
  departement: json['departement'] as String?,
  categorieSalariale: json['categorie_salariale'] as String?,
  numeroCnps: json['numero_cnps'] as String?,
);

Map<String, dynamic> _$$EmployeeContractDtoImplToJson(
  _$EmployeeContractDtoImpl instance,
) => <String, dynamic>{
  'date_embauche': instance.dateEmbauche,
  'type_contrat': instance.typeContrat,
  'fonction': instance.fonction,
  'poste': instance.poste,
  'departement': instance.departement,
  'categorie_salariale': instance.categorieSalariale,
  'numero_cnps': instance.numeroCnps,
};

_$EmployeePayDtoImpl _$$EmployeePayDtoImplFromJson(Map<String, dynamic> json) =>
    _$EmployeePayDtoImpl(
      salaireBase: (json['salaire_base'] as num?)?.toDouble() ?? 0,
      sursalaire: (json['sursalaire'] as num?)?.toDouble() ?? 0,
      salaireNetActuel: (json['salaire_net_actuel'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$EmployeePayDtoImplToJson(
  _$EmployeePayDtoImpl instance,
) => <String, dynamic>{
  'salaire_base': instance.salaireBase,
  'sursalaire': instance.sursalaire,
  'salaire_net_actuel': instance.salaireNetActuel,
};

_$EmployeeContactsDtoImpl _$$EmployeeContactsDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeContactsDtoImpl(
  telephone: json['telephone'] as String?,
  email: json['email'] as String?,
  adresse: json['adresse'] as String?,
  contactUrgenceNom: json['contact_urgence_nom'] as String?,
  contactUrgenceTelephone: json['contact_urgence_telephone'] as String?,
  contactUrgenceLien: json['contact_urgence_lien'] as String?,
);

Map<String, dynamic> _$$EmployeeContactsDtoImplToJson(
  _$EmployeeContactsDtoImpl instance,
) => <String, dynamic>{
  'telephone': instance.telephone,
  'email': instance.email,
  'adresse': instance.adresse,
  'contact_urgence_nom': instance.contactUrgenceNom,
  'contact_urgence_telephone': instance.contactUrgenceTelephone,
  'contact_urgence_lien': instance.contactUrgenceLien,
};

_$MyPayslipDtoImpl _$$MyPayslipDtoImplFromJson(Map<String, dynamic> json) =>
    _$MyPayslipDtoImpl(
      id: json['id'] as String,
      periode: json['periode'] as String?,
      statut: json['statut'] as String?,
      gross: (json['gross'] as num?)?.toDouble() ?? 0,
      taxableGross: (json['taxable_gross'] as num?)?.toDouble() ?? 0,
      deductions: (json['total_employee_deductions'] as num?)?.toDouble() ?? 0,
      netToPay: (json['net_to_pay'] as num?)?.toDouble() ?? 0,
      paymentDate: json['payment_date'] as String?,
    );

Map<String, dynamic> _$$MyPayslipDtoImplToJson(_$MyPayslipDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'periode': instance.periode,
      'statut': instance.statut,
      'gross': instance.gross,
      'taxable_gross': instance.taxableGross,
      'total_employee_deductions': instance.deductions,
      'net_to_pay': instance.netToPay,
      'payment_date': instance.paymentDate,
    };

_$MyDocumentDtoImpl _$$MyDocumentDtoImplFromJson(Map<String, dynamic> json) =>
    _$MyDocumentDtoImpl(
      id: json['id'] as String,
      nom: json['nom'] as String? ?? '',
      categorie: json['categorie'] as String?,
      description: json['description'] as String?,
      mimeType: json['mime_type'] as String?,
      taille: (json['taille'] as num?)?.toInt() ?? 0,
      date: json['date'] as String?,
      url: json['url'] as String?,
      storagePath: json['storage_path'] as String?,
      storageBucket: json['storage_bucket'] as String?,
    );

Map<String, dynamic> _$$MyDocumentDtoImplToJson(_$MyDocumentDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'description': instance.description,
      'mime_type': instance.mimeType,
      'taille': instance.taille,
      'date': instance.date,
      'url': instance.url,
      'storage_path': instance.storagePath,
      'storage_bucket': instance.storageBucket,
    };

_$InternalRegulationDtoImpl _$$InternalRegulationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$InternalRegulationDtoImpl(
  id: json['id'] as String,
  titre: json['titre'] as String? ?? '',
  version: json['version'] as String?,
  description: json['description'] as String?,
  publishedAt: json['published_at'] as String?,
  documentName: json['document_name'] as String?,
  mimeType: json['mime_type'] as String?,
  taille: (json['taille'] as num?)?.toInt() ?? 0,
  storagePath: json['storage_path'] as String?,
  storageBucket: json['storage_bucket'] as String?,
  acknowledgement: json['acknowledgement'] == null
      ? null
      : RegulationAckDto.fromJson(
          json['acknowledgement'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$InternalRegulationDtoImplToJson(
  _$InternalRegulationDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'titre': instance.titre,
  'version': instance.version,
  'description': instance.description,
  'published_at': instance.publishedAt,
  'document_name': instance.documentName,
  'mime_type': instance.mimeType,
  'taille': instance.taille,
  'storage_path': instance.storagePath,
  'storage_bucket': instance.storageBucket,
  'acknowledgement': instance.acknowledgement,
};

_$RegulationAckDtoImpl _$$RegulationAckDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegulationAckDtoImpl(
  status: json['status'] as String?,
  viewedAt: json['viewed_at'] as String?,
  signedAt: json['signed_at'] as String?,
);

Map<String, dynamic> _$$RegulationAckDtoImplToJson(
  _$RegulationAckDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'viewed_at': instance.viewedAt,
  'signed_at': instance.signedAt,
};

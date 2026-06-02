import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

enum ProfessionCategory { lifestyle, work, service }

extension ProfessionCategoryX on ProfessionCategory {
  String title(AppLocalizations l10n) {
    switch (this) {
      case ProfessionCategory.lifestyle:
        return l10n.professionCategoryLifestyleTitle;
      case ProfessionCategory.work:
        return l10n.professionCategoryWorkTitle;
      case ProfessionCategory.service:
        return l10n.professionCategoryServiceTitle;
    }
  }
}

enum UserProfessionProfile {
  student,
  officeWorker,
  freelancer,
  entrepreneur,
  manager,
  jobSeeker,
  caregiver,
  healthcareWorker,
  militaryOrReservist,
  policeOfficer,
  firefighter,
  driver,
  other,
}

extension UserProfessionProfileX on UserProfessionProfile {
  String title(AppLocalizations l10n) {
    switch (this) {
      case UserProfessionProfile.student:
        return l10n.professionStudentTitle;
      case UserProfessionProfile.officeWorker:
        return l10n.professionOfficeWorkerTitle;
      case UserProfessionProfile.freelancer:
        return l10n.professionFreelancerTitle;
      case UserProfessionProfile.entrepreneur:
        return l10n.professionEntrepreneurTitle;
      case UserProfessionProfile.manager:
        return l10n.professionManagerTitle;
      case UserProfessionProfile.jobSeeker:
        return l10n.professionJobSeekerTitle;
      case UserProfessionProfile.caregiver:
        return l10n.professionCaregiverTitle;
      case UserProfessionProfile.healthcareWorker:
        return l10n.professionHealthcareWorkerTitle;
      case UserProfessionProfile.militaryOrReservist:
        return l10n.professionMilitaryOrReservistTitle;
      case UserProfessionProfile.policeOfficer:
        return l10n.professionPoliceOfficerTitle;
      case UserProfessionProfile.firefighter:
        return l10n.professionFirefighterTitle;
      case UserProfessionProfile.driver:
        return l10n.professionDriverTitle;
      case UserProfessionProfile.other:
        return l10n.professionOtherTitle;
    }
  }

  String subtitle(AppLocalizations l10n) {
    switch (this) {
      case UserProfessionProfile.student:
        return l10n.professionStudentSubtitle;
      case UserProfessionProfile.officeWorker:
        return l10n.professionOfficeWorkerSubtitle;
      case UserProfessionProfile.freelancer:
        return l10n.professionFreelancerSubtitle;
      case UserProfessionProfile.entrepreneur:
        return l10n.professionEntrepreneurSubtitle;
      case UserProfessionProfile.manager:
        return l10n.professionManagerSubtitle;
      case UserProfessionProfile.jobSeeker:
        return l10n.professionJobSeekerSubtitle;
      case UserProfessionProfile.caregiver:
        return l10n.professionCaregiverSubtitle;
      case UserProfessionProfile.healthcareWorker:
        return l10n.professionHealthcareWorkerSubtitle;
      case UserProfessionProfile.militaryOrReservist:
        return l10n.professionMilitaryOrReservistSubtitle;
      case UserProfessionProfile.policeOfficer:
        return l10n.professionPoliceOfficerSubtitle;
      case UserProfessionProfile.firefighter:
        return l10n.professionFirefighterSubtitle;
      case UserProfessionProfile.driver:
        return l10n.professionDriverSubtitle;
      case UserProfessionProfile.other:
        return l10n.professionOtherSubtitle;
    }
  }

  String shortLabel(AppLocalizations l10n) {
    switch (this) {
      case UserProfessionProfile.student:
        return l10n.professionStudentShort;
      case UserProfessionProfile.officeWorker:
        return l10n.professionOfficeWorkerShort;
      case UserProfessionProfile.freelancer:
        return l10n.professionFreelancerShort;
      case UserProfessionProfile.entrepreneur:
        return l10n.professionEntrepreneurShort;
      case UserProfessionProfile.manager:
        return l10n.professionManagerShort;
      case UserProfessionProfile.jobSeeker:
        return l10n.professionJobSeekerShort;
      case UserProfessionProfile.caregiver:
        return l10n.professionCaregiverShort;
      case UserProfessionProfile.healthcareWorker:
        return l10n.professionHealthcareWorkerShort;
      case UserProfessionProfile.militaryOrReservist:
        return l10n.professionMilitaryOrReservistShort;
      case UserProfessionProfile.policeOfficer:
        return l10n.professionPoliceOfficerShort;
      case UserProfessionProfile.firefighter:
        return l10n.professionFirefighterShort;
      case UserProfessionProfile.driver:
        return l10n.professionDriverShort;
      case UserProfessionProfile.other:
        return l10n.professionOtherShort;
    }
  }

  ProfessionCategory get category {
    switch (this) {
      case UserProfessionProfile.student:
      case UserProfessionProfile.caregiver:
      case UserProfessionProfile.other:
        return ProfessionCategory.lifestyle;
      case UserProfessionProfile.officeWorker:
      case UserProfessionProfile.freelancer:
      case UserProfessionProfile.entrepreneur:
      case UserProfessionProfile.manager:
      case UserProfessionProfile.jobSeeker:
        return ProfessionCategory.work;
      case UserProfessionProfile.healthcareWorker:
      case UserProfessionProfile.militaryOrReservist:
      case UserProfessionProfile.policeOfficer:
      case UserProfessionProfile.firefighter:
      case UserProfessionProfile.driver:
        return ProfessionCategory.service;
    }
  }

  IconData get icon {
    switch (this) {
      case UserProfessionProfile.student:
        return Icons.school_outlined;
      case UserProfessionProfile.officeWorker:
        return Icons.desktop_windows_outlined;
      case UserProfessionProfile.freelancer:
        return Icons.work_outline_rounded;
      case UserProfessionProfile.entrepreneur:
        return Icons.trending_up_rounded;
      case UserProfessionProfile.manager:
        return Icons.groups_2_outlined;
      case UserProfessionProfile.jobSeeker:
        return Icons.search_rounded;
      case UserProfessionProfile.caregiver:
        return Icons.favorite_outline_rounded;
      case UserProfessionProfile.healthcareWorker:
        return Icons.local_hospital_outlined;
      case UserProfessionProfile.militaryOrReservist:
        return Icons.shield_outlined;
      case UserProfessionProfile.policeOfficer:
        return Icons.verified_user_outlined;
      case UserProfessionProfile.firefighter:
        return Icons.local_fire_department_outlined;
      case UserProfessionProfile.driver:
        return Icons.directions_car_outlined;
      case UserProfessionProfile.other:
        return Icons.adjust_rounded;
    }
  }

  static UserProfessionProfile fromName(String value) {
    return UserProfessionProfile.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserProfessionProfile.student,
    );
  }
}

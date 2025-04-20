class Portfolio {
  final PersonalInfo personalInfo;
  final List<ExperienceItem> experience;
  final List<ProjectItem> projects;
  final List<SkillCategory> skills;
  final List<EducationItem> education;
  final SocialLinks socialLinks;

  Portfolio({
    required this.personalInfo,
    required this.experience,
    required this.projects,
    required this.skills,
    required this.education,
    required this.socialLinks,
  });
}

class PersonalInfo {
  final String name;
  final String tagline;
  final String profileImageUrl;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final List<String> areasOfExpertise;

  PersonalInfo({
    required this.name,
    required this.tagline,
    required this.profileImageUrl,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.areasOfExpertise,
  });
}

class ExperienceItem {
  final String company;
  final String position;
  final String duration;
  final String location;
  final List<String> responsibilities;
  final String? companyLogoUrl;

  ExperienceItem({
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.responsibilities,
    this.companyLogoUrl,
  });
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? projectUrl;
  final String? githubUrl;

  ProjectItem({
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.projectUrl,
    this.githubUrl,
  });
}

class SkillCategory {
  final String category;
  final List<SkillItem> skills;

  SkillCategory({
    required this.category,
    required this.skills,
  });
}

class SkillItem {
  final String name;
  final double proficiency; // 0.0 to 1.0

  SkillItem({
    required this.name,
    required this.proficiency,
  });
}

class EducationItem {
  final String institution;
  final String degree;
  final String duration;
  final String? gpa;
  final String? location;
  final String? logoUrl;

  EducationItem({
    required this.institution,
    required this.degree,
    required this.duration,
    this.gpa,
    this.location,
    this.logoUrl,
  });
}

class SocialLinks {
  final String? linkedin;
  final String? github;
  final String? twitter;
  final String? instagram;
  final String? behance;
  final String? dribbble;
  final String? medium;
  final String? website;

  SocialLinks({
    this.linkedin,
    this.github,
    this.twitter,
    this.instagram,
    this.behance,
    this.dribbble,
    this.medium,
    this.website,
  });
}
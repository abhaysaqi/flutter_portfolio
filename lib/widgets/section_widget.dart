import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/constant.dart';
import 'package:portfolio/constants/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/pdf_service.dart';

// Home Section Widget
class HomeSection extends StatelessWidget {
  final PersonalInfo personalInfo;
  final Function(int) scrollToContact;

  const HomeSection(
      {super.key, required this.personalInfo, required this.scrollToContact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: isSmallScreen
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(context, 150),
                const SizedBox(height: Constants.paddingL),
                _buildProfileInfo(context, true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(context, 220),
                const SizedBox(width: Constants.paddingXL),
                Expanded(child: _buildProfileInfo(context, false)),
              ],
            ),
    ).animate().fadeIn(duration: 800.ms, delay: 300.ms).slideY(
        begin: 0.2, end: 0, duration: 800.ms, curve: Curves.easeOutQuint);
  }

  Widget _buildProfileImage(BuildContext context, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(personalInfo.profileImageUrl),
          fit: BoxFit.cover,
        ),
      ),
    ).animate().scale(
        begin: const Offset(0.8, 0.8),
        end: const Offset(1.0, 1.0),
        duration: 800.ms,
        curve: Curves.elasticOut);
  }

  Widget _buildProfileInfo(BuildContext context, bool isSmallScreen) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isSmallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          personalInfo.name,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: isSmallScreen ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: Constants.paddingS),
        Text(
          personalInfo.tagline,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: isSmallScreen ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: Constants.paddingL),
        Row(
          mainAxisAlignment: isSmallScreen
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => PdfService.downloadResume(
                context,
                Portfolio(
                  personalInfo: personalInfo,
                  experience: [],
                  projects: [],
                  skills: [],
                  education: [],
                  socialLinks: SocialLinks(),
                ),
              ),
              icon: !isSmallScreen
                  ? Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    )
                  : SizedBox(),
              label: const Text('Download Resume'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 10 : 24,
                    vertical: isSmallScreen ? 12 : 16),
              ),
            ),
            const SizedBox(width: Constants.paddingM),
            OutlinedButton.icon(
              onPressed: () {
                // Constants.launchEmail(personalInfo.email);
                scrollToContact(6);
              },
              icon: !isSmallScreen
                  ? Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    )
                  : SizedBox(),
              label: const Text('Contact Me'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 16 : 24,
                    vertical: isSmallScreen ? 12 : 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// About Section Widget
class AboutSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const AboutSection({super.key, required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingL),
          Text(
            personalInfo.bio,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
          const SizedBox(height: Constants.paddingXL),
          Text(
            'Areas of Expertise',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          const SizedBox(height: Constants.paddingM),
          Wrap(
            spacing: Constants.paddingM,
            runSpacing: Constants.paddingM,
            children: personalInfo.areasOfExpertise
                .asMap()
                .entries
                .map((entry) =>
                    _buildExpertiseChip(context, entry.value, entry.key))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseChip(
      BuildContext context, String expertise, int index) {
    final theme = Theme.of(context);

    return Chip(
      label: Text(expertise),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 0,
    )
        .animate()
        .fadeIn(
            delay: Duration(milliseconds: 500 + (index * 100)),
            duration: 600.ms)
        .scale(
            delay: Duration(milliseconds: 500 + (index * 100)),
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 600.ms);
  }
}

// Experience Section Widget
class ExperienceSection extends StatelessWidget {
  final List<ExperienceItem> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Experience',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingXL),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              return _buildExperienceItem(context, experiences[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
      BuildContext context, ExperienceItem experience, int index) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: Constants.paddingXL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSmallScreen) ...[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(Constants.radiusM),
              ),
              alignment: Alignment.center,
              child: Text(
                experience.company.substring(0, 2).toUpperCase(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: Constants.paddingL),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        experience.position,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!isSmallScreen)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.paddingM,
                          vertical: Constants.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(Constants.radiusL),
                        ),
                        child: Text(
                          experience.duration,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                if (isSmallScreen) ...[
                  const SizedBox(height: Constants.paddingXS),
                  Text(
                    experience.duration,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: Constants.paddingXS),
                Text(
                  '${experience.company} • ${experience.location}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: Constants.paddingM),
                ...experience.responsibilities.map((responsibility) =>
                    _buildResponsibilityItem(context, responsibility)),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 200 * index), duration: 800.ms)
        .slideY(
            delay: Duration(milliseconds: 200 * index),
            begin: 0.3,
            end: 0,
            duration: 600.ms,
            curve: Curves.easeOutQuint);
  }

  Widget _buildResponsibilityItem(BuildContext context, String responsibility) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.paddingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right_rounded,
            color: theme.colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: Constants.paddingXS),
          Expanded(
            child: Text(
              responsibility,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Projects Section Widget
class ProjectsSection extends StatelessWidget {
  final List<ProjectItem> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingL),
          isSmallScreen
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: Constants.paddingL),
                      child: _buildProjectCard(context, projects[index], index),
                    );
                  },
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: Constants.paddingL,
                    mainAxisSpacing: Constants.paddingL,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _buildProjectCard(context, projects[index], index);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      BuildContext context, ProjectItem project, int index) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image
          if (project.imageUrl != null)
            Container(
              height: isSmallScreen ? 180 : 140,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(project.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(Constants.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Constants.paddingS),
                Text(
                  project.description,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Constants.paddingM),
                Wrap(
                  spacing: Constants.paddingXS,
                  runSpacing: Constants.paddingXS,
                  children: project.technologies
                      .map((tech) => Chip(
                            label: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                            backgroundColor:
                                theme.colorScheme.secondaryContainer,
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ))
                      .toList(),
                ),
                const SizedBox(height: Constants.paddingM),
                Row(
                  children: [
                    if (project.githubUrl != null)
                      IconButton(
                        onPressed: () =>
                            Constants.launchURL(project.githubUrl!),
                        icon: const Icon(Constants.githubIcon),
                        tooltip: 'View on GitHub',
                        color: theme.colorScheme.primary,
                      ),
                    if (project.projectUrl != null)
                      IconButton(
                        onPressed: () =>
                            Constants.launchURL(project.projectUrl!),
                        icon: const Icon(Icons.open_in_new_rounded),
                        tooltip: 'View Project',
                        color: theme.colorScheme.primary,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 800.ms)
        .scale(
            delay: Duration(milliseconds: 100 * index),
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: 600.ms);
  }
}

// Skills Section Widget
class SkillsSection extends StatelessWidget {
  final List<SkillCategory> skillCategories;

  const SkillsSection({super.key, required this.skillCategories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingXL),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skillCategories.length,
            itemBuilder: (context, index) {
              return _buildSkillCategory(
                  context, skillCategories[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
      BuildContext context, SkillCategory category, int categoryIndex) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.category,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ).animate().fadeIn(
              delay: Duration(milliseconds: 200 * categoryIndex),
              duration: 600.ms),
          const SizedBox(height: Constants.paddingM),
          ...category.skills.asMap().entries.map(
                (entry) => _buildSkillItem(
                    context, entry.value, categoryIndex, entry.key),
              ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(BuildContext context, SkillItem skill,
      int categoryIndex, int skillIndex) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;
    final maxBarWidth =
        isSmallScreen ? size.width - (Constants.paddingL * 2) : 600.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(skill.proficiency * 100).toInt()}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.paddingXS),
          Stack(
            children: [
              // Background
              Container(
                height: 8,
                width: maxBarWidth,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(Constants.radiusM),
                ),
              ),
              // Progress
              Container(
                height: 8,
                width: maxBarWidth * skill.proficiency,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(Constants.radiusM),
                ),
              )
                  .animate()
                  .fadeIn(
                      delay: Duration(
                          milliseconds:
                              300 + (200 * categoryIndex) + (100 * skillIndex)),
                      duration: 300.ms)
                  .slide(
                      delay: Duration(
                          milliseconds:
                              300 + (200 * categoryIndex) + (100 * skillIndex)),
                      begin: const Offset(-1.0, 0),
                      end: Offset.zero,
                      duration: 800.ms,
                      curve: Curves.easeOutQuint),
            ],
          ),
        ],
      ),
    );
  }
}

// Education Section Widget
class EducationSection extends StatelessWidget {
  final List<EducationItem> educationItems;

  const EducationSection({super.key, required this.educationItems});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingXL),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: educationItems.length,
            itemBuilder: (context, index) {
              return _buildEducationItem(context, educationItems[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
      BuildContext context, EducationItem education, int index) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: Constants.paddingL),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.radiusL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Constants.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      education.institution,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!isSmallScreen)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.paddingM,
                        vertical: Constants.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(Constants.radiusL),
                      ),
                      child: Text(
                        education.duration,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Constants.paddingM),
              Text(
                education.degree,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              if (isSmallScreen) ...[
                const SizedBox(height: Constants.paddingS),
                Text(
                  education.duration,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (education.gpa != null) ...[
                const SizedBox(height: Constants.paddingS),
                Text(
                  'GPA: ${education.gpa}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
              if (education.location != null) ...[
                const SizedBox(height: Constants.paddingS),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    const SizedBox(width: Constants.paddingXS),
                    Text(
                      education.location!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 200 * index), duration: 800.ms)
        .slideY(
            delay: Duration(milliseconds: 200 * index),
            begin: 0.3,
            end: 0,
            duration: 600.ms,
            curve: Curves.easeOutQuint);
  }
}

// Contact Section Widget
class ContactSection extends StatelessWidget {
  final PersonalInfo personalInfo;
  final SocialLinks socialLinks;

  const ContactSection({
    super.key,
    required this.personalInfo,
    required this.socialLinks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? Constants.paddingL : Constants.paddingXXL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slide(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutQuint),
          const SizedBox(height: Constants.paddingL),
          Text(
            'Feel free to reach out for collaborations, opportunities, or just a chat about technology and design!',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
          const SizedBox(height: Constants.paddingXL),
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: Constants.paddingXL),
                    _buildSocialLinks(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    const SizedBox(width: Constants.paddingXXL),
                    Expanded(child: _buildSocialLinks(context)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Column(
      crossAxisAlignment:
          isSmallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
        const SizedBox(height: Constants.paddingL),
        _buildContactItem(
          context: context,
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: personalInfo.email,
          onTap: () => Constants.launchEmail(personalInfo.email),
          index: 0,
        ),
        _buildContactItem(
          context: context,
          icon: Icons.phone_outlined,
          title: 'Phone',
          subtitle: personalInfo.phone,
          onTap: () => Constants.launchPhone(personalInfo.phone),
          index: 1,
        ),
        _buildContactItem(
          context: context,
          icon: Icons.location_on_outlined,
          title: 'Location',
          subtitle: personalInfo.location,
          index: 2,
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    required int index,
  }) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Constants.radiusL),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: Constants.paddingL),
        padding: const EdgeInsets.all(Constants.paddingL),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Constants.radiusL),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: isSmallScreen
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Constants.radiusM),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: Constants.paddingM),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.paddingXS),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: onTap != null ? theme.colorScheme.primary : null,
                    decoration: onTap != null ? TextDecoration.underline : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
            delay: Duration(milliseconds: 700 + (200 * index)),
            duration: 800.ms)
        .slide(
            delay: Duration(milliseconds: 700 + (200 * index)),
            begin: const Offset(-0.2, 0),
            end: Offset.zero,
            duration: 600.ms,
            curve: Curves.easeOutQuint);
  }

  Widget _buildSocialLinks(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Column(
      crossAxisAlignment:
          isSmallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Me',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
        const SizedBox(height: Constants.paddingL),
        Wrap(
          spacing: Constants.paddingM,
          runSpacing: Constants.paddingM,
          children: [
            if (socialLinks.linkedin != null)
              _buildSocialButton(
                context: context,
                icon: Constants.linkedinIcon,
                url: socialLinks.linkedin!,
                label: 'LinkedIn',
                index: 0,
              ),
            if (socialLinks.github != null)
              _buildSocialButton(
                context: context,
                icon: Constants.githubIcon,
                url: socialLinks.github!,
                label: 'GitHub',
                index: 1,
              ),
            if (socialLinks.twitter != null)
              _buildSocialButton(
                context: context,
                icon: Constants.twitterIcon,
                url: socialLinks.twitter!,
                label: 'Twitter',
                index: 2,
              ),
            if (socialLinks.instagram != null)
              _buildSocialButton(
                context: context,
                icon: Constants.instagramIcon,
                url: socialLinks.instagram!,
                label: 'Instagram',
                index: 3,
              ),
            if (socialLinks.behance != null)
              _buildSocialButton(
                context: context,
                icon: Constants.behanceIcon,
                url: socialLinks.behance!,
                label: 'Behance',
                index: 4,
              ),
            if (socialLinks.medium != null)
              _buildSocialButton(
                context: context,
                icon: Constants.mediumIcon,
                url: socialLinks.medium!,
                label: 'Medium',
                index: 5,
              ),
            if (socialLinks.website != null)
              _buildSocialButton(
                context: context,
                icon: Constants.websiteIcon,
                url: socialLinks.website!,
                label: 'Website',
                index: 6,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required String url,
    required String label,
    required int index,
  }) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      onPressed: () => Constants.launchURL(url),
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingL, vertical: Constants.paddingM),
        backgroundColor: theme.colorScheme.primary,
      ),
    )
        .animate()
        .fadeIn(
            delay: Duration(milliseconds: 700 + (100 * index)),
            duration: 800.ms)
        .scale(
            delay: Duration(milliseconds: 700 + (100 * index)),
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
            duration: 600.ms);
  }
}

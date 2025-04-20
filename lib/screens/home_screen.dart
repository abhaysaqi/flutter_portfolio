import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/animation/animated_bg.dart';
import 'package:portfolio/constants/constant.dart';
import 'package:portfolio/constants/portfolio_data.dart';
import 'package:portfolio/constants/sample_data.dart';
import 'package:portfolio/theme/theme_provider.dart';
import 'package:portfolio/widgets/section_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late Portfolio _portfolioData;
  int _currentIndex = 0;
  final List<String> _sectionTitles = [
    Constants.homeSectionTitle,
    Constants.aboutSectionTitle,
    Constants.experienceSectionTitle,
    Constants.projectsSectionTitle,
    Constants.skillsSectionTitle,
    Constants.educationSectionTitle,
    Constants.contactSectionTitle,
  ];

  final List<IconData> _sectionIcons = [
    Constants.homeIcon,
    Constants.aboutIcon,
    Constants.experienceIcon,
    Constants.projectsIcon,
    Constants.skillsIcon,
    Constants.educationIcon,
    Constants.contactIcon,
  ];

  final List<GlobalKey> _sectionKeys = List.generate(7, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _portfolioData = SampleData.getPortfolioData();

    _scrollController.addListener(() {
      _updateCurrentIndexBasedOnScroll();
    });
  }

   void _updateCurrentIndexBasedOnScroll() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final RenderBox? renderBox =
          _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        if (position.dy <= 100) {
          // 100px from the top
          if (_currentIndex != i) {
            setState(() {
              _currentIndex = i;
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final RenderBox renderBox =
        _sectionKeys[index].currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final offset =
        _scrollController.offset + position.dy - 80; // 80px offset for app bar

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode();
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;
    final bool isMediumScreen = size.width >= 600 && size.width < 1024;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBackground(isDarkMode: isDarkMode),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(context, isDarkMode),

                // Main Content
                Expanded(
                  child: Row(
                    children: [
                      // Sidebar Navigation (only on larger screens)
                      if (!isSmallScreen) _buildSidebar(context),

                      // Main Content Sections
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                  key: _sectionKeys[0],
                                  child: HomeSection(
                                      personalInfo:
                                          _portfolioData.personalInfo,scrollToContact:  _scrollToSection)),
                              Container(
                                  key: _sectionKeys[1],
                                  child: AboutSection(
                                      personalInfo:
                                          _portfolioData.personalInfo)),
                              Container(
                                  key: _sectionKeys[2],
                                  child: ExperienceSection(
                                      experiences: _portfolioData.experience)),
                              Container(
                                  key: _sectionKeys[3],
                                  child: ProjectsSection(
                                      projects: _portfolioData.projects)),
                              Container(
                                  key: _sectionKeys[4],
                                  child: SkillsSection(
                                      skillCategories: _portfolioData.skills)),
                              Container(
                                  key: _sectionKeys[5],
                                  child: EducationSection(
                                      educationItems:
                                          _portfolioData.education)),
                              Container(
                                key: _sectionKeys[6],
                                child: ContactSection(
                                  personalInfo: _portfolioData.personalInfo,
                                  socialLinks: _portfolioData.socialLinks,
                                ),
                              ),
                              // Footer with copyright
                              _buildFooter(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation for small screens
      bottomNavigationBar:
          isSmallScreen ? _buildBottomNavigation(context) : null,

      // Floating Action Button for medium screens (tablet)
      floatingActionButton: isMediumScreen
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => _buildNavigationSheet(context),
                );
              },
              child: const Icon(Icons.menu),
            ).animate().scale(duration: 300.ms, curve: Curves.elasticOut)
          : null,
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDarkMode) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.paddingM,
        vertical: Constants.paddingS,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  Constants.getInitials(_portfolioData.personalInfo.name),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: Constants.paddingS),
              Text(
                _portfolioData.personalInfo.name.split(' ')[0],
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: Constants.paddingL),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: List.generate(_sectionTitles.length, (index) {
          return Tooltip(
            message: _sectionTitles[index],
            child: InkWell(
              onTap: () => _scrollToSection(index),
              child: Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(bottom: Constants.paddingM),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(Constants.radiusL),
                  boxShadow: _currentIndex == index
                      ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  _sectionIcons[index],
                  color: _currentIndex == index
                      ? Colors.white
                      : theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _scrollToSection,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
        items: List.generate(_sectionTitles.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_sectionIcons[index]),
            label: _sectionTitles[index],
          );
        }),
      ),
    );
  }

  Widget _buildNavigationSheet(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.paddingL,
        vertical: Constants.paddingXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Navigation',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Constants.paddingL),
          Wrap(
            spacing: Constants.paddingM,
            runSpacing: Constants.paddingM,
            alignment: WrapAlignment.center,
            children: List.generate(_sectionTitles.length, (index) {
              return ActionChip(
                avatar: Icon(
                  _sectionIcons[index],
                  color: _currentIndex == index
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.primary,
                  size: 18,
                ),
                label: Text(_sectionTitles[index]),
                labelStyle: TextStyle(
                  color: _currentIndex == index
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: _currentIndex == index
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                elevation: _currentIndex == index ? 2 : 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.paddingM,
                  vertical: Constants.paddingS,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _scrollToSection(index);
                },
              );
            }),
          ),
          const SizedBox(height: Constants.paddingXL),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(Constants.paddingL),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: Constants.paddingM),
          Text(
            '© ${DateTime.now().year} ${_portfolioData.personalInfo.name} | All Rights Reserved',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.paddingS),
          Text(
            'Made with Flutter ❤️',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

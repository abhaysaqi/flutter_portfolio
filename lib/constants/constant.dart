import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
  // App specific strings
  static const String appName = 'Portfolio';
  static const String resumeFileName = 'resume.pdf';
  
  // Common padding values
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Border radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  
  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 500);
  static const Duration animationDurationSlow = Duration(milliseconds: 800);
  
  // Section titles
  static const String homeSectionTitle = 'Home';
  static const String aboutSectionTitle = 'About';
  static const String experienceSectionTitle = 'Experience';
  static const String projectsSectionTitle = 'Projects';
  static const String skillsSectionTitle = 'Skills';
  static const String educationSectionTitle = 'Education';
  static const String contactSectionTitle = 'Contact';
  
  // Section icons
  static const IconData homeIcon = Icons.home_rounded;
  static const IconData aboutIcon = Icons.person_rounded;
  static const IconData experienceIcon = Icons.work_rounded;
  static const IconData projectsIcon = Icons.code_rounded;
  static const IconData skillsIcon = Icons.lightbulb_rounded;
  static const IconData educationIcon = Icons.school_rounded;
  static const IconData contactIcon = Icons.email_rounded;
  
  // Social media icons
  static const IconData linkedinIcon = Icons.link;
  static const IconData githubIcon = Icons.code;
  static const IconData twitterIcon = Icons.flutter_dash;
  static const IconData instagramIcon = Icons.camera_alt_rounded;
  static const IconData behanceIcon = Icons.brush_rounded;
  static const IconData dribbbleIcon = Icons.sports_basketball_rounded;
  static const IconData mediumIcon = Icons.article_rounded;
  static const IconData websiteIcon = Icons.language_rounded;
  
  // Helper functions
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  
  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $email');
    }
  }
  
  static Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (!await launchUrl(phoneUri)) {
      throw Exception('Could not launch $phone');
    }
  }
  
  // String extensions
  static String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    
    if (nameParts.length > 1) {
      initials = nameParts[0][0] + nameParts[1][0];
    } else if (nameParts.length == 1) {
      initials = nameParts[0][0];
    }
    
    return initials.toUpperCase();
  }
}
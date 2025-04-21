import 'package:portfolio/constants/portfolio_data.dart';



class SampleData {
  static Portfolio getPortfolioData() {
    return Portfolio(
      personalInfo: PersonalInfo(
        name: 'Abhay Kumar',
        tagline: 'Senior Software Engineer & UI/UX Enthusiast',
        profileImageUrl: "https://pixabay.com/get/g9bfda3bf4ef771aba4df4accfcf40ecfa55bfa0ebf17fe57689af670e7494698c23ff670d614791164c226bd5df46c80ee82c7754538db1a26cf17f6d3db13a9_1280.jpg",
        bio: 'Passionate software engineer with 6+ years of experience creating innovative web and mobile solutions. Specializing in Flutter, React, and cloud architecture with a focus on creating elegant user experiences that solve real-world problems.',
        email: 'abhaysaqi9@gmail.com',
        phone: '+91 9056121323',
        location: 'Jalandhar, Punjab',
        areasOfExpertise: [
          'Mobile App Development',
          'UI/UX Design',
          'Cloud Architecture',
          'Front-end Development',
          'Agile Project Management',
        ],
      ),
      experience: [
        ExperienceItem(
          company: 'TechNova Solutions',
          position: 'Senior Software Engineer',
          duration: 'Jan 2021 - Present',
          location: 'San Francisco, CA',
          responsibilities: [
            'Lead a team of 5 developers building cross-platform applications using Flutter',
            'Architect and implement cloud-based solutions using AWS and Firebase',
            'Conduct code reviews and mentor junior developers',
            'Reduced app load time by 40% through performance optimizations',
            'Implemented CI/CD pipelines that decreased deployment time by 60%',
          ],
        ),
        ExperienceItem(
          company: 'InnovateMobile',
          position: 'Mobile Developer',
          duration: 'Mar 2018 - Dec 2020',
          location: 'Boston, MA',
          responsibilities: [
            'Developed and maintained multiple iOS and Android applications using React Native',
            'Collaborated with designers to implement pixel-perfect UI/UX',
            'Integrated RESTful APIs and implemented offline-first data persistence',
            'Launched 4 successful apps with 500,000+ combined downloads',
            'Improved app store ratings from 3.2 to 4.7 stars through user-focused enhancements',
          ],
        ),
        ExperienceItem(
          company: 'WebFront Systems',
          position: 'Frontend Developer',
          duration: 'Jun 2016 - Feb 2018',
          location: 'Seattle, WA',
          responsibilities: [
            'Built responsive web applications using React and Angular',
            'Implemented state management solutions using Redux and Context API',
            'Optimized web performance and accessibility across multiple browsers',
            'Participated in Agile development processes and sprint planning',
            'Created reusable component libraries that increased development efficiency by 30%',
          ],
        ),
      ],
      projects: [
        ProjectItem(
          title: 'HealthTrack Pro',
          description: 'A comprehensive health tracking application that allows users to monitor fitness activities, nutrition, and wellness metrics. Features include real-time synchronization, personalized insights, and social sharing capabilities.',
          technologies: ['Flutter', 'Firebase', 'Google Fit API', 'Apple HealthKit'],
          imageUrl: "https://pixabay.com/get/g6482dd43f37abcfcc09f5e0914f6d970baf6f782a3a8e62fcd87c9804323752f00ce160b6b004c535e0cf8d9a41a74b082e3d2e862d7d4380a1b677deb44717b_1280.jpg",
          projectUrl: 'https://healthtrackpro.example.com',
          githubUrl: '',
        ),
        ProjectItem(
          title: 'EcoRoute',
          description: 'An eco-friendly navigation app that suggests routes optimized for lower carbon emissions. The app calculates CO2 savings and provides incentives for choosing greener transportation methods.',
          technologies: ['Flutter', 'Google Maps API', 'TensorFlow Lite', 'SQLite'],
          imageUrl: "https://pixabay.com/get/g3c418b30098aff0bee5321f858a4a74a72e4cda4412942333345af8692b37db9745cf275885de38c272dad3645af4f71dd33105879480a9001fedc2dfc5694f8_1280.jpg",
          projectUrl: 'https://ecoroute.example.com',
          githubUrl: '',
        ),
        ProjectItem(
          title: 'TaskFlow',
          description: 'A modern task management solution designed for teams with advanced workflow automation. Features Kanban boards, time tracking, and customizable project templates.',
          technologies: ['React', 'Node.js', 'MongoDB', 'Socket.io'],
          imageUrl: "https://pixabay.com/get/g870c3c1f0485f2fe0e6c2f78bb457c9e3735bdfe8414bbcec6885dd85c5775f4b0d600ef8d700008316962c41e91ccb0bda0a21d01a63b71cb3d06db20756445_1280.jpg",
          projectUrl: 'https://taskflow.example.com',
          githubUrl: '',
        ),
        ProjectItem(
          title: 'CryptoInsight',
          description: 'A cryptocurrency portfolio tracker and market analysis tool with real-time price alerts and trading simulations to help users make informed investment decisions.',
          technologies: ['Flutter', 'CoinGecko API', 'WebSockets', 'Hive DB'],
          imageUrl: "https://pixabay.com/get/g90d1ef907768884513e49c20d78062234823bf06c6bc20a8af88fe7503c1e1d99eea46f7fef0dff0ef9fa5aefca4d98cd0efcf166a7793d031d5bb6acb348f9a_1280.jpg",
          projectUrl: 'https://cryptoinsight.example.com',
          githubUrl: '',
        ),
      ],
      skills: [
        SkillCategory(
          category: 'Programming Languages',
          skills: [
            SkillItem(name: 'Dart', proficiency: 0.95),
            SkillItem(name: 'JavaScript', proficiency: 0.90),
            SkillItem(name: 'TypeScript', proficiency: 0.85),
            SkillItem(name: 'Python', proficiency: 0.75),
            SkillItem(name: 'Java', proficiency: 0.70),
            SkillItem(name: 'Swift', proficiency: 0.65),
          ],
        ),
        SkillCategory(
          category: 'Frameworks & Libraries',
          skills: [
            SkillItem(name: 'Flutter', proficiency: 0.95),
            SkillItem(name: 'React', proficiency: 0.90),
            SkillItem(name: 'React Native', proficiency: 0.85),
            SkillItem(name: 'Angular', proficiency: 0.70),
            SkillItem(name: 'Node.js', proficiency: 0.80),
            SkillItem(name: 'Express.js', proficiency: 0.75),
          ],
        ),
        SkillCategory(
          category: 'Tools & Platforms',
          skills: [
            SkillItem(name: 'Git', proficiency: 0.95),
            SkillItem(name: 'Docker', proficiency: 0.80),
            SkillItem(name: 'Firebase', proficiency: 0.90),
            SkillItem(name: 'AWS', proficiency: 0.75),
            SkillItem(name: 'CI/CD', proficiency: 0.85),
            SkillItem(name: 'Figma', proficiency: 0.70),
          ],
        ),
        SkillCategory(
          category: 'Databases',
          skills: [
            SkillItem(name: 'MongoDB', proficiency: 0.85),
            SkillItem(name: 'MySQL', proficiency: 0.80),
            SkillItem(name: 'PostgreSQL', proficiency: 0.75),
            SkillItem(name: 'Firestore', proficiency: 0.90),
            SkillItem(name: 'SQLite', proficiency: 0.85),
          ],
        ),
      ],
      education: [
        EducationItem(
          institution: 'Massachusetts Institute of Technology',
          degree: 'Master of Science in Computer Science',
          duration: '2014 - 2016',
          gpa: '3.92/4.0',
          location: 'Cambridge, MA',
        ),
        EducationItem(
          institution: 'University of California, Berkeley',
          degree: 'Bachelor of Science in Computer Engineering',
          duration: '2010 - 2014',
          gpa: '3.85/4.0',
          location: 'Berkeley, CA',
        ),
        EducationItem(
          institution: 'Coursera & Udacity',
          degree: 'Professional Certifications',
          duration: '2016 - Present',
          location: 'Online',
        ),
      ],
      socialLinks: SocialLinks(
        linkedin: 'https://linkedin.com/in/alexmorgan',
        github: 'https://github.com/alexmorgan',
        twitter: 'https://twitter.com/alexmorgan',
        instagram: 'https://instagram.com/alexmorgan.dev',
        behance: 'https://behance.net/alexmorgan',
        medium: 'https://medium.com/@alexmorgan',
        website: 'https://alexmorgan.dev',
      ),
    );
  }
}
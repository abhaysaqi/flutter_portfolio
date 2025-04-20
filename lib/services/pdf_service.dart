import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:portfolio/constants/constant.dart';
import 'package:portfolio/constants/portfolio_data.dart';
import 'package:printing/printing.dart';

class PdfService {
  // Generate PDF resume from portfolio data
  static Future<Uint8List> generateResume(Portfolio portfolio) async {
    final pdf = pw.Document();
    
    // Load a font for better styling
    final font = await PdfGoogleFonts.montserratRegular();
    final fontBold = await PdfGoogleFonts.montserratBold();
    final fontItalic = await PdfGoogleFonts.montserratItalic();
    
    // Define styles
    final titleStyle = pw.TextStyle(font: fontBold, fontSize: 24, color: PdfColors.indigo900);
    final headingStyle = pw.TextStyle(font: fontBold, fontSize: 16, color: PdfColors.indigo700);
    final sectionTitleStyle = pw.TextStyle(font: fontBold, fontSize: 14, color: PdfColors.teal700);
    final bodyStyle = pw.TextStyle(font: font, fontSize: 11);
    final bodyBoldStyle = pw.TextStyle(font: fontBold, fontSize: 11);
    final bodyItalicStyle = pw.TextStyle(font: fontItalic, fontSize: 11, color: PdfColors.grey700);
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header - Name and Contact Info
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(portfolio.personalInfo.name, style: titleStyle),
                  pw.SizedBox(height: 8),
                  pw.Text(portfolio.personalInfo.tagline, style: headingStyle),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(portfolio.personalInfo.email, style: bodyStyle),
                      pw.Text(portfolio.personalInfo.phone, style: bodyStyle),
                      pw.Text(portfolio.personalInfo.location, style: bodyStyle),
                    ],
                  ),
                  pw.Divider(color: PdfColors.indigo200),
                ],
              ),
            ),
            
            // Summary
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('SUMMARY', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  pw.Paragraph(text: portfolio.personalInfo.bio, style: bodyStyle),
                  pw.SizedBox(height: 12),
                ],
              ),
            ),
            
            // Areas of Expertise
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('AREAS OF EXPERTISE', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      ...portfolio.personalInfo.areasOfExpertise.map((expertise) => 
                        pw.Container(
                          margin: const pw.EdgeInsets.only(right: 16, bottom: 8),
                          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey100,
                            borderRadius: pw.BorderRadius.circular(12),
                            border: pw.Border.all(color: PdfColors.grey300),
                          ),
                          child: pw.Text(expertise, style: bodyStyle),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                ],
              ),
            ),
            
            // Experience
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('PROFESSIONAL EXPERIENCE', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  ...portfolio.experience.map((exp) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(exp.position, style: bodyBoldStyle),
                          pw.Text(exp.duration, style: bodyItalicStyle),
                        ],
                      ),
                      pw.Text('${exp.company} | ${exp.location}', style: bodyStyle),
                      pw.SizedBox(height: 8),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          ...exp.responsibilities.map((resp) => pw.Bullet(text: resp, style: bodyStyle)),
                        ],
                      ),
                      pw.SizedBox(height: 16),
                    ],
                  )),
                ],
              ),
            ),
            
            // Education
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('EDUCATION', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  ...portfolio.education.map((edu) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(edu.degree, style: bodyBoldStyle),
                          pw.Text(edu.duration, style: bodyItalicStyle),
                        ],
                      ),
                      pw.Text(edu.institution, style: bodyStyle),
                      if (edu.gpa != null) pw.Text('GPA: ${edu.gpa}', style: bodyStyle),
                      if (edu.location != null) pw.Text(edu.location!, style: bodyStyle),
                      pw.SizedBox(height: 12),
                    ],
                  )),
                ],
              ),
            ),
            
            // Skills
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('SKILLS', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  ...portfolio.skills.map((category) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(category.category, style: bodyBoldStyle),
                      pw.SizedBox(height: 4),
                      pw.Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...category.skills.map((skill) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              borderRadius: pw.BorderRadius.circular(8),
                            ),
                            child: pw.Text(skill.name, style: bodyStyle),
                          )),
                        ],
                      ),
                      pw.SizedBox(height: 12),
                    ],
                  )),
                ],
              ),
            ),
            
            // Projects
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('PROJECTS', style: sectionTitleStyle),
                  pw.SizedBox(height: 8),
                  ...portfolio.projects.map((project) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(project.title, style: bodyBoldStyle),
                      pw.SizedBox(height: 4),
                      pw.Text(project.description, style: bodyStyle),
                      pw.SizedBox(height: 4),
                      pw.Text('Technologies: ${project.technologies.join(', ')}', style: bodyItalicStyle),
                      if (project.githubUrl != null || project.projectUrl != null)
                        pw.SizedBox(height: 4),
                      if (project.githubUrl != null)
                        pw.Text('GitHub: ${project.githubUrl}', style: bodyStyle),
                      if (project.projectUrl != null)
                        pw.Text('Link: ${project.projectUrl}', style: bodyStyle),
                      pw.SizedBox(height: 12),
                    ],
                  )),
                ],
              ),
            ),
            
            // Footer
            pw.Footer(
              trailing: pw.Text('Generated from Portfolio App', style: pw.TextStyle(font: fontItalic, fontSize: 9, color: PdfColors.grey)),
            ),
          ];
        },
      ),
    );
    
    return pdf.save();
  }
  
  // Print or download PDF
  static Future<void> downloadResume(BuildContext context, Portfolio portfolio) async {
    final pdfData = await generateResume(portfolio);
    await Printing.sharePdf(bytes: pdfData, filename: Constants.resumeFileName);
  }
}
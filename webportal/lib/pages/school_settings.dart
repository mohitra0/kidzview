import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../utils/resize.dart';
import '../models/school_settings.dart';
import '../services/school_settings_service.dart';
import '../services/auth_service.dart';

class SchoolSettingsPage extends StatefulWidget {
  const SchoolSettingsPage({super.key});

  @override
  State<SchoolSettingsPage> createState() => _SchoolSettingsPageState();
}

class _SchoolSettingsPageState extends State<SchoolSettingsPage> {
  final Resize resize = Resize();
  bool isLoading = true;
  bool isSaving = false;

  late SchoolSettings currentSettings;

  // Controllers
  final _schoolNameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _principalController = TextEditingController();
  final _yearController = TextEditingController();
  final _timingController = TextEditingController();
  final _aboutController = TextEditingController();
  final _appNameController = TextEditingController();
  final _welcomeController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  final _twitterController = TextEditingController();
  final _youtubeController = TextEditingController();

  Color selectedColor = const Color(0xFF3b82f6);
  String? logoPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
      _loadSettings();
    });
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _taglineController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _principalController.dispose();
    _yearController.dispose();
    _timingController.dispose();
    _aboutController.dispose();
    _appNameController.dispose();
    _welcomeController.dispose();
    _emergencyController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    setState(() => isLoading = true);

    currentSettings = await SchoolSettingsService.getSettings();

    // Populate controllers
    _schoolNameController.text = currentSettings.schoolName;
    _taglineController.text = currentSettings.tagline;
    _addressController.text = currentSettings.schoolAddress;
    _phoneController.text = currentSettings.phoneNumber;
    _emailController.text = currentSettings.email;
    _websiteController.text = currentSettings.website;
    _principalController.text = currentSettings.principalName;
    _yearController.text = currentSettings.establishedYear;
    _timingController.text = currentSettings.schoolTiming;
    _aboutController.text = currentSettings.aboutUs;
    _appNameController.text = currentSettings.appDisplayName;
    _welcomeController.text = currentSettings.welcomeMessage;
    _emergencyController.text = currentSettings.emergencyContact;
    _facebookController.text = currentSettings.facebookUrl ?? '';
    _instagramController.text = currentSettings.instagramUrl ?? '';
    _twitterController.text = currentSettings.twitterUrl ?? '';
    _youtubeController.text = currentSettings.youtubeUrl ?? '';

    logoPath = currentSettings.logoUrl;
    selectedColor =
        Color(int.parse(currentSettings.primaryColor.replaceAll('#', '0xFF')));

    setState(() => isLoading = false);
  }

  Future<void> _saveSettings() async {
    setState(() => isSaving = true);

    final userName = await AuthService.getUserName() ?? 'Teacher';

    final updatedSettings = SchoolSettings(
      logoUrl: logoPath,
      primaryColor: '#${selectedColor.value.toRadixString(16).substring(2)}',
      schoolName: _schoolNameController.text.trim(),
      tagline: _taglineController.text.trim(),
      schoolAddress: _addressController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      website: _websiteController.text.trim(),
      principalName: _principalController.text.trim(),
      establishedYear: _yearController.text.trim(),
      schoolTiming: _timingController.text.trim(),
      aboutUs: _aboutController.text.trim(),
      appDisplayName: _appNameController.text.trim(),
      welcomeMessage: _welcomeController.text.trim(),
      emergencyContact: _emergencyController.text.trim(),
      facebookUrl: _facebookController.text.trim().isEmpty
          ? null
          : _facebookController.text.trim(),
      instagramUrl: _instagramController.text.trim().isEmpty
          ? null
          : _instagramController.text.trim(),
      twitterUrl: _twitterController.text.trim().isEmpty
          ? null
          : _twitterController.text.trim(),
      youtubeUrl: _youtubeController.text.trim().isEmpty
          ? null
          : _youtubeController.text.trim(),
      lastUpdated: DateTime.now(),
      updatedBy: userName,
    );

    await SchoolSettingsService.saveSettings(updatedSettings);

    setState(() => isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.white, size: resize.iconSize),
              SizedBox(width: resize.width * 0.01),
              Text(
                'School settings saved successfully!',
                style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF10b981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resize.width * 0.006),
          ),
        ),
      );
    }

    await _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(resize.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: resize.height * 0.025),
          _buildInfoBanner(),
          SizedBox(height: resize.height * 0.025),

          // Visual Branding Section
          _buildSection(
            '1. Visual Branding',
            'Customize your school\'s appearance in the mobile app',
            Icons.palette,
            const Color(0xFF8b5cf6),
            [
              _buildLogoUpload(),
              _buildColorPicker(),
              _buildTextField('School Name *', 'Enter your school name',
                  _schoolNameController),
              _buildTextField('Tagline/Motto *',
                  'e.g., Building Tomorrow\'s Leaders', _taglineController),
            ],
          ),

          SizedBox(height: resize.height * 0.03),

          // School Information Section
          _buildSection(
            '2. School Information',
            'Essential details about your school',
            Icons.info,
            const Color(0xFF3b82f6),
            [
              _buildTextField('School Address *',
                  'Full address with city and zip', _addressController,
                  maxLines: 2),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('Contact Phone *',
                          '+1 (555) 123-4567', _phoneController)),
                  SizedBox(width: resize.width * 0.015),
                  Expanded(
                      child: _buildTextField('Email Address *',
                          'info@school.com', _emailController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('Website URL *',
                          'https://school.com', _websiteController)),
                  SizedBox(width: resize.width * 0.015),
                  Expanded(
                      child: _buildTextField('Principal/Director *',
                          'Dr. Jane Smith', _principalController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          'Established Year *', '2020', _yearController)),
                  SizedBox(width: resize.width * 0.015),
                  Expanded(
                      child: _buildTextField('School Timing *',
                          '8:00 AM - 1:00 PM', _timingController)),
                ],
              ),
              _buildTextField('About Us *', 'Brief description of your school',
                  _aboutController,
                  maxLines: 4),
            ],
          ),

          SizedBox(height: resize.height * 0.03),

          // App Customization Section
          _buildSection(
            '3. Mobile App Customization',
            'Personalize the mobile app experience',
            Icons.phone_android,
            const Color(0xFF10b981),
            [
              _buildTextField('App Display Name *',
                  'What parents see on home screen', _appNameController),
              _buildTextField('Welcome Message *',
                  'Greeting for parents when they login', _welcomeController,
                  maxLines: 2),
              _buildTextField('Emergency Contact *', '+1 (555) 999-0000',
                  _emergencyController),
            ],
          ),

          SizedBox(height: resize.height * 0.03),

          // Social Media Section
          _buildSection(
            '4. Social Media Links',
            'Connect parents to your social channels (optional)',
            Icons.share,
            const Color(0xFFEF4444),
            [
              _buildSocialMediaField(
                  'Facebook',
                  'https://facebook.com/yourschool',
                  _facebookController,
                  Icons.facebook),
              _buildSocialMediaField(
                  'Instagram',
                  'https://instagram.com/yourschool',
                  _instagramController,
                  Icons.camera_alt),
              _buildSocialMediaField(
                  'Twitter/X',
                  'https://twitter.com/yourschool',
                  _twitterController,
                  Icons.tag),
              _buildSocialMediaField(
                  'YouTube',
                  'https://youtube.com/@yourschool',
                  _youtubeController,
                  Icons.play_circle),
            ],
          ),

          SizedBox(height: resize.height * 0.04),
          _buildSaveButton(),
          SizedBox(height: resize.height * 0.02),
          _buildLastUpdatedInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
        ),
        borderRadius: BorderRadius.circular(resize.width * 0.012),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resize.width * 0.015),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: resize.iconSize * 2.5,
            ),
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School Settings & Customization',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading1,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  'Customize how your school appears in the parent mobile app',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFF3b82f6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(resize.width * 0.01),
        border: Border.all(color: const Color(0xFF3b82f6).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb,
            color: const Color(0xFF3b82f6),
            size: resize.iconSize * 2,
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize Your School Brand',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeLarge,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1f2937),
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  'All changes will be reflected in the parent mobile app. Fill in all required fields (*) to provide complete information to parents.',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    color: const Color(0xFF6b7280),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String description, IconData icon,
      Color color, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(resize.width * 0.012),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(resize.width * 0.012),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.008),
                ),
                child: Icon(icon, color: color, size: resize.iconSize * 1.8),
              ),
              SizedBox(width: resize.width * 0.015),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.heading2,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1f2937),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.003),
                    Text(
                      description,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizeSmall,
                        color: const Color(0xFF6b7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.025),
          ...children.map((child) => Padding(
                padding: EdgeInsets.only(bottom: resize.height * 0.02),
                child: child,
              )),
        ],
      ),
    );
  }

  Widget _buildLogoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'School Logo/Icon *',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        Container(
          padding: EdgeInsets.all(resize.width * 0.02),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(resize.width * 0.008),
            border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 2,
                style: BorderStyle.solid),
          ),
          child: Row(
            children: [
              // Logo preview
              Container(
                width: resize.width * 0.08,
                height: resize.width * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: logoPath != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(resize.width * 0.006),
                        child: Icon(
                          Icons.school,
                          size: resize.iconSize * 3,
                          color: selectedColor,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: resize.iconSize * 2,
                          color: const Color(0xFF9ca3af),
                        ),
                      ),
              ),
              SizedBox(width: resize.width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      logoPath != null ? 'Logo uploaded' : 'No logo uploaded',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizebase,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1f2937),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.005),
                    Text(
                      'Recommended: Square image, 512x512px, PNG format',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizeSmall,
                        color: const Color(0xFF6b7280),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Simulate logo upload
                  setState(() {
                    logoPath =
                        'school_logo_${DateTime.now().millisecondsSinceEpoch}.png';
                  });
                },
                icon: Icon(Icons.upload, size: resize.iconSize),
                label: Text(
                  'Upload Logo',
                  style:
                      GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8b5cf6),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Primary Color *',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Pick Primary Color',
                  style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                ),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: selectedColor,
                    onColorChanged: (color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Done',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: resize.fontSizeSmall),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(resize.width * 0.015),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Container(
                  width: resize.width * 0.05,
                  height: resize.width * 0.05,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(resize.width * 0.006),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: resize.width * 0.015),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Color',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: resize.fontSizebase,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1f2937),
                        ),
                      ),
                      SizedBox(height: resize.height * 0.003),
                      Text(
                        '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: resize.fontSizeSmall,
                          color: const Color(0xFF6b7280),
                          // fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit,
                  color: const Color(0xFF6b7280),
                  size: resize.iconSize * 1.2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizebase,
              color: const Color(0xFF9ca3af),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            contentPadding: EdgeInsets.all(resize.width * 0.015),
          ),
          style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizebase),
        ),
      ],
    );
  }

  Widget _buildSocialMediaField(String platform, String hint,
      TextEditingController controller, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(resize.width * 0.01),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(resize.width * 0.006),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Icon(icon,
              color: const Color(0xFF6b7280), size: resize.iconSize * 1.5),
        ),
        SizedBox(width: resize.width * 0.015),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: platform,
              hintText: hint,
              hintStyle: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizeSmall,
                color: const Color(0xFF9ca3af),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(resize.width * 0.008),
              ),
              contentPadding: EdgeInsets.all(resize.width * 0.015),
            ),
            style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizebase),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isSaving ? null : _saveSettings,
        icon: isSaving
            ? SizedBox(
                width: resize.iconSize,
                height: resize.iconSize,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(Icons.save, size: resize.iconSize * 1.5),
        label: Text(
          isSaving ? 'Saving Changes...' : 'Save School Settings',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10b981),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: resize.height * 0.022,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resize.width * 0.008),
          ),
        ),
      ),
    );
  }

  Widget _buildLastUpdatedInfo() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(resize.width * 0.008),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.update,
            color: const Color(0xFF6b7280),
            size: resize.iconSize,
          ),
          SizedBox(width: resize.width * 0.01),
          Text(
            'Last updated: ${DateFormat('MMM dd, yyyy • hh:mm a').format(currentSettings.lastUpdated)} by ${currentSettings.updatedBy}',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              color: const Color(0xFF6b7280),
            ),
          ),
        ],
      ),
    );
  }
}

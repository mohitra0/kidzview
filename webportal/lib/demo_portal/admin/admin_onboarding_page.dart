import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminOnboardingPage extends StatefulWidget {
  const AdminOnboardingPage({super.key});

  @override
  State<AdminOnboardingPage> createState() => _AdminOnboardingPageState();
}

class _AdminOnboardingPageState extends State<AdminOnboardingPage> {
  int _currentStep = 0;
  String _selectedClass = 'Class 5A';
  String _selectedSection = 'A';
  String _bloodGroup = 'O+';
  String _gender = 'Male';
  bool _transportRequired = false;
  bool _parentAppEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Onboarding', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Register new students and assign to classes', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                label: Text('Bulk Import', style: GoogleFonts.spaceGrotesk()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Progress Steps
          _buildProgressStepper(),
          const SizedBox(height: 24),
          // Form Content
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: _buildCurrentStep(),
          ),
          const SizedBox(height: 24),
          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_currentStep > 0)
                OutlinedButton(
                  onPressed: () => setState(() => _currentStep--),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                  child: Text('Previous', style: GoogleFonts.spaceGrotesk()),
                ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (_currentStep < 3) {
                    setState(() => _currentStep++);
                  } else {
                    _showSuccessDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: Text(_currentStep == 3 ? 'Complete Onboarding' : 'Next Step', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStepper() {
    final steps = ['Student Info', 'Parent Details', 'Class Assignment', 'Camera & App Setup'];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: steps.asMap().entries.map((e) {
          final isActive = e.key == _currentStep;
          final isCompleted = e.key < _currentStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? const Color(0xFF10B981) : isActive ? const Color(0xFF8B5CF6) : const Color(0xFFE5E7EB),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : Text('${e.key + 1}', style: GoogleFonts.spaceGrotesk(color: isActive ? Colors.white : const Color(0xFF6B7280), fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(e.value, style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? const Color(0xFF8B5CF6) : const Color(0xFF6B7280),
                  )),
                ),
                if (e.key < steps.length - 1)
                  Container(width: 40, height: 2, color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFE5E7EB)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0: return _buildStudentInfoStep();
      case 1: return _buildParentDetailsStep();
      case 2: return _buildClassAssignmentStep();
      case 3: return _buildCameraSetupStep();
      default: return const SizedBox();
    }
  }

  Widget _buildStudentInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Student Information', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Enter basic details about the student', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
        const SizedBox(height: 24),
        Row(
          children: [
            // Photo Upload
            Container(
              width: 150, height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 48, color: Color(0xFF9CA3AF)),
                  const SizedBox(height: 8),
                  Text('Upload Photo', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  const SizedBox(height: 8),
                  OutlinedButton(onPressed: () {}, child: Text('Browse', style: GoogleFonts.spaceGrotesk(fontSize: 12))),
                ],
              ),
            ),
            const SizedBox(width: 32),
            // Form Fields
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTextField('First Name')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextField('Last Name')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildDateField('Date of Birth')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropdown('Gender', _gender, ['Male', 'Female', 'Other'], (v) => setState(() => _gender = v!))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildDropdown('Blood Group', _bloodGroup, ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], (v) => setState(() => _bloodGroup = v!))),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextField('Aadhaar Number (Optional)')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField('Complete Address'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('City')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('State')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('PIN Code')),
          ],
        ),
      ],
    );
  }

  Widget _buildParentDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Parent/Guardian Details', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Enter parent information for communication', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
        const SizedBox(height: 24),
        // Father's Details
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Father's Details", style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Full Name')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Occupation')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Mobile Number')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Email Address')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Mother's Details
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mother's Details", style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Full Name')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Occupation')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Mobile Number')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Email Address')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Emergency Contact
        Row(
          children: [
            Expanded(child: _buildTextField('Emergency Contact Name')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Emergency Contact Number')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Relationship')),
          ],
        ),
      ],
    );
  }

  Widget _buildClassAssignmentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Class Assignment', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Assign student to class and section', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildDropdown('Select Class', _selectedClass, ['Class 1', 'Class 2', 'Class 3', 'Class 4', 'Class 5A', 'Class 5B', 'Class 6A', 'Class 6B', 'Class 7A'], (v) => setState(() => _selectedClass = v!)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdown('Select Section', _selectedSection, ['A', 'B', 'C'], (v) => setState(() => _selectedSection = v!)),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Roll Number (Auto-generated)', enabled: false)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildDateField('Admission Date')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Previous School (if any)')),
          ],
        ),
        const SizedBox(height: 24),
        // Transport
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const Icon(Icons.directions_bus, color: Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('School Transport', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                    Text('Does the student require school bus service?', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
              Switch(value: _transportRequired, onChanged: (v) => setState(() => _transportRequired = v), activeColor: const Color(0xFF8B5CF6)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCameraSetupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Camera & App Setup', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Configure live streaming access for parents', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
        const SizedBox(height: 24),
        // Parent App
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.2))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.phone_android, color: Color(0xFF8B5CF6), size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enable Parent App Access', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('Allow parents to view live streaming and receive notifications', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
              Switch(value: _parentAppEnabled, onChanged: (v) => setState(() => _parentAppEnabled = v), activeColor: const Color(0xFF8B5CF6)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Camera Assignment
        Text('Assign to Camera', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildCameraChip('Classroom Camera', true),
            _buildCameraChip('Playground Camera', false),
            _buildCameraChip('Cafeteria Camera', true),
            _buildCameraChip('Lab Camera', false),
          ],
        ),
        const SizedBox(height: 24),
        // Viewing Settings
        Text('Parent Viewing Settings', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDropdown('Daily Time Limit', '30 min', ['No Limit', '15 min', '30 min', '60 min', '90 min'], (v) {})),
            const SizedBox(width: 16),
            Expanded(child: _buildDropdown('Viewing Hours', 'School Hours Only', ['School Hours Only', 'Anytime', 'Custom'], (v) {})),
          ],
        ),
        const SizedBox(height: 24),
        // Summary
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2))),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ready to Onboard', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                    Text('Student will be added and parent app invite will be sent via SMS', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCameraChip(String label, bool selected) {
    return FilterChip(
      label: Text(label, style: GoogleFonts.spaceGrotesk()),
      selected: selected,
      onSelected: (_) {},
      selectedColor: const Color(0xFF8B5CF6).withOpacity(0.2),
      checkmarkColor: const Color(0xFF8B5CF6),
    );
  }

  Widget _buildTextField(String label, {bool enabled = true}) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: !enabled,
        fillColor: const Color(0xFFF3F4F6),
      ),
    );
  }

  Widget _buildDateField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.spaceGrotesk()))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 48),
            ),
            const SizedBox(height: 20),
            Text('Student Onboarded!', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Student has been successfully added.\nParent app invite sent via SMS.', textAlign: TextAlign.center, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _currentStep = 0);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
            child: Text('Add Another Student', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

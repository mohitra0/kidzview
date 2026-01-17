import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HROnboardingPage extends StatefulWidget {
  const HROnboardingPage({super.key});

  @override
  State<HROnboardingPage> createState() => _HROnboardingPageState();
}

class _HROnboardingPageState extends State<HROnboardingPage> {
  int _currentStep = 0;
  String _selectedDepartment = 'Mathematics';
  String _employeeType = 'Teacher';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Teacher Onboarding', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Register new teachers and staff members', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file), label: Text('Bulk Import', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          _buildProgressStepper(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
            child: _buildCurrentStep(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_currentStep > 0) OutlinedButton(onPressed: () => setState(() => _currentStep--), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)), child: Text('Previous', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _currentStep < 4 ? setState(() => _currentStep++) : _showSuccessDialog(),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                child: Text(_currentStep == 4 ? 'Complete Onboarding' : 'Next Step', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStepper() {
    final steps = ['Personal Info', 'Professional Details', 'Documents', 'Salary & Bank', 'System Access'];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Row(
        children: steps.asMap().entries.map((e) {
          final isActive = e.key == _currentStep;
          final isCompleted = e.key < _currentStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: isCompleted ? const Color(0xFF10B981) : isActive ? const Color(0xFF7C3AED) : const Color(0xFFE5E7EB)),
                  child: Center(child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 16) : Text('${e.key + 1}', style: GoogleFonts.spaceGrotesk(color: isActive ? Colors.white : const Color(0xFF6B7280), fontWeight: FontWeight.w600, fontSize: 13))),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(e.value, style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: isActive ? FontWeight.w600 : FontWeight.w500, color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF6B7280)), overflow: TextOverflow.ellipsis)),
                if (e.key < steps.length - 1) Container(width: 20, height: 2, color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFE5E7EB)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0: return _buildPersonalInfoStep();
      case 1: return _buildProfessionalStep();
      case 2: return _buildDocumentsStep();
      case 3: return _buildSalaryStep();
      case 4: return _buildSystemAccessStep();
      default: return const SizedBox();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Information', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        Row(
          children: [
            Container(
              width: 140, height: 160,
              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.person, size: 40, color: Color(0xFF9CA3AF)),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: () {}, child: Text('Upload', style: GoogleFonts.spaceGrotesk(fontSize: 12))),
              ]),
            ),
            const SizedBox(width: 24),
            Expanded(child: Column(children: [
              Row(children: [Expanded(child: _buildTextField('First Name')), const SizedBox(width: 16), Expanded(child: _buildTextField('Last Name'))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildDateField('Date of Birth')), const SizedBox(width: 16), Expanded(child: _buildDropdown('Gender', 'Male', ['Male', 'Female', 'Other']))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('Phone Number')), const SizedBox(width: 16), Expanded(child: _buildTextField('Email Address'))]),
            ])),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField('Permanent Address'),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField('City')), const SizedBox(width: 16), Expanded(child: _buildTextField('State')), const SizedBox(width: 16), Expanded(child: _buildTextField('PIN Code'))]),
      ],
    );
  }

  Widget _buildProfessionalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Professional Details', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        Row(children: [
          Expanded(child: _buildDropdown('Employee Type', _employeeType, ['Teacher', 'Admin Staff', 'Support Staff', 'Management'])),
          const SizedBox(width: 16),
          Expanded(child: _buildDropdown('Department', _selectedDepartment, ['Mathematics', 'Science', 'English', 'Hindi', 'Social Studies', 'Computer', 'Music', 'Art', 'PT'])),
        ]),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField('Designation')), const SizedBox(width: 16), Expanded(child: _buildDateField('Date of Joining'))]),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField('Qualification')), const SizedBox(width: 16), Expanded(child: _buildTextField('Experience (Years)'))]),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField('Previous School/Organization')), const SizedBox(width: 16), Expanded(child: _buildTextField('Previous Designation'))]),
        const SizedBox(height: 24),
        Text('Classes to Assign', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: ['Class 1', 'Class 2', 'Class 3', 'Class 4', 'Class 5', 'Class 6', 'Class 7'].map((c) => FilterChip(label: Text(c), selected: c == 'Class 5' || c == 'Class 6', onSelected: (_) {}, selectedColor: const Color(0xFF7C3AED).withOpacity(0.2), checkmarkColor: const Color(0xFF7C3AED))).toList(),
        ),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    final docs = [
      {'name': 'Resume/CV', 'required': true, 'uploaded': false},
      {'name': 'ID Proof (Aadhaar/PAN)', 'required': true, 'uploaded': false},
      {'name': 'Address Proof', 'required': true, 'uploaded': false},
      {'name': 'Educational Certificates', 'required': true, 'uploaded': false},
      {'name': 'Experience Letter', 'required': false, 'uploaded': false},
      {'name': 'Photo', 'required': true, 'uploaded': true},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Document Upload', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        ...docs.map((d) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: d['uploaded'] == true ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12), border: Border.all(color: d['uploaded'] == true ? const Color(0xFF10B981).withOpacity(0.3) : const Color(0xFFE5E7EB))),
          child: Row(children: [
            Icon(d['uploaded'] == true ? Icons.check_circle : Icons.upload_file, color: d['uploaded'] == true ? const Color(0xFF10B981) : const Color(0xFF6B7280)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(d['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                if (d['required'] == true) Text(' *', style: GoogleFonts.spaceGrotesk(color: const Color(0xFFEF4444))),
              ]),
              Text(d['uploaded'] == true ? 'Uploaded' : 'Not uploaded', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
            ])),
            OutlinedButton(onPressed: () {}, child: Text(d['uploaded'] == true ? 'Replace' : 'Upload', style: GoogleFonts.spaceGrotesk(fontSize: 12))),
          ]),
        )),
      ],
    );
  }

  Widget _buildSalaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Salary & Bank Details', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Salary Structure', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('Basic Salary', prefix: '₹')), const SizedBox(width: 16), Expanded(child: _buildTextField('HRA', prefix: '₹'))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('DA', prefix: '₹')), const SizedBox(width: 16), Expanded(child: _buildTextField('Special Allowance', prefix: '₹'))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('PF Deduction', prefix: '₹')), const SizedBox(width: 16), Expanded(child: _buildTextField('TDS', prefix: '₹'))]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bank Details', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('Bank Name')), const SizedBox(width: 16), Expanded(child: _buildTextField('Branch'))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('Account Number')), const SizedBox(width: 16), Expanded(child: _buildTextField('IFSC Code'))]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSystemAccessStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('System Access', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _buildTextField('Employee ID (Auto)')), const SizedBox(width: 16), Expanded(child: _buildTextField('Login Email'))]),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField('Password', obscure: true)), const SizedBox(width: 16), Expanded(child: _buildTextField('Confirm Password', obscure: true))]),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF7C3AED).withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Portal Access', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(children: [
              Checkbox(value: true, onChanged: (_) {}, activeColor: const Color(0xFF7C3AED)),
              Text('Teacher Portal Access', style: GoogleFonts.spaceGrotesk()),
              const SizedBox(width: 24),
              Checkbox(value: true, onChanged: (_) {}, activeColor: const Color(0xFF7C3AED)),
              Text('Mobile App Access', style: GoogleFonts.spaceGrotesk()),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3))),
          child: Row(children: [
            const Icon(Icons.check_circle, color: Color(0xFF10B981)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ready to Onboard', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
              Text('Login credentials will be sent via email', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
            ])),
          ]),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, {String prefix = '', bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(labelText: label, prefixText: prefix.isNotEmpty ? prefix : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
    );
  }

  Widget _buildDateField(String label) {
    return TextField(decoration: InputDecoration(labelText: label, suffixIcon: const Icon(Icons.calendar_today, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)));
  }

  Widget _buildDropdown(String label, String value, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(value: value, isExpanded: true, underline: const SizedBox(), items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (_) {}),
      ),
    ]);
  }

  void _showSuccessDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 48)),
        const SizedBox(height: 20),
        Text('Teacher Onboarded!', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Employee has been added successfully.\nLogin credentials sent via email.', textAlign: TextAlign.center, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
      ]),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => _currentStep = 0); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), child: Text('Add Another', style: GoogleFonts.spaceGrotesk(color: Colors.white)))],
    ));
  }
}

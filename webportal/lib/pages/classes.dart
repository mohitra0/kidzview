import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/resize.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final Resize resize = Resize();
  String? selectedCameraId;
  bool showWelcomeGuide = true;
  bool isLoading = true;
  
  Map<String, String> cameraNames = {};
  Map<String, int> studentCounts = {};
  List<Student> currentStudents = [];
  
  final List<String> cameras = [
    'camera_1',
    'camera_2',
    'camera_3',
    'camera_4',
    'camera_5',
    'camera_6',
    'camera_7',
    'camera_8',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
      _loadData();
    });
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    
    cameraNames = await StudentService.getAllCameraNames();
    
    for (var cameraId in cameras) {
      final count = await StudentService.getStudentCount(cameraId);
      studentCounts[cameraId] = count;
    }
    
    if (selectedCameraId != null) {
      currentStudents = await StudentService.getStudentsByCamera(selectedCameraId!);
    }
    
    setState(() => isLoading = false);
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
          if (showWelcomeGuide) _buildWelcomeGuide(),
          if (showWelcomeGuide) SizedBox(height: resize.height * 0.025),
          _buildHeader(),
          SizedBox(height: resize.height * 0.025),
          if (selectedCameraId == null) _buildCameraGrid() else _buildCameraManagement(),
        ],
      ),
    );
  }

  Widget _buildWelcomeGuide() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3b82f6), Color(0xFF2563eb)],
        ),
        borderRadius: BorderRadius.circular(resize.width * 0.012),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(resize.width * 0.012),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(resize.width * 0.008),
                ),
                child: Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                  size: resize.iconSize * 2,
                ),
              ),
              SizedBox(width: resize.width * 0.015),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Student Management! 👋',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.heading2,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: resize.height * 0.005),
                    Text(
                      'Manage students for each camera/classroom',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizebase,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: resize.iconSize * 1.5,
                ),
                onPressed: () {
                  setState(() {
                    showWelcomeGuide = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.025),
          Row(
            children: [
              Expanded(child: _buildGuideStep('1', 'Select Camera', 'Choose which camera to add students to')),
              SizedBox(width: resize.width * 0.015),
              Icon(Icons.arrow_forward, color: Colors.white, size: resize.iconSize * 1.5),
              SizedBox(width: resize.width * 0.015),
              Expanded(child: _buildGuideStep('2', 'Add Students', 'Add students one by one or upload Excel')),
              SizedBox(width: resize.width * 0.015),
              Icon(Icons.arrow_forward, color: Colors.white, size: resize.iconSize * 1.5),
              SizedBox(width: resize.width * 0.015),
              Expanded(child: _buildGuideStep('3', 'Share Credentials', 'Parents login with: Full Name + DOB')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuideStep(String number, String title, String description) {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(resize.width * 0.008),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: resize.width * 0.025,
            height: resize.width * 0.025,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizebase,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3b82f6),
                ),
              ),
            ),
          ),
          SizedBox(height: resize.height * 0.01),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizebase,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: resize.height * 0.005),
          Text(
            description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String cameraName = selectedCameraId != null
        ? cameraNames[selectedCameraId] ?? 'Camera ${selectedCameraId!.split('_')[1]}'
        : 'Select a Camera';
        
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(resize.width * 0.01),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resize.width * 0.012),
            decoration: BoxDecoration(
              color: const Color(0xFF1f2937).withOpacity(0.1),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            child: Icon(
              selectedCameraId == null ? Icons.videocam : Icons.people,
              color: const Color(0xFF1f2937),
              size: resize.iconSize * 2,
            ),
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedCameraId == null ? 'Student Management' : 'Managing: $cameraName',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading2,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1f2937),
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  selectedCameraId == null
                      ? 'Select a camera to view and add students'
                      : '${currentStudents.length} student(s) in this camera',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    color: const Color(0xFF6b7280),
                  ),
                ),
              ],
            ),
          ),
          if (selectedCameraId != null)
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  selectedCameraId = null;
                  currentStudents = [];
                });
              },
              icon: Icon(Icons.arrow_back, size: resize.iconSize),
              label: Text(
                'Back to Cameras',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1f2937),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.015,
                  vertical: resize.height * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCameraGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: resize.width * 0.015,
        mainAxisSpacing: resize.height * 0.02,
        childAspectRatio: 1.3,
      ),
      itemCount: cameras.length,
      itemBuilder: (context, index) {
        return _buildCameraCard(cameras[index], index + 1);
      },
    );
  }

  Widget _buildCameraCard(String cameraId, int cameraNumber) {
    final String? customName = cameraNames[cameraId];
    final int studentCount = studentCounts[cameraId] ?? 0;
    final bool hasName = customName != null && customName.isNotEmpty;

    return InkWell(
      onTap: () async {
        setState(() {
          selectedCameraId = cameraId;
        });
        await _loadData();
      },
      child: Container(
        padding: EdgeInsets.all(resize.width * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(resize.width * 0.01),
          border: Border.all(
            color: studentCount > 0
                ? const Color(0xFF10b981)
                : const Color(0xFFE5E7EB),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(resize.width * 0.008),
                  decoration: BoxDecoration(
                    color: (studentCount > 0 ? const Color(0xFF10b981) : const Color(0xFF6b7280))
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(resize.width * 0.006),
                  ),
                  child: Icon(
                    studentCount > 0 ? Icons.people : Icons.videocam,
                    color: studentCount > 0 ? const Color(0xFF10b981) : const Color(0xFF6b7280),
                    size: resize.iconSize * 1.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: resize.iconSize,
                    color: const Color(0xFF6b7280),
                  ),
                  onPressed: () => _showRenameDialog(cameraId, cameraNumber),
                  tooltip: 'Rename camera',
                ),
              ],
            ),
            const Spacer(),
            Text(
              'Camera $cameraNumber',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.lableText,
                color: const Color(0xFF9ca3af),
              ),
            ),
            SizedBox(height: resize.height * 0.005),
            Text(
              hasName ? customName : 'Not named yet',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w700,
                color: hasName ? const Color(0xFF1f2937) : const Color(0xFF6b7280),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: resize.height * 0.01),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: resize.lableText,
                  color: const Color(0xFF6b7280),
                ),
                SizedBox(width: resize.width * 0.004),
                Text(
                  '$studentCount students',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    color: const Color(0xFF6b7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameDialog(String cameraId, int cameraNumber) {
    final controller = TextEditingController(text: cameraNames[cameraId] ?? '');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.012),
        ),
        title: Text(
          'Rename Camera $cameraNumber',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.heading3,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Give this camera a custom name (e.g., "Toddlers A", "Pre-K Room")',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizeSmall,
                color: const Color(0xFF6b7280),
              ),
            ),
            SizedBox(height: resize.height * 0.015),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter camera/classroom name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
              ),
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await StudentService.saveCameraName(cameraId, controller.text.trim());
                await _loadData();
                if (mounted) Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1f2937),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraManagement() {
    return Column(
      children: [
        _buildAddStudentButton(),
        SizedBox(height: resize.height * 0.025),
        _buildStudentsList(),
      ],
    );
  }

  Widget _buildAddStudentButton() {
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
              Icons.person_add,
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
                  'Add Students to This Camera',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading2,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  'Parents will login using: Student Full Name + Date of Birth',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _showAddStudentDialog,
            icon: Icon(Icons.add, size: resize.iconSize * 1.5),
            label: Text(
              'Add Student',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF8b5cf6),
              padding: EdgeInsets.symmetric(
                horizontal: resize.width * 0.02,
                vertical: resize.height * 0.018,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(resize.width * 0.006),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsList() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(resize.width * 0.01),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: const Color(0xFF1f2937),
                size: resize.iconSize * 1.5,
              ),
              SizedBox(width: resize.width * 0.01),
              Text(
                'Students in This Camera (${currentStudents.length})',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading3,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1f2937),
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.02),
          
          if (currentStudents.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.group_add,
                    size: resize.iconSize * 4,
                    color: const Color(0xFF9ca3af),
                  ),
                  SizedBox(height: resize.height * 0.02),
                  Text(
                    'No students added yet',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.heading4,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6b7280),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.01),
                  Text(
                    'Click "Add Student" button above to start',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      color: const Color(0xFF9ca3af),
                    ),
                  ),
                ],
              ),
            )
          else
            ...currentStudents.map((student) => _buildStudentCard(student)),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return Container(
      margin: EdgeInsets.only(bottom: resize.height * 0.015),
      padding: EdgeInsets.all(resize.width * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(resize.width * 0.008),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: resize.width * 0.02,
            backgroundColor: const Color(0xFF8b5cf6),
            child: Text(
              student.fullName[0].toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1f2937),
                  ),
                ),
                SizedBox(height: resize.height * 0.003),
                Text(
                  'DOB: ${DateFormat('MMM dd, yyyy').format(student.dateOfBirth)} • Age: ${student.age}',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    color: const Color(0xFF6b7280),
                  ),
                ),
                if (student.phone != null || student.email != null)
                  Padding(
                    padding: EdgeInsets.only(top: resize.height * 0.003),
                    child: Text(
                      [
                        if (student.phone != null) 'Phone: ${student.phone}',
                        if (student.email != null) 'Email: ${student.email}',
                      ].join(' • '),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.lableText,
                        color: const Color(0xFF9ca3af),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: resize.width * 0.008,
              vertical: resize.height * 0.005,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF10b981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(resize.width * 0.004),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: resize.lableText,
                  color: const Color(0xFF10b981),
                ),
                SizedBox(width: resize.width * 0.003),
                Text(
                  'Active',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10b981),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: resize.width * 0.01),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: const Color(0xFFEF4444),
              size: resize.iconSize * 1.2,
            ),
            onPressed: () => _confirmDeleteStudent(student),
            tooltip: 'Delete student',
          ),
        ],
      ),
    );
  }

  void _confirmDeleteStudent(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.012),
        ),
        title: Text(
          'Delete Student?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.heading3,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${student.fullName}? This action cannot be undone.',
          style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await StudentService.deleteStudent(student.id);
              await _loadData();
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Student deleted successfully',
                      style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                    ),
                    backgroundColor: const Color(0xFF10b981),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resize.width * 0.012),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(resize.width * 0.008),
                decoration: BoxDecoration(
                  color: const Color(0xFF8b5cf6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
                child: Icon(
                  Icons.person_add,
                  color: const Color(0xFF8b5cf6),
                  size: resize.iconSize * 1.5,
                ),
              ),
              SizedBox(width: resize.width * 0.01),
              Text(
                'Add New Student',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: resize.width * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name Field
                  Text(
                    'Full Name *',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1f2937),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.008),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter student full name',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizeSmall,
                        color: const Color(0xFF9ca3af),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.012,
                      ),
                    ),
                    style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                  ),
                  SizedBox(height: resize.height * 0.02),
                  
                  // Date of Birth Field
                  Text(
                    'Date of Birth *',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1f2937),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.008),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 365 * 3)),
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setDialogState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD0D5DD)),
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: resize.iconSize,
                            color: const Color(0xFF6b7280),
                          ),
                          SizedBox(width: resize.width * 0.01),
                          Text(
                            selectedDate != null
                                ? DateFormat('MMM dd, yyyy').format(selectedDate!)
                                : 'Select date of birth',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.fontSizeSmall,
                              color: selectedDate != null
                                  ? const Color(0xFF1f2937)
                                  : const Color(0xFF9ca3af),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.02),
                  
                  // Optional Fields Divider
                  Divider(height: resize.height * 0.03),
                  Text(
                    'Optional Information',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6b7280),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.015),
                  
                  // Phone
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone (Optional)',
                      hintText: 'Parent contact number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.012,
                      ),
                    ),
                    style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                  ),
                  SizedBox(height: resize.height * 0.015),
                  
                  // Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email (Optional)',
                      hintText: 'Parent email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.012,
                      ),
                    ),
                    style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                  ),
                  SizedBox(height: resize.height * 0.02),
                  
                  // Info box
                  Container(
                    padding: EdgeInsets.all(resize.width * 0.012),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3b82f6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(resize.width * 0.006),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFF3b82f6),
                          size: resize.iconSize,
                        ),
                        SizedBox(width: resize.width * 0.008),
                        Expanded(
                          child: Text(
                            'Parent login credentials:\nFull Name + Date of Birth',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              color: const Color(0xFF3b82f6),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6b7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty || selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill in all required fields',
                        style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                      ),
                      backgroundColor: const Color(0xFFEF4444),
                    ),
                  );
                  return;
                }
                
                final student = Student(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  cameraId: selectedCameraId!,
                  fullName: nameController.text.trim(),
                  dateOfBirth: selectedDate!,
                  createdBy: 'Mohit Rao',
                  createdAt: DateTime.now(),
                  phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
                  email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
                );
                
                await StudentService.addStudent(student);
                await _loadData();
                
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: resize.iconSize),
                          SizedBox(width: resize.width * 0.01),
                          Text(
                            'Student added successfully!',
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8b5cf6),
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.02,
                  vertical: resize.height * 0.012,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
              ),
              child: Text(
                'Add Student',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

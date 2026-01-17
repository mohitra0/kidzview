import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StudentService {
  static const String _keyStudents = 'students';
  static const String _keyCameraNames = 'camera_names';

  // Get all students
  static Future<List<Student>> getAllStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentsJson = prefs.getString(_keyStudents);
    
    if (studentsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(studentsJson);
    return decoded.map((json) => Student.fromJson(json)).toList();
  }

  // Get students for specific camera
  static Future<List<Student>> getStudentsByCamera(String cameraId) async {
    final allStudents = await getAllStudents();
    return allStudents.where((s) => s.cameraId == cameraId).toList();
  }

  // Add student
  static Future<void> addStudent(Student student) async {
    final students = await getAllStudents();
    students.add(student);
    await _saveStudents(students);
  }

  // Update student
  static Future<void> updateStudent(Student student) async {
    final students = await getAllStudents();
    final index = students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      students[index] = student;
      await _saveStudents(students);
    }
  }

  // Delete student
  static Future<void> deleteStudent(String studentId) async {
    final students = await getAllStudents();
    students.removeWhere((s) => s.id == studentId);
    await _saveStudents(students);
  }

  // Save students to storage
  static Future<void> _saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        students.map((s) => s.toJson()).toList();
    await prefs.setString(_keyStudents, jsonEncode(jsonList));
  }

  // Save camera name
  static Future<void> saveCameraName(String cameraId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    final String? namesJson = prefs.getString(_keyCameraNames);
    
    Map<String, String> names = {};
    if (namesJson != null) {
      names = Map<String, String>.from(jsonDecode(namesJson));
    }
    
    names[cameraId] = name;
    await prefs.setString(_keyCameraNames, jsonEncode(names));
  }

  // Get camera name
  static Future<String?> getCameraName(String cameraId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? namesJson = prefs.getString(_keyCameraNames);
    
    if (namesJson == null) return null;
    
    final Map<String, String> names =
        Map<String, String>.from(jsonDecode(namesJson));
    return names[cameraId];
  }

  // Get all camera names
  static Future<Map<String, String>> getAllCameraNames() async {
    final prefs = await SharedPreferences.getInstance();
    final String? namesJson = prefs.getString(_keyCameraNames);
    
    if (namesJson == null) return {};
    
    return Map<String, String>.from(jsonDecode(namesJson));
  }

  // Get student count by camera
  static Future<int> getStudentCount(String cameraId) async {
    final students = await getStudentsByCamera(cameraId);
    return students.length;
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherTimetablePage extends StatefulWidget {
  const TeacherTimetablePage({super.key});

  @override
  State<TeacherTimetablePage> createState() => _TeacherTimetablePageState();
}

class _TeacherTimetablePageState extends State<TeacherTimetablePage> {
  String _viewMode = 'week'; // week, month
  DateTime _currentMonth = DateTime(2026, 1);
  int? _selectedDay;

  final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final periods = ['8:00-9:00', '9:00-10:00', '10:30-11:30', '11:30-12:30', '12:30-1:30'];
  
  final timetable = {
    'Monday': ['5A Math', '6B Math', '5A Science', 'Free', '7A Math'],
    'Tuesday': ['Free', '5A Math', '7A Math', '6B Math', 'Free'],
    'Wednesday': ['5A Science', '5A Math', 'Free', '7A Math', '6B Math'],
    'Thursday': ['5A Math', '6B Math', '5A Science', '7A Math', 'Free'],
    'Friday': ['7A Math', 'Free', '5A Math', '5A Science', '6B Math'],
  };

  // Holidays and events
  final Map<int, Map<String, dynamic>> _events = {
    1: {'type': 'holiday', 'name': 'New Year', 'color': const Color(0xFFEF4444)},
    14: {'type': 'event', 'name': 'Makar Sankranti', 'color': const Color(0xFFF59E0B)},
    26: {'type': 'holiday', 'name': 'Republic Day', 'color': const Color(0xFFEF4444)},
    15: {'type': 'exam', 'name': 'Unit Test Starts', 'color': const Color(0xFF8B5CF6)},
    20: {'type': 'event', 'name': 'PTM', 'color': const Color(0xFF3B82F6)},
    30: {'type': 'event', 'name': 'Annual Day Prep', 'color': const Color(0xFF10B981)},
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Timetable & Calendar', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Your schedule, holidays & school events', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              // View Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildModeTab('Week', 'week'),
                    _buildModeTab('Month', 'month'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (_viewMode == 'week') _buildWeekView() else _buildMonthView(),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, String mode) {
    final isSelected = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : null,
        ),
        child: Text(label, style: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
        )),
      ),
    );
  }

  Widget _buildWeekView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1F2937),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                SizedBox(width: 100, child: Text('Period', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600))),
                ...days.map((d) => Expanded(
                  child: Center(child: Text(d, style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600))),
                )),
              ],
            ),
          ),
          // Rows
          ...periods.asMap().entries.map((entry) => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(entry.value, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF374151))),
                ),
                ...days.map((d) {
                  final subject = timetable[d]![entry.key];
                  final isFree = subject == 'Free';
                  return Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isFree ? const Color(0xFFF3F4F6) : const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          subject,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isFree ? const Color(0xFF9CA3AF) : const Color(0xFF3B82F6),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    return Column(
      children: [
        // Month Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1)),
                  ),
                  Text(
                    '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
                    style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Weekday Headers
              Row(
                children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                    .map((d) => Expanded(
                          child: Center(
                            child: Text(d, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, color: const Color(0xFF6B7280), fontSize: 13)),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              // Calendar Grid
              _buildCalendarGrid(),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Legend
        _buildLegend(),
        const SizedBox(height: 24),

        // Events List
        _buildEventsList(),

        // Day Details (if selected)
        if (_selectedDay != null) ...[
          const SizedBox(height: 24),
          _buildDaySchedule(_selectedDay!),
        ],
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7;
    
    List<Widget> cells = [];
    
    // Empty cells before first day
    for (int i = 0; i < startWeekday; i++) {
      cells.add(const SizedBox());
    }
    
    // Day cells
    for (int day = 1; day <= lastDay.day; day++) {
      final event = _events[day];
      final isToday = day == 16 && _currentMonth.month == 1;
      final isSelected = _selectedDay == day;
      final isWeekend = (startWeekday + day - 1) % 7 == 0 || (startWeekday + day - 1) % 7 == 6;
      
      cells.add(
        GestureDetector(
          onTap: () => setState(() => _selectedDay = _selectedDay == day ? null : day),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : isToday
                      ? const Color(0xFF3B82F6).withOpacity(0.1)
                      : event != null
                          ? (event['color'] as Color).withOpacity(0.1)
                          : isWeekend
                              ? const Color(0xFFF3F4F6)
                              : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: isToday ? Border.all(color: const Color(0xFF3B82F6), width: 2) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : isWeekend ? const Color(0xFF9CA3AF) : const Color(0xFF374151),
                  ),
                ),
                if (event != null)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : event['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.3,
      children: cells,
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem('Holiday', const Color(0xFFEF4444)),
          const SizedBox(width: 24),
          _buildLegendItem('Festival/Event', const Color(0xFFF59E0B)),
          const SizedBox(width: 24),
          _buildLegendItem('Exam', const Color(0xFF8B5CF6)),
          const SizedBox(width: 24),
          _buildLegendItem('PTM/Meeting', const Color(0xFF3B82F6)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
      ],
    );
  }

  Widget _buildEventsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ..._events.entries.map((e) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (e.value['color'] as Color).withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border(left: BorderSide(color: e.value['color'] as Color, width: 4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  child: Text('${e.key}', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: e.value['color'] as Color)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.value['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                    Text(e.value['type'] == 'holiday' ? 'Holiday' : 'School Event', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDaySchedule(int day) {
    final dayOfWeek = (DateTime(_currentMonth.year, _currentMonth.month, day).weekday - 1) % 5;
    final isWeekend = DateTime(_currentMonth.year, _currentMonth.month, day).weekday > 5;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3B82F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Schedule for ${_getMonthName(_currentMonth.month)} $day', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700)),
              const Spacer(),
              if (_events.containsKey(day))
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (_events[day]!['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(_events[day]!['name'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: _events[day]!['color'] as Color, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (isWeekend)
            Center(child: Text('Weekend - No Classes', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))))
          else
            ...periods.asMap().entries.map((e) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(e.value, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                  const SizedBox(width: 20),
                  Text(timetable[days[dayOfWeek]]![e.key], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                ],
              ),
            )),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][month - 1];
  }
}

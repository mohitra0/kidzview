import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../utils/resize.dart';
import '../widgets/navigation.dart';
import 'livestreaming.dart';
import 'classes.dart';
import 'notifications.dart';
import 'school_settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Resize resize = Resize();
  String currentPage = 'Home';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          NavigationMenu(
            onMenuItemSelected: (String menu) {
              setState(() {
                currentPage = menu;
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: _buildPageContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: resize.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: resize.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            currentPage,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading2,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
          ),
          const Spacer(),
          _buildDatePicker(),
          SizedBox(width: resize.width * 0.015),
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: resize.iconSize * 1.5,
                  color: const Color(0xFF6b7280),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: resize.width * 0.008,
                    height: resize.width * 0.008,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          SizedBox(width: resize.width * 0.01),
          CircleAvatar(
            radius: resize.width * 0.016,
            backgroundColor: const Color(0xFF1f2937),
            child: Text(
              'M',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2024, 1, 1),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1f2937),
                  onPrimary: Colors.white,
                  onSurface: Color(0xFF1f2937),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: resize.width * 0.012,
          vertical: resize.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(resize.width * 0.006),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              size: resize.iconSize,
              color: const Color(0xFF6b7280),
            ),
            SizedBox(width: resize.width * 0.006),
            Text(
              DateFormat('MMM dd, yyyy').format(selectedDate),
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizeSmall,
                color: const Color(0xFF1f2937),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: resize.width * 0.004),
            Icon(
              Icons.arrow_drop_down,
              size: resize.iconSize * 1.2,
              color: const Color(0xFF6b7280),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(resize.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Banner
          _buildInfoBanner(),
          SizedBox(height: resize.height * 0.02),
          
          // Quick Stats Row
          _buildQuickStatsRow(),
          SizedBox(height: resize.height * 0.025),
          
          // Main Charts Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildParentsWatchingChart(),
                    SizedBox(height: resize.height * 0.025),
                    _buildDailyViewsChart(),
                  ],
                ),
              ),
              SizedBox(width: resize.width * 0.02),
              Expanded(
                child: Column(
                  children: [
                    _buildStudentsPresentCard(),
                    SizedBox(height: resize.height * 0.025),
                    _buildClassroomStatsCard(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.025),
          
          // Bottom Row - Detailed Metrics
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAverageViewingDurationChart(),
              ),
              SizedBox(width: resize.width * 0.02),
              Expanded(
                child: _buildStudentsTrendChart(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    switch (currentPage) {
      case 'Live Streaming':
        return const LiveStreamingPage();
      case 'Classes':
        return const ClassesPage();
      case 'Notifications':
        return const NotificationsPage();
      case 'Settings':
        return const SchoolSettingsPage();
      case 'Home':
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1f2937),
            const Color(0xFF111827),
          ],
        ),
        borderRadius: BorderRadius.circular(resize.width * 0.01),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resize.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(resize.width * 0.006),
            ),
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: resize.iconSize * 1.5,
            ),
          ),
          SizedBox(width: resize.width * 0.012),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Collection Period: 8:00 AM - 1:00 PM',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: resize.height * 0.003),
                Text(
                  'All statistics and analytics shown below are based on data collected during school hours only.',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
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

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Parents Active',
            '342',
            '+12%',
            Icons.people,
            const Color(0xFF10b981),
            isPositive: true,
          ),
        ),
        SizedBox(width: resize.width * 0.015),
        Expanded(
          child: _buildStatCard(
            'Live Viewers Now',
            '87',
            '+5%',
            Icons.visibility,
            const Color(0xFF3b82f6),
            isPositive: true,
          ),
        ),
        SizedBox(width: resize.width * 0.015),
        Expanded(
          child: _buildStatCard(
            'Total Watch Time',
            '24.5h',
            '-2%',
            Icons.access_time,
            const Color(0xFF8b5cf6),
            isPositive: false,
          ),
        ),
        SizedBox(width: resize.width * 0.015),
        Expanded(
          child: _buildStatCard(
            'Students Present',
            '156',
            '+8%',
            Icons.child_care,
            const Color(0xFFf97316),
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String change,
    IconData icon,
    Color color, {
    required bool isPositive,
  }) {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
              Container(
                padding: EdgeInsets.all(resize.width * 0.008),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
                child: Icon(icon, color: color, size: resize.iconSize * 1.3),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.006,
                  vertical: resize.height * 0.003,
                ),
                decoration: BoxDecoration(
                  color: isPositive
                      ? const Color(0xFF10b981).withOpacity(0.1)
                      : const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.004),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: resize.lableText,
                      color: isPositive
                          ? const Color(0xFF10b981)
                          : const Color(0xFFEF4444),
                    ),
                    Text(
                      change,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.lableText,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? const Color(0xFF10b981)
                            : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.015),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading1 * 1.3,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
          ),
          SizedBox(height: resize.height * 0.005),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              color: const Color(0xFF6b7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentsWatchingChart() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parents Watching Live',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading3,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1f2937),
                ),
              ),
              SizedBox(height: resize.height * 0.005),
              Text(
                'Hourly breakdown (8 AM - 1 PM)',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF9ca3af),
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.03),
          SizedBox(
            height: resize.height * 0.3,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}h',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF9ca3af),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF9ca3af),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE5E7EB),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: _generateHourlyData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateHourlyData() {
    // Data from 8 AM to 1 PM (6 hours)
    final data = [25, 35, 60, 85, 70, 40];
    final hours = [8, 9, 10, 11, 12, 13]; // 8 AM to 1 PM
    return List.generate(6, (index) {
      return BarChartGroupData(
        x: hours[index],
        barRods: [
          BarChartRodData(
            toY: data[index].toDouble(),
            color: const Color(0xFF10b981),
            width: resize.width * 0.015,
            borderRadius: BorderRadius.circular(resize.width * 0.003),
          ),
        ],
      );
    });
  }

  Widget _buildDailyViewsChart() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Views by Classroom',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading3,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1f2937),
                ),
              ),
              SizedBox(height: resize.height * 0.005),
              Text(
                'Views for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF9ca3af),
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.025),
          Row(
            children: [
              _buildLegendItem('Classroom A', const Color(0xFF10b981)),
              SizedBox(width: resize.width * 0.015),
              _buildLegendItem('Classroom B', const Color(0xFF3b82f6)),
              SizedBox(width: resize.width * 0.015),
              _buildLegendItem('Classroom C', const Color(0xFF8b5cf6)),
              SizedBox(width: resize.width * 0.015),
              _buildLegendItem('Classroom D', const Color(0xFFf97316)),
            ],
          ),
          SizedBox(height: resize.height * 0.02),
          SizedBox(
            height: resize.height * 0.25,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 200,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const hours = ['8AM', '9AM', '10AM', '11AM', '12PM', '1PM'];
                        if (value.toInt() < hours.length) {
                          return Text(
                            hours[value.toInt()],
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              color: const Color(0xFF9ca3af),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF9ca3af),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE5E7EB),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: _generateStackedBarData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateStackedBarData() {
    // 6 hours: 8AM-1PM
    return List.generate(6, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: 150,
            color: Colors.transparent,
            width: resize.width * 0.025,
            borderRadius: BorderRadius.zero,
            rodStackItems: [
              BarChartRodStackItem(0, 40, const Color(0xFF10b981)),
              BarChartRodStackItem(40, 80, const Color(0xFF3b82f6)),
              BarChartRodStackItem(80, 120, const Color(0xFF8b5cf6)),
              BarChartRodStackItem(120, 150, const Color(0xFFf97316)),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: resize.width * 0.008,
          height: resize.width * 0.008,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: resize.width * 0.004),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.lableText,
            color: const Color(0xFF6b7280),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsPresentCard() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
          Text(
            'Students Present',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading4,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
          ),
          SizedBox(height: resize.height * 0.008),
          Text(
            '${DateFormat('MMM dd, yyyy').format(selectedDate)}',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              color: const Color(0xFF9ca3af),
            ),
          ),
          SizedBox(height: resize.height * 0.03),
          Center(
            child: SizedBox(
              width: resize.width * 0.12,
              height: resize.width * 0.12,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 0.87,
                    strokeWidth: resize.width * 0.012,
                    backgroundColor: const Color(0xFFE5E7EB),
                    color: const Color(0xFF10b981),
                    strokeCap: StrokeCap.round,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '156',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.heading1 * 1.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1f2937),
                          ),
                        ),
                        Text(
                          'of 180',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.fontSizeSmall,
                            color: const Color(0xFF9ca3af),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: resize.height * 0.03),
          Container(
            padding: EdgeInsets.all(resize.width * 0.01),
            decoration: BoxDecoration(
              color: const Color(0xFF10b981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(resize.width * 0.006),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: const Color(0xFF10b981),
                  size: resize.iconSize,
                ),
                SizedBox(width: resize.width * 0.006),
                Expanded(
                  child: Text(
                    '87% attendance rate',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      color: const Color(0xFF10b981),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassroomStatsCard() {
    final classrooms = [
      {'name': 'Classroom A', 'students': 42, 'total': 45, 'color': const Color(0xFF10b981)},
      {'name': 'Classroom B', 'students': 38, 'total': 45, 'color': const Color(0xFF3b82f6)},
      {'name': 'Classroom C', 'students': 40, 'total': 45, 'color': const Color(0xFF8b5cf6)},
      {'name': 'Classroom D', 'students': 36, 'total': 45, 'color': const Color(0xFFf97316)},
    ];

    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
          Text(
            'Classroom Status',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading4,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
          ),
          SizedBox(height: resize.height * 0.02),
          ...classrooms.map((classroom) => Padding(
                padding: EdgeInsets.only(bottom: resize.height * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          classroom['name'] as String,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.fontSizeSmall,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1f2937),
                          ),
                        ),
                        Text(
                          '${classroom['students']}/${classroom['total']}',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.fontSizeSmall,
                            color: const Color(0xFF6b7280),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resize.height * 0.008),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(resize.width * 0.01),
                      child: LinearProgressIndicator(
                        value: (classroom['students'] as int) /
                            (classroom['total'] as int),
                        minHeight: resize.height * 0.008,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          classroom['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAverageViewingDurationChart() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Average Viewing Duration',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.heading3,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.005),
                  Text(
                    'Hourly average (8 AM - 1 PM)',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      color: const Color(0xFF9ca3af),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.01,
                  vertical: resize.height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3b82f6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
                child: Text(
                  '15.2 min avg',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3b82f6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.03),
          SizedBox(
            height: resize.height * 0.25,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE5E7EB),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const hours = ['8AM', '9AM', '10AM', '11AM', '12PM', '1PM'];
                        if (value.toInt() < hours.length) {
                          return Text(
                            hours[value.toInt()],
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              color: const Color(0xFF9ca3af),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}m',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF9ca3af),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 12),
                      FlSpot(1, 15),
                      FlSpot(2, 18),
                      FlSpot(3, 16),
                      FlSpot(4, 14),
                      FlSpot(5, 13),
                    ],
                    isCurved: true,
                    color: const Color(0xFF3b82f6),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF3b82f6),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF3b82f6).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsTrendChart() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.015),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Students Attendance Trend',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.heading3,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                  ),
                  SizedBox(height: resize.height * 0.005),
                  Text(
                    'Hourly count (8 AM - 1 PM)',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizeSmall,
                      color: const Color(0xFF9ca3af),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.01,
                  vertical: resize.height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10b981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: resize.lableText,
                      color: const Color(0xFF10b981),
                    ),
                    SizedBox(width: resize.width * 0.003),
                    Text(
                      '+5.2%',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizeSmall,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF10b981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.03),
          SizedBox(
            height: resize.height * 0.25,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE5E7EB),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const hours = ['8AM', '9AM', '10AM', '11AM', '12PM', '1PM'];
                        if (value.toInt() < hours.length) {
                          return Text(
                            hours[value.toInt()],
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              color: const Color(0xFF9ca3af),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF9ca3af),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 145),
                      FlSpot(1, 150),
                      FlSpot(2, 152),
                      FlSpot(3, 156),
                      FlSpot(4, 155),
                      FlSpot(5, 154),
                    ],
                    isCurved: true,
                    color: const Color(0xFF10b981),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF10b981),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF10b981).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

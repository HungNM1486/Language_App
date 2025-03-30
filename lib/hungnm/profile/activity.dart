import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _selectedTimeFilter = 'Ngày';
  // Dữ liệu mẫu (có thể thay bằng dữ liệu thực tế)
  Map<String, List<double>> studyTimeData = {
    'Ngày': [2.5, 1.8, 3.0, 2.0, 1.5, 2.8, 2.2], // 7 ngày (giờ)
    'Tuần': [12.5, 10.8, 14.0, 11.5], // 4 tuần (giờ)
    'Tháng': [50.0, 45.5, 55.0], // 3 tháng (giờ)
  };
  int totalCourses = 5; // Số khóa học mẫu

  @override
  void initState() {
    super.initState();
    _loadTimeFilter();
  }

  Future<void> _loadTimeFilter() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFilter = prefs.getString('activity_time_filter') ?? 'Ngày';
    setState(() {
      _selectedTimeFilter = savedFilter;
    });
  }

  Future<void> _saveTimeFilter(String filter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activity_time_filter', filter);
    setState(() {
      _selectedTimeFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.activity),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16 * pix),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.activityOverview,
                style: TextStyle(
                  fontSize: 20 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff5B7BFE),
                ),
              ),
              SizedBox(height: 16 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.studyTime,
                    style: TextStyle(
                      fontSize: 16 * pix,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedTimeFilter,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24 * pix,
                    elevation: 16,
                    style: TextStyle(
                      fontSize: 14 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.black,
                    ),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _saveTimeFilter(newValue);
                      }
                    },
                    items: <String>['Ngày', 'Tuần', 'Tháng']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16 * pix),
              SizedBox(
                height: 300 * pix,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxY(),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: EdgeInsets.all(8 * pix),
                        tooltipMargin: 8 * pix,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final hours = rod.toY.floor();
                          final minutes = ((rod.toY - hours) * 60).round();
                          return BarTooltipItem(
                            '$hours h $minutes m',
                            TextStyle(
                              color: Colors.white,
                              fontSize: 12 * pix,
                              fontFamily: 'BeVietnamPro',
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              _bottomTitles(value, pix),
                          reservedSize: 30 * pix,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                            '${value.toInt()}h',
                            style: TextStyle(
                              fontSize: 12 * pix,
                              fontFamily: 'BeVietnamPro',
                              color: Colors.grey,
                            ),
                          ),
                          reservedSize: 40 * pix,
                          interval: _getYInterval(),
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: true),
                    borderData: FlBorderData(show: false),
                    barGroups: _buildBarGroups(pix),
                  ),
                ),
              ),
              SizedBox(height: 24 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                    pix: pix,
                    icon: Icons.timer,
                    label: l10n.totalStudyTime,
                    value: _formatTotalStudyTime(),
                  ),
                  _buildStatCard(
                    pix: pix,
                    icon: Icons.book,
                    label: l10n.totalCourses,
                    value: '$totalCourses ${l10n.courses}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tạo khung thống kê
  Widget _buildStatCard({
    required double pix,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 150 * pix,
      height: 200 * pix,
      padding: EdgeInsets.all(16 * pix),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16 * pix),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30 * pix,
            backgroundColor: const Color(0xff5B7BFE),
            child: Icon(
              icon,
              size: 30 * pix,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12 * pix),
          Text(
            label,
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8 * pix),
          Text(
            value,
            style: TextStyle(
              fontSize: 18 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.bold,
              color: const Color(0xff5B7BFE),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Định dạng tổng thời gian học (giờ:phút)
  String _formatTotalStudyTime() {
    final totalHours = _calculateTotalTime();
    final hours = totalHours.floor();
    final minutes = ((totalHours - hours) * 60).round();
    return '$hours h $minutes m';
  }

  // Tính tổng thời gian học
  double _calculateTotalTime() {
    return studyTimeData[_selectedTimeFilter]!.reduce((a, b) => a + b);
  }

  // Tạo các cột biểu đồ
  List<BarChartGroupData> _buildBarGroups(double pix) {
    final data = studyTimeData[_selectedTimeFilter]!;
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: const Color(0xff5B7BFE),
            width: 20 * pix,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  // Tạo tiêu đề trục X
  Widget _bottomTitles(double value, double pix) {
    final index = value.toInt();
    final data = studyTimeData[_selectedTimeFilter]!;
    if (index >= data.length) return const SizedBox();

    String title;
    switch (_selectedTimeFilter) {
      case 'Ngày':
        title = 'D${index + 1}';
        break;
      case 'Tuần':
        title = 'W${index + 1}';
        break;
      case 'Tháng':
        title = 'M${index + 1}';
        break;
      default:
        title = '';
    }
    return Padding(
      padding: EdgeInsets.only(top: 8 * pix),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12 * pix,
          fontFamily: 'BeVietnamPro',
          color: Colors.grey,
        ),
      ),
    );
  }

  // Tính giá trị tối đa trục Y
  double _getMaxY() {
    final data = studyTimeData[_selectedTimeFilter]!;
    return (data.reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble();
  }

  // Tính khoảng cách trục Y
  double _getYInterval() {
    final maxY = _getMaxY();
    return (maxY / 5).ceilToDouble();
  }
}

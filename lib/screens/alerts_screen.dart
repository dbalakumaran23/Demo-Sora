import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';
import 'lost_found_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child:
              Text('Alerts', style: Theme.of(context).textTheme.headlineMedium),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: tc.glassWhite, borderRadius: BorderRadius.circular(14)),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12)),
            labelColor: Colors.white,
            unselectedLabelColor: tc.textMuted,
            labelStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 13),
            dividerColor: Colors.transparent,
            padding: const EdgeInsets.all(4),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Academics'),
              Tab(text: 'Lost & Found'),
              Tab(text: 'Emergency')
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAllTab(tc),
              _buildAcademicsTab(tc),
              _buildLostFoundTab(context, tc),
              _buildEmergencyTab(tc)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllTab(Tc tc) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _alertCard(
            tc,
            'Class Cancelled',
            'Data Structures class at 10 AM is cancelled today.',
            '30m ago',
            Icons.school_rounded,
            AppColors.accentTeal),
        _alertCard(tc, 'Library Due', 'Return "Design Patterns" by tomorrow.',
            '1h ago', Icons.menu_book_rounded, AppColors.accentOrange),
        _alertCard(
            tc,
            'Weather Alert',
            'Heavy rain expected. Carry an umbrella.',
            '2h ago',
            Icons.cloud_rounded,
            AppColors.accentPurple),
        _alertCard(
            tc,
            'Exam Schedule',
            'Mid-semester exams start from March 15.',
            '5h ago',
            Icons.event_note_rounded,
            AppColors.accentPink),
      ],
    );
  }

  Widget _buildAcademicsTab(Tc tc) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _alertCard(
            tc,
            'Class Cancelled',
            'Data Structures class at 10 AM is cancelled today.',
            '30m ago',
            Icons.school_rounded,
            AppColors.accentTeal),
        _alertCard(
            tc,
            'Assignment Due',
            'OS assignment submission deadline is tomorrow.',
            '3h ago',
            Icons.assignment_rounded,
            AppColors.accentOrange),
        _alertCard(
            tc,
            'Exam Schedule',
            'Mid-semester exams start from March 15.',
            '5h ago',
            Icons.event_note_rounded,
            AppColors.accentPink),
        _alertCard(tc, 'New Grades', 'DBMS lab grades have been published.',
            '1d ago', Icons.grade_rounded, AppColors.accentGreen),
      ],
    );
  }

  Widget _buildLostFoundTab(BuildContext context, Tc tc) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _lostFoundCard(tc, 'Blue Backpack', 'Found near Library entrance',
                '1h ago', true),
            _lostFoundCard(tc, 'Student ID Card', 'Lost in Cafeteria area',
                '3h ago', false),
            _lostFoundCard(
                tc, 'AirPods Pro', 'Found in Lecture Hall 3', '5h ago', true),
            _lostFoundCard(tc, 'Laptop Charger', 'Lost in Computer Lab B',
                '1d ago', false),
          ],
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LostFoundScreen())),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(18),
              ),
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyTab(Tc tc) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _emergencyCard(
            tc,
            'Campus Closure',
            'Campus will be closed on Feb 25 for maintenance.',
            Icons.lock_rounded),
        _emergencyCard(
            tc,
            'Weather Warning',
            'Cyclone alert: Stay indoors. All outdoor activities suspended.',
            Icons.thunderstorm_rounded),
        _emergencyCard(
            tc,
            'Safety Threat',
            'Suspicious activity reported near Block C. Avoid the area.',
            Icons.warning_rounded),
        _emergencyCard(
            tc,
            'Power Shutdown',
            'Scheduled power cut from 2 PM - 5 PM in academic blocks.',
            Icons.power_off_rounded),
      ],
    );
  }

  Widget _alertCard(Tc tc, String title, String desc, String time,
      IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Text(title,
                            style: TextStyle(
                                color: tc.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14))),
                    Text(time,
                        style: TextStyle(color: tc.textMuted, fontSize: 11)),
                  ]),
                  const SizedBox(height: 6),
                  Text(desc,
                      style: TextStyle(
                          color: tc.textSecondary, fontSize: 13, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lostFoundCard(
      Tc tc, String item, String location, String time, bool isFound) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: (isFound ? AppColors.accentGreen : AppColors.accentRed)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                  isFound ? Icons.check_circle_rounded : Icons.search_rounded,
                  color: isFound ? AppColors.accentGreen : AppColors.accentRed,
                  size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(location,
                      style: TextStyle(color: tc.textMuted, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color:
                        (isFound ? AppColors.accentGreen : AppColors.accentRed)
                            .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(isFound ? 'Found' : 'Lost',
                      style: TextStyle(
                          color: isFound
                              ? AppColors.accentGreen
                              : AppColors.accentRed,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 6),
                Text(time, style: TextStyle(color: tc.textMuted, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emergencyCard(Tc tc, String title, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: AppColors.accentRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.accentRed, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(desc,
                      style: TextStyle(
                          color: tc.textSecondary, fontSize: 13, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

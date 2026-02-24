import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDay = 0;
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final Map<int, List<_ClassItem>> _schedule = {
    0: [
      _ClassItem('Data Structures', '09:00 – 10:00', 'Dr. Kumar', 'Room 301',
          AppColors.accentTeal),
      _ClassItem('Operating Systems', '10:15 – 11:15', 'Dr. Patel', 'Room 204',
          AppColors.accentPurple),
      _ClassItem('DBMS Lab', '11:30 – 13:00', 'Prof. Singh', 'Lab B2',
          AppColors.accentOrange),
      _ClassItem('Computer Networks', '14:00 – 15:00', 'Dr. Sharma', 'Room 102',
          AppColors.accentPink),
    ],
    1: [
      _ClassItem('Mathematics III', '09:00 – 10:00', 'Dr. Mishra', 'Room 105',
          AppColors.accentGreen),
      _ClassItem('Data Structures Lab', '10:15 – 12:15', 'Dr. Kumar', 'Lab A1',
          AppColors.accentTeal),
      _ClassItem('Operating Systems', '13:00 – 14:00', 'Dr. Patel', 'Room 204',
          AppColors.accentPurple),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    final classes = _schedule[_selectedDay] ?? [];
    return Scaffold(
      backgroundColor: tc.bg,
      body: Container(
        decoration: BoxDecoration(gradient: tc.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, tc),
              const SizedBox(height: 10),
              _buildDaySelector(tc),
              const SizedBox(height: 18),
              Expanded(
                child: classes.isEmpty
                    ? Center(
                        child: Text('No classes scheduled',
                            style:
                                TextStyle(color: tc.textMuted, fontSize: 15)))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: classes.length,
                        itemBuilder: (_, i) => _classCard(tc, classes[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Tc tc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: tc.textPrimary),
              onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 4),
          Text('Timetable',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildDaySelector(Tc tc) {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _days.length,
        itemBuilder: (_, i) {
          final isSelected = _selectedDay == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected ? null : tc.glassWhite,
                borderRadius: BorderRadius.circular(14),
                border: isSelected ? null : Border.all(color: tc.glassBorder),
              ),
              alignment: Alignment.center,
              child: Text(
                _days[i],
                style: TextStyle(
                  color: isSelected ? Colors.white : tc.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _classCard(Tc tc, _ClassItem cls) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                  width: 4,
                  decoration: BoxDecoration(
                      color: cls.color,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cls.name,
                          style: TextStyle(
                              color: tc.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      const SizedBox(height: 8),
                      Row(children: [
                        Icon(Icons.access_time_rounded,
                            size: 14, color: cls.color),
                        const SizedBox(width: 6),
                        Text(cls.time,
                            style: TextStyle(
                                color: tc.textSecondary, fontSize: 13)),
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        Icon(Icons.person_rounded,
                            size: 14, color: tc.textMuted),
                        const SizedBox(width: 6),
                        Text(cls.teacher,
                            style:
                                TextStyle(color: tc.textMuted, fontSize: 12)),
                        const SizedBox(width: 16),
                        Icon(Icons.room_rounded, size: 14, color: tc.textMuted),
                        const SizedBox(width: 4),
                        Text(cls.room,
                            style:
                                TextStyle(color: tc.textMuted, fontSize: 12)),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassItem {
  final String name, time, teacher, room;
  final Color color;
  const _ClassItem(this.name, this.time, this.teacher, this.room, this.color);
}

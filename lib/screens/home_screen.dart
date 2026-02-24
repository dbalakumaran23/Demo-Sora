import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';
import 'forum_screen.dart';
import 'services_screen.dart';
import 'events_screen.dart';
import 'circulars_screen.dart';
import 'timetable_screen.dart';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(context, tc),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Quick Access'),
          const SizedBox(height: 16),
          _buildQuickAccess(context),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Academics'),
          const SizedBox(height: 16),
          _buildAcademics(context, tc),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Latest Updates', actionText: 'View All'),
          const SizedBox(height: 16),
          _buildUpdateCard(
              context,
              tc,
              'Academic',
              '2h ago',
              'Fall 2024 Registration Open',
              'Course registration is now open for all senior students. Check your allotted time slot.',
              AppColors.accentTeal),
          const SizedBox(height: 12),
          _buildUpdateCard(
              context,
              tc,
              'Event',
              '5h ago',
              'Tech Fest 2024 Registrations',
              'Annual tech fest is around the corner. Register your team for hackathon and coding contests.',
              AppColors.accentPurple),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, Tc tc) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.warmGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: tc.bgMedium,
              child: Icon(Icons.person_rounded, size: 28, color: tc.textMuted),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning, Balakumaran 👋',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('Computer Science • Semester 5',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tc.glassWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.notifications_none_rounded,
                color: tc.textSecondary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GlassIconTile(
            icon: Icons.forum_rounded,
            label: 'Forum',
            gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF818CF8)]),
            onTap: () => _navigateTo(context, const ForumScreen()),
          ),
          GlassIconTile(
            icon: Icons.miscellaneous_services_rounded,
            label: 'Services',
            gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFFF472B6)]),
            onTap: () => _navigateTo(context, const ServicesScreen()),
          ),
          GlassIconTile(
            icon: Icons.event_rounded,
            label: 'Events',
            gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)]),
            onTap: () => _navigateTo(context, const EventsScreen()),
          ),
          GlassIconTile(
            icon: Icons.description_rounded,
            label: 'Circulars',
            gradient: const LinearGradient(
                colors: [Color(0xFF14B8A6), Color(0xFF2DD4BF)]),
            onTap: () => _navigateTo(context, const CircularsScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademics(BuildContext context, Tc tc) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _navigateTo(context, const TimetableScreen()),
            child: GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.schedule_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 12),
                  Text('Timetable',
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('View schedule',
                      style: TextStyle(color: tc.textMuted, fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: GestureDetector(
            onTap: () => _navigateTo(context, const ResultScreen()),
            child: GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient,
                        borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.assessment_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 12),
                  Text('Results',
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('View grades',
                      style: TextStyle(color: tc.textMuted, fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateCard(BuildContext context, Tc tc, String tag, String time,
      String title, String desc, Color accent) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(tag,
                    style: TextStyle(
                        color: accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              Text(time, style: TextStyle(color: tc.textMuted, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title,
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(desc,
              style: TextStyle(
                  color: tc.textSecondary, fontSize: 13, height: 1.5)),
        ],
      ),
    );
  }
}

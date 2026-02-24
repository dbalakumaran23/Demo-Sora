import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    return Scaffold(
      backgroundColor: tc.bg,
      body: Container(
        decoration: BoxDecoration(gradient: tc.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, tc),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  children: [
                    _eventCard(
                        tc,
                        'Tech Fest 2024',
                        'Annual technology festival',
                        'Mar',
                        '15',
                        'Main Auditorium',
                        AppColors.accentTeal),
                    _eventCard(
                        tc,
                        'Cultural Night',
                        'Music, dance & drama',
                        'Mar',
                        '20',
                        'Open Air Theatre',
                        AppColors.accentPurple),
                    _eventCard(tc, 'Sports Day', 'Inter-department tournaments',
                        'Mar', '25', 'Sports Complex', AppColors.accentOrange),
                    _eventCard(tc, 'Alumni Meet', 'Networking with alumni',
                        'Apr', '05', 'Convention Hall', AppColors.accentPink),
                  ],
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
          Text('Events',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _eventCard(Tc tc, String title, String desc, String month, String day,
      String location, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 64,
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(month,
                      style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Text(day,
                      style: TextStyle(
                          color: color,
                          fontSize: 22,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(desc,
                      style: TextStyle(color: tc.textSecondary, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.location_on_rounded,
                        size: 14, color: tc.textMuted),
                    const SizedBox(width: 4),
                    Text(location,
                        style: TextStyle(color: tc.textMuted, fontSize: 12)),
                  ]),
                ],
              ),
            ),
            Icon(Icons.bookmark_border_rounded, color: tc.textMuted, size: 24),
          ],
        ),
      ),
    );
  }
}

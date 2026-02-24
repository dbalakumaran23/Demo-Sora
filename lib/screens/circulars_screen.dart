import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class CircularsScreen extends StatelessWidget {
  const CircularsScreen({super.key});

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
                    _circularCard(
                        tc,
                        'Exam Schedule Notice',
                        'Mid-semester exam timetable for all departments.',
                        'Feb 18, 2024',
                        true),
                    _circularCard(
                        tc,
                        'Library Rules Update',
                        'New rules regarding book borrowing limits.',
                        'Feb 15, 2024',
                        true),
                    _circularCard(
                        tc,
                        'Hostel Maintenance',
                        'Block B maintenance schedule for March.',
                        'Feb 12, 2024',
                        false),
                    _circularCard(
                        tc,
                        'Fee Payment Reminder',
                        'Last date for semester fee payment.',
                        'Feb 10, 2024',
                        false),
                    _circularCard(
                        tc,
                        'Workshop Registration',
                        'AI/ML workshop by Google DevRel.',
                        'Feb 08, 2024',
                        false),
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
          Text('Circulars',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _circularCard(
      Tc tc, String title, String desc, String date, bool isNew) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (isNew ? AppColors.accentTeal : AppColors.accentPurple)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.description_rounded,
                  color: isNew ? AppColors.accentTeal : AppColors.accentPurple,
                  size: 22),
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
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppColors.accentTeal.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text('NEW',
                            style: TextStyle(
                                color: AppColors.accentTeal,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                      ),
                  ]),
                  const SizedBox(height: 6),
                  Text(desc,
                      style: TextStyle(
                          color: tc.textSecondary, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 12, color: tc.textMuted),
                    const SizedBox(width: 4),
                    Text(date,
                        style: TextStyle(color: tc.textMuted, fontSize: 11)),
                    const Spacer(),
                    Icon(Icons.download_rounded,
                        size: 18, color: AppColors.accentTeal),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

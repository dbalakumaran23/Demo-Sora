import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

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
                    _postCard(
                        tc,
                        'Sarah K.',
                        '2h ago',
                        'Best study spots on campus?',
                        'Looking for quiet places to study. Library gets too crowded after 3PM.',
                        12,
                        8),
                    _postCard(
                        tc,
                        'Mike R.',
                        '4h ago',
                        'Anyone interested in Python study group?',
                        'Planning weekly sessions. Beginners welcome! DM me for details.',
                        24,
                        15),
                    _postCard(
                        tc,
                        'Priya S.',
                        '8h ago',
                        'Cafeteria food review',
                        'The new pasta counter is actually pretty good. Recommend the arrabiata.',
                        31,
                        22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.edit_rounded, color: Colors.white),
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
          Text('Forum',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _postCard(Tc tc, String author, String time, String title, String body,
      int likes, int replies) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      AppColors.accentPurple.withValues(alpha: 0.2),
                  child: Text(author[0],
                      style: const TextStyle(
                          color: AppColors.accentPurple,
                          fontWeight: FontWeight.w700))),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(author,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
              Text(time, style: TextStyle(color: tc.textMuted, fontSize: 11)),
            ]),
            const SizedBox(height: 12),
            Text(title,
                style: TextStyle(
                    color: tc.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            const SizedBox(height: 6),
            Text(body,
                style: TextStyle(
                    color: tc.textSecondary, fontSize: 13, height: 1.5)),
            const SizedBox(height: 14),
            Row(children: [
              Icon(Icons.favorite_border_rounded,
                  size: 18, color: tc.textMuted),
              const SizedBox(width: 4),
              Text('$likes',
                  style: TextStyle(color: tc.textMuted, fontSize: 12)),
              const SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline_rounded,
                  size: 18, color: tc.textMuted),
              const SizedBox(width: 4),
              Text('$replies',
                  style: TextStyle(color: tc.textMuted, fontSize: 12)),
            ]),
          ],
        ),
      ),
    );
  }
}

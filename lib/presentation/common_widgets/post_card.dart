// lib/presentation/common_widgets/post_card.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final String? imageUrl;

  const PostCard({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isLiked,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                username[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              username,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              timeAgo,
              style: theme.textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                // TODO: Show post options
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              content,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: 12),
            Image.network(
              imageUrl!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _PostStat(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  count: likes,
                  onTap: onLike,
                  isActive: isLiked,
                ),
                const SizedBox(width: 24),
                _PostStat(
                  icon: Icons.comment_outlined,
                  count: comments,
                  onTap: onComment,
                ),
                const SizedBox(width: 24),
                _PostStat(
                  icon: Icons.share_outlined,
                  count: shares,
                  onTap: onShare,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostStat extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback onTap;
  final bool isActive;

  const _PostStat({
    required this.icon,
    required this.count,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        isActive ? AppColors.primary : theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: theme.textTheme.bodyMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

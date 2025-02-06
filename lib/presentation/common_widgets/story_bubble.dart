// lib/presentation/common_widgets/story_bubble.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class StoryBubble extends StatelessWidget {
  final String username;
  final bool hasUnseenStory;
  final bool isCurrentUser;
  final String? imageUrl;

  const StoryBubble({
    super.key,
    required this.username,
    this.hasUnseenStory = false,
    this.isCurrentUser = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 72,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: hasUnseenStory ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.surfaceVariant,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? Icon(
                        isCurrentUser ? Icons.add : Icons.person,
                        color: theme.colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            username,
            style: theme.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

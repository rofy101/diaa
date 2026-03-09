import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/theme.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  const ChatBubbleWidget({
    required this.message,
    required this.isUser,
    required this.timestamp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser
              ? AppTheme.primaryBlue.withOpacity(0.15)
              : AppTheme.primaryGreen.withOpacity(0.15),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? Radius.zero : const Radius.circular(16),
            bottomRight: isUser ? const Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUser ? 'أنت' : 'المساعد الذكي',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(timestamp),
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

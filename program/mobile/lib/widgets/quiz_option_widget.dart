import 'package:flutter/material.dart';
import '../config/theme.dart';

class QuizOptionWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const QuizOptionWidget({
    required this.text,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
    super.key,
  });

  Color _getBorderColor() {
    if (!isSelected) return Colors.grey[300]!;
    if (isCorrect == null) return AppTheme.primaryBlue;
    if (isCorrect == true) return AppTheme.successColor;
    return AppTheme.errorColor;
  }

  Color _getBackgroundColor() {
    if (isCorrect == true) return Colors.green.withOpacity(0.1);
    if (isCorrect == false && isSelected) return Colors.red.withOpacity(0.1);
    if (isSelected) return Colors.blue.withOpacity(0.1);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isCorrect != null ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(color: _getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (isCorrect == true)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
            if (isCorrect == false && isSelected)
              const Icon(Icons.cancel, color: Colors.red, size: 24),
            if (isCorrect == null && !isSelected)
              const Icon(Icons.radio_button_unchecked, size: 24),
            if (isCorrect == null && isSelected)
              const Icon(Icons.radio_button_checked, color: Colors.blue, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

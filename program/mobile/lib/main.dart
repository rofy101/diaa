import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/audio_player_widget.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DiaaPreview(), // تأكدنا أن الاسم مطابق لما في الأسفل
  ));
}

class DiaaPreview extends StatelessWidget {
  const DiaaPreview({super.key}); // تم تصحيح الاسم هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشروع ضياء - معاينة الـ Widgets',
            style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: const Color(0xFF4A90D9),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('--- تجربة حقول النصوص ---',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'البريد الإلكتروني',
              controller: TextEditingController(),
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 30),
            const Text('--- تجربة مشغل الصوت ---',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const AudioPlayerWidget(
                audioUrl:
                    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
            const SizedBox(height: 30),
            const Text('--- تجربة الأزرار ---',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CustomButton(text: 'تسجيل الدخول', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

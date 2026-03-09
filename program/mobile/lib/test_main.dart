import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edu Smart - اختبار',
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90D9)),
        useMaterial3: true,
      ),
      home: const TestHomePage(),
    );
  }
}

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  String _backendStatus = '⏳ جاري الاختبار...';
  String _firebaseStatus = '⏳ جاري الاختبار...';
  bool _backendOk = false;
  bool _firebaseOk = false;
  bool _testing = true;

  @override
  void initState() {
    super.initState();
    _runTests();
  }

  Future<void> _runTests() async {
    setState(() => _testing = true);

    await _testBackend();
    await _testFirebase();

    setState(() => _testing = false);
  }

  Future<void> _testBackend() async {
    try {
      const apiUrl = 'http://10.0.2.2:8000';
      final response = await http.get(Uri.parse(apiUrl));

      setState(() {
        if (response.statusCode == 200) {
          _backendStatus = '✅ متصل بنجاح';
          _backendOk = true;
        } else {
          _backendStatus = '❌ فشل: رمز الحالة ${response.statusCode}';
          _backendOk = false;
        }
      });
    } catch (e) {
      setState(() {
        _backendStatus = '❌ فشل: $e';
        _backendOk = false;
      });
    }
  }

  Future<void> _testFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _firebaseStatus = '✅ متصل بنجاح';
        _firebaseOk = true;
      });
    } catch (e) {
      setState(() {
        _firebaseStatus = '❌ فشل: $e';
        _firebaseOk = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text('🔍 اختبار Edu Smart'),
          centerTitle: true,
          backgroundColor: const Color(0xFF4A90D9),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'المساعد التعليمي الذكي',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'اختبار الاتصال بالخدمات',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildTestCard(
                title: '✅ Flutter',
                subtitle: 'المشروع يعمل بنجاح',
                isOk: true,
              ),
              const SizedBox(height: 12),
              _buildTestCard(
                title: '🖥️ Backend (FastAPI)',
                subtitle: _backendStatus,
                isOk: _backendOk,
              ),
              const SizedBox(height: 12),
              _buildTestCard(
                title: '🔥 Firebase',
                subtitle: _firebaseStatus,
                isOk: _firebaseOk,
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _testing ? null : _runTests,
                icon: _testing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.refresh),
                label: Text(_testing ? 'جاري الاختبار...' : 'إعادة الاختبار'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90D9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard({
    required String title,
    required String subtitle,
    required bool isOk,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Icon(
          isOk ? Icons.check_circle : Icons.error_outline,
          color: isOk ? Colors.green : Colors.orange,
          size: 36,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

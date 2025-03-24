import 'package:eos_advance_login/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:eos_advance_login/screens/login_screen.dart';
import 'package:eos_advance_login/theme/light_theme.dart';
import 'package:eos_advance_login/theme/foundation/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Firebase 초기화 코드
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}

/// 애플리케이션의 루트 위젯
/// - 앱의 전체 테마 및 초기 화면을 설정합니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = LightTheme();

    return MaterialApp(
      title: 'EOS Advance Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: theme.color.primary),
        useMaterial3: true,
        fontFamily: 'Pretendard', // 프리텐다드 폰트 기본 적용
      ),
      // 로그인 상태에 따른 화면 분기 처리
      home: StreamBuilder<User?>(
        stream:
            FirebaseAuth.instance.authStateChanges(), // Firebase 인증 상태 변화 스트림
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // 로딩 중에는 스피너 표시
          }

          if (snapshot.hasData) {
            // 로그인 상태: HomeScreen 표시
            return const HomeScreen();
          } else {
            // 로그아웃 상태: LoginScreen 표시
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

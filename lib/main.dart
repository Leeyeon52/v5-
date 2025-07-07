// C:\Users\user\Desktop\0703flutter_v2\lib\main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // kIsWeb을 위해 필요

import 'app/router.dart';
import 'app/theme.dart';
import 'features/auth/viewmodel/auth_viewmodel.dart';
import 'features/mypage/viewmodel/userinfo_viewmodel.dart';
import 'features/chatbot/viewmodel/chatbot_viewmodel.dart';
import 'features/diagnosis/viewmodel/diagnosis_viewmodel.dart';

// ✅ 새로운 기능 ViewModel 임포트 추가
import 'features/history/viewmodel/history_viewmodel.dart';
import 'features/non_face_to_face/viewmodel/consultation_viewmodel.dart';
import 'features/nearby_clinics/viewmodel/clinic_viewmodel.dart';


void main() {
  // 플랫폼에 따라 _baseUrl을 중앙에서 정의
  final String globalBaseUrl = kIsWeb
      ? "http://127.0.0.1:5000" // 웹 (Edge, Chrome 등)에서 실행 시
      : "http://10.0.2.2:5000"; // 안드로이드 에뮬레이터에서 실행 시 (PC의 localhost를 의미)
      // 실제 안드로이드/iOS 기기에서 테스트 시에는 PC의 실제 로컬 IP 주소 (예: "http://192.168.0.100:5000")를 사용해야 할 수도 있습니다.

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel(baseUrl: globalBaseUrl)),
        ChangeNotifierProvider(create: (context) => UserInfoViewModel()),
        ChangeNotifierProvider(create: (context) => ChatbotViewModel(baseUrl: globalBaseUrl)),
        ChangeNotifierProvider(create: (context) => DiagnosisViewModel(baseUrl: globalBaseUrl)),
        // ✅ 새로운 기능 ViewModel 추가
        ChangeNotifierProvider(create: (context) => HistoryViewModel(baseUrl: globalBaseUrl)),
        ChangeNotifierProvider(create: (context) => ConsultationViewModel(baseUrl: globalBaseUrl)),
        ChangeNotifierProvider(create: (context) => ClinicViewModel(baseUrl: globalBaseUrl)),
      ],
      child: const MediToothApp(),
    ),
  );
}

class MediToothApp extends StatelessWidget {
  const MediToothApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediTooth',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

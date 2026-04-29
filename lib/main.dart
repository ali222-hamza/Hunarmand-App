import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// ViewModels
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/booking_viewmodel.dart';
import 'viewmodels/wallet_viewmodel.dart';

// Screens - Splash and Onboarding
import 'views/splash/splash_screen.dart';
import 'views/onboarding/onboarding_screen.dart';

// Auth screens
import 'views/auth/role_selection_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/auth/otp_screen.dart';
import 'views/auth/cnic_screen.dart';
import 'views/auth/forgot_password_screen.dart';

// Customer screens
import 'views/customer/home/customer_home_screen.dart';
import 'views/customer/worker_profile/worker_profile_screen.dart';
import 'views/customer/booking/booking_screen.dart';
import 'views/customer/tracking/tracking_screen.dart';
import 'views/customer/review/review_screen.dart';

// Worker screens
import 'views/worker/dashboard/worker_dashboard_screen.dart';
import 'views/worker/job_request/job_request_screen.dart';
import 'views/worker/job_progress/job_progress_screen.dart';
import 'views/worker/wallet/wallet_screen.dart';
import 'views/worker/wallet/withdraw_screen.dart';
import 'views/worker/performance/performance_screen.dart';
import 'views/worker/portfolio/portfolio_screen.dart';
import 'views/worker/profile/worker_own_profile_screen.dart';
import 'views/worker/chat/chat_screen.dart';

// Shared screens
import 'views/shared/notifications/notifications_screen.dart';
import 'views/shared/settings/settings_screen.dart';
import 'views/shared/settings/language_screen.dart';
import 'views/shared/support/help_screen.dart';
import 'views/shared/support/terms_screen.dart';
import 'views/shared/emergency/emergency_screen.dart';

// Admin
import 'views/admin/admin_panel_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase not initialized: $e');
    debugPrint('Add google-services.json to android/app/ folder');
  }

  runApp(const HunarmandApp());
}

class HunarmandApp extends StatelessWidget {
  const HunarmandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => BookingViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewModel()),
      ],
      child: MaterialApp(
        title: 'Hunarmand',
        debugShowCheckedModeBanner: false,

        // App theme - blue primary, yellow accent
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E3A8A),
            primary: const Color(0xFF1E3A8A),
            secondary: const Color(0xFFFBB700),
          ),
          fontFamily: 'Roboto',

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xFF374151)),
            titleTextStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
              fontFamily: 'Roboto',
            ),
          ),

          scaffoldBackgroundColor: Colors.white,

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Color(0xFF1E3A8A), width: 1.5),
            ),
          ),

          checkboxTheme: CheckboxThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF1E3A8A);
              }
              return null;
            }),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
          ),

          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.white;
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF1E3A8A);
              }
              return const Color(0xFFD1D5DB);
            }),
          ),
        ),

        // First screen
        initialRoute: '/',

        // All routes
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),

          // Auth
          '/role': (context) => const RoleSelectionScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/otp': (context) => const OtpScreen(),
          '/cnic': (context) => const CnicScreen(),
          '/forgot_password': (context) =>
          const ForgotPasswordScreen(),

          // Customer
          '/customer_home': (context) => const CustomerHomeScreen(),
          '/worker_profile': (context) =>
          const WorkerProfileScreen(),
          '/booking': (context) => const BookingScreen(),
          '/tracking': (context) => const TrackingScreen(),
          '/review': (context) => const ReviewScreen(),

          // Worker
          '/worker_home': (context) =>
          const WorkerDashboardScreen(),
          '/job_request': (context) => const JobRequestScreen(),
          '/job_progress': (context) => const JobProgressScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/withdraw': (context) => const WithdrawScreen(),
          '/performance': (context) => const PerformanceScreen(),
          '/portfolio': (context) => const PortfolioScreen(),
          '/worker_profile_own': (context) =>
          const WorkerOwnProfileScreen(),
          '/chat': (context) => const ChatScreen(),

          // Shared
          '/notifications': (context) =>
          const NotificationsScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/language': (context) => const LanguageScreen(),
          '/help': (context) => const HelpScreen(),

          '/emergency': (context) => const EmergencyScreen(),

          // Admin
          '/admin': (context) => const AdminPanelScreen(),
        },

        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => const _NotFoundScreen(),
        ),
      ),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 60, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 16),
            const Text('Page Not Found',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('This screen does not exist.',
                style: TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 14),
              ),
              child: const Text('Go Home',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
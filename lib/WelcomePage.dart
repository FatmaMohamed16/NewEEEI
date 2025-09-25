// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:animate_do/animate_do.dart';
// import 'TypesScreen.dart';
// import 'ChatbotScreen.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // Determine if dark mode is active
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     // Colors for light mode
//     final Color lightBackgroundColor = const Color(0xFFF1F6FB);
//     final Color lightPrimaryColor = const Color(0xFF364C88);
//     final Color lightTextColor = const Color(0xFF364C88);

//     // Colors for dark mode
//     final Color darkBackgroundColor = const Color(0xFF1C1C1E);
//     final Color darkPrimaryColor = const Color(0xFF6B4EF6);
//     final Color darkTextColor = const Color(0xFFE0E0E0);

//     return Scaffold(
//       backgroundColor: isDarkMode ? darkBackgroundColor : lightBackgroundColor,
//       body: Stack(
//         children: [
//           // Background with a gradient
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: isDarkMode
//                   ? [const Color(0xFF1C1C1E), const Color(0xFF2E2E31)]
//                   : [const Color(0xFFFFFFFF), const Color(0xFFF1F6FB)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),

//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // The EEEI logo with animation
//                 BounceInDown(
//                   duration: const Duration(milliseconds: 1000),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20.r),
//                     child: Image.asset(
//                       'assets/EIcon.png',
//                       width: 150.w, // Adjusted size for a single logo
//                       height: 150.h,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 10.h), // Spacing between logo image and name text

//                 // The name of the logo
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1200),
//                   child: Text(
//                     'EEEI',
//                     style: GoogleFonts.cairo(
//                       fontSize: 28.sp,
//                       fontWeight: FontWeight.bold,
//                       color: isDarkMode ? darkTextColor : lightTextColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 10.h), // Spacing between name and main text

//                 // Main text with animation
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1400),
//                   child: Text(
//                     'Explore The Egyptian Ecosystem',
//                     style: GoogleFonts.cairo(
//                       fontSize: 22.sp,
//                       fontWeight: FontWeight.bold,
//                       color: isDarkMode ? darkTextColor : lightTextColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 10.h),

//                 // Sub-text
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1600),
//                   child: Text(
//                     'More than 300 companies in one place',
//                     style: GoogleFonts.cairo(
//                       fontSize: 16.sp,
//                       color: isDarkMode ? darkTextColor.withOpacity(0.7) : lightTextColor.withOpacity(0.7),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),

//                 SizedBox(height: 100.h),

//                 // "Start Now" button with animation
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1800),
//                   child: Container(
//                     width: 320.w,
//                     height: 60.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: (isDarkMode ? darkPrimaryColor : lightPrimaryColor).withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => const TypesScreen(),
//                             ),
//                           );
//                         },
//                         borderRadius: BorderRadius.circular(30),
//                         child: Center(
//                           child: Text(
//                             'Start Now',
//                             style: GoogleFonts.cairo(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: isDarkMode ? darkBackgroundColor : lightPrimaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // Floating chat button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const ChatbotScreen()),
//           );
//         },
//         backgroundColor: isDarkMode ? darkPrimaryColor : lightPrimaryColor,
//         child: Icon(Icons.chat_bubble, color: isDarkMode ? lightBackgroundColor : Colors.white),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:animate_do/animate_do.dart';
// import 'TypesScreen.dart';
// import 'ChatbotScreen.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // الألوان الموحدة للنمط الداكن
//     final Color backgroundColor = const Color(0xFF2E2E3E); // لون الخلفية الثابت
//     final Color textColor = Colors.white;
//     final Color secondaryTextColor = Colors.white70;
//     final Color buttonColor = const Color(0xFF5A5A8D); // لون زر "Start Now"
//     final Color fabColor = Colors.white; // لون أيقونة الشات بوت (أبيض)

//     return Scaffold(
//       backgroundColor: backgroundColor, // تطبيق لون الخلفية الثابت
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // The EEEI logo with animation
//             BounceInDown(
//               duration: const Duration(milliseconds: 1000),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.r),
//                 child: Image.asset(
//                   'assets/EIcon2.png',
//                   width: 150.w,
//                   height: 150.h,
//                 ),
//               ),
//             ),

//             SizedBox(height: 10.h),

//             // The name of the logo
//             FadeInUp(
//               duration: const Duration(milliseconds: 1200),
//               child: Text(
//                 'EEEI',
//                 style: GoogleFonts.cairo(
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 10.h),

//             // Main text with animation
//             FadeInUp(
//               duration: const Duration(milliseconds: 1400),
//               child: Text(
//                 'Explore The Egyptian Ecosystem',
//                 style: GoogleFonts.cairo(
//                   fontSize: 22.sp,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 10.h),

//             // Sub-text
//             FadeInUp(
//               duration: const Duration(milliseconds: 1600),
//               child: Text(
//                 'More than 300 companies in one place',
//                 style: GoogleFonts.cairo(
//                   fontSize: 16.sp,
//                   color: secondaryTextColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             SizedBox(height: 100.h),

//             // "Start Now" button with animation
//             FadeInUp(
//               duration: const Duration(milliseconds: 1800),
//               child: Container(
//                 width: 320.w,
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.r),
//                   color: buttonColor, // لون ثابت للزر
//                   boxShadow: [
//                     BoxShadow(
//                       color: buttonColor.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const TypesScreen(),
//                         ),
//                       );
//                     },
//                     borderRadius: BorderRadius.circular(30.r),
//                     child: Center(
//                       child: Text(
//                         'Start Now',
//                         style: GoogleFonts.cairo(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: textColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const ChatbotScreen()),
//           );
//         },
//         backgroundColor: Colors.white, // خلفية الزر باللون الأبيض
//         child: Icon(
//           Icons.chat_bubble,
//           color: backgroundColor,
//         ), // أيقونة الشات بوت بلون الخلفية
//       ),
//     );
//   }
// }

// import 'package:eeei/MainScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'ChatbotScreen.dart';

// /// Full-width, full-height wave for the blue section
// class _FullPageWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final p = Path();
//     // Start ~20% down from the top of the blue area to create that soft bump
//     p.moveTo(0, size.height * 0.20);
//     p.quadraticBezierTo(
//       size.width * 0.28,
//       size.height * 0.04,
//       size.width * 0.52,
//       size.height * 0.16,
//     );
//     p.quadraticBezierTo(
//       size.width * 0.80,
//       size.height * 0.28,
//       size.width,
//       size.height * 0.18,
//     );
//     p.lineTo(size.width, size.height);
//     p.lineTo(0, size.height);
//     p.close();
//     return p;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   // colors per your mock
//   static const Color waveBlue = Color(0xFF2F5ED7);
//   static const Color ctaOrange = Color(0xFFFF6B3D);

//   // put your image here & list it in pubspec.yaml
//   static const String illustrationAsset = 'assets/1.png';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // whole page is the card now
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final h = constraints.maxHeight;
//             final w = constraints.maxWidth;

//             // where the blue area begins (tweak 0.42 → 0.38/0.45 to taste)
//             final blueTop = h * 0.42;

//             return Stack(
//               children: [
//                 // --- Top white area with illustration (fills to the wave start) ---
//                 Positioned.fill(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: blueTop,
//                         width: w,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 20.w,
//                             vertical: 16.h,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16.r),
//                             child: Container(
//                               color: const Color(0xFFF5F6FA),
//                               child: Image.asset(
//                                 illustrationAsset,
//                                 fit: BoxFit.cover,
//                                 errorBuilder:
//                                     (_, __, ___) => Center(
//                                       child: Icon(
//                                         Icons.image_not_supported_outlined,
//                                         size: 48.sp,
//                                         color: Colors.black26,
//                                       ),
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // spacer; the blue section will overlap from here
//                       Expanded(child: Container(color: Colors.transparent)),
//                     ],
//                   ),
//                 ),

//                 // --- Full-width blue wavy bottom section ---
//                 // --- قسم الخلفية الزرقاء بالكامل ---
//                 Positioned(
//                   top: blueTop - 32, // لا تغيّره إلا لو حبيت ترفع/تنزل الموجة
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: ClipPath(
//                     clipper: _FullPageWaveClipper(),
//                     child: Container(
//                       color: waveBlue,
//                       // padding أسفل أكبر لعمل مسافة عن الـ bottom
//                       padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment:
//                             MainAxisAlignment.center, // وسط القسم الأزرق
//                         children: [
//                           // النص داخل الخلفية الزرقاء
//                           Text(
//                             "Let's connect\nwith each other",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.cairo(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w900,
//                               fontSize: 24.sp,
//                               height: 1.15,
//                             ),
//                           ),
//                           SizedBox(height: 14.h),
//                           Text(
//                             "Welcome back to our app. Explore, chat,\nand discover more in the ecosystem.",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.cairo(
//                               color: Colors.white.withOpacity(0.98),
//                               fontSize: 16.sp,
//                               height: 1.35,
//                             ),
//                           ),

//                           // الزر تحت النص مباشرة
//                           SizedBox(height: 24.h),
//                           SizedBox(
//                             width: double.infinity,
//                             height: 54.h,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: ctaOrange,
//                                 elevation: 8,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(26.r),
//                                 ),
//                                 shadowColor: Colors.black26,
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                     builder: (_) => const MainScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 "Let's Start",
//                                 style: GoogleFonts.cairo(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: 18.sp,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           // مسافة إضافية أسفل الزر بعيداً عن حافة الشاشة
//                           SizedBox(height: 32.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),

//       // same FAB + routes (unchanged logic)
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(
//             context,
//           ).push(MaterialPageRoute(builder: (_) => const ChatbotScreen()));
//         },
//         backgroundColor: Colors.white,
//         child: const Icon(Icons.chat_bubble, color: Color(0xFF2E2E3E)),
//       ),
//     );
//   }
// }

// import 'package:eeei/MainScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'ChatbotScreen.dart';

// /// نفس ألوان التدرّج الموحّدة
// const Color kBlueDeep = Color(0xFF2F5ED7);
// const Color kOrangeSoft = Color(0xFFFF8A4C);
// const Color kVioletSoft = Color(0xFF6C5DD3);
// // زر أزرق مريح للقراءة فوق التدرّج
// const Color kBtnBlue = Color(0xFF3B6EE8);

// /// موجة الجزء السفلي
// class _FullPageWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final p = Path();
//     p.moveTo(0, size.height * 0.20);
//     p.quadraticBezierTo(
//       size.width * 0.28,
//       size.height * 0.04,
//       size.width * 0.52,
//       size.height * 0.16,
//     );
//     p.quadraticBezierTo(
//       size.width * 0.80,
//       size.height * 0.28,
//       size.width,
//       size.height * 0.18,
//     );
//     p.lineTo(size.width, size.height);
//     p.lineTo(0, size.height);
//     p.close();
//     return p;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   static const String illustrationAsset = 'assets/1.png';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final h = constraints.maxHeight;
//             final w = constraints.maxWidth;
//             final waveTop = h * 0.42;

//             return Stack(
//               children: [
//                 // الجزء العلوي الأبيض + الصورة
//                 Positioned.fill(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: waveTop,
//                         width: w,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 20.w,
//                             vertical: 16.h,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16.r),
//                             child: Container(
//                               color: const Color(0xFFF5F6FA),
//                               child: Image.asset(
//                                 illustrationAsset,
//                                 fit: BoxFit.cover,
//                                 errorBuilder:
//                                     (_, __, ___) => Center(
//                                       child: Icon(
//                                         Icons.image_not_supported_outlined,
//                                         size: 48.sp,
//                                         color: Colors.black26,
//                                       ),
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(child: Container(color: Colors.transparent)),
//                     ],
//                   ),
//                 ),

//                 // الجزء السفلي بالموجة + التدرّج بدل الأزرق
//                 Positioned(
//                   top: waveTop - 32,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: ClipPath(
//                     clipper: _FullPageWaveClipper(),
//                     child: DecoratedBox(
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [kBlueDeep, kOrangeSoft, kVioletSoft],
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Let's connect\nwith each other",
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.cairo(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 24.sp,
//                                 height: 1.15,
//                               ),
//                             ),
//                             SizedBox(height: 14.h),
//                             Text(
//                               "Welcome back to our app. Explore, chat,\nand discover more in the ecosystem.",
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.cairo(
//                                 color: Colors.white.withOpacity(0.98),
//                                 fontSize: 16.sp,
//                                 height: 1.35,
//                               ),
//                             ),
//                             SizedBox(height: 24.h),

//                             // زر أزرق بدل البرتقالي
//                             SizedBox(
//                               width: double.infinity,
//                               height: 54.h,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: kBtnBlue,
//                                   elevation: 8,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(26.r),
//                                   ),
//                                   shadowColor: Colors.black26,
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pushReplacement(
//                                     MaterialPageRoute(
//                                       builder: (_) => const MainScreen(),
//                                     ),
//                                   );
//                                 },
//                                 child: Text(
//                                   "Let's Start",
//                                   style: GoogleFonts.cairo(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w900,
//                                     fontSize: 18.sp,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 32.h),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(
//             context,
//           ).push(MaterialPageRoute(builder: (_) => const ChatbotScreen()));
//         },
//         backgroundColor: Colors.white,
//         child: const Icon(Icons.chat_bubble, color: Color(0xFF2E2E3E)),
//       ),
//     );
//   }
// }
import 'package:eeei/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ChatbotScreen.dart';

/// نفس ألوان التدرّج الموحّدة
const Color kBlueDeep = Color(0xFF2F5ED7);
const Color kOrangeSoft = Color(0xFFFF8A4C);
const Color kVioletSoft = Color(0xFF6C5DD3);
// زر أزرق مريح للقراءة فوق التدرّج
const Color kBtnBlue = Color(0xFF3B6EE8);

/// موجة الجزء السفلي
class _FullPageWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.moveTo(0, size.height * 0.20);
    p.quadraticBezierTo(
      size.width * 0.28,
      size.height * 0.04,
      size.width * 0.52,
      size.height * 0.16,
    );
    p.quadraticBezierTo(
      size.width * 0.80,
      size.height * 0.28,
      size.width,
      size.height * 0.18,
    );
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// ويدجت لعرض اللوجو بشكل متكيّف مع المقاس و الـ DPR
class _LogoBox extends StatelessWidget {
  final String asset;
  final double maxPercentOfWidth;
  const _LogoBox(
    this.asset, {
    this.maxPercentOfWidth = 0.32, // النسبة من عرض الشاشة
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final dpr = media.devicePixelRatio;

    // مقاس متكَيّف: بين 80 و 140 بكسل حسب عرض الشاشة
    final double side = (w * maxPercentOfWidth).clamp(80.0, 140.0);

    return SizedBox(
      width: side,
      height: side, // مربع؛ BoxFit.contain يحافظ على الأسبكت
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        // يساعد على رسم أوضح على شاشات عالية الكثافة
        cacheWidth: (side * dpr).round(),
        errorBuilder: (context, error, stack) {
          debugPrint('❌ Unable to load asset: $asset -> $error');
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.broken_image_outlined,
              color: Colors.redAccent,
            ),
          );
        },
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            final waveTop = h * 0.42; // مساحة الجزء العلوي قبل الموجة

            return Stack(
              children: [
                // الجزء العلوي: لوجو | فاصل | لوجو (بدون كارد/خلفية)
                Positioned.fill(
                  child: Column(
                    children: [
                      SizedBox(
                        height: waveTop,
                        width: w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // لوجو يسار (Flexible يمنع الـ overflow)
                                const Flexible(
                                  fit: FlexFit.loose,
                                  child: _LogoBox('assets/logoDar.png'),
                                ),

                                // فاصل رأسي بسيط
                                Container(
                                  width: 1,
                                  height: 48.h,
                                  color: Colors.black26,
                                ),

                                // لوجو يمين
                                const Flexible(
                                  fit: FlexFit.loose,
                                  child: _LogoBox('assets/logomagic.jpeg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ),

                // الجزء السفلي بالموجة + التدرّج
                Positioned(
                  top: waveTop - 32,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipPath(
                    clipper: _FullPageWaveClipper(),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [kBlueDeep, kOrangeSoft, kVioletSoft],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Let's connect\nwith each other",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24.sp,
                                height: 1.15,
                              ),
                            ),
                          SizedBox(height: 14.h),
Text(
  "Welcome back to our app. Explore, chat,\nand discover more in the ecosystem.",
  textAlign: TextAlign.center,
  style: GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.98),
    fontSize: 16.sp,
    height: 1.35,
  ),
),
SizedBox(height: 6.h), // مسافة صغيرة بين النصين
Text(
  "516 companies",
  textAlign: TextAlign.center,
  style: GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.85),
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  ),
),
SizedBox(height: 24.h),


                            // زر أزرق
                            SizedBox(
                              width: double.infinity,
                              height: 54.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kBtnBlue,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26.r),
                                  ),
                                  shadowColor: Colors.black26,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const MainScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Let's Start",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ChatbotScreen()));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.chat_bubble, color: Color(0xFF2E2E3E)),
      ),
    );
  }
}

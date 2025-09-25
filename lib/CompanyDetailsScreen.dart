// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart'; // لاستخدام الانيميشن

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       // استخدام mode: LaunchMode.externalApplication لفتحها في المتصفح الخارجي
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       // يمكنك هنا عرض رسالة خطأ للمستخدم إذا فشل فتح الرابط
//       debugPrint('Could not launch $url');
//       // مثال لعرض رسالة خطأ للمستخدم:
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text('Could not open $url')),
//       // );
//     }
//   }

//   // دالة لفتح الإيميل
//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   // Widget لبناء صفوف المعلومات (مثل العنوان)
//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) { // لون رمادي فاتح للأيقونات
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h), // زيادة المسافة الرأسية قليلاً
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp), // حجم أكبر للأيقونة
//           SizedBox(width: 12.w), // مسافة أكبر بين الأيقونة والنص
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp, // حجم خط أكبر قليلاً
//                 color: Colors.white70, // لون أبيض فاتح للنصوص
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget لبناء صفوف الإجراءات (روابط قابلة للنقر)
//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h), // زيادة المسافة الرأسية قليلاً
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else { // للروابط الأخرى مثل الموقع وفيسبوك
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp), // حجم أكبر للأيقونة
//             SizedBox(width: 12.w), // مسافة أكبر بين الأيقونة والنص
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp, // حجم خط أكبر قليلاً
//                   color: Colors.lightBlueAccent, // لون أزرق فاتح مميز للروابط
//                   decoration: TextDecoration.underline, // خط سفلي للروابط
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget لأيقونات التواصل الاجتماعي الدائرية
//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w, // حجم الأيقونة الدائرية
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66), // لون خلفية الأيقونة (رمادي داكن)
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3), // ظل خفيف
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp), // حجم الأيقونة الداخلية
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // تصميم الـ AppBar
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white, // لون عنوان أبيض
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56), // لون خلفية الـ AppBar
//         elevation: 0, // إزالة الظل
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // أيقونة رجوع بيضاء
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true, // توسيط العنوان
//       ),
//       backgroundColor: const Color(0xFF2E2E3E), // لون خلفية الشاشة الرئيسي (داكن)
//       body: Center( // لتوسيط المحتوى الرئيسي
//         child: FadeInUp( // إضافة انيميشن للدخول
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w, // عرض البطاقة الرئيسي
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h), // مسافة من الأطراف
//             padding: EdgeInsets.all(20.w), // مسافة داخلية للمحتوى
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E), // لون خلفية البطاقة (أغمق قليلاً من AppBar)
//               borderRadius: BorderRadius.circular(25.r), // زوايا دائرية كبيرة
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4), // ظل قوي للبطاقة
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView( // للسماح بالتمرير إذا كان المحتوى طويلاً
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // لجعل العمود يأخذ أقل مساحة ممكنة
//                 children: [
//                   // عرض شعار الشركة في المنتصف
//                  if (company.logoImageUrl != null && company.logoImageUrl!.isNotEmpty && company.logoImageUrl != 'null')
//   Container(
//     width: 100.w,
//     height: 100.h,
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.1), // خلفية خفيفة للشعار
//       shape: BoxShape.circle, // هذا يجعل الشكل دائرة
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.2),
//           blurRadius: 10,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: ClipOval( // هذا يقوم بقص الصورة على شكل دائرة
//       child: Image.asset( // هذا يقوم بتحميل الصورة المحلية
//         'assets/${company.logoImageUrl!}', // هنا نضيف 'assets/' إلى المسار
//         fit: BoxFit.contain, // هذا يضمن ظهور الصورة بالكامل
//         errorBuilder: (context, error, stackTrace) => const Icon(
//           Icons.broken_image_outlined,
//           color: Colors.red,
//           size: 50,
//         ),
//       ),
//     ),
//   ),
//                   SizedBox(height: 20.h), // مسافة بعد الشعار

//                   // اسم الشركة
//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp, // حجم خط كبير لاسم الشركة
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, // لون نص أبيض
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h), // مسافة صغيرة

//                   // وصف الشركة
//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300], // لون رمادي فاتح للوصف
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h), // مسافة أكبر قبل التفاصيل

//                   // فاصل أفقي
//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB), // لون الفاصل بلون قريب من تدرج الأزرار
//                   ),
//                   SizedBox(height: 28.h), // مسافة بعد الفاصل

//                   // صف أيقونات التواصل الاجتماعي
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly, // توزيع الأيقونات بشكل متساوي
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h), // مسافة أكبر قبل زر الموقع

//                   // زر "Visit Website"
//                   SlideInUp( // إضافة انيميشن للزر
//                     delay: const Duration(milliseconds: 300), // تأخير بسيط قبل ظهور الزر
//                     child: Container(
//                       width: double.infinity, // عرض الزر ليملأ المساحة المتاحة
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)], // تدرج لوني مميز للزر
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r), // زوايا دائرية كبيرة للزر
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4), // ظل بلون أزرق
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent, // جعل المادة شفافة
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl), // استدعاء دالة فتح الرابط
//                           borderRadius: BorderRadius.circular(30.r), // نفس زوايا الـ Container
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white, // نص أبيض
//                                 letterSpacing: 1.2, // مسافة بين الحروف
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // تم تعديل هذا الجزء لعرض الشعار بدون حواف دائرية
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r), // يمكن إضافة زوايا بسيطة للمظهر الجمالي
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image_outlined,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),

//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),

//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),

//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB),
//                   ),
//                   SizedBox(height: 28.h),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),

//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // تم تعديل هذا الجزء لعرض الشعار بدون حواف دائرية
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r), // يمكن إضافة زوايا بسيطة للمظهر الجمالي
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image_outlined,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),

//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),

//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),

//                   // تم إضافة هذا السطر لإظهار العنوان
//                   _buildInfoRow(Icons.location_on, company.address),

//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB),
//                   ),
//                   SizedBox(height: 28.h),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),

//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') {
//       debugPrint('Address is null or empty');
//       return;
//     }
//     final encodedAddress = Uri.encodeComponent(address);
//     final uri = Uri.parse('http://maps.google.com/?q=$encodedAddress');

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch maps with address: $address');
//     }
//   }

//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else if (type == 'map') {
//             _launchMap(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image_outlined,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),

//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),

//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),

//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB),
//                   ),
//                   SizedBox(height: 28.h),

//                   _buildActionRow(
//                     'map',
//                     Icons.location_on,
//                     company.address,
//                   ),
//                   SizedBox(height: 12.h),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),

//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   // تم تعديل هذه الدالة لفتح الخريطة على العنوان مع وضع علامة
//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') {
//       debugPrint('Address is null or empty');
//       return;
//     }
//     // بناء رابط خرائط جوجل باستخدام العنوان كمعامل بحث
//     final Uri mapLaunchUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');

//     if (await canLaunchUrl(mapLaunchUri)) {
//       await launchUrl(mapLaunchUri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch maps with address: $address');
//     }
//   }

//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else if (type == 'map') {
//             _launchMap(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image_outlined,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),

//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),

//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),

//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB),
//                   ),
//                   SizedBox(height: 28.h),

//                   _buildActionRow(
//                     'map',
//                     Icons.location_on,
//                     company.address,
//                   ),
//                   SizedBox(height: 12.h),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),

//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') {
//       debugPrint('Address is null or empty');
//       return;
//     }

//     final Uri mapLaunchUri = Uri.parse(
//         'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&z=19');

//     if (await canLaunchUrl(mapLaunchUri)) {
//       await launchUrl(mapLaunchUri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch maps with address: $address');
//     }
//   }

//   Widget _buildInfoRow(IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(
//                 fontSize: 15.sp,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(String type, IconData icon, String? value, {Color color = const Color(0xFFB0BEC5)}) {
//     if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else if (type == 'map') {
//             _launchMap(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image_outlined,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),

//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),

//                   if (company.description != null && company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),

//                   const Divider(
//                     height: 1,
//                     color: Color(0xFF7A7ABB),
//                   ),
//                   SizedBox(height: 28.h),

//                   _buildActionRow(
//                     'map',
//                     Icons.location_on,
//                     company.address,
//                   ),
//                   SizedBox(height: 12.h),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSocialIcon(FontAwesomeIcons.facebookF, company.facebookUrl, _launchUrl),
//                       _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//                       _buildSocialIcon(FontAwesomeIcons.envelope, company.email, _launchEmail),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),

//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   // // هذه هي الدالة الجديدة التي ستقوم بتعديل المسار
//   // String _formatImagePath(String path) {
//   //   return path.replaceAll(' ', '_');
//   // }

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') {
//       debugPrint('Address is null or empty');
//       return;
//     }

//     final Uri mapLaunchUri = Uri.parse(
//       'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&z=19',
//     );

//     if (await canLaunchUrl(mapLaunchUri)) {
//       await launchUrl(mapLaunchUri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch maps with address: $address');
//     }
//   }

//   Widget _buildInfoRow(
//     IconData icon,
//     String? value, {
//     Color color = const Color(0xFFB0BEC5),
//   }) {
//     if (value == null || value.isEmpty || value == 'null')
//       return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(fontSize: 15.sp, color: Colors.white70),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(
//     String type,
//     IconData icon,
//     String? value, {
//     Color color = const Color(0xFFB0BEC5),
//   }) {
//     if (value == null || value.isEmpty || value == 'null')
//       return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else if (type == 'map') {
//             _launchMap(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         // هنا التعديل
//                         'assets/images/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder:
//                             (context, error, stackTrace) => const Icon(
//                               Icons.broken_image_outlined,
//                               color: Colors.red,
//                               size: 50,
//                             ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),
//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),
//                   if (company.description != null &&
//                       company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),
//                   const Divider(height: 1, color: Color(0xFF7A7ABB)),
//                   SizedBox(height: 28.h),

//                   // العناوين
//                   _buildActionRow('map', Icons.location_on, company.address),
//                   _buildActionRow(
//                     'map',
//                     Icons.location_on,
//                     company.secondAddress,
//                   ),
//                   SizedBox(height: 12.h),

//                   // أيقونات التواصل الأساسية ومواقع التواصل الاجتماعي
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children:
//                         [
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.phone,
//                                 company.phone,
//                                 _launchPhone,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.phone,
//                                 company.secondPhone,
//                                 _launchPhone,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.solidEnvelope,
//                                 company.email,
//                                 _launchEmail,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.facebookF,
//                                 company.facebookUrl,
//                                 _launchUrl,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.instagram,
//                                 company.instagramUrl,
//                                 _launchUrl,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.linkedinIn,
//                                 company.linkedinUrl,
//                                 _launchUrl,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.youtube,
//                                 company.youtubeUrl,
//                                 _launchUrl,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.tiktok,
//                                 company.tiktokUrl,
//                                 _launchUrl,
//                               ),
//                               SizedBox(width: 16.w),
//                               _buildSocialIcon(
//                                 FontAwesomeIcons.twitter,
//                                 company.twitterUrl,
//                                 _launchUrl,
//                               ),
//                             ]
//                             .where(
//                               (widget) => widget != const SizedBox.shrink(),
//                             )
//                             .toList(),
//                   ),

//                   SizedBox(height: 20.h),
//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

/////////////////

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyDetailsScreen({super.key, required this.company});

//   // // هذه هي الدالة الجديدة التي ستقوم بتعديل المسار
//   // String _formatImagePath(String path) {
//   //   return path.replaceAll(' ', '_');
//   // }

//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') {
//       debugPrint('URL is null or empty');
//       return;
//     }
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch $url');
//     }
//   }

//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') {
//       debugPrint('Email is null or empty');
//       return;
//     }
//     final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       debugPrint('Could not launch email');
//     }
//   }

//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') {
//       debugPrint('Phone number is null or empty');
//       return;
//     }
//     final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     } else {
//       debugPrint('Could not launch phone');
//     }
//   }

//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') {
//       debugPrint('Address is null or empty');
//       return;
//     }

//     final Uri mapLaunchUri = Uri.parse(
//       'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&z=19',
//     );

//     if (await canLaunchUrl(mapLaunchUri)) {
//       await launchUrl(mapLaunchUri, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('Could not launch maps with address: $address');
//     }
//   }

//   Widget _buildInfoRow(
//     IconData icon,
//     String? value, {
//     Color color = const Color(0xFFB0BEC5),
//   }) {
//     if (value == null || value.isEmpty || value == 'null')
//       return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 22.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.cairo(fontSize: 15.sp, color: Colors.white70),
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionRow(
//     String type,
//     IconData icon,
//     String? value, {
//     Color color = const Color(0xFFB0BEC5),
//   }) {
//     if (value == null || value.isEmpty || value == 'null')
//       return const SizedBox.shrink();
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: InkWell(
//         onTap: () {
//           if (type == 'email') {
//             _launchEmail(value);
//           } else if (type == 'phone') {
//             _launchPhone(value);
//           } else if (type == 'map') {
//             _launchMap(value);
//           } else {
//             _launchUrl(value);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 22.sp),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.cairo(
//                   fontSize: 15.sp,
//                   color: Colors.lightBlueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, String? url, Function(String?) onTap) {
//     if (url == null || url.isEmpty || url == 'null') {
//       return const SizedBox.shrink();
//     }
//     return GestureDetector(
//       onTap: () => onTap(url),
//       child: Container(
//         width: 50.w,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4C4C66),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 24.sp),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // قم بتعريف القائمة هنا، قبل استخدامها في شجرة الويدجت
//     final List<Widget> socialIcons =
//         [
//           _buildSocialIcon(FontAwesomeIcons.phone, company.phone, _launchPhone),
//           _buildSocialIcon(
//             FontAwesomeIcons.phone,
//             company.secondPhone,
//             _launchPhone,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.solidEnvelope,
//             company.email,
//             _launchEmail,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.facebookF,
//             company.facebookUrl,
//             _launchUrl,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.instagram,
//             company.instagramUrl,
//             _launchUrl,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.linkedinIn,
//             company.linkedinUrl,
//             _launchUrl,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.youtube,
//             company.youtubeUrl,
//             _launchUrl,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.tiktok,
//             company.tiktokUrl,
//             _launchUrl,
//           ),
//           _buildSocialIcon(
//             FontAwesomeIcons.twitter,
//             company.twitterUrl,
//             _launchUrl,
//           ),
//         ].where((widget) => widget is! SizedBox).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           company.name ?? 'Company Details',
//           style: GoogleFonts.cairo(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF3C3C56),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFF2E2E3E),
//       body: Center(
//         child: FadeInUp(
//           duration: const Duration(milliseconds: 700),
//           child: Container(
//             width: 340.w,
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A4A6E),
//               borderRadius: BorderRadius.circular(25.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 25,
//                   offset: const Offset(0, 12),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(15.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         'assets/images/${company.logoImageUrl!}',
//                         fit: BoxFit.contain,
//                         errorBuilder:
//                             (context, error, stackTrace) => const Icon(
//                               Icons.broken_image_outlined,
//                               color: Colors.red,
//                               size: 50,
//                             ),
//                       ),
//                     ),
//                   SizedBox(height: 20.h),
//                   Text(
//                     company.name ?? 'Company Name',
//                     style: GoogleFonts.cairo(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8.h),
//                   if (company.description != null &&
//                       company.description!.isNotEmpty)
//                     Text(
//                       company.description!,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15.sp,
//                         color: Colors.grey[300],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 28.h),
//                   const Divider(height: 1, color: Color(0xFF7A7ABB)),
//                   SizedBox(height: 28.h),

//                   // العناوين
//                   _buildActionRow('map', Icons.location_on, company.address),
//                   _buildActionRow(
//                     'map',
//                     Icons.location_on,
//                     company.secondAddress,
//                   ),
//                   SizedBox(height: 12.h),

//                   // استخدام GridView لعرض الأيقونات
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: socialIcons.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 20.0,
//                           mainAxisSpacing: 20.0,
//                         ),
//                     itemBuilder: (context, index) {
//                       return socialIcons[index];
//                     },
//                   ),

//                   SizedBox(height: 20.h),
//                   SlideInUp(
//                     delay: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF5A5A8D), Color(0xFF7A7ABB)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.4),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () => _launchUrl(company.websiteUrl),
//                           borderRadius: BorderRadius.circular(30.r),
//                           child: Center(
//                             child: Text(
//                               'VISIT WEBSITE',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';

// class CompanyDetailsScreen extends StatelessWidget {
//   final CompanyModel company;
//   const CompanyDetailsScreen({super.key, required this.company});

//   // ---------- launch helpers ----------
//   Future<void> _launchUrl(String? url) async {
//     if (url == null || url.isEmpty || url == 'null') return;
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }
//   Future<void> _launchEmail(String? email) async {
//     if (email == null || email.isEmpty || email == 'null') return;
//     final uri = Uri(scheme: 'mailto', path: email);
//     if (await canLaunchUrl(uri)) await launchUrl(uri);
//   }
//   Future<void> _launchPhone(String? phone) async {
//     if (phone == null || phone.isEmpty || phone == 'null') return;
//     final uri = Uri(scheme: 'tel', path: phone);
//     if (await canLaunchUrl(uri)) await launchUrl(uri);
//   }
//   Future<void> _launchMap(String? address) async {
//     if (address == null || address.isEmpty || address == 'null') return;
//     final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&z=19');
//     if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }

//   // ---------- brand colors for social icons ----------
//   static const _brand = {
//     'threads': Color(0xFF000000),
//     'instagram1': Color(0xFFFEDA77), // gradient sample
//     'instagram2': Color(0xFFD62976),
//     'linkedin': Color(0xFF0A66C2),
//     'x': Color(0xFF000000),
//     'facebook': Color(0xFF1877F2),
//     'youtube': Color(0xFFFF0000),
//     'tiktok': Color(0xFF000000),
//     'whatsapp': Color(0xFF25D366),
//   };

//   Widget _chipIcon({
//     required Widget icon,
//     required VoidCallback onTap,
//     Color? color,
//     Gradient? gradient,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 54.w,
//         height: 54.w,
//         decoration: BoxDecoration(
//           color: color,
//           gradient: gradient,
//           shape: BoxShape.circle,
//           boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 4))],
//         ),
//         child: Center(child: icon),
//       ),
//     );
//   }

//   Widget _rowAction({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(14.r),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10.h),
//         child: Row(
//           children: [
//             Container(
//               width: 38.w,
//               height: 38.w,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(.12),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Icon(icon, color: Colors.white, size: 18.sp),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(
//                 label,
//                 style: GoogleFonts.cairo(fontSize: 16.sp, color: Colors.white.withOpacity(.95)),
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final logo = (company.logoImageUrl != null && company.logoImageUrl!.isNotEmpty && company.logoImageUrl != 'null')
//         ? 'assets/images/${company.logoImageUrl!}'
//         : null;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: FadeInDown(
//           duration: const Duration(milliseconds: 350),
//           child: Text(
//             'Company',
//             style: GoogleFonts.cairo(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           // gradient like your reference
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFFB56B), Color(0xFFF46DB5), Color(0xFF7B5BAA)],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
//             child: Column(
//               children: [
//                 /// -------- top card: logo + name + description --------
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 500),
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24.r),
//                       // soft glass-card feel
//                       gradient: LinearGradient(
//                         colors: [Colors.white.withOpacity(.18), Colors.white.withOpacity(.10)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       border: Border.all(color: Colors.white.withOpacity(.15)),
//                       boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 18, offset: const Offset(0, 10))],
//                     ),
//                     child: Column(
//                       children: [
//                         // logo card
//                         Container(
//                           width: 96.w,
//                           height: 96.w,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(.15),
//                             borderRadius: BorderRadius.circular(20.r),
//                             border: Border.all(color: Colors.white.withOpacity(.18)),
//                           ),
//                           child: logo != null
//                               ? Padding(
//                                   padding: EdgeInsets.all(10.w),
//                                   child: Image.asset(logo, fit: BoxFit.contain),
//                                 )
//                               : const Icon(Icons.apartment, color: Colors.white70, size: 40),
//                         ),
//                         SizedBox(height: 16.h),
//                         Text(
//                           company.name ?? 'Company Name',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.cairo(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.white,
//                             height: 1.15,
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         if ((company.description ?? '').trim().isNotEmpty)
//                           Text(
//                             company.description!,
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.cairo(fontSize: 14.5.sp, color: Colors.white.withOpacity(.95), height: 1.35),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 16.h),

//                 /// -------- info + social card --------
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 650),
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 22.h),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24.r),
//                       gradient: LinearGradient(
//                         colors: [Colors.white.withOpacity(.18), Colors.white.withOpacity(.10)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       border: Border.all(color: Colors.white.withOpacity(.15)),
//                       boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 18, offset: const Offset(0, 10))],
//                     ),
//                     child: Column(
//                       children: [
//                         // actions (tap to launch)
//                         if ((company.address ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.location_on,
//                             label: company.address!,
//                             onTap: () => _launchMap(company.address),
//                           ),
//                         if ((company.secondAddress ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.location_on,
//                             label: company.secondAddress!,
//                             onTap: () => _launchMap(company.secondAddress),
//                           ),
//                         if ((company.phone ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.call,
//                             label: company.phone!,
//                             onTap: () => _launchPhone(company.phone),
//                           ),
//                         if ((company.secondPhone ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.phone_android,
//                             label: company.secondPhone!,
//                             onTap: () => _launchPhone(company.secondPhone),
//                           ),
//                         if ((company.email ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.email_outlined,
//                             label: company.email!,
//                             onTap: () => _launchEmail(company.email),
//                           ),
//                         if ((company.websiteUrl ?? '').isNotEmpty)
//                           _rowAction(
//                             icon: Icons.public,
//                             label: Uri.tryParse(company.websiteUrl!)?.host ?? company.websiteUrl!,
//                             onTap: () => _launchUrl(company.websiteUrl),
//                           ),

//                         SizedBox(height: 12.h),
//                         const Divider(color: Colors.white24, height: 1),
//                         SizedBox(height: 12.h),

//                         // brand-colored social icons (only if present)
//                         Wrap(
//                           spacing: 14.w,
//                           runSpacing: 14.h,
//                           alignment: WrapAlignment.center,
//                           children: [
//                             if ((company.instagramUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 gradient: LinearGradient(
//                                   colors: [_brand['instagram1']!, _brand['instagram2']!],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.instagramUrl),
//                               ),
//                             if ((company.linkedinUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 color: _brand['linkedin'],
//                                 icon: const FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.linkedinUrl),
//                               ),
//                             if ((company.twitterUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 color: _brand['x'],
//                                 icon: const FaIcon(FontAwesomeIcons.xTwitter, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.twitterUrl),
//                               ),
//                             if ((company.facebookUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 color: _brand['facebook'],
//                                 icon: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.facebookUrl),
//                               ),
//                             if ((company.youtubeUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 color: _brand['youtube'],
//                                 icon: const FaIcon(FontAwesomeIcons.youtube, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.youtubeUrl),
//                               ),
//                             if ((company.tiktokUrl ?? '').isNotEmpty)
//                               _chipIcon(
//                                 color: _brand['tiktok'],
//                                 icon: const FaIcon(FontAwesomeIcons.tiktok, color: Colors.white, size: 22),
//                                 onTap: () => _launchUrl(company.tiktokUrl),
//                               ),

//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 16.h),

//                 /// website CTA (optional)
//                 if ((company.websiteUrl ?? '').isNotEmpty)
//                   SlideInUp(
//                     duration: const Duration(milliseconds: 500),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 52.h,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 10,
//                           backgroundColor: Colors.white.withOpacity(.18),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
//                           shadowColor: Colors.black26,
//                         ),
//                         onPressed: () => _launchUrl(company.websiteUrl),
//                         child: Text(
//                           'Visit Website',
//                           style: GoogleFonts.cairo(fontSize: 18.sp, fontWeight: FontWeight.w800, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eeei/models.dart';

class CompanyDetailsScreen extends StatelessWidget {
  final CompanyModel company;
  const CompanyDetailsScreen({super.key, required this.company});

  // ---------- launch helpers ----------
  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty || url == 'null') return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String? email) async {
    if (email == null || email.isEmpty || email == 'null') return;
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchPhone(String? phone) async {
    if (phone == null || phone.isEmpty || phone == 'null') return;
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchMap(String? address) async {
    if (address == null || address.isEmpty || address == 'null') return;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&z=19',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ---------- brand colors for social icons ----------
  static const _brandLinkedIn = Color(0xFF0A66C2);
  static const _brandFacebook = Color(0xFF1877F2);
  static const _brandYouTube = Color(0xFFFF0000);
  static const _brandWhatsApp = Color(0xFF25D366);
  static const _brandX = Color(0xFF000000);
  static const _chipBg = Colors.white12;

  // Welcome palette (أغمق شوية)
  static const Color kBlueDeep = Color(0xFF2F5ED7); // الأزرق الأوضح
  static const Color kOrangeSoft = Color(0xFFFF8A4C); // برتقالي هادي أغمق
  static const Color kVioletSoft = Color(0xFF6C5DD3); // بنفسجي أعمق
  static const Color kCtaOrange = Color(0xFFFF6B3D);
  static const Color kCtaBlue = Color(0xFF2F5ED7);

  // زر واضح

  Widget _chipIcon({
    required Widget icon,
    required VoidCallback onTap,
    Color? color,
    Gradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54.w,
        height: 54.w,
        decoration: BoxDecoration(
          color: color ?? _chipBg,
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: icon),
      ),
    );
  }

  Widget _rowAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.14), // أغمق شوية
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: Colors.white, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(.98),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo =
        (company.logoImageUrl != null &&
                company.logoImageUrl!.isNotEmpty &&
                company.logoImageUrl != 'null')
            ? 'assets/images/${company.logoImageUrl!}'
            : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: FadeInDown(
          duration: const Duration(milliseconds: 350),
          child: Text(
            'Company',
            style: GoogleFonts.cairo(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // ✅ خلفية أغمق لتحسين التباين
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kBlueDeep, kOrangeSoft, kVioletSoft],
                ),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                      child: Column(
                        children: [
                          // -------- بطاقة العنوان --------
                          FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                24.h,
                                20.w,
                                24.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(
                                      .22,
                                    ), // أغمق لرفع التباين
                                    Colors.white.withOpacity(.14),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(.18),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if (logo != null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: Image.asset(
                                        logo,
                                        height: 120.w,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (_, __, ___) => const Icon(
                                              Icons.apartment,
                                              color: Colors.white70,
                                              size: 40,
                                            ),
                                      ),
                                    )
                                  else
                                    const Icon(
                                      Icons.apartment,
                                      color: Colors.white70,
                                      size: 40,
                                    ),

                                  Text(
                                    company.name ?? 'Company Name',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.15,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  if ((company.description ?? '')
                                      .trim()
                                      .isNotEmpty)
                                    Text(
                                      company.description!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                        fontSize: 14.5.sp,
                                        color: Colors.white.withOpacity(.98),
                                        height: 1.35,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // -------- بطاقة البيانات ووسائل التواصل --------
                          FadeInUp(
                            duration: const Duration(milliseconds: 650),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                18.h,
                                20.w,
                                22.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(.22),
                                    Colors.white.withOpacity(.14),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(.18),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if ((company.address ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.location_on,
                                      label: company.address!,
                                      onTap: () => _launchMap(company.address),
                                    ),
                                  if ((company.secondAddress ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.location_on,
                                      label: company.secondAddress!,
                                      onTap:
                                          () =>
                                              _launchMap(company.secondAddress),
                                    ),
                                  if ((company.phone ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.call,
                                      label: company.phone!,
                                      onTap: () => _launchPhone(company.phone),
                                    ),
                                  if ((company.secondPhone ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.phone_android,
                                      label: company.secondPhone!,
                                      onTap:
                                          () =>
                                              _launchPhone(company.secondPhone),
                                    ),
                                  if ((company.email ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.email_outlined,
                                      label: company.email!,
                                      onTap: () => _launchEmail(company.email),
                                    ),
                                  if ((company.websiteUrl ?? '').isNotEmpty)
                                    _rowAction(
                                      icon: Icons.public,
                                      label:
                                          Uri.tryParse(
                                            company.websiteUrl!,
                                          )?.host ??
                                          company.websiteUrl!,
                                      onTap:
                                          () => _launchUrl(company.websiteUrl),
                                    ),

                                  SizedBox(height: 12.h),
                                  const Divider(
                                    color: Colors.white24,
                                    height: 1,
                                  ),
                                  SizedBox(height: 12.h),

                                  // سوشيال ميديا
                                  Wrap(
                                    spacing: 14.w,
                                    runSpacing: 14.h,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      if ((company.instagramUrl ?? '')
                                          .isNotEmpty)
                                        _chipIcon(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFFEDA77),
                                              Color(0xFFD62976),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          icon: const FaIcon(
                                            FontAwesomeIcons.instagram,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onTap:
                                              () => _launchUrl(
                                                company.instagramUrl,
                                              ),
                                        ),
                                      if ((company.linkedinUrl ?? '')
                                          .isNotEmpty)
                                        _chipIcon(
                                          color: _brandLinkedIn,
                                          icon: const FaIcon(
                                            FontAwesomeIcons.linkedinIn,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onTap:
                                              () => _launchUrl(
                                                company.linkedinUrl,
                                              ),
                                        ),
                                      if ((company.twitterUrl ?? '').isNotEmpty)
                                        _chipIcon(
                                          color: _brandX,
                                          icon: const FaIcon(
                                            FontAwesomeIcons.xTwitter,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onTap:
                                              () => _launchUrl(
                                                company.twitterUrl,
                                              ),
                                        ),
                                      if ((company.facebookUrl ?? '')
                                          .isNotEmpty)
                                        _chipIcon(
                                          color: _brandFacebook,
                                          icon: const FaIcon(
                                            FontAwesomeIcons.facebookF,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onTap:
                                              () => _launchUrl(
                                                company.facebookUrl,
                                              ),
                                        ),
                                      if ((company.youtubeUrl ?? '').isNotEmpty)
                                        _chipIcon(
                                          color: _brandYouTube,
                                          icon: const FaIcon(
                                            FontAwesomeIcons.youtube,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onTap:
                                              () => _launchUrl(
                                                company.youtubeUrl,
                                              ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          if ((company.websiteUrl ?? '').isNotEmpty)
                            SlideInUp(
                              duration: const Duration(milliseconds: 500),
                              child: SizedBox(
                                width: double.infinity,
                                height: 52.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: kCtaBlue, // زر أوضح
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26.r),
                                    ),
                                    shadowColor: Colors.black26,
                                  ),
                                  onPressed:
                                      () => _launchUrl(company.websiteUrl),
                                  child: Text(
                                    'Visit Website',
                                    style: GoogleFonts.cairo(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:eeei/CompaniesScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animate_do/animate_do.dart';

// class FieldsScreen extends StatelessWidget {
//   final String typeName;
//   final List<FieldModel> fields;

//   FieldsScreen({super.key, required this.typeName, required this.fields});

//   // قائمة الألوان الخاصة بالمجالات
//   final Map<String, Color> _fieldColors = const {
//     // TypeId = 1 (تمويل واستثمار)
//     'Business Angels': Color(0xFFD291BC),
//     'Crowd Funding': Color(0xFFF6D971),
//     'Credit Guarantees': Color(0xFFB5EAD7),
//     'Leasing': Color(0xFFF7CAC9),
//     'Venture Capital': Color(0xFFCCE4F5),
//     'Private Equity': Color(0xFF957DAD),
//     'Seed': Color(0xFFE0BBE4),
//     'Micro Finance': Color(0xFFF4A261),
//     'Preseed': Color(0xFFB5EAD7),
//     'Grants': Color(0xFFF4A261),

//     // TypeId = 2 (خدمات الأعمال والدعم)
//     'Training': Color(0xFFCCE4F5),
//     'Business Online': Color(0xFFD291BC),
//     'Marketing': Color(0xFFCCE4F5),
//     'Hiring': Color(0xFFF6D971),
//     'Mentoring': Color(0xFF957DAD),
//     'Women': Color(0xFFF7CAC9),
//     'NGOs': Color(0xFFF6D971),
//     'Incubators': Color(0xFFB5EAD7),
//     'Teach Advice': Color(0xFF957DAD),
//     'Information': Color(0xFFF7CAC9),
//     'Consulting': Color(0xFFE0BBE4),
//     'Valuation & Strategy': Color(0xFFD291BC),
//     'Accounting': Color(0xFFF4A261),
//     'Legal': Color(0xFFF7CAC9),
//     'Research': Color(0xFFE0BBE4),
//     'Special Abilities': Color(0xFFF4A261),
//     'Green Business': Color(0xFFCCE4F5),
//     'Policy': Color(0xFFD291BC),

//     // TypeId = 3 (مساحات وأنشطة)
//     'Coworking / Maker Spaces': Color(0xFFCCE4F5),
//     'Events': Color(0xFFD291BC),
//     'Competitions': Color(0xFF957DAD),
//     'Media': Color(0xFFF4A261),
//     'Platforms': Color(0xFFF6D971),

//     // TypeId = 4 (تعليم وابتكار)
//     'Education': Color(0xFFF7CAC9),
//     'Innovation': Color(0xFFB5EAD7),
//     'Culture': Color(0xFFE0BBE4),
//     'Donors': Color(0xFFF7CAC9),

//     // TypeId = 5 (بحث وتكنولوجيا)
//     'IP, TTO & KTOs': Color(0xFFF7CAC9),
//     'R&D': Color(0xFFE0BBE4),
//     'Export': Color(0xFFD291BC),
//     'Science and Technology Parks': Color(0xFFB5EAD7),
//   };

//   // ⭐️ قائمة الأيقونات المحدثة لجميع المجالات ⭐️
//   final Map<String, IconData> _fieldIcons = const {
//     // TypeId = 1 (تمويل واستثمار)
//     'Business Angels': FontAwesomeIcons.angellist,
//     'Crowd Funding': FontAwesomeIcons.handHoldingDollar,
//     'Credit Guarantees': FontAwesomeIcons.fileSignature,
//     'Leasing': FontAwesomeIcons.fileInvoiceDollar,
//     'Venture Capital': FontAwesomeIcons.chartLine,
//     'Private Equity': FontAwesomeIcons.piggyBank,
//     'Seed': FontAwesomeIcons.seedling,
//     'Micro Finance': FontAwesomeIcons.coins,
//     'Preseed': FontAwesomeIcons.seedling,
//     'Grants': FontAwesomeIcons.award,

//     // TypeId = 2 (خدمات الأعمال والدعم)
//     'Training': FontAwesomeIcons.personChalkboard,
//     'Business Online': FontAwesomeIcons.laptop,
//     'Marketing': FontAwesomeIcons.bullhorn,
//     'Hiring': FontAwesomeIcons.userPlus,
//     'Mentoring': FontAwesomeIcons.handsHoldingChild,
//     'Women': FontAwesomeIcons.personDress,
//     'NGOs': FontAwesomeIcons.handshakeAngle,
//     'Incubators': FontAwesomeIcons.seedling,
//     'Teach Advice': FontAwesomeIcons.comments,
//     'Information': FontAwesomeIcons.infoCircle,
//     'Consulting': FontAwesomeIcons.commentsDollar,
//     'Valuation & Strategy': FontAwesomeIcons.chartPie,
//     'Accounting': FontAwesomeIcons.calculator,
//     'Legal': FontAwesomeIcons.scaleBalanced,
//     'Research': FontAwesomeIcons.flask,
//     'Special Abilities': FontAwesomeIcons.wheelchair,
//     'Green Business': FontAwesomeIcons.leaf,
//     'Policy': FontAwesomeIcons.gavel,

//     // TypeId = 3 (مساحات وأنشطة)
//     'Coworking / Maker Spaces': FontAwesomeIcons.peopleGroup,
//     'Events': FontAwesomeIcons.calendarDay,
//     'Competitions': FontAwesomeIcons.trophy,
//     'Media': FontAwesomeIcons.playCircle,
//     'Platforms': FontAwesomeIcons.laptopCode,

//     // TypeId = 4 (تعليم وابتكار)
//     'Education': FontAwesomeIcons.graduationCap,
//     'Innovation': FontAwesomeIcons.lightbulb,
//     'Culture': FontAwesomeIcons.mask,
//     'Donors': FontAwesomeIcons.heart,

//     // TypeId = 5 (بحث وتكنولوجيا)
//     'IP, TTO & KTOs': FontAwesomeIcons.fileContract,
//     'R&D': FontAwesomeIcons.flask,
//     'Export': FontAwesomeIcons.boxesPacking,
//     'Science and Technology Parks': FontAwesomeIcons.robot,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E2E3E),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E2E3E),
//         elevation: 0,
//         toolbarHeight: 80.h,
//         title: Text(
//           typeName,
//           style: GoogleFonts.poppins(
//             fontSize: 24.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: false,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF2E2E3E), Color(0xFF3C3C56)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body:
//           fields.isEmpty
//               ? Center(
//                 child: Text(
//                   'No fields available.',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white70,
//                     fontSize: 18.sp,
//                   ),
//                 ),
//               )
//               : Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                 child: ListView.builder(
//                   itemCount: fields.length,
//                   itemBuilder: (context, index) {
//                     final field = fields[index];
//                     final fieldColor =
//                         _fieldColors[field.name] ?? const Color(0xFF7A7A8A);
//                     final fieldIcon =
//                         _fieldIcons[field.name] ?? FontAwesomeIcons.layerGroup;

//                     return FadeInUp(
//                       duration: Duration(milliseconds: 200 + index * 100),
//                       child: SlideInLeft(
//                         duration: Duration(milliseconds: 200 + index * 100),
//                         child: FieldCard(
//                           field: field,
//                           fieldColor: fieldColor,
//                           fieldIcon: fieldIcon,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//     );
//   }
// }

// class FieldCard extends StatelessWidget {
//   final FieldModel field;
//   final Color fieldColor;
//   final IconData fieldIcon;

//   const FieldCard({
//     super.key,
//     required this.field,
//     required this.fieldColor,
//     required this.fieldIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120.h,
//       margin: EdgeInsets.only(bottom: 16.h),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             if (field.companies != null && field.companies!.isNotEmpty) {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder:
//                       (context) => CompaniesScreen(
//                         fieldName: field.name,
//                         companies: field.companies!,
//                       ),
//                 ),
//               );
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('No companies available for this field.'),
//                 ),
//               );
//             }
//           },
//           borderRadius: BorderRadius.circular(20.r),
//           child: Ink(
//             decoration: BoxDecoration(
//               color: const Color(0xFF3C3C56),
//               borderRadius: BorderRadius.circular(20.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 70.w,
//                     height: 70.h,
//                     decoration: BoxDecoration(
//                       color: fieldColor.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(15.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: fieldColor.withOpacity(0.5),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Icon(fieldIcon, size: 35.sp, color: Colors.white),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           field.name,
//                           style: GoogleFonts.poppins(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'View Companies',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14.sp,
//                             color: Colors.grey[400],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     color: Colors.white54,
//                     size: 20,
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

// import 'package:eeei/CompaniesScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'package:animations/animations.dart';

// class FieldsScreen extends StatefulWidget {
//   final String typeName;
//   final List<FieldModel> fields;

//   const FieldsScreen({super.key, required this.typeName, required this.fields});

//   @override
//   State<FieldsScreen> createState() => _FieldsScreenState();
// }

// class _FieldsScreenState extends State<FieldsScreen> {
//   // ألوان/خطوط مطابقه للـ HomePage/TypesScreen
//   static const Color pageBg = Color(0xFFF1F6FB);
//   static const Color cardBg = Colors.white;
//   static const Color primaryText = Colors.black87;
//   static const Color secondaryText = Color(0xFF616161);

//   late List<FieldModel> _allFields;
//   late List<FieldModel> _visibleFields;

//   final TextEditingController _searchController = TextEditingController();

//   final Map<String, Color> _fieldColors = const {
//     // TypeId = 1 (تمويل واستثمار)
//     'Business Angels': Color(0xFFD291BC),
//     'Crowd Funding': Color(0xFFF6D971),
//     'Credit Guarantees': Color(0xFFB5EAD7),
//     'Leasing': Color(0xFFF7CAC9),
//     'Venture Capital': Color(0xFFCCE4F5),
//     'Private Equity': Color(0xFF957DAD),
//     'Seed': Color(0xFFE0BBE4),
//     'Micro Finance': Color(0xFFF4A261),
//     'Preseed': Color(0xFFB5EAD7),
//     'Grants': Color(0xFFF4A261),

//     // TypeId = 2 (خدمات الأعمال والدعم)
//     'Training': Color(0xFFCCE4F5),
//     'Business Online': Color(0xFFD291BC),
//     'Marketing': Color(0xFFCCE4F5),
//     'Hiring': Color(0xFFF6D971),
//     'Mentoring': Color(0xFF957DAD),
//     'Women': Color(0xFFF7CAC9),
//     'NGOs': Color(0xFFF6D971),
//     'Incubators': Color(0xFFB5EAD7),
//     'Teach Advice': Color(0xFF957DAD),
//     'Information': Color(0xFFF7CAC9),
//     'Consulting': Color(0xFFE0BBE4),
//     'Valuation & Strategy': Color(0xFFD291BC),
//     'Accounting': Color(0xFFF4A261),
//     'Legal': Color(0xFFF7CAC9),
//     'Research': Color(0xFFE0BBE4),
//     'Special Abilities': Color(0xFFF4A261),
//     'Green Business': Color(0xFFCCE4F5),
//     'Policy': Color(0xFFD291BC),

//     // TypeId = 3 (مساحات وأنشطة)
//     'Coworking / Maker Spaces': Color(0xFFCCE4F5),
//     'Events': Color(0xFFD291BC),
//     'Competitions': Color(0xFF957DAD),
//     'Media': Color(0xFFF4A261),
//     'Platforms': Color(0xFFF6D971),

//     // TypeId = 4 (تعليم وابتكار)
//     'Education': Color(0xFFF7CAC9),
//     'Innovation': Color(0xFFB5EAD7),
//     'Culture': Color(0xFFE0BBE4),
//     'Donors': Color(0xFFF7CAC9),

//     // TypeId = 5 (بحث وتكنولوجيا)
//     'IP, TTO & KTOs': Color(0xFFF7CAC9),
//     'R&D': Color(0xFFE0BBE4),
//     'Export': Color(0xFFD291BC),
//     'Science and Technology Parks': Color(0xFFB5EAD7),
//   };

//   final Map<String, IconData> _fieldIcons = const {
//     // TypeId = 1 (تمويل واستثمار)
//     'Business Angels': FontAwesomeIcons.angellist,
//     'Crowd Funding': FontAwesomeIcons.handHoldingDollar,
//     'Credit Guarantees': FontAwesomeIcons.fileSignature,
//     'Leasing': FontAwesomeIcons.fileInvoiceDollar,
//     'Venture Capital': FontAwesomeIcons.chartLine,
//     'Private Equity': FontAwesomeIcons.piggyBank,
//     'Seed': FontAwesomeIcons.seedling,
//     'Micro Finance': FontAwesomeIcons.coins,
//     'Preseed': FontAwesomeIcons.seedling,
//     'Grants': FontAwesomeIcons.award,

//     // TypeId = 2 (خدمات الأعمال والدعم)
//     'Training': FontAwesomeIcons.personChalkboard,
//     'Business Online': FontAwesomeIcons.laptop,
//     'Marketing': FontAwesomeIcons.bullhorn,
//     'Hiring': FontAwesomeIcons.userPlus,
//     'Mentoring': FontAwesomeIcons.handsHoldingChild,
//     'Women': FontAwesomeIcons.personDress,
//     'NGOs': FontAwesomeIcons.handshakeAngle,
//     'Incubators': FontAwesomeIcons.seedling,
//     'Teach Advice': FontAwesomeIcons.comments,
//     'Information': FontAwesomeIcons.infoCircle,
//     'Consulting': FontAwesomeIcons.commentsDollar,
//     'Valuation & Strategy': FontAwesomeIcons.chartPie,
//     'Accounting': FontAwesomeIcons.calculator,
//     'Legal': FontAwesomeIcons.scaleBalanced,
//     'Research': FontAwesomeIcons.flask,
//     'Special Abilities': FontAwesomeIcons.wheelchair,
//     'Green Business': FontAwesomeIcons.leaf,
//     'Policy': FontAwesomeIcons.gavel,

//     // TypeId = 3 (مساحات وأنشطة)
//     'Coworking / Maker Spaces': FontAwesomeIcons.peopleGroup,
//     'Events': FontAwesomeIcons.calendarDay,
//     'Competitions': FontAwesomeIcons.trophy,
//     'Media': FontAwesomeIcons.playCircle,
//     'Platforms': FontAwesomeIcons.laptopCode,

//     // TypeId = 4 (تعليم وابتكار)
//     'Education': FontAwesomeIcons.graduationCap,
//     'Innovation': FontAwesomeIcons.lightbulb,
//     'Culture': FontAwesomeIcons.mask,
//     'Donors': FontAwesomeIcons.heart,

//     // TypeId = 5 (بحث وتكنولوجيا)
//     'IP, TTO & KTOs': FontAwesomeIcons.fileContract,
//     'R&D': FontAwesomeIcons.flask,
//     'Export': FontAwesomeIcons.boxesPacking,
//     'Science and Technology Parks': FontAwesomeIcons.robot,
//   };

//   @override
//   void initState() {
//     super.initState();
//     _allFields = List<FieldModel>.from(widget.fields);
//     _visibleFields = List<FieldModel>.from(widget.fields);
//     _searchController.addListener(_onSearch);
//   }

//   void _onSearch() {
//     final q = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _visibleFields = q.isEmpty
//           ? _allFields
//           : _allFields.where((f) => f.name.toLowerCase().contains(q)).toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearch);
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: pageBg,
//       appBar: AppBar(
//         backgroundColor: pageBg,
//         elevation: 0,
//         centerTitle: false,
//         title: Text(
//           widget.typeName,
//           style: GoogleFonts.cairo(
//             fontSize: 24.sp,
//             fontWeight: FontWeight.bold,
//             color: primaryText,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//         child: Column(
//           children: [
//             // 🔎 سيرش بسيط (بدون أنيميشن ثقيل)
//             TextField(
//               controller: _searchController,
//               style: GoogleFonts.cairo(color: primaryText, fontSize: 16.sp),
//               decoration: InputDecoration(
//                 hintText: 'Search fields...',
//                 hintStyle: GoogleFonts.cairo(color: Colors.grey),
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.r),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//               ),
//             ),
//             SizedBox(height: 10.h),

//             // القائمة
//             Expanded(
//               child: _visibleFields.isEmpty
//                   ? Center(
//                       child: Text(
//                         'No fields available.',
//                         style: GoogleFonts.cairo(
//                           color: Colors.grey,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: _visibleFields.length,
//                       itemBuilder: (context, index) {
//                         final field = _visibleFields[index];
//                         final fieldColor =
//                             _fieldColors[field.name] ?? const Color(0xFF7A7A8A);
//                         final fieldIcon =
//                             _fieldIcons[field.name] ?? FontAwesomeIcons.layerGroup;

//                         // ✅ أنيميشن خفيفة جدًا زي TypesScreen: OpenContainer فقط
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 12.h),
//                           child: OpenContainer(
//                             openColor: cardBg,
//                             closedColor: cardBg,
//                             closedElevation: 4,
//                             closedShape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.r),
//                             ),
//                             transitionType: ContainerTransitionType.fadeThrough,
//                             transitionDuration: const Duration(milliseconds: 250),
//                             openBuilder: (context, action) {
//                               if (field.companies != null && field.companies!.isNotEmpty) {
//                                 return CompaniesScreen(
//                                   fieldName: field.name,
//                                   companies: field.companies!,
//                                 );
//                               }
//                               return const SizedBox.shrink();
//                             },
//                             closedBuilder: (context, action) {
//                               return Card(
//                                 color: cardBg,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                 ),
//                                 margin: EdgeInsets.zero,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                   onTap: () {
//                                     if (field.companies != null && field.companies!.isNotEmpty) {
//                                       action(); // يستخدم انتقال OpenContainer الخفيف
//                                     } else {
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         const SnackBar(
//                                           content: Text('No companies available for this field.'),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.w),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 60.w,
//                                           height: 60.w,
//                                           decoration: BoxDecoration(
//                                             color: fieldColor.withOpacity(0.18),
//                                             borderRadius: BorderRadius.circular(10.r),
//                                           ),
//                                           child: Icon(fieldIcon, size: 28.sp, color: fieldColor),
//                                         ),
//                                         SizedBox(width: 15.w),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 field.name,
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.cairo(
//                                                   fontSize: 18.sp,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: primaryText,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 5.h),
//                                               Text(
//                                                 'View Companies',
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.cairo(
//                                                   fontSize: 14.sp,
//                                                   color: secondaryText,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eeei/CompaniesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eeei/models.dart';
import 'package:animations/animations.dart';

class FieldsScreen extends StatefulWidget {
  final String typeName;
  final List<FieldModel> fields;

  const FieldsScreen({super.key, required this.typeName, required this.fields});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  // نفس ألوان الجريدينت المستخدمة في الصفحات الأخرى
  static const Color kBlueDeep = Color(0xFF2F5ED7);
  static const Color kOrangeSoft = Color(0xFFFF8A4C);
  static const Color kVioletSoft = Color(0xFF6C5DD3);

  static const Color cardBg = Colors.white;
  static const Color primaryText = Colors.black87;
  static const Color secondaryText = Color(0xFF616161);

  late List<FieldModel> _allFields;
  late List<FieldModel> _visibleFields;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, Color> _fieldColors = const {
    // TypeId = 1 (تمويل واستثمار)
    'Business Angels': Color(0xFFD291BC),
    'Crowd Funding': Color(0xFFF6D971),
    'Credit Guarantees': Color(0xFFB5EAD7),
    'Leasing': Color(0xFFF7CAC9),
    'Venture Capital': Color(0xFFCCE4F5),
    'Private Equity': Color(0xFF957DAD),
    'Seed': Color(0xFFE0BBE4),
    'Micro Finance': Color(0xFFF4A261),
    'Preseed': Color(0xFFB5EAD7),
    'Grants': Color(0xFFF4A261),

    // TypeId = 2 (خدمات الأعمال والدعم)
    'Training': Color(0xFFCCE4F5),
    'Business Online': Color(0xFFD291BC),
    'Marketing': Color(0xFFCCE4F5),
    'Hiring': Color(0xFFF6D971),
    'Mentoring': Color(0xFF957DAD),
    'Women': Color(0xFFF7CAC9),
    'NGOs': Color(0xFFF6D971),
    'Incubators': Color(0xFFB5EAD7),
    'Teach Advice': Color(0xFF957DAD),
    'Information': Color(0xFFF7CAC9),
    'Consulting': Color(0xFFE0BBE4),
    'Valuation & Strategy': Color(0xFFD291BC),
    'Accounting': Color(0xFFF4A261),
    'Legal': Color(0xFFF7CAC9),
    'Research': Color(0xFFE0BBE4),
    'Special Abilities': Color(0xFFF4A261),
    'Green Business': Color(0xFFCCE4F5),
    'Policy': Color(0xFFD291BC),

    // TypeId = 3 (مساحات وأنشطة)
    'Coworking / Maker Spaces': Color(0xFFCCE4F5),
    'Events': Color(0xFFD291BC),
    'Competitions': Color(0xFF957DAD),
    'Media': Color(0xFFF4A261),
    'Platforms': Color(0xFFF6D971),

    // TypeId = 4 (تعليم وابتكار)
    'Education': Color(0xFFF7CAC9),
    'Innovation': Color(0xFFB5EAD7),
    'Culture': Color(0xFFE0BBE4),
    'Donors': Color(0xFFF7CAC9),

    // TypeId = 5 (بحث وتكنولوجيا)
    'IP, TTO & KTOs': Color(0xFFF7CAC9),
    'R&D': Color(0xFFE0BBE4),
    'Export': Color(0xFFD291BC),
    'Science and Technology Parks': Color(0xFFB5EAD7),
  };

  final Map<String, IconData> _fieldIcons = const {
    'Business Angels': FontAwesomeIcons.angellist,
    'Crowd Funding': FontAwesomeIcons.handHoldingDollar,
    'Credit Guarantees': FontAwesomeIcons.fileSignature,
    'Leasing': FontAwesomeIcons.fileInvoiceDollar,
    'Venture Capital': FontAwesomeIcons.chartLine,
    'Private Equity': FontAwesomeIcons.piggyBank,
    'Seed': FontAwesomeIcons.seedling,
    'Micro Finance': FontAwesomeIcons.coins,
    'Preseed': FontAwesomeIcons.seedling,
    'Grants': FontAwesomeIcons.award,
    'Training': FontAwesomeIcons.personChalkboard,
    'Business Online': FontAwesomeIcons.laptop,
    'Marketing': FontAwesomeIcons.bullhorn,
    'Hiring': FontAwesomeIcons.userPlus,
    'Mentoring': FontAwesomeIcons.handsHoldingChild,
    'Women': FontAwesomeIcons.personDress,
    'NGOs': FontAwesomeIcons.handshakeAngle,
    'Incubators': FontAwesomeIcons.seedling,
    'Teach Advice': FontAwesomeIcons.comments,
    'Information': FontAwesomeIcons.infoCircle,
    'Consulting': FontAwesomeIcons.commentsDollar,
    'Valuation & Strategy': FontAwesomeIcons.chartPie,
    'Accounting': FontAwesomeIcons.calculator,
    'Legal': FontAwesomeIcons.scaleBalanced,
    'Research': FontAwesomeIcons.flask,
    'Special Abilities': FontAwesomeIcons.wheelchair,
    'Green Business': FontAwesomeIcons.leaf,
    'Policy': FontAwesomeIcons.gavel,
    'Coworking / Maker Spaces': FontAwesomeIcons.peopleGroup,
    'Events': FontAwesomeIcons.calendarDay,
    'Competitions': FontAwesomeIcons.trophy,
    'Media': FontAwesomeIcons.playCircle,
    'Platforms': FontAwesomeIcons.laptopCode,
    'Education': FontAwesomeIcons.graduationCap,
    'Innovation': FontAwesomeIcons.lightbulb,
    'Culture': FontAwesomeIcons.mask,
    'Donors': FontAwesomeIcons.heart,
    'IP, TTO & KTOs': FontAwesomeIcons.fileContract,
    'R&D': FontAwesomeIcons.flask,
    'Export': FontAwesomeIcons.boxesPacking,
    'Science and Technology Parks': FontAwesomeIcons.robot,
  };

  @override
  void initState() {
    super.initState();
    _allFields = List<FieldModel>.from(widget.fields);
    _visibleFields = List<FieldModel>.from(widget.fields);
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchController.text.trim().toLowerCase();
    setState(() {
      _visibleFields =
          q.isEmpty
              ? _allFields
              : _allFields
                  .where((f) => f.name.toLowerCase().contains(q))
                  .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          widget.typeName,
          style: GoogleFonts.cairo(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🌈 خلفية الجريدينت الدائمة
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  // 🔎 سيرش بسيط مع خلفية شبه شفافة
                  TextField(
                    controller: _searchController,
                    style: GoogleFonts.cairo(
                      color: Colors.black87,
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search fields...',
                      hintStyle: GoogleFonts.cairo(color: Colors.black54),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.92),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // القائمة
                  Expanded(
                    child:
                        _visibleFields.isEmpty
                            ? Center(
                              child: Text(
                                'No fields available.',
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: _visibleFields.length,
                              itemBuilder: (context, index) {
                                final field = _visibleFields[index];
                                final fieldColor =
                                    _fieldColors[field.name] ??
                                    const Color(0xFF7A7A8A);
                                final fieldIcon =
                                    _fieldIcons[field.name] ??
                                    FontAwesomeIcons.layerGroup;

                                // انتقال خفيف OpenContainer فقط
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: OpenContainer(
                                    openColor: cardBg,
                                    closedColor: cardBg,
                                    closedElevation: 4,
                                    closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    transitionType:
                                        ContainerTransitionType.fadeThrough,
                                    transitionDuration: const Duration(
                                      milliseconds: 250,
                                    ),
                                    openBuilder: (context, action) {
                                      if (field.companies != null &&
                                          field.companies!.isNotEmpty) {
                                        return CompaniesScreen(
                                          fieldName: field.name,
                                          companies: field.companies!,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                    closedBuilder: (context, action) {
                                      return Card(
                                        color: cardBg,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                        ),
                                        margin: EdgeInsets.zero,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                          onTap: () {
                                            if (field.companies != null &&
                                                field.companies!.isNotEmpty) {
                                              action();
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'No companies available for this field.',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(12.w),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 60.w,
                                                  height: 60.w,
                                                  decoration: BoxDecoration(
                                                    color: fieldColor
                                                        .withOpacity(0.18),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    fieldIcon,
                                                    size: 28.sp,
                                                    color: fieldColor,
                                                  ),
                                                ),
                                                SizedBox(width: 15.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        field.name,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style:
                                                            GoogleFonts.cairo(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  primaryText,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        'View Companies',
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style:
                                                            GoogleFonts.cairo(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  secondaryText,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

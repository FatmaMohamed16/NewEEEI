// import 'package:eeei/Services/local_data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'FieldsScreen.dart'; // أضفنا استدعاء لصفحة المجالات
// import 'package:animations/animations.dart'; // استدعاء حزمة الأنيميشن

// class TypesScreen extends StatefulWidget {
//   const TypesScreen({super.key});

//   @override
//   State<TypesScreen> createState() => _TypesScreenState();
// }

// class _TypesScreenState extends State<TypesScreen> {
//   List<TypeModel> _allTypes = [];
//   bool _isLoading = true;
//   final TextEditingController _searchController = TextEditingController();

//   final Map<String, Color> _typeColors = {
//     'Talent': const Color(0xFFE0BBE4), // لون بنفسجي فاتح
//     'Networking': const Color(0xFF957DAD), // لون بنفسجي متوسط
//     'Growth': const Color(0xFFD291BC), // لون وردي بنفسجي
//     'Support': const Color(0xFFB5EAD7), // لون أخضر مائي فاتح
//     'Funding': const Color(0xFFF7CAC9), // لون وردي خوخي
//   };

//   final Map<String, IconData> _typeIcons = {
//     'Talent': FontAwesomeIcons.lightbulb,
//     'Networking': FontAwesomeIcons.users,
//     'Growth': FontAwesomeIcons.chartLine,
//     'Support': FontAwesomeIcons.headset,
//     'Funding': FontAwesomeIcons.moneyBillWave,
//   };

//   @override
//   void initState() {
//     super.initState();
//     _loadAllData();
//   }

//   Future<void> _loadAllData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final List<TypeModel> types = await LocalDataService.loadAllData();
//       setState(() {
//         _allTypes = types;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error loading data: $e");
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to load categories: $e')));
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E2E3E), // خلفية داكنة للـ Scaffold
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E2E3E), // نفس لون الخلفية للأب بار
//         elevation: 0, // لا يوجد ظل للأب بار
//         toolbarHeight: 80.h, // ارتفاع الأب بار
//         title: Text(
//           'Company Categories',
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
//               colors: [
//                 Color(0xFF2E2E3E), // لون بداية التدرج
//                 Color(0xFF3C3C56), // لون نهاية التدرج
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body:
//           _isLoading
//               ? const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               )
//               : Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                 child: ListView.builder(
//                   itemCount: _allTypes.length,
//                   itemBuilder: (context, index) {
//                     final type = _allTypes[index];
//                     final typeColor =
//                         _typeColors[type.name] ?? const Color(0xFF7A7A8A);
//                     final typeIcon =
//                         _typeIcons[type.name] ?? FontAwesomeIcons.layerGroup;

//                     // استخدام OpenContainer لإنيميشن الانتقال
//                     return OpenContainer(
//                       transitionDuration: const Duration(milliseconds: 200),
//                       closedElevation: 0,
//                       openElevation: 0,
//                       closedColor: Colors.transparent,
//                       openColor: const Color(0xFF2E2E3E),
//                       tappable: false, // نجعل الكارد نفسه هو التاببل
//                       closedBuilder: (context, action) {
//                         return TypeCard(
//                           type: type,
//                           typeColor: typeColor,
//                           typeIcon: typeIcon,
//                           onTap: action, // تمرير الـ action للـ InkWell
//                         );
//                       },
//                       openBuilder: (context, action) {
//                         if (type.fields != null && type.fields!.isNotEmpty) {
//                           return FieldsScreen(
//                             typeName: type.name,
//                             fields: type.fields!,
//                           );
//                         } else {
//                           // إظهار رسالة إذا لم تكن هناك مجالات ثم العودة
//                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'No fields available for this category.',
//                                 ),
//                               ),
//                             );
//                             Navigator.of(context).pop(); // نرجع للصفحة السابقة
//                           });
//                           return Container(); // نرجع حاوية فارغة بشكل مؤقت
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//     );
//   }
// }

// // Widget منفصل للكارد لتنظيم الكود
// class TypeCard extends StatelessWidget {
//   final TypeModel type;
//   final Color typeColor;
//   final IconData typeIcon;
//   final VoidCallback onTap;

//   const TypeCard({
//     super.key,
//     required this.type,
//     required this.typeColor,
//     required this.typeIcon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120.h, // ارتفاع الكارد زاد
//       margin: EdgeInsets.only(bottom: 16.h),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20.r), // زوايا دائرية أكثر
//           child: Ink(
//             decoration: BoxDecoration(
//               color: const Color(0xFF3C3C56), // لون خلفية الكارد أغمق
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
//                   // الأيقونة والخلفية الملونة
//                   Container(
//                     width: 70.w,
//                     height: 70.h,
//                     decoration: BoxDecoration(
//                       color: typeColor.withOpacity(0.9), // لون قوي للأيقونة
//                       borderRadius: BorderRadius.circular(
//                         15.r,
//                       ), // زوايا دائرية للمربع
//                       boxShadow: [
//                         BoxShadow(
//                           color: typeColor.withOpacity(0.5),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Icon(typeIcon, size: 35.sp, color: Colors.white),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           type.name,
//                           style: GoogleFonts.poppins(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white, // لون أبيض لاسم النوع
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'Read more',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14.sp,
//                             color: Colors.grey[400], // لون رمادي فاتح
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

// TypesScreen.dart
// import 'package:eeei/Services/local_data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:eeei/models.dart';
// import 'FieldsScreen.dart';
// import 'package:animations/animations.dart';

// class TypesScreen extends StatefulWidget {
//   const TypesScreen({super.key, this.onBackToHome});

//   final VoidCallback? onBackToHome; // 👈 callback جاية من MainScreen

//   @override
//   State<TypesScreen> createState() => _TypesScreenState();
// }

// class _TypesScreenState extends State<TypesScreen> {
//   static const Color backgroundColor = Color(0xFFF1F6FB);
//   static const Color cardColor = Colors.white;
//   static const Color primaryText = Colors.black87;
//   static const Color secondaryText = Color(0xFF616161);

//   List<TypeModel> _allTypes = [];
//   List<TypeModel> _visibleTypes = [];
//   bool _isLoading = true;
//   final TextEditingController _searchController = TextEditingController();

//   final Map<String, Color> _typeColors = {
//     'Talent': const Color(0xFFE0BBE4),
//     'Networking': const Color(0xFF957DAD),
//     'Growth': const Color(0xFFD291BC),
//     'Support': const Color(0xFFB5EAD7),
//     'Funding': const Color(0xFFF7CAC9),
//   };

//   final Map<String, IconData> _typeIcons = {
//     'Talent': FontAwesomeIcons.lightbulb,
//     'Networking': FontAwesomeIcons.solidHandshake,
//     'Growth': FontAwesomeIcons.chartLine,
//     'Support': FontAwesomeIcons.solidLifeRing,
//     'Funding': FontAwesomeIcons.dollarSign,
//   };

//   @override
//   void initState() {
//     super.initState();
//     _loadTypes();
//     _searchController.addListener(_filterTypes);
//   }

//   Future<void> _loadTypes() async {
//     setState(() => _isLoading = true);
//     try {
//       final types = await LocalDataService.loadAllData();
//       setState(() {
//         _allTypes = types;
//         _visibleTypes = types;
//       });
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _filterTypes() {
//     final q = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _visibleTypes =
//           q.isEmpty
//               ? _allTypes
//               : _allTypes
//                   .where((t) => t.name.toLowerCase().contains(q))
//                   .toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_filterTypes);
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         // 👇 نعرض السهم دايمًا، ولو مفيش pop نرجّع للهوم عبر callback
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryText),
//           onPressed: () async {
//             if (Navigator.canPop(context)) {
//               Navigator.maybePop(context);
//             } else {
//               widget.onBackToHome?.call(); // ارجع للهوم داخل الـPageView
//             }
//           },
//         ),
//         centerTitle: false,
//         title: Text(
//           'Categories',
//           style: GoogleFonts.cairo(
//             fontSize: 24.sp,
//             fontWeight: FontWeight.bold,
//             color: primaryText,
//           ),
//         ),
//       ),
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 16.w,
//                       vertical: 8.h,
//                     ),
//                     child: TextField(
//                       controller: _searchController,
//                       style: GoogleFonts.cairo(
//                         color: primaryText,
//                         fontSize: 16.sp,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: 'Search categories...',
//                         hintStyle: GoogleFonts.cairo(color: Colors.grey),
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.r),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16.w,
//                         vertical: 8.h,
//                       ),
//                       itemCount: _visibleTypes.length,
//                       itemBuilder: (context, index) {
//                         final type = _visibleTypes[index];
//                         final typeIcon =
//                             _typeIcons[type.name] ?? Icons.category;
//                         final typeColor = _typeColors[type.name] ?? Colors.grey;

//                         final companyCount =
//                             type.fields?.fold<int>(
//                               0,
//                               (sum, f) => sum + (f.companies?.length ?? 0),
//                             ) ??
//                             0;

//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 12.h),
//                           child: OpenContainer(
//                             openColor: cardColor,
//                             closedColor: cardColor,
//                             closedElevation: 4,
//                             closedShape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.r),
//                             ),
//                             transitionDuration: const Duration(
//                               milliseconds: 450,
//                             ),
//                             transitionType: ContainerTransitionType.fadeThrough,
//                             openBuilder: (context, action) {
//                               if (type.fields != null &&
//                                   type.fields!.isNotEmpty) {
//                                 return FieldsScreen(
//                                   typeName: type.name,
//                                   fields: type.fields!,
//                                 );
//                               }
//                               return const SizedBox.shrink();
//                             },
//                             closedBuilder: (context, action) {
//                               return Card(
//                                 color: cardColor,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                 ),
//                                 margin: EdgeInsets.zero,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                   onTap: action,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.w),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 60.w,
//                                           height: 60.w,
//                                           decoration: BoxDecoration(
//                                             color: typeColor.withOpacity(0.18),
//                                             borderRadius: BorderRadius.circular(
//                                               10.r,
//                                             ),
//                                           ),
//                                           child: Icon(
//                                             typeIcon,
//                                             size: 28.sp,
//                                             color: typeColor,
//                                           ),
//                                         ),
//                                         SizedBox(width: 15.w),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 type.name,
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
//                                                 '$companyCount Companies',
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
//                                         const Icon(
//                                           Icons.arrow_forward_ios,
//                                           color: Colors.grey,
//                                         ),
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
//                   ),
//                 ],
//               ),
//     );
//   }
// }











import 'package:eeei/Services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eeei/models.dart';
import 'FieldsScreen.dart';
import 'package:animations/animations.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key, this.onBackToHome});
  final VoidCallback? onBackToHome;

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  // لوحة ألوان متسقة مع Welcome/CompanyDetails
  static const Color kBlueDeep   = Color(0xFF2F5ED7);
  static const Color kOrangeSoft = Color(0xFFFF8A4C);
  static const Color kVioletSoft = Color(0xFF6C5DD3);

  static const Color cardColor = Colors.white;
  static const Color primaryTextOnCard = Colors.black87;
  static const Color secondaryTextOnCard = Color(0xFF616161);

  List<TypeModel> _allTypes = [];
  List<TypeModel> _visibleTypes = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, Color> _typeColors = const {
    'Talent': Color(0xFFE0BBE4),
    'Networking': Color(0xFF957DAD),
    'Growth': Color(0xFFD291BC),
    'Support': Color(0xFFB5EAD7),
    'Funding': Color(0xFFF7CAC9),
  };

  final Map<String, IconData> _typeIcons = const {
    'Talent': FontAwesomeIcons.lightbulb,
    'Networking': FontAwesomeIcons.solidHandshake,
    'Growth': FontAwesomeIcons.chartLine,
    'Support': FontAwesomeIcons.solidLifeRing,
    'Funding': FontAwesomeIcons.dollarSign,
  };

  @override
  void initState() {
    super.initState();
    _loadTypes();
    _searchController.addListener(_filterTypes);
  }

  Future<void> _loadTypes() async {
    setState(() => _isLoading = true);
    try {
      final types = await LocalDataService.loadAllData();
      setState(() {
        _allTypes = types;
        _visibleTypes = types;
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _filterTypes() {
    final q = _searchController.text.trim().toLowerCase();
    setState(() {
      _visibleTypes = q.isEmpty
          ? _allTypes
          : _allTypes.where((t) => t.name.toLowerCase().contains(q)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterTypes);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // نخلي الجسم يمتد تحت الـAppBar عشان الجريدينت يبان
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // سهم الرجوع: لو مفيش pop نرجّع للهوم عن طريق callback
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.maybePop(context);
            } else {
              widget.onBackToHome?.call();
            }
          },
        ),
        centerTitle: false,
        title: Text(
          'Categories',
          style: GoogleFonts.cairo(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white, // أبيض فوق الجريدينت
          ),
        ),
      ),
      body: Stack(
        children: [
          // خلفية الجريدينت (نفس روحية الويلكم/الدتفصيل)
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

          // المحتوى
          SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : Column(
                    children: [
                      // حقل البحث أبيض شبه شفاف عشان يبقى واضح فوق الجريدينت
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        child: TextField(
                          controller: _searchController,
                          style: GoogleFonts.cairo(
                            color: Colors.black87,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search categories...',
                            hintStyle: GoogleFonts.cairo(color: Colors.black54),
                            prefixIcon: const Icon(Icons.search, color: Colors.black54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.92),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                      ),

                      // قائمة الأنواع بكروت بيضاء (للقراءة الممتازة)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          itemCount: _visibleTypes.length,
                          itemBuilder: (context, index) {
                            final type = _visibleTypes[index];
                            final typeIcon = _typeIcons[type.name] ?? Icons.category;
                            final typeColor = _typeColors[type.name] ?? Colors.grey;

                            final companyCount = type.fields?.fold<int>(
                                  0,
                                  (sum, f) => sum + (f.companies?.length ?? 0),
                                ) ??
                                0;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: OpenContainer(
                                openColor: cardColor,
                                closedColor: cardColor,
                                closedElevation: 4,
                                closedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                transitionDuration: const Duration(milliseconds: 350),
                                transitionType: ContainerTransitionType.fadeThrough,
                                openBuilder: (context, action) {
                                  if (type.fields != null && type.fields!.isNotEmpty) {
                                    return FieldsScreen(
                                      typeName: type.name,
                                      fields: type.fields!,
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                                closedBuilder: (context, action) {
                                  return Card(
                                    color: cardColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    margin: EdgeInsets.zero,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15.r),
                                      onTap: action,
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60.w,
                                              height: 60.w,
                                              decoration: BoxDecoration(
                                                color: typeColor.withOpacity(0.18),
                                                borderRadius: BorderRadius.circular(10.r),
                                              ),
                                              child: Icon(typeIcon, size: 28.sp, color: typeColor),
                                            ),
                                            SizedBox(width: 15.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    type.name,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: primaryTextOnCard,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    '$companyCount Companies',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 14.sp,
                                                      color: secondaryTextOnCard,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
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
        ],
      ),
    );
  }
}

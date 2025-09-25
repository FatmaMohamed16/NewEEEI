// // lib/CompaniesScreen.dart
// import 'package:eeei/models.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'CompanyDetailsScreen.dart';

// class CompaniesScreen extends StatefulWidget {
//   final String fieldName;
//   final List<CompanyModel> companies;

//   const CompaniesScreen({
//     super.key,
//     required this.fieldName,
//     required this.companies,
//   });

//   @override
//   State<CompaniesScreen> createState() => _CompaniesScreenState();
// }

// class _CompaniesScreenState extends State<CompaniesScreen> {
//   List<CompanyModel> _filteredCompanies = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _filteredCompanies = widget.companies;
//     _searchController.addListener(_filterCompanies);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _filterCompanies() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredCompanies = widget.companies
//           .where((company) =>
//               (company.name?.toLowerCase() ?? '').contains(query) ||
//               (company.address?.toLowerCase() ?? '').contains(query) ||
//               (company.description?.toLowerCase() ?? '').contains(query))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E2E3E),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E2E3E),
//         elevation: 0,
//         toolbarHeight: 80.h,
//         title: Text(
//           '${widget.fieldName} Companies',
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
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for a company',
//                 hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
//                 prefixIcon: const Icon(Icons.search, color: Colors.white70),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.r),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xFF3C3C56),
//               ),
//               style: GoogleFonts.poppins(color: Colors.white),
//             ),
//           ),
//           Expanded(
//             child: _filteredCompanies.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No companies available.',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white70,
//                         fontSize: 18.sp,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: _filteredCompanies.length,
//                     itemBuilder: (context, index) {
//                       final company = _filteredCompanies[index];
//                       return FadeInUp(
//                         duration: Duration(milliseconds: 500 + index * 100),
//                         child: SlideInLeft(
//                           duration: Duration(milliseconds: 600 + index * 100),
//                           child: CompanyCard(company: company),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CompanyCard extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyCard({super.key, required this.company});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120.h,
//       margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => CompanyDetailsScreen(company: company),
//               ),
//             );
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
//                   if (company.logoImageUrl != null &&
//                       company.logoImageUrl!.isNotEmpty &&
//                       company.logoImageUrl != 'null')
//                     Container(
//                       width: 70.w,
//                       height: 70.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.r),
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/${company.logoImageUrl!}'),
//                       fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           company.name ?? 'Not Found',
//                           style: GoogleFonts.poppins(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           company.description ?? '',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14.sp,
//                             color: Colors.grey[400],
//                           ),
//                           overflow: TextOverflow.ellipsis,
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
// lib/CompaniesScreen.dart
// import 'package:eeei/models.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'CompanyDetailsScreen.dart';

// /// ===================== CompanyCard (مطابق لستايل الهوم/الأنواع/المجالات) =====================
// class CompanyCard extends StatelessWidget {
//   final CompanyModel company;

//   const CompanyCard({super.key, required this.company});

//   @override
//   Widget build(BuildContext context) {
//     final String? formattedImageUrl =
//         company.logoImageUrl != null
//             ? 'assets/images/${company.logoImageUrl!}'
//             : null;

//     return Card(
//       color: Colors.white,
//       elevation: 4, // مثل CompanyCard في HomePage
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(15.r),
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => CompanyDetailsScreen(company: company),
//             ),
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.all(12.w), // نفس padding بطاقات الهوم/الأنواع
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // لوجو الشركة (مطابق لفكرة شعار البطاقة)
//               Container(
//                 width: 60.w,
//                 height: 60.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   color: Colors.grey[200],
//                   image:
//                       (formattedImageUrl != null)
//                           ? DecorationImage(
//                             image: AssetImage(formattedImageUrl),
//                             fit: BoxFit.contain,
//                           )
//                           : null,
//                 ),
//                 child:
//                     formattedImageUrl == null
//                         ? const Icon(
//                           Icons.business,
//                           size: 28,
//                           color: Colors.grey,
//                         )
//                         : null,
//               ),
//               SizedBox(width: 15.w),

//               // نصوص بنفس أحجام Fields/Types
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // اسم الشركة
//                     Text(
//                       company.name ?? 'Not Found',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.cairo(
//                         fontSize: 18.sp, // = اسم البطاقة في باقي الشاشات
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     // وصف مختصر (يمكنك استبداله بـ company.description)
//                     Text(
//                       'More about this company',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.cairo(
//                         fontSize: 14.sp, // = وصف البطاقة في باقي الشاشات
//                         color: const Color(0xFF616161),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ===================== CompaniesScreen (مطابقة لستايل Fields + نفس التدرّج) =====================
// class CompaniesScreen extends StatefulWidget {
//   final String fieldName;
//   final List<CompanyModel> companies;

//   const CompaniesScreen({
//     super.key,
//     required this.fieldName,
//     required this.companies,
//   });

//   @override
//   State<CompaniesScreen> createState() => _CompaniesScreenState();
// }

// class _CompaniesScreenState extends State<CompaniesScreen> {
//   // ألوان وخطوط موحّدة مثل Fields/Types
//   static const Color pageBg = Color(0xFFF1F6FB);
//   static const Color primaryText = Colors.black87;

//   late List<CompanyModel> _filteredCompanies;
//   final TextEditingController _searchController = TextEditingController();

//   // قيم التدرّج مثل صفحة Fields الأصلية
//   static const int kBaseMs = 200; // الأساس
//   static const int kStepMs = 100; // الزيادة لكل عنصر

//   @override
//   void initState() {
//     super.initState();
//     _filteredCompanies = widget.companies;
//     _searchController.addListener(_filterCompanies);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_filterCompanies);
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _filterCompanies() {
//     final query = _searchController.text.toLowerCase().trim();
//     setState(() {
//       _filteredCompanies =
//           widget.companies.where((company) {
//             final name = (company.name ?? '').toLowerCase();
//             final address = (company.address ?? '').toLowerCase();
//             final desc = (company.description ?? '').toLowerCase();
//             return name.contains(query) ||
//                 address.contains(query) ||
//                 desc.contains(query);
//           }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: pageBg,
//       appBar: AppBar(
//         backgroundColor: pageBg,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black87), // سهم رجوع مثل Fields
//         centerTitle: false,
//         title: FadeInDown(
//           duration: const Duration(milliseconds: 350),
//           child: Text(
//             '${widget.fieldName} Companies',
//             style: GoogleFonts.cairo(
//               fontSize: 24.sp, // = عنوان AppBar في باقي الشاشات
//               fontWeight: FontWeight.bold,
//               color: primaryText,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // حقل البحث — نفس ستايل Fields/Types
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//             child: FadeInRight(
//               duration: const Duration(milliseconds: 600),
//               child: TextField(
//                 controller: _searchController,
//                 style: GoogleFonts.cairo(color: primaryText, fontSize: 16.sp),
//                 decoration: InputDecoration(
//                   hintText: 'Search for a company...',
//                   hintStyle: GoogleFonts.cairo(color: Colors.grey),
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.r),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//                 ),
//               ),
//             ),
//           ),

//           // القائمة — نفس الأنيميشن FadeInUp + SlideInLeft مع التدرّج (200 + index*100)
//           Expanded(
//             child:
//                 _filteredCompanies.isEmpty
//                     ? Center(
//                       child: Text(
//                         'No companies available.',
//                         style: GoogleFonts.cairo(
//                           color: Colors.grey,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                     )
//                     : ListView.builder(
//                       itemCount: _filteredCompanies.length,
//                       itemBuilder: (context, index) {
//                         final company = _filteredCompanies[index];
//                         final duration = Duration(
//                           milliseconds: kBaseMs + index * kStepMs,
//                         );

//                         return FadeInUp(
//                           duration: duration,
//                           child: SlideInLeft(
//                             duration: duration,
//                             child: CompanyCard(company: company),
//                           ),
//                         );
//                       },
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///
///

import 'package:eeei/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'CompanyDetailsScreen.dart';

/// ============= ثوابت ألوان التدرّج الموحّدة =============
const Color kBlueDeep = Color(0xFF2F5ED7);
const Color kOrangeSoft = Color(0xFFFF8A4C);
const Color kVioletSoft = Color(0xFF6C5DD3);

/// ===================== CompanyCard (مطابق لستايل الهوم/الأنواع/المجالات) =====================
class CompanyCard extends StatelessWidget {
  final CompanyModel company;

  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final String? formattedImageUrl =
        company.logoImageUrl != null
            ? 'assets/images/${company.logoImageUrl!}'
            : null;

    return Card(
      color: Colors.white,
      elevation: 4, // مثل CompanyCard في HomePage
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CompanyDetailsScreen(company: company),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(12.w), // نفس padding بطاقات الهوم/الأنواع
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // لوجو الشركة
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.grey[200],
                  image:
                      (formattedImageUrl != null)
                          ? DecorationImage(
                            image: AssetImage(formattedImageUrl),
                            fit: BoxFit.contain,
                          )
                          : null,
                ),
                child:
                    formattedImageUrl == null
                        ? const Icon(
                          Icons.business,
                          size: 28,
                          color: Colors.grey,
                        )
                        : null,
              ),
              SizedBox(width: 15.w),

              // نصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم الشركة
                    Text(
                      company.name ?? 'Not Found',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // وصف مختصر
                    Text(
                      'More about this company',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        color: const Color(0xFF616161),
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
  }
}

/// ===================== CompaniesScreen (بنفس تدرّج الأنواع/المجالات) =====================
/// ===================== CompaniesScreen =====================
class CompaniesScreen extends StatefulWidget {
  final String fieldName;
  final List<CompanyModel> companies;

  const CompaniesScreen({
    super.key,
    required this.fieldName,
    required this.companies,
  });

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  static const Color primaryText = Colors.black87;

  late List<CompanyModel> _filteredCompanies;
  final TextEditingController _searchController = TextEditingController();

  static const int kBaseMs = 200;
  static const int kStepMs = 100;

  @override
  void initState() {
    super.initState();
    _filteredCompanies = widget.companies;
    _searchController.addListener(_filterCompanies);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCompanies);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCompanies() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredCompanies =
          widget.companies.where((c) {
            final name = (c.name ?? '').toLowerCase();
            final address = (c.address ?? '').toLowerCase();
            final desc = (c.description ?? '').toLowerCase();
            return name.contains(query) ||
                address.contains(query) ||
                desc.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // يخلي التدرج ورا الأپبار
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: false,
        // نفس شكل الأپبار في الصفحات التانية: تدرّج + حافة سفلية
        backgroundColor: Colors.transparent,
        toolbarHeight: 64,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kBlueDeep, kOrangeSoft, kVioletSoft],
            ),
          ),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 250),
          child: Text(
            '${widget.fieldName} Companies', // اسم المجال أولًا ثم Companies
            style: GoogleFonts.cairo(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // خلفية التدرّج للصفحة كلها
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
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
            child: Column(
              children: [
                // بحث داخل كونتينر أبيض
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: GoogleFonts.cairo(
                          color: primaryText,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search for a company...',
                          hintStyle: GoogleFonts.cairo(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ),
                ),

                // القائمة
                Expanded(
                  child:
                      _filteredCompanies.isEmpty
                          ? Center(
                            child: Text(
                              'No companies available.',
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: EdgeInsets.only(top: 6.h, bottom: 12.h),
                            itemCount: _filteredCompanies.length,
                            itemBuilder: (context, index) {
                              final company = _filteredCompanies[index];
                              final duration = Duration(
                                milliseconds: kBaseMs + index * kStepMs,
                              );

                              return FadeInUp(
                                duration: duration,
                                child: CompanyCard(company: company),
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

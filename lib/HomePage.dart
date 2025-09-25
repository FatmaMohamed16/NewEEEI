
// import 'package:eeei/CompanyDetailsScreen.dart';
// import 'package:eeei/Services/local_data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';
// import 'models.dart';


// const Color kTextDark  = Color(0xFF101217);
// const Color kCardTitle = Color(0xFF0C0F13);
// const Color kCardBody  = Color(0xFF55616C);

// const List<Color> kAccentColors = [
//   Color(0xFF6C5DD3), // Violet
//   Color(0xFFFF8A4C), // Orange
//   Color(0xFF2F5ED7), // Blue
// ];

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   final List<CompanyModel> _allCompanies = [];
//   final List<FieldModel> _allFields = [];
//   List<CompanyModel> _filteredCompanies = [];

//   FieldModel? _selectedField;
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadAllData();
//     _searchController.addListener(_filterCompanies);
//   }

//   Future<void> _loadAllData() async {
//     setState(() => _isLoading = true);
//     try {
//       final types = await LocalDataService.loadAllData();
//       final List<FieldModel> allFieldsList = [];
//       final List<CompanyModel> allCompaniesList = [];

//       for (var type in types) {
//         if (type.fields != null) {
//           allFieldsList.addAll(type.fields!);
//           for (var field in type.fields!) {
//             if (field.companies != null) {
//               allCompaniesList.addAll(field.companies!);
//             }
//           }
//         }
//       }

//       final uniqueCompanies = {for (var c in allCompaniesList) c.id: c}.values.toList();

//       setState(() {
//         _allFields
//           ..clear()
//           ..addAll(allFieldsList);
//         _allCompanies
//           ..clear()
//           ..addAll(uniqueCompanies);
//         _filteredCompanies = List.from(uniqueCompanies);
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Error loading data: $e')));
//       }
//     }
//     if (mounted) setState(() => _isLoading = false);
//   }

//   void _filterCompanies() {
//     final q = _searchController.text.toLowerCase();
//     final source = (_selectedField?.companies?.isNotEmpty ?? false)
//         ? _selectedField!.companies!
//         : _allCompanies;

//     setState(() {
//       _filteredCompanies = source
//           .where((c) => (c.name ?? '').toLowerCase().contains(q))
//           .toList();
//     });
//   }

//   void _onFieldChanged(FieldModel? newField) {
//     setState(() {
//       _selectedField = newField;
//       _filterCompanies();
//     });
//   }

//   void focusSearch() => _searchFocusNode.requestFocus();

//   Future<void> _openWebsite() async {
//     const url = 'https://eeei.arenho.com/';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Could not open the website')),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_filterCompanies);
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     super.dispose();
//   }
// // ===== HOME PAGE WITH SMALL BANNER =====
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Stack(
//       children: [
//         // خلفية متدرجة
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF6C5DD3), // purple
//                 Color(0xFFFF8A4C), // orange
//                 Color(0xFF6C5DD3), // purple bottom
//               ],
//               stops: [0.0, 0.55, 1.0],
//             ),
//           ),
//         ),

//         _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : CustomScrollView(
//                 slivers: <Widget>[
//                   // ======= SMALL HEADER IMAGE =======
//                   SliverToBoxAdapter(
//                     child: GestureDetector(
//                       onTap: _openWebsite,
//                       child: SizedBox(
//                         height: 110.h, // 👈 نفس الطول اللي في الصورة
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             // صورة الهيدر
//                             Image.asset(
//                               'assets/2025-09-16 (1).png',
//                               fit: BoxFit.cover,
//                               alignment: Alignment.center,
//                             ),
//                             // ظل شفاف فوق الصورة
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.55),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   // ======= SEARCH + FILTER =======
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
//                       child: Column(
//                         children: [
//                           // Search
//                           FadeInRight(
//                             duration: const Duration(milliseconds: 400),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.9),
//                                 borderRadius: BorderRadius.circular(28.r),
//                               ),
//                               child: TextField(
//                                 controller: _searchController,
//                                 focusNode: _searchFocusNode,
//                                 style: GoogleFonts.cairo(color: kTextDark),
//                                 decoration: InputDecoration(
//                                   hintText: 'Search for a company...',
//                                   hintStyle: GoogleFonts.cairo(
//                                     color: const Color(0xFF8C95A1),
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   prefixIcon: const Icon(Icons.search,
//                                       color: Color(0xFF8C95A1)),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(28.r),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white.withOpacity(0.92),
//                                   contentPadding:
//                                       EdgeInsets.symmetric(vertical: 14.h),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 12.h),

//                           // Filter
//                           FadeInRight(
//                             delay: const Duration(milliseconds: 90),
//                             duration: const Duration(milliseconds: 400),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.9),
//                                 borderRadius: BorderRadius.circular(28.r),
//                               ),
//                               child: DropdownButtonFormField<FieldModel>(
//                                 decoration: InputDecoration(
//                                   label: Text(
//                                     'Select a Field',
//                                     style: GoogleFonts.cairo(
//                                       fontWeight: FontWeight.w800,
//                                       color: kTextDark,
//                                     ),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(28.r),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white.withOpacity(0.92),
//                                   contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 16.w,
//                                     vertical: 8.h,
//                                   ),
//                                 ),
//                                 value: _selectedField,
//                                 onChanged: _onFieldChanged,
//                                 menuMaxHeight: 320,
//                                 items: [
//                                   const DropdownMenuItem<FieldModel>(
//                                     value: null,
//                                     child: Text('All Fields'),
//                                   ),
//                                   ..._allFields.map(
//                                     (f) => DropdownMenuItem<FieldModel>(
//                                       value: f,
//                                       child: Text(f.name),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 12.h),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // ======= LIST =======
//                   (_filteredCompanies.isEmpty)
//                       ? SliverFillRemaining(
//                           hasScrollBody: false,
//                           child: Center(
//                             child: Text(
//                               'No matching companies found',
//                               style: GoogleFonts.cairo(
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         )
//                       : SliverPadding(
//                           padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
//                           sliver: SliverList(
//                             delegate: SliverChildBuilderDelegate(
//                               (context, index) {
//                                 final company = _filteredCompanies[index];
//                                 final accent = kAccentColors[
//                                     index % kAccentColors.length];
//                                 return FadeInUp(
//                                   duration:
//                                       const Duration(milliseconds: 220),
//                                   child: CompanyCard(
//                                     company: company,
//                                     accent: accent,
//                                   ),
//                                 );
//                               },
//                               childCount: _filteredCompanies.length,
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//       ],
//     ),
//   );
// }
// }

// class CompanyCard extends StatelessWidget {
//   final CompanyModel company;
//   final Color? accent;
//   const CompanyCard({super.key, required this.company, this.accent});

//   @override
//   Widget build(BuildContext context) {
//     final Color a = (accent ?? const Color(0xFF6C5DD3));

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CompanyDetailsScreen(company: company),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 16.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(26.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.10),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.white.withOpacity(0.96),
//           borderRadius: BorderRadius.circular(26.r),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
//             child: Row(
//               children: [
//                 Container(
//                   width: 66.w,
//                   height: 66.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.r),
//                     color: a.withOpacity(0.12),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: company.logoImageUrl != null
//                       ? Image.asset(
//                           'assets/images/${company.logoImageUrl}',
//                           fit: BoxFit.contain,
//                         )
//                       : Icon(Icons.business, size: 32, color: a.withOpacity(0.7)),
//                 ),
//                 SizedBox(width: 16.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         company.name ?? 'No Name',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.cairo(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.w800,
//                           color: kCardTitle,
//                         ),
//                       ),
//                       SizedBox(height: 6.h),
//                       Text(
//                         company.description ?? 'No description available.',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.cairo(
//                           fontSize: 15.sp,
//                           height: 1.25,
//                           color: kCardBody,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }














import 'package:eeei/CompanyDetailsScreen.dart';
import 'package:eeei/Services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'models.dart';

const Color kTextDark  = Color(0xFF101217);
const Color kCardTitle = Color(0xFF0C0F13);
const Color kCardBody  = Color(0xFF55616C);

const List<Color> kAccentColors = [
  Color(0xFF6C5DD3), // Violet
  Color(0xFFFF8A4C), // Orange
  Color(0xFF2F5ED7), // Blue
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<CompanyModel> _allCompanies = [];
  final List<FieldModel> _allFields = [];
  List<CompanyModel> _filteredCompanies = [];

  FieldModel? _selectedField;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isLoading = true;

  // ScrollController للسكرول لأعلى
  final ScrollController _scrollController = ScrollController();

  // يناديها MainScreen عند الضغط على أيقونة الهوم
  void scrollToTopIfNotAtTop() {
    if (_scrollController.hasClients && _scrollController.offset > 0) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  // ★ يناديها MainScreen لإغلاق الدروب داون وتصـفير الفلترة
  void resetFieldFilterAndCloseDropdown() {
    // اقفل أي Dropdown/Keyboard مفتوح
    FocusScope.of(context).unfocus();
    // لو في Route فوق (زي قائمة Dropdown) اقفله
    Navigator.of(context).maybePop();

    // صفّر اختيار الفيلد وأعد التصفية
    if (_selectedField != null) {
      setState(() {
        _selectedField = null;
        _filterCompanies();
      });
    }
  }

  void focusSearch() => _searchFocusNode.requestFocus();

  @override
  void initState() {
    super.initState();
    _loadAllData();
    _searchController.addListener(_filterCompanies);
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);
    try {
      final types = await LocalDataService.loadAllData();
      final List<FieldModel> allFieldsList = [];
      final List<CompanyModel> allCompaniesList = [];

      for (var type in types) {
        if (type.fields != null) {
          allFieldsList.addAll(type.fields!);
          for (var field in type.fields!) {
            if (field.companies != null) {
              allCompaniesList.addAll(field.companies!);
            }
          }
        }
      }

      final uniqueCompanies = {for (var c in allCompaniesList) c.id: c}.values.toList();

      setState(() {
        _allFields
          ..clear()
          ..addAll(allFieldsList);
        _allCompanies
          ..clear()
          ..addAll(uniqueCompanies);
        _filteredCompanies = List.from(uniqueCompanies);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error loading data: $e')));
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _filterCompanies() {
    final q = _searchController.text.toLowerCase();
    final source = (_selectedField?.companies?.isNotEmpty ?? false)
        ? _selectedField!.companies!
        : _allCompanies;

    setState(() {
      _filteredCompanies = source
          .where((c) => (c.name ?? '').toLowerCase().contains(q))
          .toList();
    });
  }

  void _onFieldChanged(FieldModel? newField) {
    setState(() {
      _selectedField = newField;
      _filterCompanies();
    });
  }

  Future<void> _openWebsite() async {
    const url = 'https://eeei.arenho.com/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the website')),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCompanies);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ===== HOME PAGE WITH SMALL BANNER =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية متدرجة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C5DD3), // purple
                  Color(0xFFFF8A4C), // orange
                  Color(0xFF6C5DD3), // purple bottom
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  controller: _scrollController, // ربط الكنترولر
                  slivers: <Widget>[
                    // ======= SMALL HEADER IMAGE =======
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: _openWebsite,
                        child: SizedBox(
                          height: 110.h,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/2025-09-16 (1).png',
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.55),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ======= SEARCH + FILTER =======
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
                        child: Column(
                          children: [
                            // Search
                            FadeInRight(
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  focusNode: _searchFocusNode,
                                  style: GoogleFonts.cairo(color: kTextDark),
                                  decoration: InputDecoration(
                                    hintText: 'Search for a company...',
                                    hintStyle: GoogleFonts.cairo(
                                      color: const Color(0xFF8C95A1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    prefixIcon: const Icon(Icons.search,
                                        color: Color(0xFF8C95A1)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.92),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14.h),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // Filter (Dropdown)
                            FadeInRight(
                              delay: const Duration(milliseconds: 90),
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                child: DropdownButtonFormField<FieldModel>(
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Select a Field',
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w800,
                                        color: kTextDark,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.92),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                  ),
                                  value: _selectedField,
                                  onChanged: _onFieldChanged,
                                  menuMaxHeight: 320,
                                  items: [
                                    const DropdownMenuItem<FieldModel>(
                                      value: null,
                                      child: Text('All Fields'),
                                    ),
                                    ..._allFields.map(
                                      (f) => DropdownMenuItem<FieldModel>(
                                        value: f,
                                        child: Text(f.name),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),

                    // ======= LIST =======
                    (_filteredCompanies.isEmpty)
                        ? SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text(
                                'No matching companies found',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final company = _filteredCompanies[index];
                                  final accent = kAccentColors[
                                      index % kAccentColors.length];
                                  return FadeInUp(
                                    duration: const Duration(milliseconds: 220),
                                    child: CompanyCard(
                                      company: company,
                                      accent: accent,
                                    ),
                                  );
                                },
                                childCount: _filteredCompanies.length,
                              ),
                            ),
                          ),
                  ],
                ),
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final Color? accent;
  const CompanyCard({super.key, required this.company, this.accent});

  @override
  Widget build(BuildContext context) {
    final Color a = (accent ?? const Color(0xFF6C5DD3));

    return GestureDetector(
      onTap: () {
        // هذا الـ push يذهب داخل Navigator الخاص بتبويب الهوم (Nested) تلقائيًا
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompanyDetailsScreen(company: company),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(26.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 66.w,
                  height: 66.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: a.withOpacity(0.12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: company.logoImageUrl != null
                      ? Image.asset(
                          'assets/images/${company.logoImageUrl}',
                          fit: BoxFit.contain,
                        )
                      : Icon(Icons.business, size: 32, color: a.withOpacity(0.7)),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name ?? 'No Name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: kCardTitle,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        company.description ?? 'No description available.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          height: 1.25,
                          color: kCardBody,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

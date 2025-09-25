// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'HomePage.dart'; // Assuming HomePage is in this path
// import 'TypesScreen.dart'; // Assuming TypesScreen is in this path
// // Import other screens if you have more tabs

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     // If the tapped item is the search icon (index 2 in this setup)
//     if (index == 2) {
//       // Navigate to the HomePage and potentially focus the search bar
//       // This assumes HomePage has a method to focus its search bar.
//       // For now, we'll just navigate to HomePage.
//       _pageController.jumpToPage(0); // Go to HomePage
//       setState(() {
//         _selectedIndex = 0; // Update selected index to HomePage
//       });
//       // If you have a GlobalKey for HomePageState, you can call focusSearch() here.
//       // Example: if (homePageKey.currentState != null) { homePageKey.currentState!.focusSearch(); }

//     } else {
//       // For other navigation items (HomePage, TypesScreen)
//       _pageController.jumpToPage(index);
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures for PageView
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: const [
//           HomePage(),      // Index 0
//           TypesScreen(),   // Index 1
//           // Placeholder for the search tab. Tapping it will navigate to HomePage.
//           // If you need a dedicated search screen, add it here.
//           Center(child: Text("Search content will appear here when selected.", style: TextStyle(color: Colors.white))), // Placeholder for search index
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(FontAwesomeIcons.magnifyingGlass), // Search icon
//             label: '',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 12, 19, 24), // Or your preferred color
//         unselectedItemColor: Colors.grey,
//         backgroundColor: const Color.fromARGB(255, 250, 250, 252), // Dark background for the nav bar
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'HomePage.dart';
// import 'TypesScreen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _index = 0;

//   // مفاتيح لكل Navigator داخلي (لاحظ: types/search قابلة لإعادة الإنشاء)
//   final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
//   GlobalKey<NavigatorState> _typesNavKey = GlobalKey<NavigatorState>();
//   GlobalKey<NavigatorState> _searchNavKey = GlobalKey<NavigatorState>();

//   // مفتاح لـ HomePage عشان نعمل focus للبحث
//   final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

//   List<GlobalKey<NavigatorState>> get _navKeys => [
//     _homeNavKey,
//     _typesNavKey,
//     _searchNavKey,
//   ];

//   Future<bool> _onWillPop() async {
//     final key = _navKeys[_index];
//     if (key.currentState?.canPop() ?? false) {
//       key.currentState!.pop();
//       return false;
//     }
//     return true;
//   }

//   void _resetTypesTabAndSwitch() {
//     // ✅ اصفر Navigator تبويب الأنواع تمامًا ثم اعرض التبويب — مفيش pops أو وميض
//     setState(() {
//       _typesNavKey = GlobalKey<NavigatorState>(); // Stack جديد نظيف
//       _index = 1; // روح للأنواع
//     });
//   }

//   void _resetSearchTabAndSwitch() {
//     setState(() {
//       _searchNavKey = GlobalKey<NavigatorState>();
//       _index = 2;
//     });
//   }

//   void _goToHomeAndFocusSearch() {
//     // ارجع لجذر الهوم (لو فيه صفحات داخلية)
//     _homeNavKey.currentState?.popUntil((r) => r.isFirst);
//     setState(() => _index = 0);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _homePageKey.currentState?.focusSearch();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _index,
//           children: [
//             _TabNavigator(
//               navigatorKey: _homeNavKey,
//               initial: HomePage(key: _homePageKey),
//             ),
//             _TabNavigator(
//               navigatorKey: _typesNavKey,
//               initial: TypesScreen(
//                 onBackToHome: () => setState(() => _index = 0),
//               ),
//             ),
//             _TabNavigator(
//               navigatorKey: _searchNavKey,
//               initial: const Center(
//                 child: Text('Search content will appear here'),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _index,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: const Color.fromARGB(255, 12, 19, 24),
//           unselectedItemColor: Colors.grey,
//           backgroundColor: const Color.fromARGB(255, 250, 250, 252),
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//             BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
//             BottomNavigationBarItem(
//               icon: Icon(FontAwesomeIcons.magnifyingGlass),
//               label: '',
//             ),
//           ],
//           onTap: (i) {
//             if (i == 2) {
//               // البحث: افتح الهوم + فوكس على صندوق البحث
//               _goToHomeAndFocusSearch();
//             } else if (i == 1) {
//               // الأنواع: صفّر الـNavigator ثم اعرض الأنواع فورًا (بدون وميض)
//               _resetTypesTabAndSwitch();
//             } else if (i == 0) {
//               // الهوم عادي
//               setState(() => _index = 0);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// /// Navigator لكل تبويب — يحافظ على الـBottom Bar ثابت ويعزل التصفح داخل التبويب
// class _TabNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final Widget initial;

//   const _TabNavigator({required this.navigatorKey, required this.initial});

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(builder: (_) => initial, settings: settings);
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HomePage.dart';
import 'TypesScreen.dart';
import 'ChatbotScreen.dart'; // تأكد أن الملف موجود

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  // مفاتيح لكل Navigator داخلي (كل تبويب له ستاك مستقل)
  final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _typesNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _chatNavKey  = GlobalKey<NavigatorState>();

  // مفتاح لـ HomePage للتحكم في السكرول/الفوكس/تصـفير الفلترة
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

  // تاريخ التبويبات
  final List<int> _tabHistory = [];

  List<GlobalKey<NavigatorState>> get _navKeys => [
        _homeNavKey,
        _typesNavKey,
        _chatNavKey,
      ];

  Future<bool> _onWillPop() async {
    final key = _navKeys[_index];

    if (key.currentState?.canPop() ?? false) {
      key.currentState!.pop();
      return false;
    }

    if (_tabHistory.isNotEmpty) {
      setState(() => _index = _tabHistory.removeLast());
      return false;
    }

    return true;
  }

  void _resetTypesTabAndSwitch() {
    if (_index != 1) _tabHistory.add(_index);
    setState(() {
      _typesNavKey = GlobalKey<NavigatorState>(); // Stack جديد نظيف
      _index = 1;
    });
  }

  void _resetChatTabAndSwitch() {
    if (_index != 2) _tabHistory.add(_index);
    setState(() {
      _chatNavKey = GlobalKey<NavigatorState>(); // Stack جديد نظيف
      _index = 2;
    });
  }

  // متروكة لو حبيت تستخدمها لاحقًا
  void _goToHomeAndFocusSearch() {
    if (_index != 0) _tabHistory.add(_index);
    _homeNavKey.currentState?.popUntil((r) => r.isFirst);
    setState(() => _index = 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homePageKey.currentState?.focusSearch();
    });
  }

  void _handleChatBack() {
    final nav = _chatNavKey.currentState;

    if (nav?.canPop() ?? false) {
      nav!.pop();
      return;
    }

    if (_tabHistory.isNotEmpty) {
      setState(() => _index = _tabHistory.removeLast());
    } else {
      setState(() => _index = 0);
    }
  }

  // منطق الضغط على أيقونة الهوم:
  // - لو أنت بالفعل في تبويب الهوم:
  //    * فيه صفحات مفتوحة (تفاصيل شركة)؟ popUntil(isFirst).
  //    * في كل الأحوال: اقفل Dropdown + صفّر الفلترة.
  //    * ثم سكرول لأعلى لو مش في أول الصفحة.
  // - لو مش في تبويب الهوم: انتقل إليه ثم صفّر الفلترة.
  void _handleHomeTapped() {
    if (_index == 0) {
      final nav = _homeNavKey.currentState;
      if (nav != null && nav.canPop()) {
        nav.popUntil((route) => route.isFirst); // رجوع من تفاصيل الشركة للهوم
      }

      // ★ اقفل الدروب داون + صفّر الفلترة
      _homePageKey.currentState?.resetFieldFilterAndCloseDropdown();

      // ★ سكرول لأعلى لو مش في الأعلى
      _homePageKey.currentState?.scrollToTopIfNotAtTop();
    } else {
      _tabHistory.add(_index);
      setState(() => _index = 0);

      // بعد الانتقال للهوم: صفّر الفلترة واقفل أي Dropdown
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _homePageKey.currentState?.resetFieldFilterAndCloseDropdown();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            // تبويب الهوم
            _TabNavigator(
              navigatorKey: _homeNavKey,
              initial: HomePage(key: _homePageKey),
            ),

            // تبويب الأنواع
            _TabNavigator(
              navigatorKey: _typesNavKey,
              initial: TypesScreen(
                onBackToHome: () => setState(() => _index = 0),
              ),
            ),

            // تبويب الشات بوت
            _TabNavigator(
              navigatorKey: _chatNavKey,
              initial: ChatbotScreen(onBackRequested: _handleChatBack),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 12, 19, 24),
          unselectedItemColor: Colors.grey,
          backgroundColor: const Color.fromARGB(255, 250, 250, 252),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.robot),
              label: '',
            ),
          ],
          onTap: (i) {
            if (i == 2) {
              _resetChatTabAndSwitch();
            } else if (i == 1) {
              _resetTypesTabAndSwitch();
            } else if (i == 0) {
              _handleHomeTapped(); // استخدام المنطق الجديد
            }
          },
        ),
      ),
    );
  }
}

/// Navigator لكل تبويب — يحافظ على الـBottom Bar ثابت ويعزل التصفح داخل التبويب
class _TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget initial;

  const _TabNavigator({required this.navigatorKey, required this.initial});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => initial, settings: settings);
      },
    );
  }
}

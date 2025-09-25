// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:http/http.dart' as http;

// // // message model
// // class Message {
// //   final String text;
// //   final bool isUser;
// //   final List<Widget>? richContent; // <-- for styled bot responses
// //   final bool isLoading; // <-- for loading indicator
// //   final bool isError; // <-- for error messages
// //   final VoidCallback? onRetry; // <-- for retry functionality

// //   Message({
// //     required this.text,
// //     required this.isUser,
// //     this.richContent,
// //     this.isLoading = false,
// //     this.isError = false,
// //     this.onRetry,
// //   });
// // }

// // class ChatbotScreen extends StatefulWidget {
// //   const ChatbotScreen({super.key});

// //   @override
// //   State<ChatbotScreen> createState() => _ChatbotScreenState();
// // }

// // class _ChatbotScreenState extends State<ChatbotScreen> {
// //   final TextEditingController _controller = TextEditingController();
// //   final List<Message> _messages = [];
// //   bool _isWaitingForResponse = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Add welcome message when the chat starts
// //     _addWelcomeMessage();
// //   }

// //   void _addWelcomeMessage() {
// //     setState(() {
// //       _messages.add(
// //         Message(
// //           text:
// //               "Hello! I'm here to help you find companies that can support your startup idea. "
// //               "Tell me about your project or what kind of help you're looking for.",
// //           isUser: false,
// //         ),
// //       );
// //     });
// //   }

// //   Future<void> _sendToBackend(String text) async {
// //     setState(() {
// //       _isWaitingForResponse = true;
// //       // Add loading indicator message
// //       _messages.add(Message(text: "", isUser: false, isLoading: true));
// //     });

// //     try {
// //       final url = Uri.parse(
// //         "http://172.30.1.98:8000/chatbot/suggest_companies/",
// //       );

// //       final response = await http.post(
// //         url,
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({"prompt": text}),
// //       );

// //       // Remove loading indicator
// //       setState(() {
// //         _isWaitingForResponse = false;
// //         _messages.removeWhere((msg) => msg.isLoading);
// //       });

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);

// //         final botMessage = data["message"] ?? "Here are some results:";
// //         _addMessage(botMessage, false);

// //         final types = data["types"] as List<dynamic>;
// //         for (var t in types) {
// //           String typeName = t["type"];
// //           List companies = t["companies"];

// //           if (companies.isNotEmpty) {
// //             List<Widget> widgets = [];

// //             widgets.add(
// //               Padding(
// //                 padding: EdgeInsets.symmetric(vertical: 8.h),
// //                 child: Text(
// //                   typeName,
// //                   style: GoogleFonts.poppins(
// //                     fontSize: 20.sp,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.deepPurple,
// //                   ),
// //                 ),
// //               ),
// //             );

// //             for (var c in companies) {
// //               widgets.add(
// //                 Padding(
// //                   padding: EdgeInsets.only(bottom: 12.h),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         c['name'],
// //                         style: GoogleFonts.poppins(
// //                           fontSize: 18.sp,
// //                           fontWeight: FontWeight.w700,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       SizedBox(height: 6.h),
// //                       Wrap(
// //                         spacing: 6.w,
// //                         runSpacing: 6.h,
// //                         children:
// //                             (c['fields'] as List).map<Widget>((field) {
// //                               return Container(
// //                                 padding: EdgeInsets.symmetric(
// //                                   horizontal: 10.w,
// //                                   vertical: 4.h,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.green[100],
// //                                   borderRadius: BorderRadius.circular(20.r),
// //                                 ),
// //                                 child: Text(
// //                                   field,
// //                                   style: GoogleFonts.poppins(
// //                                     color: Colors.green[800],
// //                                     fontSize: 12.sp,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                               );
// //                             }).toList(),
// //                       ),
// //                       SizedBox(height: 8.h),
// //                       Text(
// //                         c['reason'],
// //                         style: GoogleFonts.poppins(
// //                           fontSize: 13.sp,
// //                           color: Colors.grey[700],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }

// //             _addMessage("", false, richContent: widgets);
// //           }
// //         }
// //       } else {
// //         _addMessage(
// //           "Error: Unable to get response. Please try again.",
// //           false,
// //           isError: true,
// //           onRetry: () {
// //             _retryLastRequest(text);
// //           },
// //         );
// //       }
// //     } catch (e) {
// //       // Remove loading indicator
// //       setState(() {
// //         _isWaitingForResponse = false;
// //         _messages.removeWhere((msg) => msg.isLoading);
// //       });

// //       _addMessage(
// //         "Error: Connection failed. Please try again.",
// //         false,
// //         isError: true,
// //         onRetry: () {
// //           _retryLastRequest(text);
// //         },
// //       );
// //     }
// //   }

// //   void _retryLastRequest(String text) {
// //     // Remove the error message
// //     setState(() {
// //       _messages.removeWhere((msg) => msg.isError);
// //     });
// //     // Retry the request
// //     _sendToBackend(text);
// //   }

// //   void _handleSubmitted(String text) {
// //     if (text.isEmpty || _isWaitingForResponse) return;
// //     _controller.clear();

// //     _addMessage(text, true);
// //     _sendToBackend(text);
// //   }

// //   void _addMessage(
// //     String text,
// //     bool isUser, {
// //     List<Widget>? richContent,
// //     bool isLoading = false,
// //     bool isError = false,
// //     VoidCallback? onRetry,
// //   }) {
// //     setState(() {
// //       _messages.add(
// //         Message(
// //           text: text,
// //           isUser: isUser,
// //           richContent: richContent,
// //           isLoading: isLoading,
// //           isError: isError,
// //           onRetry: onRetry,
// //         ),
// //       );
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF0F0F0),
// //       body: Column(
// //         children: [_buildAppBar(), _buildChatList(), _buildMessageComposer()],
// //       ),
// //     );
// //   }

// //   Widget _buildAppBar() {
// //     return Container(
// //       padding: EdgeInsets.only(
// //         top: MediaQuery.of(context).padding.top + 10.h,
// //         left: 16.w,
// //         right: 16.w,
// //         bottom: 10.h,
// //       ),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF5A5A8D),
// //         borderRadius: BorderRadius.only(
// //           bottomLeft: Radius.circular(25.r),
// //           bottomRight: Radius.circular(25.r),
// //         ),
// //       ),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
// //             onPressed: () => Navigator.of(context).pop(),
// //           ),
// //           Expanded(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(Icons.android, color: Colors.white, size: 24.sp),
// //                 SizedBox(width: 8.w),
// //                 Text(
// //                   'chatty',
// //                   style: GoogleFonts.poppins(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 22.sp,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(width: 48.w),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildChatList() {
// //     return Expanded(
// //       child: ListView.builder(
// //         // REMOVE THIS LINE: reverse: true,
// //         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
// //         itemCount: _messages.length,
// //         itemBuilder: (context, index) {
// //           final msg = _messages[index];
// //           if (msg.isUser) return _buildUserBubble(msg);

// //           // Handle loading indicator
// //           if (msg.isLoading) return _buildLoadingIndicator();

// //           // Handle error messages
// //           if (msg.isError) return _buildErrorMessage(msg);

// //           // bot messages (text or styled widgets)
// //           return _buildBotMessage(msg);
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildUserBubble(Message msg) {
// //     return Align(
// //       alignment: Alignment.centerRight,
// //       child: Container(
// //         constraints: BoxConstraints(
// //           maxWidth: MediaQuery.of(context).size.width * 0.75,
// //         ),
// //         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
// //         margin: EdgeInsets.symmetric(vertical: 4.h),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF7A7ABB), // لون فقاعة المستخدم
// //           borderRadius: BorderRadius.circular(20.r),
// //         ),
// //         child: Text(
// //           msg.text,
// //           style: GoogleFonts.poppins(color: Colors.white, fontSize: 15.sp),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildBotMessage(Message msg) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(vertical: 6.h),
// //         margin: EdgeInsets.symmetric(vertical: 4.h),
// //         child:
// //             msg.richContent != null
// //                 ? Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: msg.richContent!,
// //                 )
// //                 : Text(
// //                   msg.text,
// //                   style: GoogleFonts.poppins(
// //                     color: Colors.black87,
// //                     fontSize: 15.sp,
// //                   ),
// //                 ),
// //       ),
// //     );
// //   }

// //   Widget _buildLoadingIndicator() {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(vertical: 6.h),
// //         margin: EdgeInsets.symmetric(vertical: 4.h),
// //         child: Row(
// //           children: [
// //             SizedBox(
// //               width: 20.w,
// //               height: 20.h,
// //               child: CircularProgressIndicator(
// //                 strokeWidth: 2.0,
// //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
// //               ),
// //             ),
// //             SizedBox(width: 12.w),
// //             Text(
// //               "Thinking...",
// //               style: GoogleFonts.poppins(
// //                 color: Colors.grey[600],
// //                 fontSize: 15.sp,
// //                 fontStyle: FontStyle.italic,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildErrorMessage(Message msg) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Container(
// //         constraints: BoxConstraints(
// //           maxWidth: MediaQuery.of(context).size.width * 0.75,
// //         ),
// //         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
// //         margin: EdgeInsets.symmetric(vertical: 4.h),
// //         decoration: BoxDecoration(
// //           color: Colors.red[50],
// //           borderRadius: BorderRadius.circular(20.r),
// //           border: Border.all(color: Colors.red[200]!),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               msg.text,
// //               style: GoogleFonts.poppins(
// //                 color: Colors.red[800],
// //                 fontSize: 15.sp,
// //               ),
// //             ),
// //             SizedBox(height: 8.h),
// //             ElevatedButton(
// //               onPressed: msg.onRetry,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.red,
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20.r),
// //                 ),
// //               ),
// //               child: Text(
// //                 "Try Again",
// //                 style: GoogleFonts.poppins(fontSize: 14.sp),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMessageComposer() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 10,
// //             offset: const Offset(0, -5),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Container(
// //               padding: EdgeInsets.symmetric(horizontal: 16.w),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFFE0E0E0),
// //                 borderRadius: BorderRadius.circular(25.r),
// //               ),
// //               child: TextField(
// //                 controller: _controller,
// //                 style: GoogleFonts.poppins(color: Colors.black87),
// //                 decoration: InputDecoration(
// //                   hintText: 'Type a message',
// //                   hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
// //                   border: InputBorder.none,
// //                 ),
// //                 onSubmitted: _handleSubmitted,
// //                 enabled: !_isWaitingForResponse,
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 8.w),
// //           FloatingActionButton(
// //             onPressed:
// //                 _isWaitingForResponse
// //                     ? null
// //                     : () => _handleSubmitted(_controller.text),
// //             backgroundColor:
// //                 _isWaitingForResponse
// //                     ? Colors.grey
// //                     : const Color(0xFF5A5A8D), // لون زر الإرسال

// //             mini: true,
// //             elevation: 0,
// //             child: Icon(Icons.send, color: Colors.white),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart'; // make sure to add url_launcher dependency

// // message model
// class Message {
//   final String text;
//   final bool isUser;
//   final List<Widget>? richContent; // <-- for styled bot responses
//   final bool isLoading; // <-- for loading indicator
//   final bool isError; // <-- for error messages
//   final VoidCallback? onRetry; // <-- for retry functionality

//   Message({
//     required this.text,
//     required this.isUser,
//     this.richContent,
//     this.isLoading = false,
//     this.isError = false,
//     this.onRetry,
//   });
// }

// class ChatbotScreen extends StatefulWidget {
//   const ChatbotScreen({super.key});

//   @override
//   State<ChatbotScreen> createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Message> _messages = [];
//   bool _isWaitingForResponse = false;

//   @override
//   void initState() {
//     super.initState();
//     // Add welcome message when the chat starts
//     _addWelcomeMessage();
//   }

//   void _addWelcomeMessage() {
//     setState(() {
//       _messages.add(
//         Message(
//           text:
//               "Hello! I'm here to help you find companies that can support your startup idea. "
//               "Tell me about your project or what kind of help you're looking for.",
//           isUser: false,
//         ),
//       );
//     });
//   }

//   Future<void> _sendToBackend(String text) async {
//     setState(() {
//       _isWaitingForResponse = true;
//       // Add loading indicator message
//       _messages.add(Message(text: "", isUser: false, isLoading: true));
//     });

//     try {
//       final url = Uri.parse(
//         "http://172.30.1.98:8000/chatbot/suggest_companies/",
//       );

//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"prompt": text}),
//       );

//       // Remove loading indicator
//       setState(() {
//         _isWaitingForResponse = false;
//         _messages.removeWhere((msg) => msg.isLoading);
//       });

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         final botMessage = data["message"] ?? "Here are some results:";
//         _addMessage(botMessage, false);

//         final types = data["types"] as List<dynamic>;
//         for (var t in types) {
//           String typeName = t["type"];
//           List companies = t["companies"];

//           if (companies.isNotEmpty) {
//             List<Widget> widgets = [];

//             widgets.add(
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.h),
//                 child: Text(
//                   typeName,
//                   style: GoogleFonts.poppins(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               ),
//             );

//             for (var c in companies) {
//               widgets.add(
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 12.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Company name
//                       Text(
//                         c['name'],
//                         style: GoogleFonts.poppins(
//                           fontSize: 16.sp, // smaller to fit card better
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 6.h),

//                       // Fields as chips
//                       Wrap(
//                         spacing: 6.w,
//                         runSpacing: 6.h,
//                         children:
//                             (c['fields'] as List).map<Widget>((field) {
//                               return Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10.w,
//                                   vertical: 4.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green[100],
//                                   borderRadius: BorderRadius.circular(20.r),
//                                 ),
//                                 child: Text(
//                                   field,
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.green[800],
//                                     fontSize: 11.sp, // smaller
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                       SizedBox(height: 8.h),

//                       // Reason text
//                       Text(
//                         c['reason'],
//                         style: GoogleFonts.poppins(
//                           fontSize: 12.sp, // smaller
//                           color: Colors.grey[700],
//                           height: 1.4, // more vertical spacing
//                         ),
//                       ),
//                       SizedBox(height: 8.h),

//                       // Contact card
//                       Card(
//                         elevation: 1,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(8.w),
//                           child: Row(
//                             children: [
//                               // Company logo (larger)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 child:
//                                     c['logoImageUrl'] != null
//                                         ? Image.network(
//                                           c['logoImageUrl'],
//                                           width: 80.w,
//                                           height: 80.w,
//                                           fit: BoxFit.contain,
//                                           loadingBuilder: (
//                                             context,
//                                             child,
//                                             loadingProgress,
//                                           ) {
//                                             if (loadingProgress == null)
//                                               return child;
//                                             return Container(
//                                               width: 80.w,
//                                               height: 80.w,
//                                               color: Colors.grey[200],
//                                               child: Center(
//                                                 child: CircularProgressIndicator(
//                                                   value:
//                                                       loadingProgress
//                                                                   .expectedTotalBytes !=
//                                                               null
//                                                           ? loadingProgress
//                                                                   .cumulativeBytesLoaded /
//                                                               (loadingProgress
//                                                                       .expectedTotalBytes ??
//                                                                   1)
//                                                           : null,
//                                                   strokeWidth: 2.0,
//                                                   valueColor:
//                                                       AlwaysStoppedAnimation<
//                                                         Color
//                                                       >(Colors.grey[600]!),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           errorBuilder: (
//                                             context,
//                                             error,
//                                             stackTrace,
//                                           ) {
//                                             return Container(
//                                               width: 80.w,
//                                               height: 80.w,
//                                               color: Colors.grey[300],
//                                               child: Icon(
//                                                 Icons.business,
//                                                 size: 28.sp,
//                                                 color: Colors.grey[600],
//                                               ),
//                                             );
//                                           },
//                                         )
//                                         : Container(
//                                           width: 80.w,
//                                           height: 80.w,
//                                           color: Colors.grey[300],
//                                           child: Icon(
//                                             Icons.business,
//                                             size: 28.sp,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                               ),

//                               SizedBox(width: 12.w),

//                               // Contact info with clickable links
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if (c['phone'] != null &&
//                                         c['phone'].toString().isNotEmpty)
//                                       Text(
//                                         "📞 ${c['phone']}",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 11.sp,
//                                           height: 1.5,
//                                         ),
//                                       ),
//                                     if (c['email'] != null &&
//                                         c['email'].toString().isNotEmpty)
//                                       InkWell(
//                                         onTap:
//                                             () => launchUrl(
//                                               Uri.parse("mailto:${c['email']}"),
//                                             ),
//                                         child: Text(
//                                           "✉️ ${c['email']}",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 11.sp,
//                                             color: Colors.blue,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ),
//                                     if (c['facebookUrl'] != null &&
//                                         c['facebookUrl'].toString().isNotEmpty)
//                                       InkWell(
//                                         onTap:
//                                             () => launchUrl(
//                                               Uri.parse(c['facebookUrl']),
//                                             ),
//                                         child: Text(
//                                           "📘 Facebook",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 11.sp,
//                                             color: Colors.blue,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ),
//                                     if (c['instagramUrl'] != null &&
//                                         c['instagramUrl'].toString().isNotEmpty)
//                                       InkWell(
//                                         onTap:
//                                             () => launchUrl(
//                                               Uri.parse(c['instagramUrl']),
//                                             ),
//                                         child: Text(
//                                           "📸 Instagram",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 11.sp,
//                                             color: Colors.blue,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ),
//                                     if (c['websiteUrl'] != null &&
//                                         c['websiteUrl'].toString().isNotEmpty)
//                                       InkWell(
//                                         onTap:
//                                             () => launchUrl(
//                                               Uri.parse(
//                                                 c['websiteUrl'].startsWith(
//                                                       "http",
//                                                     )
//                                                     ? c['websiteUrl']
//                                                     : "https://${c['websiteUrl']}",
//                                               ),
//                                             ),
//                                         child: Text(
//                                           "🌐 Website",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 11.sp,
//                                             color: Colors.blue,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             _addMessage("", false, richContent: widgets);
//           }
//         }
//       } else {
//         _addMessage(
//           "Error: Unable to get response. Please try again.",
//           false,
//           isError: true,
//           onRetry: () {
//             _retryLastRequest(text);
//           },
//         );
//       }
//     } catch (e) {
//       // Remove loading indicator
//       setState(() {
//         _isWaitingForResponse = false;
//         _messages.removeWhere((msg) => msg.isLoading);
//       });

//       _addMessage(
//         "Error: Connection failed. Please try again.",
//         false,
//         isError: true,
//         onRetry: () {
//           _retryLastRequest(text);
//         },
//       );
//     }
//   }

//   void _retryLastRequest(String text) {
//     // Remove the error message
//     setState(() {
//       _messages.removeWhere((msg) => msg.isError);
//     });
//     // Retry the request
//     _sendToBackend(text);
//   }

//   void _handleSubmitted(String text) {
//     if (text.isEmpty || _isWaitingForResponse) return;
//     _controller.clear();

//     _addMessage(text, true);
//     _sendToBackend(text);
//   }

//   void _addMessage(
//     String text,
//     bool isUser, {
//     List<Widget>? richContent,
//     bool isLoading = false,
//     bool isError = false,
//     VoidCallback? onRetry,
//   }) {
//     setState(() {
//       _messages.add(
//         Message(
//           text: text,
//           isUser: isUser,
//           richContent: richContent,
//           isLoading: isLoading,
//           isError: isError,
//           onRetry: onRetry,
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F0F0),
//       body: Column(
//         children: [_buildAppBar(), _buildChatList(), _buildMessageComposer()],
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Container(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top + 10.h,
//         left: 16.w,
//         right: 16.w,
//         bottom: 10.h,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xFF5A5A8D),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(25.r),
//           bottomRight: Radius.circular(25.r),
//         ),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.android, color: Colors.white, size: 24.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'chatty',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 48.w),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatList() {
//     return Expanded(
//       child: ListView.builder(
//         // REMOVE THIS LINE: reverse: true,
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         itemCount: _messages.length,
//         itemBuilder: (context, index) {
//           final msg = _messages[index];
//           if (msg.isUser) return _buildUserBubble(msg);

//           // Handle loading indicator
//           if (msg.isLoading) return _buildLoadingIndicator();

//           // Handle error messages
//           if (msg.isError) return _buildErrorMessage(msg);

//           // bot messages (text or styled widgets)
//           return _buildBotMessage(msg);
//         },
//       ),
//     );
//   }

//   Widget _buildUserBubble(Message msg) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         decoration: BoxDecoration(
//           color: const Color(0xFF7A7ABB),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Text(
//           msg.text,
//           style: GoogleFonts.poppins(color: Colors.white, fontSize: 15.sp),
//         ),
//       ),
//     );
//   }

//   Widget _buildBotMessage(Message msg) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 6.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         child:
//             msg.richContent != null
//                 ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: msg.richContent!,
//                 )
//                 : Text(
//                   msg.text,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black87,
//                     fontSize: 15.sp,
//                   ),
//                 ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 6.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 20.w,
//               height: 20.h,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2.0,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Text(
//               "Thinking...",
//               style: GoogleFonts.poppins(
//                 color: Colors.grey[600],
//                 fontSize: 15.sp,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorMessage(Message msg) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         decoration: BoxDecoration(
//           color: Colors.red[50],
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(color: Colors.red[200]!),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               msg.text,
//               style: GoogleFonts.poppins(
//                 color: Colors.red[800],
//                 fontSize: 15.sp,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             ElevatedButton(
//               onPressed: msg.onRetry,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//               ),
//               child: Text(
//                 "Try Again",
//                 style: GoogleFonts.poppins(fontSize: 14.sp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE0E0E0),
//                 borderRadius: BorderRadius.circular(25.r),
//               ),
//               child: TextField(
//                 controller: _controller,
//                 style: GoogleFonts.poppins(color: Colors.black87),
//                 decoration: InputDecoration(
//                   hintText: 'Type a message',
//                   hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
//                   border: InputBorder.none,
//                 ),
//                 onSubmitted: _handleSubmitted,
//                 enabled: !_isWaitingForResponse,
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           FloatingActionButton(
//             onPressed:
//                 _isWaitingForResponse
//                     ? null
//                     : () => _handleSubmitted(_controller.text),
//             backgroundColor:
//                 _isWaitingForResponse ? Colors.grey : const Color(0xFF5A5A8D),
//             mini: true,
//             elevation: 0,
//             child: Icon(Icons.send, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;

// /// نفس ألوان الـ Welcome
// const Color waveBlue = Color(0xFF2F5ED7);
// const Color ctaOrange = Color(0xFFFF6B3D);

// // message model
// class Message {
//   final String text;
//   final bool isUser;
//   final List<Widget>? richContent;
//   final bool isLoading;
//   final bool isError;
//   final VoidCallback? onRetry;

//   Message({
//     required this.text,
//     required this.isUser,
//     this.richContent,
//     this.isLoading = false,
//     this.isError = false,
//     this.onRetry,
//   });
// }

// class ChatbotScreen extends StatefulWidget {
//   const ChatbotScreen({super.key, this.onBackRequested});

//   /// يناديها MainScreen لما تضغط رجوع ومفيش روتس تتPop جوه تبويب الشات
//   final VoidCallback? onBackRequested;

//   @override
//   State<ChatbotScreen> createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Message> _messages = [];
//   bool _isWaitingForResponse = false;

//   @override
//   void initState() {
//     super.initState();
//     _addWelcomeMessage();
//   }

//   void _addWelcomeMessage() {
//     setState(() {
//       _messages.add(
//         Message(
//           text:
//               "Hello! I'm here to help you find companies that can support your startup idea.\n"
//               "Tell me about your project or what kind of help you're looking for.",
//           isUser: false,
//         ),
//       );
//     });
//   }

//   Future<void> _sendToBackend(String text) async {
//     setState(() {
//       _isWaitingForResponse = true;
//       _messages.add(Message(text: "", isUser: false, isLoading: true));
//     });

//     try {
//       final url = Uri.parse(
//         "http://41.33.191.235:8000/chatbot/suggest_companies/",
//       );
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"prompt": text}),
//       );

//       setState(() {
//         _isWaitingForResponse = false;
//         _messages.removeWhere((m) => m.isLoading);
//       });

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final botMessage = data["message"] ?? "Here are some results:";
//         _addMessage(botMessage, false);

//         final types = (data["types"] as List<dynamic>? ?? []);
//         for (var t in types) {
//           String typeName = t["type"];
//           List companies = t["companies"] ?? [];

//           if (companies.isNotEmpty) {
//             List<Widget> widgets = [];

//             // عنوان النوع بلون waveBlue
//             widgets.add(
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.h),
//                 child: Text(
//                   typeName,
//                   style: GoogleFonts.cairo(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w800,
//                     color: waveBlue,
//                   ),
//                 ),
//               ),
//             );

//             for (var c in companies) {
//               widgets.add(
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 12.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // اسم الشركة
//                       Text(
//                         '${c['name']}',
//                         style: GoogleFonts.cairo(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 6.h),

//                       // حقول كـ Chips خفيفة
//                       Wrap(
//                         spacing: 6.w,
//                         runSpacing: 6.h,
//                         children:
//                             (c['fields'] as List? ?? []).map<Widget>((field) {
//                               return Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10.w,
//                                   vertical: 4.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: waveBlue.withOpacity(.10),
//                                   borderRadius: BorderRadius.circular(20.r),
//                                   border: Border.all(
//                                     color: waveBlue.withOpacity(.25),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   '$field',
//                                   style: GoogleFonts.cairo(
//                                     color: waveBlue,
//                                     fontSize: 11.sp,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                       SizedBox(height: 8.h),

//                       // السبب/الوصف
//                       Text(
//                         '${c['reason'] ?? ''}',
//                         style: GoogleFonts.cairo(
//                           fontSize: 12.sp,
//                           color: Colors.grey[700],
//                           height: 1.4,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),

//                       // كارت تواصل
//                       Card(
//                         elevation: 1,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(10.w),
//                           child: Row(
//                             children: [
//                               // اللوجو
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 child:
//                                     c['logoImageUrl'] != null
//                                         ? Image.network(
//                                           '${c['logoImageUrl']}',
//                                           width: 72.w,
//                                           height: 72.w,
//                                           fit: BoxFit.contain,
//                                           errorBuilder:
//                                               (_, __, ___) => _logoFallback(),
//                                         )
//                                         : _logoFallback(),
//                               ),
//                               SizedBox(width: 12.w),

//                               // بيانات تواصل (الروابط بلون waveBlue)
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if ((c['phone'] ?? '')
//                                         .toString()
//                                         .isNotEmpty)
//                                       Text(
//                                         '📞 ${c['phone']}',
//                                         style: GoogleFonts.cairo(
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                     if ((c['email'] ?? '')
//                                         .toString()
//                                         .isNotEmpty)
//                                       _linkText(
//                                         '✉️ ${c['email']}',
//                                         'mailto:${c['email']}',
//                                       ),
//                                     if ((c['facebookUrl'] ?? '')
//                                         .toString()
//                                         .isNotEmpty)
//                                       _linkText(
//                                         '📘 Facebook',
//                                         '${c['facebookUrl']}',
//                                       ),
//                                     if ((c['instagramUrl'] ?? '')
//                                         .toString()
//                                         .isNotEmpty)
//                                       _linkText(
//                                         '📸 Instagram',
//                                         '${c['instagramUrl']}',
//                                       ),
//                                     if ((c['websiteUrl'] ?? '')
//                                         .toString()
//                                         .isNotEmpty)
//                                       _linkText(
//                                         '🌐 Website',
//                                         (_ensureHttp('${c['websiteUrl']}')),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             _addMessage("", false, richContent: widgets);
//           }
//         }
//       } else {
//         _addMessage(
//           "Error: Unable to get response. Please try again.",
//           false,
//           isError: true,
//           onRetry: () => _retryLastRequest(text),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isWaitingForResponse = false;
//         _messages.removeWhere((m) => m.isLoading);
//       });
//       _addMessage(
//         "Error: Connection failed. Please try again.",
//         false,
//         isError: true,
//         onRetry: () => _retryLastRequest(text),
//       );
//     }
//   }

//   String _ensureHttp(String url) {
//     final u = url.trim();
//     if (u.startsWith('http://') || u.startsWith('https://')) return u;
//     return 'https://$u';
//   }

//   void _retryLastRequest(String text) {
//     setState(() {
//       _messages.removeWhere((msg) => msg.isError);
//     });
//     _sendToBackend(text);
//   }

//   void _addMessage(
//     String text,
//     bool isUser, {
//     List<Widget>? richContent,
//     bool isLoading = false,
//     bool isError = false,
//     VoidCallback? onRetry,
//   }) {
//     setState(() {
//       _messages.add(
//         Message(
//           text: text,
//           isUser: isUser,
//           richContent: richContent,
//           isLoading: isLoading,
//           isError: isError,
//           onRetry: onRetry,
//         ),
//       );
//     });
//   }

//   void _handleSubmitted(String text) {
//     if (text.isEmpty || _isWaitingForResponse) return;
//     _controller.clear();
//     _addMessage(text, true);
//     _sendToBackend(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // دمج لوجك الرجوع: لو مفيش صفحات داخل تبويب الشات ننادي onBackRequested
//     return WillPopScope(
//       onWillPop: () async {
//         final nav = Navigator.of(context);
//         if (nav.canPop()) {
//           // فيه صفحات داخل تبويب الشات → pop عادي
//           return true;
//         }
//         // مفيش صفحات جوّه الشات → ارجع للتبويب السابق عبر MainScreen
//         widget.onBackRequested?.call();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF7F9FF),
//         body: Column(
//           children: [_buildAppBar(), _buildChatList(), _buildMessageComposer()],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Container(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top + 10.h,
//         left: 16.w,
//         right: 16.w,
//         bottom: 10.h,
//       ),
//       decoration: BoxDecoration(
//         color: waveBlue,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(18.r),
//           bottomRight: Radius.circular(18.r),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: waveBlue.withOpacity(.25),
//             blurRadius: 14,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//             onPressed: () {
//               final nav = Navigator.of(context);
//               if (nav.canPop()) {
//                 nav.pop();
//               } else {
//                 // رجوع للتبويب السابق (أو الهوم) عبر MainScreen
//                 widget.onBackRequested?.call();
//               }
//             },
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.android, color: Colors.white, size: 22.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'chatty',
//                   style: GoogleFonts.cairo(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 20.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 48.w),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatList() {
//     return Expanded(
//       child: ListView.builder(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         itemCount: _messages.length,
//         itemBuilder: (context, index) {
//           final msg = _messages[index];
//           if (msg.isUser) return _buildUserBubble(msg);
//           if (msg.isLoading) return _buildLoadingIndicator();
//           if (msg.isError) return _buildErrorMessage(msg);
//           return _buildBotMessage(msg);
//         },
//       ),
//     );
//   }

//   Widget _buildUserBubble(Message msg) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         decoration: BoxDecoration(
//           color: waveBlue,
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: waveBlue.withOpacity(.25),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Text(
//           msg.text,
//           style: GoogleFonts.cairo(color: Colors.white, fontSize: 15.sp),
//         ),
//       ),
//     );
//   }

//   Widget _buildBotMessage(Message msg) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 6.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         child:
//             msg.richContent != null
//                 ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: msg.richContent!,
//                 )
//                 : Text(
//                   msg.text,
//                   style: GoogleFonts.cairo(
//                     color: Colors.black87,
//                     fontSize: 15.sp,
//                   ),
//                 ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 6.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 20.w,
//               height: 20.h,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2.0,
//                 valueColor: AlwaysStoppedAnimation<Color>(waveBlue),
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Text(
//               "Thinking...",
//               style: GoogleFonts.cairo(
//                 color: Colors.grey[700],
//                 fontSize: 15.sp,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorMessage(Message msg) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFF2F2),
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(color: const Color(0xFFFFC9C9)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               msg.text,
//               style: GoogleFonts.cairo(
//                 color: const Color(0xFFB00020),
//                 fontSize: 15.sp,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             ElevatedButton(
//               onPressed: msg.onRetry,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ctaOrange,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//               ),
//               child: Text(
//                 "Try Again",
//                 style: GoogleFonts.cairo(fontSize: 14.sp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25.r),
//                 border: Border.all(color: waveBlue.withOpacity(.25)),
//               ),
//               child: TextField(
//                 controller: _controller,
//                 style: GoogleFonts.cairo(color: Colors.black87),
//                 decoration: InputDecoration(
//                   hintText: 'Type a message',
//                   hintStyle: GoogleFonts.cairo(color: Colors.grey[600]),
//                   border: InputBorder.none,
//                 ),
//                 onSubmitted: _handleSubmitted,
//                 enabled: !_isWaitingForResponse,
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           FloatingActionButton(
//             onPressed:
//                 _isWaitingForResponse
//                     ? null
//                     : () => _handleSubmitted(_controller.text),
//             backgroundColor: _isWaitingForResponse ? Colors.grey : ctaOrange,
//             mini: true,
//             elevation: 2,
//             child: const Icon(Icons.send, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _logoFallback() => Container(
//     width: 72.w,
//     height: 72.w,
//     color: Colors.grey[200],
//     child: Icon(Icons.business, size: 26.sp, color: Colors.grey[600]),
//   );

//   Widget _linkText(String label, String url) {
//     return InkWell(
//       onTap:
//           () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
//       child: Text(
//         label,
//         style: GoogleFonts.cairo(
//           fontSize: 12.sp,
//           color: waveBlue,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ========= Message Model =========
class Message {
  final String text;
  final bool isUser;
  final List<Widget>? richContent; // for styled bot responses
  final bool isLoading; // loading indicator
  final bool isError; // error messages
  final VoidCallback? onRetry; // retry

  Message({
    required this.text,
    required this.isUser,
    this.richContent,
    this.isLoading = false,
    this.isError = false,
    this.onRetry,
  });
}

// ========= Chatbot Screen =========
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key, this.onBackRequested});

  /// يناديها MainScreen لو ضغطت رجوع ومفيش Routes جوه تبويب الشات
  final VoidCallback? onBackRequested;

  @override
  ChatbotScreenState createState() => ChatbotScreenState();
}

class ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isWaitingForResponse = false;

  // ★ للتحكم في سكرول الرسائل + فوكس الإدخال (يخدم أيقونة الشات بالـ BottomBar)
  final ScrollController _listController = ScrollController();
  final FocusNode _inputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  // ★ API عامة: يناديها Main عند الضغط على أيقونة الشات
  void focusInputAndScrollToEnd() {
    _inputFocus.requestFocus();
    _scrollToEndSoon();
  }

  // ★ سكرول لآخر القائمة بعد الإطار الحالي
  void _scrollToEndSoon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listController.hasClients) {
        _listController.animateTo(
          _listController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(
        Message(
          text:
              "Hello! I'm here to help you find companies that can support your startup idea. "
              "Tell me about your project or what kind of help you're looking for.",
          isUser: false,
        ),
      );
    });
    _scrollToEndSoon();
  }

  Future<void> _sendToBackend(String text) async {
    setState(() {
      _isWaitingForResponse = true;
      _messages.add(Message(text: "", isUser: false, isLoading: true));
    });
    _scrollToEndSoon();

    try {
      final url = Uri.parse(
        "http://41.33.191.235:8000/chatbot/suggest_companies/",
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": text}),
      );

      setState(() {
        _isWaitingForResponse = false;
        _messages.removeWhere((msg) => msg.isLoading);
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final botMessage = data["message"] ?? "Here are some results:";
        _addMessage(botMessage, false);

        final types = (data["types"] as List<dynamic>? ?? []);
        for (var t in types) {
          final String typeName = t["type"];
          final List companies = t["companies"] ?? [];

          if (companies.isNotEmpty) {
            final List<Widget> widgets = [];

            // عنوان النوع
            widgets.add(
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  typeName,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6B4EF6),
                  ),
                ),
              ),
            );

            for (var c in companies) {
              widgets.add(
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم الشركة
                      Text(
                        '${c['name']}',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      // الحقول كـ Chips
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children:
                            (c['fields'] as List? ?? []).map<Widget>((field) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '$field',
                                  style: GoogleFonts.poppins(
                                    color: Colors.green[800],
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 8.h),

                      // سبب/وصف
                      Text(
                        '${c['reason'] ?? ''}',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // كارت التواصل
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              // اللوجو
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child:
                                    (c['logoImageUrl'] != null &&
                                            '${c['logoImageUrl']}'.isNotEmpty)
                                        ? Image.network(
                                          '${c['logoImageUrl']}',
                                          width: 80.w,
                                          height: 80.w,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              width: 80.w,
                                              height: 80.w,
                                              color: Colors.grey[200],
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                  strokeWidth: 2.0,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.grey[600]!),
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (_, __, ___) => _logoFallback(),
                                        )
                                        : _logoFallback(),
                              ),
                              SizedBox(width: 12.w),

                              // بيانات التواصل (روابط أيقونية)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((c['phone'] ?? '')
                                        .toString()
                                        .isNotEmpty)
                                      Text(
                                        "📞 ${c['phone']}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          height: 1.5,
                                        ),
                                      ),
                                    if ((c['email'] ?? '')
                                        .toString()
                                        .isNotEmpty)
                                      InkWell(
                                        onTap:
                                            () => launchUrl(
                                              Uri.parse("mailto:${c['email']}"),
                                            ),
                                        child: Text(
                                          "✉️ ${c['email']}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.sp,
                                            color: Colors.blue,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        if ((c['facebookUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.facebook,
                                              color: Colors.blue,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(c['facebookUrl']),
                                                ),
                                          ),
                                        if ((c['instagramUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.purple,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(c['instagramUrl']),
                                                ),
                                          ),
                                        if ((c['linkedinUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.linkedin,
                                              color: Colors.blueAccent,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(c['linkedinUrl']),
                                                ),
                                          ),
                                        if ((c['tiktokUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.tiktok,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(c['tiktokUrl']),
                                                ),
                                          ),
                                        if ((c['youtubeUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.youtube,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(c['youtubeUrl']),
                                                ),
                                          ),
                                        if ((c['websiteUrl'] ?? '')
                                            .toString()
                                            .isNotEmpty)
                                          IconButton(
                                            icon: const FaIcon(
                                              FontAwesomeIcons.globe,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                            onPressed:
                                                () => launchUrl(
                                                  Uri.parse(
                                                    _ensureHttp(
                                                      '${c['websiteUrl']}',
                                                    ),
                                                  ),
                                                ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            _addMessage("", false, richContent: widgets);
          }
        }
      } else {
        _addMessage(
          "Error: Unable to get response. Please try again.",
          false,
          isError: true,
          onRetry: () => _retryLastRequest(text),
        );
      }
    } catch (e) {
      setState(() {
        _isWaitingForResponse = false;
        _messages.removeWhere((msg) => msg.isLoading);
      });
      _addMessage(
        "Error: Connection failed. Please try again.",
        false,
        isError: true,
        onRetry: () => _retryLastRequest(text),
      );
    }

    _scrollToEndSoon();
  }

  void _retryLastRequest(String text) {
    setState(() {
      _messages.removeWhere((msg) => msg.isError);
    });
    _sendToBackend(text);
  }

  String _ensureHttp(String url) {
    final u = url.trim();
    if (u.startsWith('http://') || u.startsWith('https://')) return u;
    return 'https://$u';
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty || _isWaitingForResponse) return;
    _controller.clear();
    _addMessage(text, true);
    _sendToBackend(text);
  }

  void _addMessage(
    String text,
    bool isUser, {
    List<Widget>? richContent,
    bool isLoading = false,
    bool isError = false,
    VoidCallback? onRetry,
  }) {
    setState(() {
      _messages.add(
        Message(
          text: text,
          isUser: isUser,
          richContent: richContent,
          isLoading: isLoading,
          isError: isError,
          onRetry: onRetry,
        ),
      );
    });
    _scrollToEndSoon();
  }

  @override
  Widget build(BuildContext context) {
    // رجوع الهاردوير: لو مفيش Routes داخل تبويب الشات، نرجّع للتبويب السابق عبر MainScreen
    return WillPopScope(
      onWillPop: () async {
        final nav = Navigator.of(context);
        if (nav.canPop()) return true;
        widget.onBackRequested?.call();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
        body: Column(
          children: [_buildAppBar(), _buildChatList(), _buildMessageComposer()],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        left: 16.w,
        right: 16.w,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4EF6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4EF6).withOpacity(.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              final nav = Navigator.of(context);
              if (nav.canPop()) {
                nav.pop();
              } else {
                widget.onBackRequested?.call();
              }
            },
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android, color: Colors.white, size: 24.sp),
                SizedBox(width: 8.w),
                Text(
                  'chatty',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: ListView.builder(
        controller: _listController, // ★ سكرول كنترولر
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final msg = _messages[index];
          if (msg.isUser) return _buildUserBubble(msg);
          if (msg.isLoading) return _buildLoadingIndicator();
          if (msg.isError) return _buildErrorMessage(msg);
          return _buildBotMessage(msg);
        },
      ),
    );
  }

  Widget _buildUserBubble(Message msg) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: const Color(0xFF6B4EF6),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          msg.text,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15.sp),
        ),
      ),
    );
  }

  Widget _buildBotMessage(Message msg) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child:
            msg.richContent != null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: msg.richContent!,
                )
                : Text(
                  msg.text,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 15.sp,
                  ),
                ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(strokeWidth: 2.0),
            ),
            SizedBox(width: 12.w),
            Text(
              "Thinking...",
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 15.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(Message msg) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: GoogleFonts.poppins(
                color: Colors.red[800],
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: msg.onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                "Try Again",
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _inputFocus, // ★ فوكس الإدخال
                style: GoogleFonts.poppins(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                  border: InputBorder.none,
                ),
                onSubmitted: _handleSubmitted,
                enabled: !_isWaitingForResponse,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          FloatingActionButton(
            onPressed:
                _isWaitingForResponse
                    ? null
                    : () => _handleSubmitted(_controller.text),
            backgroundColor:
                _isWaitingForResponse ? Colors.grey : const Color(0xFF6B4EF6),
            mini: true,
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _logoFallback() => Container(
    width: 80.w,
    height: 80.w,
    color: Colors.grey[300],
    child: Icon(Icons.business, size: 28.sp, color: Colors.grey[600]),
  );

  @override
  void dispose() {
    _listController.dispose();
    _inputFocus.dispose();
    _controller.dispose();
    super.dispose();
  }
}

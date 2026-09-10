import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/views/pages/match_page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});
  @override State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override Widget build(BuildContext context) {
    final dark = isDarkMode.value;
    final accentColor = const Color(0xFF9A0002);
    final users = AppDummyDataService.getAllUsers().where((u) => u.id != AppDummyDataService.currentUser.id).toList();

    return Scaffold(
      backgroundColor: dark ? Color(0xFF121212) : Colors.white,
      body: Column(children: [
        Container(padding: EdgeInsets.fromLTRB(16, 56, 16, 12), color: accentColor, child: Row(children: [Text('Messages', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))])),
        Expanded(child: ListView.builder(padding: EdgeInsets.zero, itemCount: users.length, itemBuilder: (ctx, i) { final u = users[i]; return ListTile(leading: CircleAvatar(radius: 28, backgroundColor: accentColor, child: Text(u.username[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), title: Text(u.fullName, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), subtitle: Text('@', style: GoogleFonts.poppins(fontSize: 12, color: dark ? Colors.white : Colors.grey)), trailing: Icon(Icons.arrow_forward_ios, size: 16, color: dark ? Colors.white38 : Colors.black26), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailPage()))); })),
      ]),
    );
  }
}

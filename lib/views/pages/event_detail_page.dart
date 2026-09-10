import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/models/app_models.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetailPage> {
  bool _joined = false;

  String _fmtDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    final accentColor = const Color(0xFF9A0002);
    final textPrimary = isDarkMode.value ? Colors.white : Colors.black;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: accentColor,
                child: Center(
                  child: Icon(
                    Icons.sports_soccer,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.location_on, e.place),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.event,
                    '${_fmtDate(e.dateTime)} - '
                    '${e.dateTime.hour.toString().padLeft(2, '0')}:'
                    '${e.dateTime.minute.toString().padLeft(2, '0')}',
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    Icons.people,
                    '${e.participants.length}/${e.maxPlayers} joined',
                  ),
                  if (e.remainingSlots > 0 && e.remainingSlots <= 2) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Only ${e.remainingSlots} slot left!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Organizer',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode.value
                          ? const Color(0xFF1E1E1E)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: accentColor,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.organizerUsername,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Organizer',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Participants',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  ...e.participants.map((pid) {
                    final u = AppDummyDataService.getUserById(pid);
                    if (u == null) return Container();
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDarkMode.value
                            ? const Color(0xFF1E1E1E)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              u.username[0],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  u.fullName,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '@${u.username}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _joined
          ? FloatingActionButton.extended(
              onPressed: null,
              backgroundColor: accentColor,
              icon: Icon(Icons.check_circle, color: Colors.white),
              label: Text('Joined'),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                setState(() => _joined = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Joined the event!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              backgroundColor: accentColor,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Join Event'),
            ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color.fromARGB(1000, 154, 0, 2)),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 14))),
      ],
    );
  }
}
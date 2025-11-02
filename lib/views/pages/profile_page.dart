import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final SupabaseClient _supabase = Supabase.instance.client;

  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final user = _authService.getCurrentUser();
      if (user == null) {
        throw Exception('No user logged in');
      }

      // Fetch profile data from database
      final response = await _supabase
          .from('profile')
          .select('*')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) {
        throw Exception('Profile not found');
      }

      setState(() {
        _profileData = response;
        _isLoading = false;
      });

      print('Profile data loaded: $_profileData');
    } catch (e) {
      print('Error loading profile: $e');
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor:
              dark ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: dark ? Colors.white : const Color(0xFF9A0002),
                  ),
                )
              : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              _errorMessage!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: dark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _loadProfileData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark
                                  ? Colors.white
                                  : const Color(0xFF9A0002),
                              foregroundColor: dark ? Colors.black : Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadProfileData,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              // Profile Picture
                              ClipOval(
                                child: _profileData?['pp_url'] != null
                                    ? Image.network(
                                        _profileData!['pp_url'],
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return _buildDefaultAvatar(dark);
                                        },
                                      )
                                    : _buildDefaultAvatar(dark),
                              ),
                              const SizedBox(height: 24),

                              // Username
                              Text(
                                _profileData?['username'] ?? 'No username',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Full Name
                              Text(
                                _profileData?['full_name'] ?? 'No name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: dark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Profile Information Cards
                              _buildInfoCard(
                                dark,
                                Icons.cake_outlined,
                                'Age',
                                '${_profileData?['age'] ?? 'N/A'} years',
                              ),
                              _buildInfoCard(
                                dark,
                                Icons.height_outlined,
                                'Height',
                                '${_profileData?['height'] ?? 'N/A'} cm',
                              ),
                              if (_profileData?['weight'] != null)
                                _buildInfoCard(
                                  dark,
                                  Icons.monitor_weight_outlined,
                                  'Weight',
                                  '${_profileData!['weight']} kg',
                                ),
                              if (_profileData?['gender'] != null)
                                _buildInfoCard(
                                  dark,
                                  Icons.person_outline,
                                  'Gender',
                                  _profileData!['gender'].toString(),
                                ),
                              if (_profileData?['domisili'] != null)
                                _buildInfoCard(
                                  dark,
                                  Icons.location_on_outlined,
                                  'Location',
                                  _profileData!['domisili'].toString(),
                                ),
                              _buildInfoCard(
                                dark,
                                Icons.sports_soccer_outlined,
                                'Role',
                                _profileData?['role']?.toString() ?? 'N/A',
                              ),
                              _buildInfoCard(
                                dark,
                                Icons.star_outline,
                                'Level',
                                _profileData?['level']?.toString() ?? 'N/A',
                              ),
                              if (_profileData?['date_of_birth'] != null)
                                _buildInfoCard(
                                  dark,
                                  Icons.calendar_today_outlined,
                                  'Date of Birth',
                                  _formatDate(_profileData!['date_of_birth']),
                                ),
                              if (_profileData?['bio'] != null)
                                _buildInfoCard(
                                  dark,
                                  Icons.info_outline,
                                  'Bio',
                                  _profileData!['bio'].toString(),
                                  isMultiline: true,
                                ),

                              const SizedBox(height: 32),

                              // Edit Profile Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // TODO: Navigate to edit profile page
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Edit profile feature coming soon!'),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Edit Profile'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: dark
                                        ? const Color.fromARGB(255, 239, 230, 222)
                                        : const Color(0xFF9A0002),
                                    foregroundColor: dark ? Colors.black : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Logout Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Logout'),
                                        content: const Text('Are you sure you want to logout?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text('Logout'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm == true && mounted) {
                                      await _authService.signOutGoogle();
                                      if (mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/',
                                          (route) => false,
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.logout),
                                  label: const Text('Logout'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget _buildDefaultAvatar(bool dark) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: dark ? Colors.grey[800] : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: 80,
        color: dark ? Colors.white54 : Colors.black54,
      ),
    );
  }

  Widget _buildInfoCard(bool dark, IconData icon, String label, String value,
      {bool isMultiline = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: dark
                ? const Color.fromARGB(255, 239, 230, 222)
                : const Color(0xFF9A0002),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: dark ? Colors.white60 : Colors.black45,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}

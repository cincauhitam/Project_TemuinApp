import '../models/app_models.dart';
import 'package:flutter/material.dart';

class AppDummyDataService {
  // ============================================================================
  // Mock Users Database (matches Supabase profile schema)
  // ============================================================================
  
  static final List<UserModel> _mockUsers = [
    UserModel(
      id: 'demo-uuid-001',
      username: 'futsal_demo',
      fullName: 'Ahmad Pratama',
      age: 25,
      height: 175,
      weight: 70,
      role: {'primary_role': 'flank'},
      level: 'amateur',
      ppUrl: null,
      domisili: 'Jakarta Selatan',
      interests: ['futsal', 'basketball'],
    ),
    UserModel(
      id: 'demo-uuid-002',
      username: 'golf_master_id',
      fullName: 'Budi Santoso',
      age: 30,
      height: 180,
      weight: 75,
      role: {'primary_role': 'pivot'},
      level: 'semi pro',
      ppUrl: null,
      domisili: 'Bandung',
      interests: ['futsal'],
    ),
    UserModel(
      id: 'demo-uuid-003',
      username: 'speed_demon_24',
      fullName: 'Citra Dewi',
      age: 24,
      height: 165,
      weight: 58,
      role: {'primary_role': 'anchor'},
      level: 'beginner',
      ppUrl: null,
      domisili: 'Surabaya',
      interests: ['futsal', 'yoga'],
    ),
    UserModel(
      id: 'demo-uuid-004',
      username: 'goal_keeper_pro',
      fullName: 'Dian Kurniawan',
      age: 28,
      height: 185,
      weight: 80,
      role: {'primary_role': 'goalkeeper'},
      level: 'semi pro',
      ppUrl: null,
      domisili: 'Yogyakarta',
      interests: ['futsal'],
    ),
    UserModel(
      id: 'demo-uuid-005',
      username: 'mabar_king',
      fullName: 'Eka Pratama',
      age: 26,
      height: 172,
      weight: 68,
      role: {'primary_role': 'flank'},
      level: 'amateur',
      ppUrl: null,
      domisili: 'Semarang',
      interests: ['futsal', 'badminton'],
    ),
    UserModel(
      id: 'demo-uuid-006',
      username: 'striker_nomer9',
      fullName: 'Fajar Nugroho',
      age: 22,
      height: 178,
      weight: 72,
      role: {'primary_role': 'pivot'},
      level: 'amateur',
      ppUrl: null,
      domisili: 'Jakarta Pusat',
      interests: ['futsal'],
    ),
  ];

  // ============================================================================
  // Mock Events Database (futsal-only, no booking/payment)
  // ============================================================================
  
  static final List<EventModel> _mockEvents = [
    EventModel(
      id: 'evt-001',
      title: 'Weekend Futsal Liga A',
      place: 'Gelanggang Olahraga Jakarta Pusat',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 5)),
      maxPlayers: 10,
      participants: ['demo-uuid-002', 'demo-uuid-003'],
      latitude: -6.1751,
      longitude: 106.8650,
      organizerUsername: 'golf_master_id',
      status: 'upcoming',
    ),
    EventModel(
      id: 'evt-002',
      title: 'Casual Friday Night Futsal',
      place: 'Arena Futsal Bandung Selatan',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 12)),
      maxPlayers: 8,
      participants: ['demo-uuid-001'],
      latitude: -6.9389,
      longitude: 107.6448,
      organizerUsername: 'speed_demon_24',
      status: 'upcoming',
    ),
    EventModel(
      id: 'evt-003',
      title: 'Sunday Morning Pickup Game',
      place: 'Lapangan Futsal Surabaya Utara',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      maxPlayers: 12,
      participants: ['demo-uuid-004', 'demo-uuid-005'],
      latitude: -7.2441,
      longitude: 112.7489,
      organizerUsername: 'goal_keeper_pro',
      status: 'upcoming',
    ),
    EventModel(
      id: 'evt-004',
      title: "Pro Liga Kualifikasi",
      place: 'Stadion GBLA Jakarta',
      dateTime: DateTime.now().add(const Duration(days: 7)),
      maxPlayers: 10,
      participants: [for (int i = 1; i <= 8; i++) 'demo-uuid-$i'],
      latitude: -6.2297,
      longitude: 106.8295,
      organizerUsername: 'futsal_demo',
      status: 'upcoming',
    ),
    EventModel(
      id: 'evt-005',
      title: 'After Work Futsal Session',
      place: 'Futsal Hall Kemang Jakarta',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 8)),
      maxPlayers: 6,
      participants: ['demo-uuid-006'],
      latitude: -6.2615,
      longitude: 106.8106,
      organizerUsername: 'striker_nomer9',
      status: 'upcoming',
    ),
  ];

  // ============================================================================
  // Mock Posts Database (user/group/community post types)
  // ============================================================================
  
  static final List<PostModel> _mockPosts = [
    PostModel(
      id: 'post-001',
      userId: 'demo-uuid-002',
      username: 'golf_master_id',
      caption: "Great match last night! Who wants to play again this weekend? ⚽🔥",
      mediaUrls: [],
      postType: 'user',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likesCount: 15,
      commentsCount: 3,
      isLiked: false,
    ),
    PostModel(
      id: 'post-002',
      userId: 'demo-uuid-004',
      username: 'goal_keeper_pro',
      caption: null,
      mediaUrls: [],
      postType: 'group',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likesCount: 8,
      commentsCount: 1,
      isLiked: false,
    ),
    PostModel(
      id: 'post-003',
      userId: 'demo-uuid-001',
      username: 'futsal_demo',
      caption: "Just joined a new futsal community! Looking for teammates near Jakarta 🙌",
      mediaUrls: [],
      postType: 'community',
      createdAt: DateTime.now().subtract(const Duration(hours: 24)),
      likesCount: 23,
      commentsCount: 7,
      isLiked: false,
    ),
    PostModel(
      id: 'post-004',
      userId: 'demo-uuid-005',
      username: 'mabar_king',
      caption: "Training hard for the upcoming tournament! 💪 Let me know who's in!",
      mediaUrls: [],
      postType: 'user',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      likesCount: 31,
      commentsCount: 5,
      isLiked: false,
    ),
  ];

  // ============================================================================
  // Mock Comments Database (per post)
  // ============================================================================
  
  static final Map<String, List<CommentModel>> _mockComments = {
    'post-001': [
      CommentModel(
        id: 'cmt-001',
        userId: 'demo-uuid-001',
        username: 'futsal_demo',
        postId: 'post-001',
        content: "Count me in! What time and where?",
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      CommentModel(
        id: 'cmt-002',
        userId: 'demo-uuid-005',
        username: 'mabar_king',
        postId: 'post-001',
        content: "Nice! I'll bring extra shoes 😄",
        createdAt: DateTime.now().subtract(const Duration(hours: 30, minutes: 20)),
      ),
    ],
    'post-002': [
      CommentModel(
        id: 'cmt-003',
        userId: 'demo-uuid-003',
        username: 'speed_demon_24',
        postId: 'post-002',
        content: "Looking forward to it! ⚽",
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
    ],
    'post-003': [
      CommentModel(
        id: 'cmt-004',
        userId: 'demo-uuid-002',
        username: 'golf_master_id',
        postId: 'post-003',
        content: "Welcome! Feel free to join our group anytime.",
        createdAt: DateTime.now().subtract(const Duration(hours: 20)),
      ),
    ],
    'post-004': [
      CommentModel(
        id: 'cmt-005',
        userId: 'demo-uuid-006',
        username: 'striker_nomer9',
        postId: 'post-004',
        content: "Let's go! Same time next week?",
        createdAt: DateTime.now().subtract(const Duration(hours: 10)),
      ),
    ],
  };

  // ============================================================================
  // Mock Badges Database (dummy futsal-themed per PRD v2.0 §5.10)
  // Thresholds TBD by product team — placeholder criteria only
  // ============================================================================
  
  static final List<BadgeModel> _mockBadges = [
    BadgeModel(
      id: 'badge-001',
      name: 'First Match Played',
      description: 'Play your first futsal match',
      icon: IconData(0xe8e9, fontFamily: 'MaterialIcons'),
      requirement: 'Complete 1 match',
      isAchieved: true,
    ),
    BadgeModel(
      id: 'badge-002',
      name: '5 Events Joined',
      description: 'Join 5 different futsal events',
      icon: IconData(0xe871, fontFamily: 'MaterialIcons'),
      requirement: 'Join 5 events',
      isAchieved: true,
    ),
    BadgeModel(
      id: 'badge-003',
      name: 'Team Player',
      description: 'Participate in 10 team games',
      icon: IconData(0xf0c1, fontFamily: 'MaterialIcons'),
      requirement: 'Play 10 matches',
      isAchieved: false,
    ),
    BadgeModel(
      id: 'badge-004',
      name: 'Goal Machine',
      description: 'Score 50 goals total',
      icon: IconData(0xf239, fontFamily: 'MaterialIcons'),
      requirement: 'Score 50 goals',
      isAchieved: false,
    ),
    BadgeModel(
      id: 'badge-005',
      name: 'Social Butterfly',
      description: 'Get 100 likes on your posts',
      icon: IconData(0xe851, fontFamily: 'MaterialIcons'),
      requirement: 'Receive 100 likes',
      isAchieved: false,
    ),
    BadgeModel(
      id: 'badge-006',
      name: 'Community Leader',
      description: "Create 5 events and host them successfully",
      icon: IconData(0xe8e9, fontFamily: 'MaterialIcons'),
      requirement: 'Host 5 events',
      isAchieved: false,
    ),
    BadgeModel(
      id: 'badge-007',
      name: 'Futsal Enthusiast',
      description: 'Play futsal for 30 days straight',
      icon: IconData(0xf1b2, fontFamily: 'MaterialIcons'),
      requirement: 'Active 30 consecutive days',
      isAchieved: false,
    ),
    BadgeModel(
      id: 'badge-008',
      name: 'Sharpshooter',
      description: 'Score a hat trick in a single match',
      icon: IconData(0xf2bf, fontFamily: 'MaterialIcons'),
      requirement: '3 goals in 1 match',
      isAchieved: false,
    ),
  ];

  // ============================================================================
  // Mock Groups Database
  // ============================================================================
  
  static final List<GroupModel> _mockGroups = [
    GroupModel(
      id: 'grp-001',
      name: 'Jakarta Futsal Kings',
      description: 'Casual futsal group based in South Jakarta. Everyone welcome!',
      creatorId: 'demo-uuid-002',
      members: ['demo-uuid-001', 'demo-uuid-002', 'demo-uuid-004'],
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
    GroupModel(
      id: 'grp-002',
      name: 'Bandung Pickups',
      description: 'Weekly pickup futsal games in Bandung area.',
      creatorId: 'demo-uuid-003',
      members: ['demo-uuid-003', 'demo-uuid-005'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    GroupModel(
      id: 'grp-003',
      name: 'Futsal Enthusiasts ID',
      description: 'National futsal community. Events in multiple cities.',
      creatorId: 'demo-uuid-001',
      members: ['demo-uuid-001', 'demo-uuid-002', 'demo-uuid-004', 'demo-uuid-006'],
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
    ),
  ];

  // ============================================================================
  // Mock Chat Messages
  // ============================================================================
  
  static final List<ChatMessage> _mockChatMessages = [
    ChatMessage(
      id: 'msg-001',
      senderId: 'demo-uuid-002',
      receiverId: 'demo-uuid-001',
      content: "Hey! Want to join our futsal session this Friday?",
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    ChatMessage(
      id: 'msg-002',
      senderId: 'demo-uuid-001',
      receiverId: 'demo-uuid-002',
      content: "Sure! What time?",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      id: 'msg-003',
      senderId: 'demo-uuid-004',
      receiverId: 'demo-uuid-003',
      content: "Are you coming to the Sunday game?",
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  // ============================================================================
  // Mock Followers/Following
  // ============================================================================
  
  static final Map<String, List<String>> _mockFollowers = {
    'demo-uuid-001': ['demo-uuid-002', 'demo-uuid-004'],
    'demo-uuid-002': ['demo-uuid-001', 'demo-uuid-003', 'demo-uuid-006'],
  };

  static final Map<String, List<String>> _mockFollowing = {
    'demo-uuid-001': ['demo-uuid-002', 'demo-uuid-004', 'demo-uuid-005'],
    'demo-uuid-002': ['demo-uuid-001', 'demo-uuid-003'],
  };

  // ============================================================================
  // Mock Stats for current user (demo-uuid-001)
  // ============================================================================
  
  static final StatsModel _mockStats = StatsModel(
    userId: 'demo-uuid-001',
    eventsJoined: 3,
    matchesPlayed: 2,
    wins: 1,
    postsCount: 1,
    likesReceived: 23,
    followersCount: 45,
    followingCount: 32,
    achievedBadgeIds: ['badge-001', 'badge-002'],
  );

  // ============================================================================
  // Public accessor methods
  // ============================================================================

  static List<UserModel> getAllUsers() => _mockUsers;

  static UserModel? getUserById(String id) {
    try {
      return _mockUsers.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<EventModel> getEvents({String status = 'upcoming'}) {
    return _mockEvents.where((e) => e.status == status).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  static List<PostModel> getPosts() => _mockPosts;

  static List<CommentModel> getCommentsForPost(String postId) =>
      _mockComments[postId] ?? [];

  static List<BadgeModel> getAllBadges() => _mockBadges;

  static StatsModel getStats(String userId) => _mockStats;

  static List<GroupModel> getGroups({String? memberId}) {
    if (memberId != null) {
      return _mockGroups.where((g) => g.members.contains(memberId)).toList();
    }
    return _mockGroups;
  }

  static bool isMemberOfGroup(String groupId, String userId) =>
      _mockGroups.firstWhere((g) => g.id == groupId, orElse: () => GroupModel(
        id: '', name: '', creatorId: '', members: [], createdAt: DateTime.now(),
      )).members.contains(userId);

  static List<ChatMessage> getChatMessages(String userId1, String userId2) {
    return _mockChatMessages.where((m) =>
      (m.senderId == userId1 && m.receiverId == userId2) ||
      (m.senderId == userId2 && m.receiverId == userId1)
    ).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  static List<UserModel> getFollowers(String userId) {
    final followerIds = _mockFollowers[userId] ?? [];
    return followerIds.map((id) => getUserById(id)!).toList();
  }

  static List<UserModel> getFollowing(String userId) {
    final followingIds = _mockFollowing[userId] ?? [];
    return followingIds.map((id) => getUserById(id)!).toList();
  }

  static bool isFollowing(String followerId, String followeeId) {
    return (_mockFollowing[followerId] ?? []).contains(followeeId);
  }

  /// Profile Matcher: surfaces candidate teammates based on compatibility
  static List<MatchCandidate> getMatchCandidates(String userId, {int limit = 5}) {
    final myRole = getUserById(userId)?.role;
    return _mockUsers.where((u) => u.id != userId).map((u) {
      double score = 0.5; // base compatibility
      if (myRole is Map && u.role is Map) {
        final myPrimary = (myRole as dynamic)['primary_role']?.toString();
        final theirPrimary = (u.role as dynamic)['primary_role']?.toString();
        if (myPrimary != theirPrimary) score += 0.3; // complementary roles
      }
      return MatchCandidate(user: u, compatibilityScore: score);
    }).toList()..sort((a, b) => b.compatibilityScore.compareTo(a.compatibilityScore))..take(limit).toList();
  }

  /// Get nearby events by date proximity (simulated for demo)
  static List<EventModel> getNearbyEvents({int maxDaysAhead = 7}) {
    final now = DateTime.now();
    return _mockEvents.where((e) =>
      e.dateTime.isAfter(now) &&
      e.dateTime.difference(now).inDays <= maxDaysAhead &&
      e.status == 'upcoming'
    ).toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  /// Current logged-in user (simulated)
  static UserModel get currentUser => _mockUsers.first;

  
}

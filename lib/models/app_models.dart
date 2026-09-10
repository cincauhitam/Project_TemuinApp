library;

import 'package:flutter/material.dart';

/// Real data models matching Supabase schema

class UserModel {
  final String id;
  final String username;
  final String fullName;
  final int age;
  final int height;
  final int weight;
  final dynamic role; // JSON in DB
  final String level;
  final String? ppUrl;
  final String? domisili;
  final List<dynamic>? interests;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.age,
    required this.height,
    required this.weight,
    required this.role,
    required this.level,
    this.ppUrl,
    this.domisili,
    this.interests,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        fullName: map['full_name'] ?? '',
        age: map['age'] ?? 0,
        height: map['height'] ?? 0,
        weight: map['weight'] ?? 0,
        role: map['role'] ?? {},
        level: map['level'] ?? '',
        ppUrl: map['pp_url'],
        domisili: map['domisili'],
        interests: map['interests'] != null ? List.from(map['interests']) : null,
        createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'full_name': fullName,
        'age': age,
        'height': height,
        'weight': weight,
        'role': role,
        'level': level,
        if (ppUrl != null) 'pp_url': ppUrl,
        if (domisili != null) 'domisili': domisili,
        if (interests != null) 'interests': interests,
      };
}

class PostModel {
  final String id;
  final String userId;
  final String username;
  final String? caption;
  final List<String> mediaUrls;
  final String postType; // user, group, community
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final String? destinationGroupId;

  PostModel({
    required this.id,
    required this.userId,
    required this.username,
    this.caption,
    this.mediaUrls = const [],
    required this.postType,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    this.destinationGroupId,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
        id: map['id'] ?? '',
        userId: map['userId'] ?? map['user_id'] ?? '',
        username: map['username'] ?? '',
        caption: map['caption'],
        mediaUrls: List<String>.from(map['media_urls'] ?? map['mediaUrls'] ?? []),
        postType: map['post_type'] ?? map['postType'] ?? 'user',
        createdAt: DateTime.parse(map['created_at'] ?? map['createdAt'] ?? DateTime.now().toIso8601String()),
        likesCount: map['likes_count'] ?? map['likesCount'] ?? 0,
        commentsCount: map['comments_count'] ?? map['commentsCount'] ?? 0,
        isLiked: map['is_liked'] ?? map['isLiked'] ?? false,
        destinationGroupId: map['destination_group_id'] ?? map['destinationGroupId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'username': username,
        if (caption != null) 'caption': caption,
        'media_urls': mediaUrls,
        'post_type': postType,
        'created_at': createdAt.toIso8601String(),
        'likes_count': likesCount,
        'comments_count': commentsCount,
      };
}

class CommentModel {
  final String id;
  final String userId;
  final String username;
  final String postId;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.postId,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) => CommentModel(
        id: map['id'] ?? '',
        userId: map['userId'] ?? map['user_id'] ?? '',
        username: map['username'] ?? '',
        postId: map['postId'] ?? map['post_id'] ?? '',
        content: map['content'] ?? '',
        createdAt: DateTime.parse(map['created_at'] ?? map['createdAt'] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'username': username,
        'postId': postId,
        'content': content,
        'created_at': createdAt.toIso8601String(),
      };
}

class EventModel {
  final String id;
  final String title;
  final String place;
  final DateTime dateTime;
  final int maxPlayers;
  final List<String> participants;
  final double latitude;
  final double longitude;
  final String organizerUsername;
  final String status; // upcoming, ongoing, completed
  final String? groupId;

  EventModel({
    required this.id,
    required this.title,
    required this.place,
    required this.dateTime,
    required this.maxPlayers,
    required this.participants,
    required this.latitude,
    required this.longitude,
    required this.organizerUsername,
    required this.status,
    this.groupId,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) => EventModel(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        place: map['place'] ?? '',
        dateTime: DateTime.parse(map['dateTime'] ?? map['date_time'] ?? map['created_at'] ?? DateTime.now().toIso8601String()),
        maxPlayers: map['max_players'] ?? map['maxPlayers'] ?? 10,
        participants: List<String>.from(map['participants'] ?? []),
        latitude: (map['latitude'] ?? 0).toDouble(),
        longitude: (map['longitude'] ?? 0).toDouble(),
        organizerUsername: map['organizer_username'] ?? map['organizerUsername'] ?? '',
        status: map['status'] ?? 'upcoming',
        groupId: map['group_id'] ?? map['groupId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'place': place,
        'dateTime': dateTime.toIso8601String(),
        'max_players': maxPlayers,
        'participants': participants,
        'latitude': latitude,
        'longitude': longitude,
        'organizer_username': organizerUsername,
        'status': status,
      };

  bool get isFull => participants.length >= maxPlayers;
  int get remainingSlots => maxPlayers - participants.length;
}

class GroupModel {
  final String id;
  final String name;
  final String description;
  final String creatorId;
  final List<String> members;
  final bool postVisibilityControlByAdmin;
  final DateTime createdAt;

  GroupModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.creatorId,
    this.members = const [],
    this.postVisibilityControlByAdmin = true,
    required this.createdAt,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) => GroupModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        creatorId: map['creator_id'] ?? map['creatorId'] ?? '',
        members: List<String>.from(map['members'] ?? []),
        postVisibilityControlByAdmin: map['post_visibility_control_by_admin'] ?? map['postVisibilityControlByAdmin'] ?? true,
        createdAt: DateTime.parse(map['created_at'] ?? map['createdAt'] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'creator_id': creatorId,
        'members': members,
        'post_visibility_control_by_admin': postVisibilityControlByAdmin,
        'created_at': createdAt.toIso8601String(),
      };

  bool get isAdmin => false; // Will be set dynamically based on current user
}

class BadgeModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String requirement;
  final bool isAchieved;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.requirement,
    this.isAchieved = false,
  });
}

class StatsModel {
  final String userId;
  final int eventsJoined;
  final int matchesPlayed;
  final int wins;
  final int postsCount;
  final int likesReceived;
  final int followersCount;
  final int followingCount;
  final List<String> achievedBadgeIds;

  StatsModel({
    required this.userId,
    this.eventsJoined = 0,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.postsCount = 0,
    this.likesReceived = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.achievedBadgeIds = const [],
  });

  factory StatsModel.fromMap(Map<String, dynamic> map) => StatsModel(
        userId: map['userId'] ?? map['user_id'] ?? '',
        eventsJoined: map['events_joined'] ?? map['eventsJoined'] ?? 0,
        matchesPlayed: map['matches_played'] ?? map['matchesPlayed'] ?? 0,
        wins: map['wins'] ?? 0,
        postsCount: map['posts_count'] ?? map['postsCount'] ?? 0,
        likesReceived: map['likes_received'] ?? map['likesReceived'] ?? 0,
        followersCount: map['followers_count'] ?? map['followersCount'] ?? 0,
        followingCount: map['following_count'] ?? map['followingCount'] ?? 0,
        achievedBadgeIds: List<String>.from(map['achieved_badges'] ?? map['achievedBadges'] ?? []),
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'events_joined': eventsJoined,
        'matches_played': matchesPlayed,
        'wins': wins,
        'posts_count': postsCount,
        'likes_received': likesReceived,
        'followers_count': followersCount,
        'following_count': followingCount,
      };
}

class FollowModel {
  final String followerId; // who is following
  final String followeeId; // who is being followed
  final DateTime createdAt;

  FollowModel({
    required this.followerId,
    required this.followeeId,
    required this.createdAt,
  });
}

class MatchCandidate {
  final UserModel user;
  final double compatibilityScore;
  final String reason;

  MatchCandidate({
    required this.user,
    required this.compatibilityScore,
    this.reason = '',
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime createdAt;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
    this.isRead = false,
  });
}

class DummyUser {
  final String id;
  final String username;
  final String fullName;
  final int age;
  final int height;
  final int weight;
  final dynamic role;
  final String level;
  final String domisili;
  final List<String> interests;

  DummyUser({
    required this.id,
    required this.username,
    required this.fullName,
    required this.age,
    required this.height,
    required this.weight,
    required this.role,
    required this.level,
    required this.domisili,
    required this.interests,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'full_name': fullName,
        'age': age,
        'height': height,
        'weight': weight,
        'role': role,
        'level': level,
        'domisili': domisili,
        'interests': interests,
      };

  factory DummyUser.fromMap(Map<String, dynamic> map) => DummyUser(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        fullName: map['full_name'] ?? '',
        age: map['age'] ?? 0,
        height: map['height'] ?? 0,
        weight: map['weight'] ?? 0,
        role: map['role'] ?? {},
        level: map['level'] ?? '',
        domisili: map['domisili'] ?? '',
        interests: List<String>.from(map['interests'] ?? []),
      );
}

class DummyPost {
  final String id;
  final String userId;
  final String username;
  final String? caption;
  final List<String> mediaUrls;
  final String postType;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  DummyPost({
    required this.id,
    required this.userId,
    required this.username,
    this.caption,
    this.mediaUrls = const [],
    required this.postType,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'username': username,
        if (caption != null) 'caption': caption,
        'media_urls': mediaUrls,
        'post_type': postType,
        'created_at': createdAt.toIso8601String(),
        'likes_count': likesCount,
        'comments_count': commentsCount,
      };

  factory DummyPost.fromMap(Map<String, dynamic> map) => DummyPost(
        id: map['id'] ?? '',
        userId: map['userId'] ?? '',
        username: map['username'] ?? '',
        caption: map['caption'],
        mediaUrls: List<String>.from(map['media_urls'] ?? []),
        postType: map['post_type'] ?? 'user',
        createdAt: DateTime.parse(map['created_at']),
        likesCount: map['likes_count'] ?? 0,
        commentsCount: map['comments_count'] ?? 0,
      );
}

class DummyBadge {
  final String id;
  final String name;
  final String description;
  final bool isAchieved;
  final String requirement;

  DummyBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.requirement,
    this.isAchieved = false,
  });
}

class DummyStats {
  final String userId;
  final int eventsJoined;
  final int matchesPlayed;
  final int wins;
  final int postsCount;
  final int likesReceived;
  final int followersCount;
  final List<String> achievedBadges;

  DummyStats({
    required this.userId,
    this.eventsJoined = 0,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.postsCount = 0,
    this.likesReceived = 0,
    this.followersCount = 0,
    this.achievedBadges = const [],
  });

  static DummyStats getDefault() => DummyStats(
        userId: 'demo-uuid-001',
        eventsJoined: 3,
        matchesPlayed: 2,
        wins: 1,
        postsCount: 1,
        likesReceived: 23,
        followersCount: 45,
        achievedBadges: ['badge-001', 'badge-002'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'eventsJoined': eventsJoined,
        'matchesPlayed': matchesPlayed,
        'wins': wins,
        'postsCount': postsCount,
        'likesReceived': likesReceived,
        'followersCount': followersCount,
      };

  factory DummyStats.fromMap(Map<String, dynamic> map) => DummyStats(
        userId: map['userId'] ?? '',
        eventsJoined: map['eventsJoined'] ?? 0,
        matchesPlayed: map['matchesPlayed'] ?? 0,
        wins: map['wins'] ?? 0,
        postsCount: map['postsCount'] ?? 0,
        likesReceived: map['likesReceived'] ?? 0,
        followersCount: map['followersCount'] ?? 0,
        achievedBadges: List<String>.from(map['achievedBadges'] ?? []),
      );
}



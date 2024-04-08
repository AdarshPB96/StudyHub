// class UploadPostModel {
 
//   final String? text;
//   final List<String>? fileLinks;
//   final String userId;

//   UploadPostModel({ this.text, this.fileLinks, required this.userId});

//   factory UploadPostModel.fromJson(Map<String, dynamic> json) {
//     return UploadPostModel(
      
//       text: json['text'] ?? '',
//        fileLinks: List<String>.from(json['file_links'] ?? []),
//       userId: json['user_id'],
//     );
//   }
// }

class Post {
  final String id;
  final String text;
  final List<String> fileLinks;
  final User user;

  Post({
    required this.id,
    required this.text,
    required this.fileLinks,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      text: json['text'],
      fileLinks: List<String>.from(json['file_links']),
      user: User.fromJson(json['user_id']),
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePicUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicUrl: json['profilePicUrl'],
    );
  }
}

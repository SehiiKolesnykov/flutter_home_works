
class User {

  final String name;
  final String surname;
  final String? avatarUrl;
  final String profession;
  final int numberOfProjects;
  final int numberOfSubscribers;
  final int numberOfSubscriptions;

  User({
    required this.name,
    required this.surname,
    required this.avatarUrl,
    required this.profession,
    required this.numberOfProjects,
    required this.numberOfSubscribers,
    required this.numberOfSubscriptions,
  });

  String get fullName => '$name $surname';
  String? get userAvatarUrl => avatarUrl?.isNotEmpty == true ? avatarUrl :null ;
  String get userProfession => profession;

  Map<String, int> userStatisticMap () {
    return {
      'projects': numberOfProjects,
      'subscribers': numberOfSubscribers,
      'subscriptions': numberOfSubscriptions,
    };
  }

}
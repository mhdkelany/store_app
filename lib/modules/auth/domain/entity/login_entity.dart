import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.status,
    required this.statusProfile,
    required this.message,
    required this.lang,
    required this.lat,
    required this.name,
    required this.phone,
    required this.token,
    required this.address,
   required this.userType,
    required this.id,
  });
  final int? id;
  final bool status;
  final bool? statusProfile;
  final String message;
  final dynamic lang;
  final dynamic lat;
  final String? name;
  final String? phone;
  final String? token;
  final String? address;
  final dynamic userType;

  @override
  List<Object> get props => [
        status,
        statusProfile!,
        name!,
        phone!,
        token!,
        address!,
    id!,
      ];
}

import 'package:store/modules/home/domain/entity/change_favorite_entity.dart';

class ChangeFavoriteStateModel extends ChangeFavoriteEntity {
  ChangeFavoriteStateModel({
    required super.status,
    required super.message,
  });

  factory ChangeFavoriteStateModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoriteStateModel(
      status: json['state'],
      message: json['message'],
    );
  }
}

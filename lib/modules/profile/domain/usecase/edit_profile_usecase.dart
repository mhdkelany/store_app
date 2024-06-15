import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/profile/domain/entity/edit_profie_entity.dart';
import 'package:store/modules/profile/domain/repo/base_profile_repo.dart';

class EditProfileParameters extends Equatable {
  final String name;
  final String password;
  final String phone;
  final double? lat;
  final double? lng;
  final int userType;

  EditProfileParameters({
    required this.name,
    required this.password,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.userType,
  });

  @override
  List<Object> get props => [
        name,
        password,
        phone,
        lat!,
        lng!,
        userType,
      ];
}
class EditProfileUseCase extends BaseUseCase<EditProfileEntity,EditProfileParameters>
{
  final BaseProfileRepo baseProfileRepo;

  EditProfileUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, EditProfileEntity>> call(EditProfileParameters parameters)async {
    return await baseProfileRepo.editProfile(parameters);
  }
}
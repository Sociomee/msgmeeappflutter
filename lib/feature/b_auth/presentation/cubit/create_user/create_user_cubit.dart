import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../otp_send/otp_send_cubit.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserState.initial());
}

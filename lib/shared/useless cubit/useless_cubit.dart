import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_admin_system/shared/useless%20cubit/useless_states.dart';

class UselessCubit extends Cubit<UselessStates> {
  UselessCubit() : super(UselessInitialState());

  static UselessCubit get(context) => BlocProvider.of(context);
}
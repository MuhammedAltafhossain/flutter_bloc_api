import 'package:flutter_bloc_api/cubit/user_cubit_state.dart';
import 'package:bloc/bloc.dart';

import '../model/user_model.dart';
import '../service/api_service.dart';

class UserCubit extends Cubit<UserCubitState>{
  List<UserModel> userList = [];

  ApiService apiService;

  UserCubit({required this.apiService}) : super(UserCubitInit());

  void getAllUserList() async{
    try{
      emit(UserCubitLoading());
      userList = await apiService.getData();
      emit(UserCubitDataLoaded(userList: userList));
    }catch (e){
      emit(UserCubitError(message: e.toString()));
    }

  }
}
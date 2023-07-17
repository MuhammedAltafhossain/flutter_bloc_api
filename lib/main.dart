import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/model/user_model.dart';
import 'package:flutter_bloc_api/service/api_service.dart';
import 'cubit/user_cubit.dart';
import 'cubit/user_cubit_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit(apiService: ApiService()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserCubit>().getAllUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Api'),
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(builder: (context, state) {
        if (state is UserCubitLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserCubitError) {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state is UserCubitDataLoaded) {
          return ListView.builder(
              itemCount: state.userList.length,
              itemBuilder: (context, itemIndex) {
                UserModel userModel = state.userList[itemIndex];
                return ListTile(
                  leading: Text(userModel.id.toString()),
                  title: Text(userModel.name.toString()),
                  subtitle: Text(userModel.email.toString()),
                );
              });
        }
        else{
          return const SizedBox();
        }
      }),
    );
  }
}

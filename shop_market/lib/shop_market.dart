import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/home/home.dart';

class ShopMarket extends StatelessWidget {
  const ShopMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottombarNavigationBloc>( create: (context) => BottombarNavigationBloc(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
    
        home: Scaffold(
          appBar: AppbarWidget(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    
          floatingActionButton: const FabWidget(),
    
          drawer:const DrawerWidget(),
    
          body:   const PagesView(),
    
          bottomNavigationBar: const BottombarWidget(),
    
        ),
      ),
    );
  }
}

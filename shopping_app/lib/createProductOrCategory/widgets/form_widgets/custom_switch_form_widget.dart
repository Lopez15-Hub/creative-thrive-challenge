import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/title_changer/title_changer_bloc.dart';

class SwitchFormWidget extends StatelessWidget {
  const SwitchFormWidget({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var titleChangerBloc = BlocProvider.of<TitleChangerBloc>(context);
    return BlocBuilder<TitleChangerBloc, bool>(
      builder: (context, currentForm) => Switch(
        activeColor: Colors.white,
        activeTrackColor: Colors.deepOrange[800],
        value: currentForm,
        onChanged: (currentForm) =>titleChangerBloc.add(ChangeTitle(currentForm)),
      ),
    );
  }
}

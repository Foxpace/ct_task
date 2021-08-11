import 'package:flutter/material.dart';
import 'package:ct_task/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ct_task/bloc_module/bloc_module.dart';


/// custom search bar with grey background
/// updates search query on every change
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key, required this.hint}) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) => TextField(
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      onChanged: (String text) => <void>{
        BlocProvider.of<BlocModule>(context) // calling search query
            .getSearchByNameOrId(text)
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).splashColor,
        contentPadding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        prefixIcon: const Icon(Icons.search),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Consts.borderRadius),
        ),
      ));

}


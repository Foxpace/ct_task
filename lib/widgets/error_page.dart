import 'package:ct_task/bloc_module/bloc_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ct_task/res/strings.dart';
import 'package:ct_task/theme.dart';
import 'package:flutter/material.dart';

/// simple widget to show error message
/// Structure:
/// [imageSrc] for [Image] from assets
/// [message] for text underneath the picture
/// [TextButton] for refresh
class ErrorPage extends StatelessWidget {
  const ErrorPage(
      {Key? key,
      required this.imageSrc,
      required this.message,})
      : super(key: key);

  final String imageSrc;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: Consts.largeImage,
                height: Consts.largeImage,
                child: Image.asset(imageSrc, fit: BoxFit.contain)),
            Padding(
              padding: Consts.itemsInCardBorders,
              child:
                  Text(message, style: Theme.of(context).textTheme.headline6),
            ),
            TextButton(
              onPressed: () => <void>{
                BlocProvider.of<BlocModule>(context).getExams()
              },
              child: const Text(Strings.tryAgain),
            )
          ],
        ),
      );
}

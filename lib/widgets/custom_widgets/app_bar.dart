import 'package:flutter/material.dart';
import 'package:ct_task/res/strings.dart';
import 'package:ct_task/theme.dart';

/// custom appbar for the task
/// structure -> (IconButton)  CT1   (IconButton)
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Material(
          elevation: Consts.elevation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize:
                    Theme.of(context).iconTheme.size ?? Consts.iconDefaultSize,
                icon: const Icon(Icons.menu),
                tooltip: Strings.menu,
                onPressed: () {},
              ),
              Text(
                Strings.ct1,
                style: Theme.of(context).textTheme.headline6,
              ),
              IconButton(
                iconSize:
                    Theme.of(context).iconTheme.size ?? Consts.iconDefaultSize,
                icon: const Icon(Icons.add),
                tooltip: Strings.addExam,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}

import 'package:ct_task/bloc_module/bloc_module.dart';
import 'package:flutter/material.dart';
import 'package:ct_task/fhir/types/examination.dart';
import 'package:ct_task/res/strings.dart';
import 'package:ct_task/theme.dart';
import 'package:ct_task/widgets/custom_widgets/search_bar.dart';
import 'package:ct_task/widgets/exams/exam_tab.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamList extends StatelessWidget {
  const ExamList({Key? key, required this.exams}) : super(key: key);

  final List<Examination> exams;

  /// Structure:
  /// [SearchBarWidget]
  /// Row with text about number of exams - 2 icons to reverse and filter
  /// [Divider] with custom theme
  /// [Text] with [Center] / listView with [ExaminationTab] widget - based on the [exams] count
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const Padding(
              padding: Consts.allRoundBorders,
              child: SearchBarWidget(hint: Strings.searchBoxHint)),
          Padding(
            padding: Consts.listBorders,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  sprintf(Strings.countOfPatientsToday, <int>[exams.length]),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      tooltip: Strings.reverseList,
                      iconSize: Theme.of(context).iconTheme.size ??
                          Consts.iconDefaultSize,
                      onPressed: () {
                        BlocProvider.of<BlocModule>(context).getReversedList();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_alt),
                      tooltip: Strings.filterList,
                      iconSize: Theme.of(context).iconTheme.size ??
                          Consts.iconDefaultSize,
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
                dividerTheme: Theme.of(context)
                    .dividerTheme
                    .copyWith(color: Colors.black)),
            child: const Divider(),
          ),
          Expanded(
            child: _getList(context),
          ),
        ],
      );

  /// returns text with no exams, if there is nothing to show after search
  Widget _getList(BuildContext context) {
    if (exams.isEmpty) {
      return Center(
          child: Text(Strings.emptyList,
              style: Theme.of(context).textTheme.headline6));
    }

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          ExaminationTab(exam: exams[index]),
      itemCount: exams.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

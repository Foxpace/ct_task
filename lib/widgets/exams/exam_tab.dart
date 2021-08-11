import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ct_task/fhir/types/examination.dart';
import 'package:ct_task/res/strings.dart';
import 'package:ct_task/theme.dart';
import 'package:sprintf/sprintf.dart';

/// widget to show specific examination
/// Structure:
/// [Row]
///   [Image] of the examination
///   [Column] with patient and examination information
///   [PopupMenuButton] with one property to delete examination
/// [Text] is styled with [headline6] and [subtitle1] and [subtitle2]

class ExaminationTab extends StatelessWidget {
  ExaminationTab({Key? key, required this.exam}) : super(key: key);

  final Examination exam;
  final DateFormat dateFormat = DateFormat(Strings.dateFormat);

  @override
  Widget build(BuildContext context) => Padding(
        padding: Consts.itemsInCardBorders,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: Consts.itemsInCardBorders,
                  child: SizedBox(
                    width: Consts.iconSize,
                    height: Consts.iconSize,
                    child: Image.asset(
                      exam.examinationType.getAsset(exam.examinationType),
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: Consts.itemsInCardBorders,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Text>[
                      Text(exam.patient.name,
                          style: Theme.of(context).textTheme.headline6),
                      Text(
                          sprintf(Strings.examBirthDateGenderId, <String>[
                            exam.patient.birthDay,
                            exam.patient.gender,
                            exam.patient.id
                          ]),
                          style: Theme.of(context).textTheme.subtitle1),
                      Text(dateFormat.format(exam.dateTime),
                          style: Theme.of(context).textTheme.subtitle2),
                      Text(exam.examinationType.getText(exam.examinationType),
                          style: Theme.of(context).textTheme.subtitle2),
                    ]
                        .map((Widget text) => Padding(
                              padding: Consts.paddingBetweenLines,
                              child: text,
                            ))
                        .toList(),
                  ),
                ),
              ),
              PopupMenuButton<int>(
                  icon: Icon(
                    Icons.more_vert,
                    size: Theme.of(context).iconTheme.size ??
                        Consts.iconDefaultSize,
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                        const PopupMenuItem<int>(
                          child: Text(Strings.deleteExam),
                          value: 1,
                        ),
                      ])
            ]),
      );
}

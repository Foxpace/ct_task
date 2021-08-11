import 'package:ct_task/res/images.dart';
import 'package:ct_task/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ct_task/bloc_module/bloc_module.dart';
import 'package:ct_task/bloc_module/states.dart';
import 'package:ct_task/widgets/exams/exam_list.dart';

/// holds reference to BlocModule for state management
/// decides, which widget to use based on the state
class ExamsPage extends StatefulWidget {
  const ExamsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  late BlocModule _blocModule;

  @override
  void initState() {
    super.initState();
    _blocModule = context.read<BlocModule>();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<BlocModule, ExamsState>(
      bloc: BlocProvider.of<BlocModule>(context),
      builder: (BuildContext context, ExamsState examState) {
        switch (examState.status) {
          case StatusTypes.loading:
            return const Center(child: CircularProgressIndicator());
          case StatusTypes.success:
            return ExamList(exams: examState.exams);
          case StatusTypes.noConnection:
          case StatusTypes.error:
            return ErrorPage(
              imageSrc: Images.errorImage,
              message: examState.message,
            );
          case StatusTypes.empty:
            return ErrorPage(
                imageSrc: Images.rest,
                message: examState.message);
        }
      },
    );

  @override
  void dispose() {
    _blocModule.onDispose();
    super.dispose();
  }
}

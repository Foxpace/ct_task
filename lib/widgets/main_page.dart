import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ct_task/bloc_module/bloc_module.dart';
import 'package:ct_task/bloc_module/events.dart';
import 'package:ct_task/widgets/exams/exam_page.dart';
import 'package:ct_task/widgets/custom_widgets/app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        // to unfocus from searchbar by touch outside of the field
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: BlocProvider<BlocModule>(
            create: (_) =>
                BlocModule(httpClient: http.Client())..add(ExamsLoad()),
            child: const ExamsPage(),
          ),
        ),
      );
}

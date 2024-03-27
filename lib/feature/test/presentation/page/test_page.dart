import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/bloc/test_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/model/test_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  void initState() {
    BlocProvider.of<TestBloc>(context).add(TestPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          if(state is FetchTestDataState){
            return _listBuilder(dataState: state);
          } else {
            return const Center(child:  CenterLoaderWidget());
          }
        },
      ),
    );
  }

  Widget _listBuilder({required FetchTestDataState dataState}) {
    return Container(
       margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: ListView.builder(
            itemCount: dataState.testList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
            return Column(
              children: [
                dataState.testList[index].child!,
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                index == dataState.testList.length-1 ? _button(testList: dataState.testList) : const SizedBox.shrink()
              ],
            );
        }),
      ),
    );
  }

  Widget _button({required List<TestModel> testList}) {
    return ButtonWidget(
        text: "Save",
        onPressed: () {

         if(kDebugMode) {
           for(var testData in testList) {
             print("data ------------ ${testData.controller!.text.toString()}");
             for(var listData in testData.list!) {
               if(listData.isSelected  == true) {
                 print("data ------------ ${listData.id}");
               }
             }
           }
         }
      }
    );
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/bloc/test_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/model/file_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/model/test_model.dart';

class TestHelper {

  static Future<dynamic> fetchUIWidgetData({required BuildContext context}) async {
    List<TestModel> testList = [];
    try{
      var data = await DefaultAssetBundle.of(context).loadString("assets/test.json");
      final jsonResult = jsonDecode(data);
      return testListResponse(jsonResult['data']);
    }catch(e){
      if(kDebugMode){
        print("Error --------- $e");
      }
    }
    return testList;
  }

  static Future<dynamic> widgetBuilderRefresh({required BuildContext context,
    required List<TestModel> testList, required LoginDataModel userData}) async {
    List<TestModel> widgetList = [];
    try{
      int index = 0;
      for(var testData in testList) {
        if(testData.type.toString() == "inputBox") {
          TestModel widgetData =  testData;
          widgetData.child =  inputBox(testData: testData);
          widgetList.add(widgetData);
        }
        else if(testData.type.toString() == "radioButton") {
          TestModel widgetData =  testData;
          widgetData.child =  radioButton(testData: testData);
          widgetList.add(widgetData);
        }
        else if(testData.type.toString() == "file") {
          TestModel widgetData =  testData;
          File file =  File("");
          if(testData.fileData != null && testData.fileData!.fileByte != null
              && testData.fileData!.fileByte!.isNotEmpty){
            file =  await FileModel.writeToFile(data: testData.fileData!.fileByte!, fileName: testData.fileData!.fileName.toString());
          }
          widgetData.child =  fileWidget(testData: testData, context: context, file: file);
          widgetList.add(widgetData);
        }
        else if(testData.type.toString() == "searchDropDown") {
          TestModel widgetData =  testData;
          widgetData.child =  searchDropdown(testData: widgetData, context: context, testList: testList, index: index);
          widgetList.add(widgetData);
        }
        else if(testData.type.toString() == "normalDropDown") {
          TestModel widgetData =  testData;
          widgetData.child =  normalDropDown(testData: widgetData, index: index, testList: testList, context: context);
          widgetList.add(widgetData);
        }
        index++ ;
      }
    }catch(e){
      if(kDebugMode){
        print("Error --------- $e");
      }
    }
    return widgetList;
  }

  static Future<dynamic> widgetBuilder({required BuildContext context,
    required List<TestModel> testList, required LoginDataModel userData}) async {
    List<TestModel> widgetList = [];
    try{
      int index = 0;
      for(var testData in testList) {
         if(testData.type.toString() == "inputBox") {
           TestModel widgetData =  testData;
           widgetData.child =  inputBox(testData: testData);
           widgetList.add(widgetData);
         }
         else if(testData.type.toString() == "radioButton") {
           TestModel widgetData =  testData;
           widgetData.child =  radioButton(testData: testData);
           widgetList.add(widgetData);
         }
         else if(testData.type.toString() == "file") {
           TestModel widgetData =  testData;
           File file =  File("");
           if(testData.fileData != null && testData.fileData!.fileByte != null
               && testData.fileData!.fileByte!.isNotEmpty){
             file =  await FileModel.writeToFile(data: testData.fileData!.fileByte!, fileName: testData.fileData!.fileName.toString());
           }
           widgetData.child =  fileWidget(testData: testData, context: context, file: file);
           widgetList.add(widgetData);
         }
         else if(testData.type.toString() == "searchDropDown") {
           TestModel widgetData =  testData;
           if(widgetData.api.toString() == "alignment"){
             var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: context, userData: userData);
             if(res != null){
               List<AlignmentModel>  alignmentList =  res;
               widgetData.list =  testListModelResponse(alignmentList.map((v) => v.toJson()).toList());
             }
           }
           widgetData.child =  searchDropdown(testData: widgetData, context: context, testList: testList, index: index);
           widgetList.add(widgetData);
         }
/*         else if(testData.type.toString() == "normalDropDown") {
           TestModel widgetData =  testData;
           if(widgetData.api.toString() == "weather"){
             var res =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
             if(res != null){
               List<WeatherModel>  weatherList =  res;
               widgetData.list =  testListModelResponse(weatherList.map((v) => v.toJson()).toList());
             }
           }
           widgetData.child =  normalDropDown(testData: widgetData, index: index, testList: testList, context: context);
           widgetList.add(widgetData);
         }*/
         index++ ;
      }
    }catch(e){
      if(kDebugMode){
        print("Error --------- $e");
      }
    }
    return widgetList;
  }

  static Widget inputBox({required TestModel testData}) {
    testData.controller!.text =  testData.value.toString();
    return TextFieldWidget(
        controller: testData.controller,
        isRequired: testData.required,
        textInputType: testData.inputType.toString() == "number"
            ? TextInputType.number : TextInputType.text,
        labelText: testData.label.toString(),
    );
  }

  static Widget radioButton({required TestModel testData}) {
    return  testData.list != null  && testData.list!.isNotEmpty ?
    ListView.builder(
      itemCount: testData.list!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
       TestListModel testListData =  testData.list![index];
      return Row(
        children: [
          Radio(
            value: testListData.name,
            groupValue: testListData.value,
            onChanged: (val) {
              testListData.value =  val.toString();
            },
          ),
          TextWidget(testListData.name.toString(),),
        ],
      );
     },
    ) : const SizedBox.shrink();
  }

  static Widget fileWidget({required BuildContext context, required TestModel testData, required File file}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height:MediaQuery.of(context).size.width/3,
      child: InkWell(
        onTap: () {
          mediaType(context: context);
        },
        child: DottedBorder(
          color: AppColor.grey,
          strokeWidth: 1,
          child: file.path.isEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Icon(Icons.photo_camera_back_outlined),),
              Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: TextWidget(testData.label.toString(),
                  fontSize: AppFont.font_12,
                  color: AppColor.grey,),
              ),
            ],
          ):Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  file.path.toString().toLowerCase().contains(".jpg")
                      || file.path.toString().toLowerCase().contains(".png")
                      || file.path.toString().toLowerCase().contains(".jpeg")
                      ? Image.file(file,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width/3,
                    height: MediaQuery.of(context).size.width/4.5 ,)
                      : file.path.toString().toLowerCase().contains(".pdf")
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      : const Icon(Icons.document_scanner_outlined),
                  TextWidget(file.path.split('/').last.toString(),
                    color: AppColor.themeColor, fontSize: AppFont.font_12,),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width/3,
                  height:MediaQuery.of(context).size.width/3,
                  color : Colors.white.withOpacity(0.6),
                  child: Center(child: Icon(Icons.refresh, color: AppColor.themeColor,))),
            ],
          ),
        ),
      ),
    );
  }

  static void mediaType({required BuildContext context}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {

              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {

              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  static Widget searchDropdown({required TestModel testData, required BuildContext context,
    required List<TestModel> testList, required int index}) {
    TestListModel selectedTestListData = TestListModel();
    for(var testListData in testData.list!) {
      if(testListData.isSelected == true){
        selectedTestListData =  testListData;
      }
    }
    return  DropDownSearchWidget(
      selectedItem: selectedTestListData.id != null ? selectedTestListData  : null,
      hint: testData.label.toString(),
      items: testData.list!,
      itemAsString: (alignmentData) => alignmentData.name.toString(),
      onChanged: (value) {
        List<TestListModel> tempTestList = [];
        for(var testListData in testData.list!) {
          TestListModel testData = testListData;
          if(testListData.name.toString() == value.name.toString()){
            testData.isSelected =  true;
          } else {
            testData.isSelected =  false;
          }
          tempTestList.add(testData);
        }
        testList[index].list =  tempTestList;
        if(kDebugMode){
          print(value.name.toString());
          BlocProvider.of<TestBloc>(context).add(TestPageSelectAlignmentData(testList: testList, context: context));
        }
      },
    );
  }

  static Widget normalDropDown({required TestModel testData, required BuildContext context,
    required List<TestModel> testList, required int index}) {
    TestListModel selectedTestListData = TestListModel();
    for(var testListData in testData.list!) {
      if(testListData.isSelected == true){
        selectedTestListData =  testListData;
      }
    }
    return DropdownWidget(
      hint: testData.label.toString(),
      dropdownValue: selectedTestListData.id != null ? selectedTestListData : null,
      onChanged: (value) {
        List<TestListModel> tempTestList = [];
        for(var testListData in testData.list!) {
          TestListModel testData = testListData;
          if(testListData.name.toString() == value.name.toString()){
            testData.isSelected =  true;
          } else {
            testData.isSelected =  false;
          }
          tempTestList.add(testData);
        }
        testList[index].list =  tempTestList;
        if(kDebugMode){
          print(value.name.toString());
          BlocProvider.of<TestBloc>(context).add(TestPageSelectAlignmentData(testList: testList, context: context));
        }
      },
      items: testData.list!.map<DropdownMenuItem<TestListModel>>((TestListModel testListData) {
        return DropdownMenuItem<TestListModel>(
          value: testListData,
          child: Text(testListData.name.toString()),
        );
      }).toList(),
    );
  }
}
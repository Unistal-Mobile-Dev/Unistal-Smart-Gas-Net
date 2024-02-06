import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/bloc/add_lowering_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddLoweringPage extends StatefulWidget {
  const AddLoweringPage({super.key});

  @override
  State<AddLoweringPage> createState() => _AddLoweringPageState();
}

class _AddLoweringPageState extends State<AddLoweringPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: TextWidget("Add Lowering",
          color: AppColor.white, fontSize: AppFont.font_16, fontWeight: FontWeight.w700,),
      ),
      body: BlocBuilder<AddLoweringBloc, AddLoweringState>(
        builder: (context, state) {
          if(state is FetchAddLoweringDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddLoweringDataState dataState}){
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child : Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _locatinController(dataState: dataState),
            _verticalSpace(),
            _holidayDetectorDetailsController(dataState: dataState),
            _verticalSpace(),
            _modelController(dataState: dataState),
            _verticalSpace(),
            _testVoltageController(dataState: dataState),
            _verticalSpace(),
            _calibarationDateController(dataState: dataState),
            _verticalSpace(),
            _repairCoatingController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _postPaddingController(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddLoweringDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            SelectWeatherEvent(weatherData: value));
      },
      items: dataState.weatherList.map<DropdownMenuItem<WeatherModel>>((WeatherModel weatherData) {
        return DropdownMenuItem<WeatherModel>(
          value: weatherData,
          child: Text(weatherData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _locatinController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }

  Widget _holidayDetectorDetailsController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.holidayDetectorDetails,
      controller: dataState.holidayDetectorDetailsController,
    );
  }

  Widget _modelController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.makeModel,
      controller: dataState.modelController,
    );
  }

  Widget _testVoltageController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.testVoltage,
      controller: dataState.testVoltageController,
    );
  }

  Widget _calibarationDateController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.calibarationDate,
      controller: dataState.calibarationDateController,
      onTap: () {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringCalibarationDataEvent(context: context,));
      },
    );
  }

  Widget _repairCoatingController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.repairCoatingDamage,
      controller: dataState.repairCoatingController,
    );
  }


  Widget _jointTypeDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddLoweringDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddLoweringDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _chainageFromController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _postPaddingController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.postPadding,
      controller: dataState.postPaddingController,
    );
  }

  Widget _holidayChecksDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null ? dataState.holidayChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context).add(
            AddLoweringSelectHolidayDataEvent(holidayChecksData: value));
      },
      items: dataState.holidayCheckList.map<DropdownMenuItem<HolidayChecksModel>>((HolidayChecksModel holidayChecksData) {
        return DropdownMenuItem<HolidayChecksModel>(
          value: holidayChecksData,
          child: Text(holidayChecksData.value.toString()),
        );
      }).toList(),
    );
  }


  Widget _activityRemark({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddLoweringDataState dataState}) {
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
          child: dataState.file == null
              ||dataState.file.path.isEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Icon(Icons.photo_camera_back_outlined),),
              Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: TextWidget("Photo",
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
                  dataState.file.path.toString().toLowerCase().contains(".jpg")
                      || dataState.file.path.toString().toLowerCase().contains(".png")
                      || dataState.file.path.toString().toLowerCase().contains(".jpeg")
                      ? Image.file(dataState.file,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width/3,
                    height: MediaQuery.of(context).size.width/4.5 ,)
                      : dataState.file.path.toString().toLowerCase().contains(".pdf")
                      ? Icon(Icons.picture_as_pdf_outlined)
                      : Icon(Icons.document_scanner_outlined),
                  TextWidget(dataState.file.path.split('/').last.toString(),
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

  void mediaType({required BuildContext context}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.23,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {
                BlocProvider.of<AddLoweringBloc>(context).add(AddLoweringAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddLoweringBloc>(context).add(AddLoweringAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddLoweringDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        onPressed: () {
          BlocProvider.of<AddLoweringBloc>(context).add(AddLoweringSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


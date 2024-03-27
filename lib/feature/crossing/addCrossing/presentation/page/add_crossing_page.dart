import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/bloc/add_crossing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddCrossingPage extends StatefulWidget {
  const AddCrossingPage({super.key});

  @override
  State<AddCrossingPage> createState() => _AddCrossingPageState();
}

class _AddCrossingPageState extends State<AddCrossingPage> {

  @override
  void initState() {
    BlocProvider.of<AddCrossingBloc>(context).add(AddCrossingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddCrossingBloc, AddCrossingState>(
        builder: (context, state) {
          if(state is FetchAddCrossingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddCrossingDataState dataState}){
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
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _hddSectionPreparationController(dataState: dataState),
            _verticalSpace(),
            _hddWithCashingController(dataState: dataState),
            _verticalSpace(),
            _casingLengthController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _weldingReportNumberController(dataState: dataState),
            _verticalSpace(),
            _radiographyReportNoController(dataState: dataState),
            _verticalSpace(),
            _preHydroReportNoController(dataState: dataState),
            _verticalSpace(),
            _coatingReportNoController(dataState: dataState),
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

  Widget _dateController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectDateEvent(context: context,));
      },
    );
  }


  Widget _alignmentDropdown({required FetchAddCrossingDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
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

  Widget _hddSectionPreparationController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.hddSectionPreparation,
      controller: dataState.hddSectionPreparationController,
    );
  }

  Widget _hddWithCashingController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.hddWithCasingWithOutCasingLength,
      controller: dataState.hddWithCashingController,
    );
  }

  Widget _casingLengthController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.casingLength,
      controller: dataState.casingLengthController,
    );
  }


  Widget _jointTypeDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddCrossingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddCrossingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _weldingReportNumberController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.weldingReportNumber,
      controller: dataState.weldingReportNumberController,
    );
  }

  Widget _radiographyReportNoController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.radiographyRepostNo,
      controller: dataState.radiographyReportNoController,
    );
  }

  Widget _preHydroReportNoController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.preHydroReportNo,
      controller: dataState.preHydroReportNoController,
    );
  }

  Widget _coatingReportNoController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.coatingReportNo,
      controller: dataState.coatingReportNoController,
    );
  }

  Widget _holidayChecksDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null ? dataState.holidayChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectHolidayDataEvent(holidayChecksData: value));
      },
      items: dataState.holidayCheckList.map<DropdownMenuItem<HolidayChecksModel>>((HolidayChecksModel holidayChecksData) {
        return DropdownMenuItem<HolidayChecksModel>(
          value: holidayChecksData,
          child: Text(holidayChecksData.value.toString()),
        );
      }).toList(),
    );
  }


  Widget _activityRemark({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddCrossingDataState dataState}) {
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
          child: dataState.file.path.isEmpty ?
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
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      : const Icon(Icons.document_scanner_outlined),
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
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {
                BlocProvider.of<AddCrossingBloc>(context).add(AddCrossingAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddCrossingBloc>(context).add(AddCrossingAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddCrossingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddCrossingBloc>(context).add(AddCrossingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}



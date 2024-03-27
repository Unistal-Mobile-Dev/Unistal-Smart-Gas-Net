import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/domain/bloc/add_hdpe_duct_testing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddHDPEDuctTestingPage extends StatefulWidget {
  const AddHDPEDuctTestingPage({super.key});

  @override
  State<AddHDPEDuctTestingPage> createState() => _AddHDPEDuctTestingPageState();
}

class _AddHDPEDuctTestingPageState extends State<AddHDPEDuctTestingPage> {

  @override
  void initState() {
    BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(AddHdpeDuctTestingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddHdpeDuctTestingBloc, AddHdpeDuctTestingState>(
        builder: (context, state) {
          if(state is FetchAddHdpeDuctTestingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddHdpeDuctTestingDataState dataState}){
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
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _ductCleaningController(dataState: dataState),
            _verticalSpace(),
            _ductIntegrityTestController(dataState: dataState),
            _verticalSpace(),
            _airPressureTestController(dataState: dataState),
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

  Widget _dateController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectDateEvent(context: context,));
      },
    );
  }


  Widget _alignmentDropdown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
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

  Widget _jointTypeDropDown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _lengthController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.hdpeLayinglength,
      controller: dataState.lengthController,
    );
  }

  Widget _ductCleaningController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ductCleaning,
      controller: dataState.ductCleaningController,
    );
  }

  Widget _ductIntegrityTestController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ductIntegrityTest,
      controller: dataState.ductIntegrityTestController,
    );
  }

  Widget _airPressureTestController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.airPressureTest,
      controller: dataState.airPressureTestController,
    );
  }

  Widget _activityRemark({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddHdpeDuctTestingDataState dataState}) {
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
                      :  const Icon(Icons.document_scanner_outlined),
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
                BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(AddHdpeDuctTestingAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(AddHdpeDuctTestingAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(AddHdpeDuctTestingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/domain/bloc/add_restoration_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddRestorationPage extends StatefulWidget {
  const AddRestorationPage({super.key});

  @override
  State<AddRestorationPage> createState() => _AddRestorationPageState();
}

class _AddRestorationPageState extends State<AddRestorationPage> {

  @override
  void initState() {
    BlocProvider.of<AddRestorationBloc>(context).add(AddRestorationPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddRestorationBloc, AddRestorationState>(
        builder: (context, state) {
          if(state is FetchAddRestorationDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddRestorationDataState dataState}){
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
            _postPaddingController(dataState: dataState),
            _verticalSpace(),
            _removalOfSurplusMaterialDropDown(dataState: dataState),
            _verticalSpace(),
            _replacementofTopSoilDropDown(dataState: dataState),
            _verticalSpace(),
            _reinstallationBoundaryStoneDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddRestorationDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
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

  Widget _jointTypeDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddRestorationDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddRestorationDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _lengthController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.lengthMeter,
      controller: dataState.lengthController,
    );
  }


  Widget _chainageFromController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _postPaddingController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.landType,
      controller: dataState.landTypeController,
    );
  }


  Widget _removalOfSurplusMaterialDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectRemovalOfSurplusMaterialData,
      dropdownValue: dataState.removalOfSurplusMaterialData.id != null ? dataState.removalOfSurplusMaterialData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectRemovalOfSurplusMaterialDataEvent(removalOfSurplusMaterialData: value));
      },
      items: dataState.removalOfSurplusMaterialList.map<DropdownMenuItem<PaddingModel>>((PaddingModel removalOfSurplusMaterialData) {
        return DropdownMenuItem<PaddingModel>(
          value: removalOfSurplusMaterialData,
          child: Text(removalOfSurplusMaterialData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _replacementofTopSoilDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectReplacementofTopSoilData,
      dropdownValue: dataState.replacementofTopSoilData.id != null ? dataState.replacementofTopSoilData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectReplacementofTopSoilDataEvent(replacementofTopSoilData: value));
      },
      items: dataState.replacementofTopSoilList.map<DropdownMenuItem<PaddingModel>>((PaddingModel replacementofTopSoilData) {
        return DropdownMenuItem<PaddingModel>(
          value: replacementofTopSoilData,
          child: Text(replacementofTopSoilData.value.toString()),
        );
      }).toList(),
    );
  }


  Widget _reinstallationBoundaryStoneDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectReinstallationBoundaryStonesData,
      dropdownValue: dataState.reinstallationBoundaryStonesData.id != null ? dataState.reinstallationBoundaryStonesData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectReinstallationBoundaryStonesDataEvent(reinstallationBoundaryStonesData: value));
      },
      items: dataState.replacementofTopSoilList.map<DropdownMenuItem<PaddingModel>>((PaddingModel reinstallationBoundaryStonesData) {
        return DropdownMenuItem<PaddingModel>(
          value: reinstallationBoundaryStonesData,
          child: Text(reinstallationBoundaryStonesData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddRestorationDataState dataState}) {
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
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {
                BlocProvider.of<AddRestorationBloc>(context).add(AddRestorationAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddRestorationBloc>(context).add(AddRestorationAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }



  Widget _button({required FetchAddRestorationDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        onPressed: () {
          BlocProvider.of<AddRestorationBloc>(context).add(AddRestorationSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/domain/bloc/add_marker_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddMarkerPage extends StatefulWidget {
  const AddMarkerPage({super.key});

  @override
  State<AddMarkerPage> createState() => _AddMarkerPageState();
}

class _AddMarkerPageState extends State<AddMarkerPage> {

  @override
  void initState() {
    BlocProvider.of<AddMarkerBloc>(context).add(AddMarkerPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddMarkerBloc, AddMarkerState>(
        builder: (context, state) {
          if(state is FetchAddMarkerDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddMarkerDataState dataState}){
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child : Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  TextWidget("Accuracy :  ", color: AppColor.themeColor,),
                  TextWidget(dataState.accuracy.isNotEmpty ?
                  double.parse(dataState.accuracy.toString()).toStringAsFixed(2)
                      : "0.0", color: AppColor.black, fontWeight: FontWeight.w700,),
                ],)
            ),
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _spreadDropDown(dataState: dataState),
            _verticalSpace(),
            _sectionDropDown(dataState: dataState),
            _verticalSpace(),
            _markerTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _descriptionController(dataState: dataState),
            _verticalSpace(),
            _captureGPSPointButton(dataState: dataState),
            _verticalSpace(),
            _latController(dataState: dataState),
            _verticalSpace(),
            _longController(dataState: dataState),
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

  Widget _dateController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectDateEvent(context: context,));
      },
    );
  }

  Widget _spreadDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectSpread,
      dropdownValue: dataState.spreadTypeData.id != null ? dataState.spreadTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectSpreadEvent(spreadTypeData: value,));
      },
      items: dataState.spreadList.map<DropdownMenuItem<SpreadTypeModel>>((SpreadTypeModel spreadTypeData) {
        return DropdownMenuItem<SpreadTypeModel>(
          value: spreadTypeData,
          child: Text(spreadTypeData.spreadName.toString()),
        );
      }).toList(),
    );
  }

  Widget _sectionDropDown({required FetchAddMarkerDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectSection,
      dropdownValue: dataState.sectionTypeData.id != null ? dataState.sectionTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectSectionEvent(sectionTypeData: value,));
      },
      items: dataState.sectionList.map<DropdownMenuItem<SectionTypeModel>>((SectionTypeModel sectionTypeData) {
        return DropdownMenuItem<SectionTypeModel>(
          value: sectionTypeData,
          child: Text(sectionTypeData.sectionName.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _alignmentDropdown({required FetchAddMarkerDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
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

  Widget _pipeMaterialDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeMaterial,
      dropdownValue: dataState.pipeMaterialData.id != null ? dataState.pipeMaterialData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectPipeMaterialDataEvent(pipeMaterialData: value));
      },
      items: dataState.pipeMaterialList.map<DropdownMenuItem<PipeMaterialModel>>((PipeMaterialModel pipeMaterialData) {
        return DropdownMenuItem<PipeMaterialModel>(
          value: pipeMaterialData,
          child: Text(pipeMaterialData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _pipeDiaDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeDia,
      dropdownValue: dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectPipeDiaDataEvent(pipeDiaData: value));
      },
      items: dataState.pipeDialList.map<DropdownMenuItem<PipeDiaModel>>((PipeDiaModel pipeDiaData) {
        return DropdownMenuItem<PipeDiaModel>(
          value: pipeDiaData,
          child: Text(pipeDiaData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _thicknessDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeThickness,
      dropdownValue: dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectPipeThicknessDataEvent(thicknessData: value));
      },
      items: dataState.thicknessList.map<DropdownMenuItem<ThicknessModel>>((ThicknessModel thicknessData) {
        return DropdownMenuItem<ThicknessModel>(
          value: thicknessData,
          child: Text(thicknessData.value.toString()),
        );
      }).toList(),
    );
  }



  Widget _peelTestDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPeelTest,
      dropdownValue: dataState.peelTestData.id != null ? dataState.peelTestData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectPeelTestDataEvent(peelTestData: value));
      },
      items: dataState.peelTestList.map<DropdownMenuItem<PaddingModel>>((PaddingModel peelTestData) {
        return DropdownMenuItem<PaddingModel>(
          value: peelTestData,
          child: Text(peelTestData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _locatinController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }

  Widget _holidayTestNoController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.holidayTestNo,
      controller: dataState.holidayTestNoController,
    );
  }

  Widget _primaryAbatchController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerABatch,
      controller: dataState.primaryAbatchController,
    );
  }

  Widget _primaryBbatchController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerBBatch,
      controller: dataState.primaryBbatchController,
    );
  }

  Widget _surfaceController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.surface,
      controller: dataState.surfaceController,
    );
  }

  Widget _markerTypeDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectMarkerType,
      dropdownValue: dataState.markerTypeData.id != null ? dataState.markerTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectMarkerEvent(markerTypeData: value));
      },
      items: dataState.markerTypeList.map<DropdownMenuItem<MarkerTypeModel>>((MarkerTypeModel markerTypeData) {
        return DropdownMenuItem<MarkerTypeModel>(
          value: markerTypeData,
          child: Text(markerTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _onBodyController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.onBody,
      controller: dataState.onBodyController,
    );
  }


  Widget _jointTypeDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddMarkerDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _chainageFromController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _descriptionController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.description,
      controller: dataState.descriptionController,
    );
  }

  Widget _holidayChecksDropDown({required FetchAddMarkerDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null ? dataState.holidayChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerBloc>(context).add(
            AddMarkerSelectHolidayDataEvent(holidayChecksData: value));
      },
      items: dataState.holidayCheckList.map<DropdownMenuItem<HolidayChecksModel>>((HolidayChecksModel holidayChecksData) {
        return DropdownMenuItem<HolidayChecksModel>(
          value: holidayChecksData,
          child: Text(holidayChecksData.value.toString()),
        );
      }).toList(),
    );
  }


  Widget _captureGPSPointButton({required FetchAddMarkerDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.captureGPS,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddMarkerBloc>(context).add(AddMarkerCaptureGPSPointEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }

  Widget _latController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.latitude,
      controller: dataState.latController,
    );
  }

  Widget _longController({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.longitude,
      controller: dataState.longController,
    );
  }

  Widget _activityRemark({required FetchAddMarkerDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddMarkerDataState dataState}) {
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
                BlocProvider.of<AddMarkerBloc>(context).add(AddMarkerAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddMarkerBloc>(context).add(AddMarkerAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddMarkerDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddMarkerBloc>(context).add(AddMarkerSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


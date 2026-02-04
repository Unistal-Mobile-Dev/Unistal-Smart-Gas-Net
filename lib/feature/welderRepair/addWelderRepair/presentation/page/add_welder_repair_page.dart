import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/bloc/add_welder_repair_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/model/welder_repair_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddWelderRepairPage extends StatefulWidget {
  const AddWelderRepairPage({super.key});

  @override
  State<AddWelderRepairPage> createState() => _AddWelderRepairPageState();
}

class _AddWelderRepairPageState extends State<AddWelderRepairPage> {
  @override
  void initState() {
    BlocProvider.of<AddWelderRepairBloc>(context)
        .add(AddWelderRepairLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddWelderRepairBloc, AddWelderRepairState>(
        builder: (context, state) {
          if (state is FetchAddWelderRepairDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddWelderRepairDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
          /*  _verticalSpace(),
            TextWidget(
              "Electrode/Filler Wire No.",
              color: EnvironmentConfig.of(context)!.primaryTheme,
              fontWeight: FontWeight.w600,
            ),
            const Divider(),
            _e6010Controller(dataState: dataState),
            _verticalSpace(),
            _e8010P1Controller(dataState: dataState),
            _verticalSpace(),
            _e9045P2Controller(dataState: dataState),
            _verticalSpace(),
            _er70s6Controller(dataState: dataState),
            _verticalSpace(),
            _e81TM21ABController(dataState: dataState),
            _verticalSpace(),
            const Divider(),*/
            _verticalSpace(),
          /*  _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _segmentDropdown(dataState: dataState),
            _verticalSpace(),
            _wpdTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _welderDropDown(dataState: dataState),
            _verticalSpace(),
            _preHeatingTemperatureController(dataState: dataState),
            _verticalSpace(),
            _weldVisualDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddWelderRepairDataState dataState}) {
    return  AppConfig.instanceInit()!.client == Client.vppl
        ?  DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    ) : DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(SelectWeatherEvent(weatherData: value));
      },
      items: dataState.weatherList
          .map<DropdownMenuItem<WeatherModel>>((WeatherModel weatherData) {
        return DropdownMenuItem<WeatherModel>(
          value: weatherData,
          child: Text(weatherData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _e6010Controller({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E6010",
      controller: dataState.e6010Controller,
    );
  }

  Widget _e8010P1Controller(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E8010P1",
      controller: dataState.e8010P1Controller,
    );
  }

  Widget _e9045P2Controller(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E9045P2",
      controller: dataState.e9045P2Controller,
    );
  }

  Widget _er70s6Controller({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Er70s6",
      controller: dataState.er70s6Controller,
    );
  }

  Widget _e81TM21ABController(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E81TM21AB",
      controller: dataState.e81TM21ABController,
    );
  }

  Widget _jointTypeDropDown(
      {required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectJointTypeEvent(
                jointTypeModel: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>(
          (JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _jointNumberDropDown(
      {required FetchAddWelderRepairDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
      isRequired: true,
            hint: AppString.selectJointNumber,
            dropdownValue: dataState.jointNumberData.id != null
                ? dataState.jointNumberData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddWelderRepairBloc>(context).add(
                  AddWelderRepairSelectJointNumberEvent(
                      jointNumberData: value));
            },
            items: dataState.jointNumberList
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
          )
        : const DottedLoaderWidget();
  }

  Widget _weldVisualDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeldVisual,
      dropdownValue:
      dataState.weldVisualData.id != null ? dataState.weldVisualData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairSelectWeldVisualEvent(weldVisualData: value));
      },
      items: dataState.weldVisualList.map<DropdownMenuItem<VisualChecksModel>>(
              (VisualChecksModel welderData) {
            return DropdownMenuItem<VisualChecksModel>(
              value: welderData,
              child: Text(welderData.value.toString()),
            );
          }).toList(),
    );
  }

  Widget _segmentDropdown({required FetchAddWelderRepairDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.selectedSegmentStatusList,
      hint: AppString.selectSegment,
      items: dataState.segmentStatusList,
      itemAsString: (segmentData) => segmentData.name.toString(),
      onChanged: (selectedItems) {
        List<SegmentModel> segmentStatusList = [];
        for (var data in selectedItems) {
          segmentStatusList.add(data);
        }
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectSegmentEvent(
                selectedSegmentList: segmentStatusList));
      },
    );
  }

  Widget _wpdTypeDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWPS,
      dropdownValue:
          dataState.wpsTypeData.id != null ? dataState.wpsTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectWPSTypeEvent(
                wpsTypeData: value, context: context));
      },
      items: dataState.wpsTypeList
          .map<DropdownMenuItem<WPSModel>>((WPSModel wpsData) {
        return DropdownMenuItem<WPSModel>(
          value: wpsData,
          child: Text(wpsData.wps.toString()),
        );
      }).toList(),
    );
  }

  Widget _preHeatingTemperatureController(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.preHeatingTemperature,
      controller: dataState.preHeatingTemperatureController,
    );
  }

  Widget _welderDropDown({required FetchAddWelderRepairDataState dataState}) {
    return dataState.isWelderLoader == false
        ? DropdownWidget(
            hint: AppString.selectWelder,
            dropdownValue:
                dataState.welderData.id != null ? dataState.welderData : null,
            onChanged: (value) {
              BlocProvider.of<AddWelderRepairBloc>(context)
                  .add(AddWelderRepairSelectWelderEvent(welderData: value));
            },
            items: dataState.welderList
                .map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
              return DropdownMenuItem<WelderModel>(
                value: welderData,
                child: Text(welderData.welderName.toString()),
              );
            }).toList(),
          )
        : const DottedLoaderWidget();
  }

  Widget _activityRemark({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddWelderRepairDataState dataState}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: InkWell(
        onTap: () {
          mediaType(context: context);
        },
        child: DottedBorder(
          color: AppColor.grey,
          strokeWidth: 1,
          child: dataState.file.path.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Icon(Icons.photo_camera_back_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      child: TextWidget(
                        "Photo",
                        fontSize: AppFont.font_12,
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dataState.file.path
                                    .toString()
                                    .toLowerCase()
                                    .contains(".jpg") ||
                                dataState.file.path
                                    .toString()
                                    .toLowerCase()
                                    .contains(".png") ||
                                dataState.file.path
                                    .toString()
                                    .toLowerCase()
                                    .contains(".jpeg")
                            ? Image.file(
                                dataState.file,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 4.5,
                              )
                            : dataState.file.path
                                    .toString()
                                    .toLowerCase()
                                    .contains(".pdf")
                                ? const Icon(Icons.picture_as_pdf_outlined)
                                : const Icon(Icons.document_scanner_outlined),
                        TextWidget(
                          dataState.file.path.split('/').last.toString(),
                          color: EnvironmentConfig.of(context)!.primaryTheme,
                          fontSize: AppFont.font_12,
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        color: Colors.white.withOpacity(0.6),
                        child: Center(
                            child: Icon(
                          Icons.refresh,
                          color: EnvironmentConfig.of(context)!.primaryTheme,
                        ))),
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
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddWelderRepairBloc>(context).add(
                        AddWelderRepairAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddWelderRepairBloc>(context).add(
                        AddWelderRepairAddImageEvent(
                            context: context, mediaType: 2));
                  },
                  child: TextWidget(
                    "Gallery",
                    fontSize: AppFont.font_16,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddWelderRepairDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddWelderRepairBloc>(context)
                  .add(AddWelderRepairSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

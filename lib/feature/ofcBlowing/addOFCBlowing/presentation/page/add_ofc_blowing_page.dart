import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/OFCBlowing/addOFCBlowing/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcBlowing/addOFCBlowing/domain/add_ofc_blowing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddOFCBlowingPage extends StatefulWidget {
  const AddOFCBlowingPage({super.key});

  @override
  State<AddOFCBlowingPage> createState() => _AddOFCBlowingPageState();
}

class _AddOFCBlowingPageState extends State<AddOFCBlowingPage> {
  @override
  void initState() {
    BlocProvider.of<AddOFCBlowingBloc>(context)
        .add(AddOFCBlowingPageLoadEvent(context: context));
    super.initState();
  }

  final client = AppConfig.instanceInit()!.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddOFCBlowingBloc, AddOFCBlowingState>(
        builder: (context, state) {
          if (state is FetchAddOFCBlowingDataState) {
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

  Widget _itemBuilder({required FetchAddOFCBlowingDataState dataState}) {
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
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumLengthController(dataState: dataState),
            _verticalSpace(),
            _smmController(dataState: dataState),
            _verticalSpace(),
            _pitCableLengthController(dataState: dataState),
            _verticalSpace(),
            _loopPitController(dataState: dataState),
            _verticalSpace(),
            _locationBPController(dataState: dataState),
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

  Widget _dateController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddOFCBlowingBloc>(context)
            .add(AddOFCBlowingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: false, value: value, context: context));
      },
    );
  }

  Widget _chainageToController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return DropdownWidget(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointValue.id != null
                ? dataState.fromJointValue
                : null,
            onChanged: (value) {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(SelectFromJointEvent(fromJointValue: value));
            },
            items: dataState.listOfFromJoint
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
          );
  }

  Widget _toJointNumberDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return  DropdownWidget(
            hint: AppString.selectToJointNumber,
            dropdownValue: dataState.toJointValue.id != null
                ? dataState.toJointValue
                : null,
            onChanged: (value) {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(SelectToJointEvent(toJointValue: value));
            },
            items: dataState.listOfToJoint
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel? jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData!.jointNumber.toString()),
              );
            }).toList(),
          );
  }

  Widget _ofcDrumNoController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "OFC Drum No.",
      controller: dataState.ofcDrumNoController,
    );
  }

  Widget _ofcDrumLengthController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "OFC Drum Length(Meter)",
      controller: dataState.ofcDrumLengthController,
    );
  }

  Widget _smmController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "Sequential Meter Marker on OFC(meter)",
      controller: dataState.smmController,
    );
  }

  Widget _pitCableLengthController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "Pit Cable Length(Meter)",
      controller: dataState.pitCableLengthController,
    );
  }

  Widget _loopPitController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "Loop At Pit",
      controller: dataState.loopPitController,
    );
  }

  Widget _locationBPController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "No. & Location of Blowing Pit",
      controller: dataState.locationBPController,
    );
  }

  Widget _activityRemark({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddOFCBlowingDataState dataState}) {
    return AppConfig.instanceInit()!.client == Client.vppl
        ? DropDownSearchMultiSelectWidget(
            selectedItem: dataState.multipleAlignmentData,
            hint: AppString.selectAlignment,
            items: dataState.alignmentList,
            itemAsString: (alignmentData) =>
                alignmentData.alignmentName.toString(),
            onChanged: (value) {
              List<AlignmentModel> selectedAlignmentDataList = [];
              for (var data in value) {
                selectedAlignmentDataList.add(data);
              }
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(AddOFCBlowingMultipleSelectAlignmentEvent(
                alignmentData: selectedAlignmentDataList,
              ));
            },
          )
        : DropDownSearchWidget(
            isRequired: true,
            selectedItem: dataState.alignmentData.id != null
                ? dataState.alignmentData
                : null,
            hint: AppString.selectAlignment,
            items: dataState.alignmentList,
            itemAsString: (alignmentData) =>
                alignmentData.alignmentName.toString(),
            onChanged: (value) {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(AddOFCBlowingSelectAlignmentEvent(
                alignmentData: value,
              ));
            },
          );
  }

  Widget _weatherDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context)
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

  Widget _photo({required FetchAddOFCBlowingDataState dataState}) {
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
                        dataState.file.path
                                .toString()
                                .toLowerCase()
                                .contains(".pdf")
                            ? TextWidget(
                                dataState.file.path.split('/').last.toString(),
                                color:
                                    EnvironmentConfig.of(context)!.primaryTheme,
                                fontSize: AppFont.font_12,
                              )
                            : const SizedBox.shrink(),
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
                    BlocProvider.of<AddOFCBlowingBloc>(context).add(
                        AddOFCBlowingAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddOFCBlowingBloc>(context).add(
                        AddOFCBlowingAddImageEvent(
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

  Widget _button({required FetchAddOFCBlowingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(AddOFCBlowingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

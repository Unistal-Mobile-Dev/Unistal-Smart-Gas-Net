import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_source_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/bloc/add_radiography_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';

class AddRadioGraphyPage extends StatefulWidget {
  const AddRadioGraphyPage({super.key});

  @override
  State<AddRadioGraphyPage> createState() => _AddRadioGraphyPageState();
}

class _AddRadioGraphyPageState extends State<AddRadioGraphyPage> {
  @override
  void initState() {
    BlocProvider.of<AddRadiographyBloc>(context)
        .add(AddRadiographyPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddRadiographyBloc, AddRadiographyState>(
        builder: (context, state) {
          if (state is FetchAddRadiographyDataState) {
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

  Widget _itemBuilder({required FetchAddRadiographyDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _ndtSourceDropDown(dataState: dataState),
            _verticalSpace(),
            _filmTypeController(dataState: dataState),
            _verticalSpace(),
            _inspectTechniqueController(dataState: dataState),
            _verticalSpace(),
            _sensivityController(dataState: dataState),
            _verticalSpace(),
            _densityController(dataState: dataState),
            _verticalSpace(),
            _equipmentController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _segmentListBuilder(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _ndtAgencyDropDown(dataState: dataState),
            _verticalSpace(),
            _dSPPLDropDown(dataState: dataState),
            _verticalSpace(),
            _mECONPBGPLDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _alignmentDropdown({required FetchAddRadiographyDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
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

  Widget _ndtSourceDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectRtSource,
      dropdownValue:
          dataState.ndtSourceData.id != null ? dataState.ndtSourceData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectNdtSourceDataEvent(ndtSourceData: value));
      },
      items: dataState.ndtSourceList.map<DropdownMenuItem<NdtSourceModel>>(
          (NdtSourceModel ndtSourceData) {
        return DropdownMenuItem<NdtSourceModel>(
          value: ndtSourceData,
          child: Text(ndtSourceData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _chainageController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _filmTypeController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.filmType,
      controller: dataState.filmTypeController,
    );
  }

  Widget _inspectTechniqueController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.inspectionTechnique,
      controller: dataState.inspectTechniqueController,
    );
  }

  Widget _sensivityController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.sensivity,
      controller: dataState.sensivityController,
    );
  }

  Widget _densityController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.density,
      controller: dataState.densityController,
    );
  }

  Widget _equipmentController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.equipment,
      controller: dataState.equipmentController,
    );
  }

  Widget _jointTypeDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectJointTypeDataEvent(
                jointTypeData: value, context: context));
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
      {required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointNumberData.id != null
          ? dataState.jointNumberData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectJointNumberDataEvent(jointNumberData: value));
      },
      items: dataState.jointNumberList.map<DropdownMenuItem<JointNumberModel>>(
          (JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    );
  }

  Widget _segmentListBuilder(
      {required FetchAddRadiographyDataState dataState}) {
    return ListView.builder(
        itemCount: dataState.segmentList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _listItemBuilder(
              segmentData: dataState.segmentList[index], index: index);
        });
  }

  Widget _listItemBuilder(
      {required SegmentModel segmentData, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
          "${segmentData.name}*",
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        _verticalSpace(),
        _radioButtonList(segmentData: segmentData, segmentIndex: index),
        TextFieldWidget(
          isRequired: true,
          labelText: "${segmentData.observation}",
          controller: segmentData.observationController,
        ),
        _verticalSpace(),
        segmentData.segmentWelderList != null &&
                segmentData.segmentWelderList!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: segmentData.segmentWelderList!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, welderIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        "${segmentData.segmentWelderList![welderIndex].name}",
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                      _welderDropDown(
                          welderData: segmentData
                              .segmentWelderList![welderIndex].welderData!,
                          welderList: segmentData
                              .segmentWelderList![welderIndex].welderList!,
                          index: index,
                          welderIndex: welderIndex),
                      _verticalSpace(),
                    ],
                  );
                })
            : const SizedBox.shrink(),
        TextFieldWidget(
          isRequired: false,
          labelText: "${segmentData.remark}",
          controller: segmentData.remarkController,
        ),
        _verticalSpace(),
        const Divider(),
      ],
    );
  }

  Widget _radioButtonList(
      {required SegmentModel segmentData, required int segmentIndex}) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: segmentData.segmentStatusList!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Radio(
                value:
                    segmentData.segmentStatusList![index].groupType.toString(),
                groupValue: segmentData.segmentStatusList![index].selectedValue
                    .toString(),
                onChanged: (val) {
                  BlocProvider.of<AddRadiographyBloc>(context).add(
                      AddRadiographySelectSegmentDataEvent(
                          index: index, segmentIndex: segmentIndex));
                },
              ),
              TextWidget(
                  segmentData.segmentStatusList![index].status.toString()),
            ],
          );
        });
  }

  Widget _welderDropDown(
      {required WelderModel welderData,
      required List<WelderModel> welderList,
      required int index,
      required int welderIndex}) {
    return DropdownWidget(
      hint: AppString.selectWelder,
      dropdownValue: welderData.id != null ? welderData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectWelderDataEvent(
                welderData: value, index: index, welderIndex: welderIndex));
      },
      items: welderList
          .map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _ndtAgencyDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectNdtAgency,
      dropdownValue:
          dataState.ndtAgencyData.id != null ? dataState.ndtAgencyData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectNdtAgencyDataEvent(ndtAgencyData: value));
      },
      items: dataState.ndtAgencyList.map<DropdownMenuItem<NdtStatusModel>>(
          (NdtStatusModel ndtAgencyData) {
        return DropdownMenuItem<NdtStatusModel>(
          value: ndtAgencyData,
          child: Text(ndtAgencyData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _dSPPLDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDSPPL,
      dropdownValue: dataState.dSPPLAgencyData.id != null
          ? dataState.dSPPLAgencyData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectDspplDataEvent(dspplData: value));
      },
      items: dataState.dSPPLAgencyList.map<DropdownMenuItem<NdtStatusModel>>(
          (NdtStatusModel ndtAgencyData) {
        return DropdownMenuItem<NdtStatusModel>(
          value: ndtAgencyData,
          child: Text(ndtAgencyData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _mECONPBGPLDropDown(
      {required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectMECONPBGPL,
      dropdownValue:
          dataState.meconPbgplData.id != null ? dataState.meconPbgplData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectMeconPbgplDataEvent(meconPbgplData: value));
      },
      items: dataState.meconPbgplList.map<DropdownMenuItem<NdtStatusModel>>(
          (NdtStatusModel ndtAgencyData) {
        return DropdownMenuItem<NdtStatusModel>(
          value: ndtAgencyData,
          child: Text(ndtAgencyData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddRadiographyDataState dataState}) {
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
                                ? Icon(Icons.picture_as_pdf_outlined)
                                : Icon(Icons.document_scanner_outlined),
                        TextWidget(
                          dataState.file.path.split('/').last.toString(),
                          color: AppColor.themeColor,
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
                          color: AppColor.themeColor,
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
                    BlocProvider.of<AddRadiographyBloc>(context).add(
                        AddRadiographyAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddRadiographyBloc>(context).add(
                        AddRadiographyAddImageEvent(
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

  Widget _button({required FetchAddRadiographyDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddRadiographyBloc>(context)
                  .add(AddRadiographySubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

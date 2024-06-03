import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/bloc/add_ndt_mut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

class AddNdtMutPage extends StatefulWidget {
  const AddNdtMutPage({super.key});

  @override
  State<AddNdtMutPage> createState() => _AddNdtMutPageState();
}

class _AddNdtMutPageState extends State<AddNdtMutPage> {
  @override
  void initState() {
    BlocProvider.of<AddNdtMutBloc>(context)
        .add(AddNdtMutPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddNdtMutBloc, AddNdtMutState>(
        builder: (context, state) {
          if (state is FetchAddNdtMutDataState) {
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

  Widget _itemBuilder({required FetchAddNdtMutDataState dataState}) {
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
            _typeOfFlawDetectorController(dataState: dataState),
            _verticalSpace(),
            _angleOfRayInputController(dataState: dataState),
            _verticalSpace(),
            _operatingFrequencyController(dataState: dataState),
            _verticalSpace(),
            _leveOfInspectionController(dataState: dataState),
            _verticalSpace(),
            _pipeNumberSearchController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
/*            _segmentListBuilder(dataState: dataState),
            _verticalSpace(),*/
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _locationDiscoverDefectController(dataState: dataState),
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

  Widget _dateController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddNdtMutBloc>(context).add(AddNdtMutSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddNdtMutDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
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

  Widget _typeOfFlawDetectorController(
      {required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.typeOfFlawDetector,
      controller: dataState.typeOfFlawDetectorController,
    );
  }

  Widget _angleOfRayInputController(
      {required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.angleOfRayInput,
      controller: dataState.angleOfRayInputController,
    );
  }

  Widget _operatingFrequencyController(
      {required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.operatingFrequency,
      controller: dataState.operatingFrequencyController,
    );
  }

  Widget _leveOfInspectionController(
      {required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.levelOfInspection,
      controller: dataState.leveOfInspectionController,
    );
  }

  Widget _pipeNumberSearchController(
      {required FetchAddNdtMutDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddNdtMutBloc>(context).add(
              AddNdtMutSearchPipeDataEvent(keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddNdtMutBloc>(context)
              .add(AddNdtMutSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.pipeList);
  }

  Widget _jointTypeDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context).add(
            AddNdtMutSelectJointTypeDataEvent(
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

  Widget _jointNumberDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointNumberData.id != null
          ? dataState.jointNumberData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectJointNumberDataEvent(jointNumberData: value));
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

  Widget _segmentListBuilder({required FetchAddNdtMutDataState dataState}) {
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
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
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
                  BlocProvider.of<AddNdtMutBloc>(context).add(
                      AddNdtMutSelectSegmentDataEvent(
                          index: index, segmentIndex: segmentIndex));
                },
              ),
              TextWidget(
                  segmentData.segmentStatusList![index].status.toString()),
            ],
          );
        });
  }

  Widget _activityRemark({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _locationDiscoverDefectController(
      {required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: AppString.locationOfDiscoveredDefect,
      controller: dataState.locationDiscoverDefectController,
    );
  }

  Widget _ndtAgencyDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectNdtAgency,
      dropdownValue:
          dataState.ndtAgencyData.id != null ? dataState.ndtAgencyData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectNdtAgencyDataEvent(ndtAgencyData: value));
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

  Widget _dSPPLDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDSPPL,
      dropdownValue: dataState.dSPPLAgencyData.id != null
          ? dataState.dSPPLAgencyData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectDspplDataEvent(dspplData: value));
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

  Widget _mECONPBGPLDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectMECONPBGPL,
      dropdownValue:
          dataState.meconPbgplData.id != null ? dataState.meconPbgplData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectMeconPbgplDataEvent(meconPbgplData: value));
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

  Widget _photo({required FetchAddNdtMutDataState dataState}) {
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
                    BlocProvider.of<AddNdtMutBloc>(context).add(
                        AddNdtMutAddImageEvent(context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddNdtMutBloc>(context).add(
                        AddNdtMutAddImageEvent(context: context, mediaType: 2));
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

  Widget _button({required FetchAddNdtMutDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddNdtMutBloc>(context)
                  .add(AddNdtMutSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

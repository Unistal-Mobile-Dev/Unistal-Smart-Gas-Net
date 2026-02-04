import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/polarisationCoupan/addPolarisationCoupan/domain/bloc/add_polarisation_coupan_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddPolarisationCoupanPage extends StatefulWidget {
  const AddPolarisationCoupanPage({super.key});

  @override
  State<AddPolarisationCoupanPage> createState() => _AddPolarisationCoupanPageState();
}

class _AddPolarisationCoupanPageState extends State<AddPolarisationCoupanPage> {
  @override
  void initState() {
    BlocProvider.of<AddPolarisationCoupanBloc>(context)
        .add(AddPolarisationCoupanPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddPolarisationCoupanBloc, AddPolarisationCoupanState>(
        builder: (context, state) {
          if (state is FetchAddPolarisationCoupanState) {
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

  Widget _itemBuilder({required FetchAddPolarisationCoupanState dataState}) {
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
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _areaController(dataState: dataState),
            _verticalSpace(),
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _corrosionDropDown(dataState: dataState),
            _verticalSpace(),
            _distanceController(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _pspMeasurementController(dataState: dataState),
            _verticalSpace(),
            _couponController(dataState: dataState),
            _verticalSpace(),
            _digitalController(dataState: dataState),
            _verticalSpace(),
            _modelController(dataState: dataState),
            _verticalSpace(),
            _makeController(dataState: dataState),
            _verticalSpace(),
            _dateCalibrationController(dataState: dataState),
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

  Widget _dateController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddPolarisationCoupanState dataState}) {
    return  AppConfig.instanceInit()!.client == Client.vppl
        ?  DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    ) : DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
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

  Widget _chainageController(
      {required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanTLPTypeEvent(tlpTypeValue: value));
      },
      items: dataState.listOfTLPType
          .map<DropdownMenuItem<TlpTypeModel>>((TlpTypeModel tlpTypeData) {
        return DropdownMenuItem<TlpTypeModel>(
          value: tlpTypeData,
          child: Text(tlpTypeData.name.toString()),
        );
      }).toList(),
    );
  }


  Widget _areaController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _testStationLocationController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _corrosionDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCorrosion,
      dropdownValue:
      dataState.corrosionValue.id != null ? dataState.corrosionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanCorrosionEvent(corrosionValue: value));
      },
      items: dataState.listOfCorrosion
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _distanceController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDistance,
      controller: dataState.distanceController,
    );
  }

  Widget _cableTerminationDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanCableTerminationEvent(cableTerminationValue: value));
      },
      items: dataState.listOfCableTermination
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _pspMeasurementController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectPSPMeasurement,
      controller: dataState.pspMeasurementController,
    );
  }

  Widget _couponController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCouponInstant,
      controller: dataState.couponController,
    );
  }

  Widget _digitalController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDigitalMultimete,
      controller: dataState.digitalController,
    );
  }

  Widget _modelController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectModelNo,
      controller: dataState.modelController,
    );
  }

  Widget _makeController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectMake,
      controller: dataState.makeController,
    );
  }

  Widget _dateCalibrationController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.selectDateCalibration,
      controller: dataState.dateCalibrationController,
      onTap: (){
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanDateCalibrationEvent(context: context));
      },
    );
  }


  Widget _activityRemark({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddPolarisationCoupanState dataState}) {
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
                    color:  EnvironmentConfig.of(context)!.primaryTheme,
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
                        color:  EnvironmentConfig.of(context)!.primaryTheme,
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
                    BlocProvider.of<AddPolarisationCoupanBloc>(context).add(
                        AddPolarisationCoupanAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddPolarisationCoupanBloc>(context).add(
                        AddPolarisationCoupanAddImageEvent(
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

  Widget _button({required FetchAddPolarisationCoupanState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddPolarisationCoupanBloc>(context)
              .add(AddPolarisationCoupanSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}



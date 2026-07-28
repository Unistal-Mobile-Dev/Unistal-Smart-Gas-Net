import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/bloc/add_tren_ching_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddTrenChingPage extends StatefulWidget {
  const AddTrenChingPage({super.key});

  @override
  State<AddTrenChingPage> createState() => _AddTrenChingPageState();
}

class _AddTrenChingPageState extends State<AddTrenChingPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;
  bool get _isPJPL => _client == Client.pjpl;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddTrenChingBloc>(context)
        .add(AddTrenChingPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddTrenChingBloc, AddTrenChingState>(
        builder: (context, state) {
          if (state is FetchAddTrenChingDataState) {
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

  Widget _itemBuilder({required FetchAddTrenChingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL || _isPJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            if (!(_isHPCL || _isHPOIL || _isPJPL)) ...[
              _detailsStructure(dataState: dataState),
              _verticalSpace(),
              _mimimumCover(dataState: dataState),
              _verticalSpace(),
              _arableSoil(dataState: dataState),
              _verticalSpace(),
              _trenchProfile(dataState: dataState),
              _verticalSpace(),
              if (_isVPPL || _isVRPL || _isBJPL) ...[
                _provisionOfWarningSignsSafetySignsCtrt(dataState: dataState),
                _verticalSpace(),
                if(!(_isVRPL || _isBJPL))...[
                  _verificationOfMinimumDepthCtrl(dataState: dataState),
                  _verticalSpace(),
                  _seismicZoneAndCoverCtrl(dataState: dataState),
                  _verticalSpace(),
                ]
              ],
              if(!( _isBJPL))...[
                _from(dataState: dataState),
                _verticalSpace(),
                _to(dataState: dataState),
                _verticalSpace(),
              ]
            ],
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            if (!(_isVPPL || _isVRPL || _isHPCL || _isHPOIL || _isBJPL || _isPJPL)) ...[
              _ipFromController(dataState: dataState),
              _verticalSpace(),
              _ipToController(dataState: dataState),
              _verticalSpace(),
            ],
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _trenchingDepthController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _toWidthController(dataState: dataState),
            _verticalSpace(),
            if(_isHPOIL)...[
              _bottomWidthController(dataState: dataState),
              _verticalSpace(),
            ],
            if(!(_isMGL || _isHPCL || _isHPOIL || _isPJPL))...[
              _terrainDropDown(dataState: dataState),
              _verticalSpace(),
            ],
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


  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }


  Widget _dateController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: false, value: value));
      },
    );
  }

  Widget _chainageToController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: true, value: value));
      },
    );
  }

  Widget _lengthController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _alignmentDropdown({required FetchAddTrenChingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
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
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddTrenChingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
            dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddTrenChingBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }

  Widget _jointTypeDropDown({required FetchAddTrenChingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
        hint: AppString.selectJointType,
        dropdownValue:
            dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
        onChanged: (value) {
          BlocProvider.of<AddTrenChingBloc>(context).add(
              AddTrenChingSelectJointTypeDataEvent(
                  jointTypeData: value!, context: context));
        },
        items: dataState.jointTypeList);
  }

/*  Widget _fromJointNumberDropDown(
      {required FetchAddTrenChingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddTrenChingBloc>(context).add(
                  AddTrenChingSelectFromJointDataEvent(jointNumberData: value));
            },
            items: dataState.jointFromList
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
          )
        : const DottedLoaderWidget();
  }*/

  Widget _fromJointNumberDropDown({required FetchAddTrenChingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown({required FetchAddTrenChingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

/*  Widget _toJointNumberDropDown(
      {required FetchAddTrenChingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddTrenChingBloc>(context).add(
                  AddTrenChingSelectToJointDataEvent(jointNumberData: value));
            },
            items: dataState.jointToList
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
          )
        : const DottedLoaderWidget();
  }*/

  Widget _trenchingDepthController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: _isBJPL ? "Depth(Mtr)": AppString.trenchingDepth,
      controller: dataState.trenchingDepthController,
    );
  }

  Widget _terrainDropDown({required FetchAddTrenChingDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
      hint: _isBJPL ? "TERRAIN CLASSIFICATION/TYPE OF GROUND" :AppString.selectTerrain,
      dropdownValue: dataState.terrainTypeData.id != null
          ? dataState.terrainTypeData
          : null,
      onChanged: (value) {
        context.read<AddTrenChingBloc>().add(
              AddClearingGradingSelectTerrainEvent(
                terrainTypeData: value!,
              ),
            );
      },
      items: dataState.terrainTypeList,
    );
  }

  Widget _toWidthController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: _isBJPL ? "Width At Top(Mtr)" : AppString.widthMeter,
      controller: dataState.toWidthController,
    );
  }

  Widget _bottomWidthController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "Width At Bottom(Mtr)",
      controller: dataState.bottomWidthController,
    );
  }

  Widget _activityRemark({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _detailsStructure({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Details of Structure",
      controller: dataState.detailsStructureCtrl,
    );
  }

  Widget _mimimumCover({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Availability of mimimum cover",
      controller: dataState.mimimumCoverCtrl,
    );
  }

  Widget _arableSoil({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Separation of Arable soil",
      controller: dataState.arableSoilCtrl,
    );
  }

  Widget _trenchProfile({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Suitability of trench profile for bends",
      controller: dataState.trenchProfileCtrl,
    );
  }

  Widget _provisionOfWarningSignsSafetySignsCtrt(
      {required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Provision of warning signs & safety signs",
      controller: dataState.provisionOfWarningSignsSafetySignsCtrt,
    );
  }

  Widget _verificationOfMinimumDepthCtrl(
      {required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Verification of minimum depth w.r.t. padding in rocky area",
      controller: dataState.verificationOfMinimumDepthCtrl,
    );
  }

  Widget _seismicZoneAndCoverCtrl(
      {required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Seismic zone and cover requirements by MEIL",
      controller: dataState.seismicZoneAndCoverCtrl,
    );
  }

  Widget _from({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "From",
      controller: dataState.fromCtrl,
    );
  }

  Widget _to({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      labelText: "To",
      controller: dataState.toCtrl,
    );
  }

  Widget _ipFromController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: "IP From",
      controller: dataState.ipFromCtrl,
    );
  }

  Widget _ipToController({required FetchAddTrenChingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: "IP To",
      controller: dataState.ipToCtrl,
    );
  }

  Widget _photo({required FetchAddTrenChingDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddTrenChingBloc>(context)
            .add(AddTrenChingAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddTrenChingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddTrenChingBloc>(context)
                  .add(AddTrenChingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

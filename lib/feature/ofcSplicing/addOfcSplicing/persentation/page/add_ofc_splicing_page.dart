import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/domain/bloc/add_ofc_splicing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddOfcSplicingPage extends StatefulWidget {
  const AddOfcSplicingPage({super.key});

  @override
  State<AddOfcSplicingPage> createState() => _AddOfcSplicingPageState();
}

class _AddOfcSplicingPageState extends State<AddOfcSplicingPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddOfcSplicingBloc>(context)
        .add(AddOfcSplicingPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddOfcSplicingBloc, AddOfcSplicingState>(
        builder: (context, state) {
          if (state is FetchAddOfcSplicingDataState) {
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

  Widget _itemBuilder({required FetchAddOfcSplicingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL)...[
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
            _srNumberSplicingMachineController(dataState: dataState),
            _verticalSpace(),
            _makeModelMachineController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoPlusDirectionController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoMinusDirectionController(dataState: dataState),
            _verticalSpace(),
            _cableReadingPlusDirectionController(dataState: dataState),
            _verticalSpace(),
            _cableReadingMinusDirectionController(dataState: dataState),
            _verticalSpace(),
           /* _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _jointPitController(dataState: dataState),
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

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _dateController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddOfcSplicingBloc>(context)
            .add(AddOfcSplicingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddOfcSplicingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddOfcSplicingBloc>(context)
            .add(AddOfcSplicingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddOfcSplicingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddOfcSplicingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown(
      {required FetchAddOfcSplicingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      isRequired: true,
            hint: AppString.selectJointNumber,
            dropdownValue: dataState.jointNumberData.id != null
                ? dataState.jointNumberData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddOfcSplicingBloc>(context).add(
                  AddOfcSplicingSelectJointNumberDataEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointNumberList
          )
        : const DottedLoaderWidget();
  }

  Widget _chainageFromController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _srNumberSplicingMachineController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.srNoSplicingMachine,
      controller: dataState.srNumberSplicingMachineController,
    );
  }

  Widget _makeModelMachineController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.makeModel,
      controller: dataState.makeModelMachineController,
    );
  }

  Widget _ofcDrumNoPlusDirectionController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ofcDrumNoPlusDirection,
      controller: dataState.ofcDrumNoPlusDirectionController,
    );
  }

  Widget _ofcDrumNoMinusDirectionController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ofcDrumNoMinusDirection,
      controller: dataState.ofcDrumNoMinusDirectionController,
    );
  }

  Widget _cableReadingPlusDirectionController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.cableReadingPlusDirection,
      controller: dataState.cableReadingPlusDirectionController,
    );
  }

  Widget _cableReadingMinusDirectionController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.cableReadingMinusDirection,
      controller: dataState.cableReadingMinusDirectionController,
    );
  }

  Widget _jointPitController(
      {required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.pitNumber,
      controller: dataState.jointPitController,
    );
  }

  Widget _activityRemark({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddOfcSplicingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddOfcSplicingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddOfcSplicingBloc>(context)
                  .add(AddOfcSplicingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

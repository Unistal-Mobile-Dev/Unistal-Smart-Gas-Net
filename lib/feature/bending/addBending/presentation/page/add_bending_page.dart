import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/bending_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddBendingPage extends StatefulWidget {
  const AddBendingPage({super.key});

  @override
  State<AddBendingPage> createState() => _AddBendingPageState();
}

class _AddBendingPageState extends State<AddBendingPage> {
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
    BlocProvider.of<AddBendingBloc>(context)
        .add(AddBendingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddBendingBloc, AddBendingState>(
        builder: (context, state) {
          if (state is FetchAddBendingDataState) {
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

  Widget _itemBuilder({required FetchAddBendingDataState dataState}) {
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
            _pipeDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _gaugingChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _disbomdmentChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _bendingTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _bendNumberController(dataState: dataState),
            _verticalSpace(),
            _bendTpNumber(dataState: dataState),
            _verticalSpace(),
            _bendAngleDegreeController(dataState: dataState),
            _verticalSpace(),
            _bendAngleMinuteController(dataState: dataState),
            _verticalSpace(),
            _bendAngleSecondController(dataState: dataState),
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

  Widget _dateController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddBendingBloc>(context).add(AddBendingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _pipeDropDown({required FetchAddBendingDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddBendingBloc>(context).add(
              AddBendingAddSearchPipeDataEvent(
                  keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddBendingBloc>(context)
              .add(AddBendingSelectSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.searchPipeList);
  }

  Widget _chainageController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _visualChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null
          ? dataState.visualChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context)
            .add(AddBendingSelectVisualDataEvent(visualChecksData: value!));
      },
      items: dataState.visualChecksList,
    );
  }

  Widget _gaugingChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectGaugingChecks,
      dropdownValue: dataState.gaugingChecksData.id != null
          ? dataState.gaugingChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context)
            .add(AddBendingSelectGaugingEvent(gaugingChecksData: value!));
      },
      items: dataState.gaugingChecksList,
    );
  }

  Widget _disbomdmentChecksDropDown(
      {required FetchAddBendingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectDisbomdmentChecks,
      dropdownValue: dataState.disbomdmentChecksData.id != null
          ? dataState.disbomdmentChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectDisbomdmentEvent(disbomdmentChecksData: value!));
      },
      items: dataState.disbomdmentChecksList,
    );
  }

  Widget _holidayChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget<HolidayChecksModel>(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context)
            .add(AddBendingSelectHolidayDataEvent(holidayChecksData: value!));
      },
      items: dataState.holidayChecksList,
    );
  }

  Widget _bendingTypeDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget<BendingTypeModel>(
      hint: AppString.selectBendingType,
      dropdownValue: dataState.bendingTypeData.id != null
          ? dataState.bendingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context)
            .add(AddBendingSelectBendingTypeEvent(bendingTypeData: value!));
      },
      items: dataState.bendingTypeList,
    );
  }

  Widget _bendNumberController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendNumber,
      controller: dataState.bendNumberController,
    );
  }

  Widget _bendTpNumber({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleTpNumber,
      controller: dataState.bendAngleTpNumberController,
    );
  }

  Widget _bendAngleDegreeController(
      {required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleDegree,
      controller: dataState.bendAngleDegreeController,
    );
  }

  Widget _bendAngleMinuteController(
      {required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleMinute,
      controller: dataState.bendAngleMinuteController,
    );
  }

  Widget _bendAngleSecondController(
      {required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleSecond,
      controller: dataState.bendAngleSecondController,
    );
  }

  Widget _activityRemark({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddBendingDataState dataState}) {
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
        BlocProvider.of<AddBendingBloc>(context)
            .add(AddBendingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList,
    );
  }
  Widget _photo({required FetchAddBendingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }


  Widget _button({required FetchAddBendingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddBendingBloc>(context)
                  .add(AddBendingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

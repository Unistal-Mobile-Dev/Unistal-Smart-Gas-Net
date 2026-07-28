import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/domain/add_rou_handover_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddRouHandoverPage extends StatefulWidget {
  const AddRouHandoverPage({super.key});

  @override
  State<AddRouHandoverPage> createState() => _AddRouHandoverPageState();
}

class _AddRouHandoverPageState extends State<AddRouHandoverPage> {
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
    BlocProvider.of<AddRouHandoverBloc>(context)
        .add(AddRouHandoverLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRouHandoverBloc, AddRouHandoverState>(
        builder: (context, state) {
          if (state is FetchAddRouHandoverDataState) {
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

  Widget _itemBuilder({required FetchAddRouHandoverDataState dataState}) {
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
            if(!_isPJPL)...[
              _tenderNoController(dataState: dataState),
              _verticalSpace(),
            ],
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _lengthField(dataState: dataState),
            _verticalSpace(),
            _typeofGround(dataState: dataState),
            _verticalSpace(),
            _tpIpNOSController(dataState: dataState),
            _verticalSpace(),
            _tpRemarkController(dataState: dataState),
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


  Widget _dateController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRouHandoverBloc>(context)
            .add(AddRouHandoverSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _tenderNoController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      labelText: "Tender No",
      controller: dataState.tenderNoController,
    );
  }

  Widget _chainageFromController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddRouHandoverBloc>(context).add(
          CalculateLengthEvent(
            isChainageTo: false,
            value: value,
            context: context,
          ),
        );
      },
    );
  }

  Widget _chainageToController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddRouHandoverBloc>(context).add(
          CalculateLengthEvent(
            isChainageTo: true,
            value: value,
            context: context,
          ),
        );
      },
    );
  }

  Widget _lengthField({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _typeofGround({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: _isBJPL ? "TERRAIN DETAILS" :AppString.typeofGround,
      controller: dataState.typeofGroundController,
    );
  }

  Widget _tpIpNOSController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: _isBJPL ? TextInputType.text: TextInputType.number,
      labelText:  _isBJPL ? "DETAIL OF SKIPPING IF ANY" : "IP/TP No.",
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _tpRemarkController({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      maxLine: 2,
      labelText: _isBJPL
          ? "DETAIL OF HINDRENSE/OBSTACLES"
          :"OTHER DETAILS (If Any) Details of Structures, P/L, HT, Crossing",
      controller: dataState.tpRemarkController,
    );
  }

  Widget _activityRemark({required FetchAddRouHandoverDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddRouHandoverDataState dataState}) {
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
        BlocProvider.of<AddRouHandoverBloc>(context)
            .add(AddRouHandoverMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddRouHandoverDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
            dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddRouHandoverBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }
  Widget _photo({required FetchAddRouHandoverDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddRouHandoverBloc>(context).add(
            AddRouHandoverAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddRouHandoverBloc>(context).add(
            AddRouHandoverAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddRouHandoverDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddRouHandoverBloc>(context)
                  .add(AddRouHandoverSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

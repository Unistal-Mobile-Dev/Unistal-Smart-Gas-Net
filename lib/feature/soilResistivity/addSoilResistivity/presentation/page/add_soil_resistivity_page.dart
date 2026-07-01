import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/domain/bloc/add_soil_resistivity_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddSoilResistivityPage extends StatefulWidget {
  const AddSoilResistivityPage({super.key});

  @override
  State<AddSoilResistivityPage> createState() => _AddSoilResistivityPageState();
}

class _AddSoilResistivityPageState extends State<AddSoilResistivityPage> {
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
    BlocProvider.of<AddSoilResistivityBloc>(context)
        .add(AddSoilResistivityPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddSoilResistivityBloc, AddSoilResistivityState>(
        builder: (context, state) {
          if (state is FetchAddSoilResistivityDataState) {
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

  Widget _itemBuilder({required FetchAddSoilResistivityDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL  ||_isVRPL || _isBJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _depthController(dataState: dataState),
            _verticalSpace(),
            _readingController(dataState: dataState),
            _verticalSpace(),
            _multiplierController(dataState: dataState),
            _verticalSpace(),
            _resisitivityController(dataState: dataState),
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

  Widget _dateController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSoilResistivityBloc>(context)
            .add(AddSoilResistivitySelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _depthController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Depth in Mtr(D)",
      controller: dataState.depthController,
    );
  }

  Widget _readingController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Reading in OHM(R)",
      controller: dataState.readingController,
    );
  }

  Widget _multiplierController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Multiplier 2D π",
      controller: dataState.multiplierController,
    );
  }

  Widget _resisitivityController({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Resisitivity in OHM-MTR(2DR) π",
      controller: dataState.resisitivityController,
    );
  }



  Widget _activityRemark({required FetchAddSoilResistivityDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSoilResistivityDataState dataState}) {
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
        BlocProvider.of<AddSoilResistivityBloc>(context)
            .add(AddSoilResistivityMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSoilResistivityDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSoilResistivityBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }
  Widget _photo({required FetchAddSoilResistivityDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddSoilResistivityBloc>(context).add(
            AddSoilResistivityAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddSoilResistivityBloc>(context).add(
            AddSoilResistivityAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddSoilResistivityDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddSoilResistivityBloc>(context)
                  .add(AddSoilResistivitySubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddStringingPage extends StatefulWidget {
  const AddStringingPage({super.key});

  @override
  State<AddStringingPage> createState() => _AddStringingPageState();
}

class _AddStringingPageState extends State<AddStringingPage> {
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
  bool get _isAllClient => _isVPPL || _isVRPL || _isBJPL || _isURJAGATI || _isGJPL || _isMGL || _isPJPL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddStringingBloc>(context)
        .add(AddStringingPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddStringingBloc, AddStringingState>(
        builder: (context, state) {
          if (state is FetchAddStringingDataState) {
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

  Widget _itemBuilder({required FetchAddStringingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if (_isVPPL || _isVRPL || _isBJPL || _isPJPL) ...[
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
            if (_isAllClient && !_isBJPL) ...[
              _verticalSpace(),
              _corrosionCoatingController(dataState: dataState),
              _verticalSpace(),
              if(_isPJPL)...[
                _fromController(dataState: dataState),
                _verticalSpace(),
                _toController(dataState: dataState),
                _verticalSpace(),
              ],
              if(!_isPJPL)...[
                _nameManufactureDropDown(dataState: dataState),
                _verticalSpace(),
              ],
              _weightCoatingDropDown(dataState: dataState),
              _verticalSpace(),
            ],
            _pipeLengthController(dataState: dataState),
            _pipeLengthListWidget(dataState: dataState),
            if (_isAllClient) ...[
              _concreteCoatingDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddStringingBloc>(context)
            .add(AddStringingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddStringingDataState dataState, required int index}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController[index],
    );
  }

  Widget _pipeLengthController({required FetchAddStringingDataState dataState}) {
    return Row(
      children: [
        Expanded(
          child: SearchTextField(
              isLoader: dataState.searchPipeLoader,
              onChange: (value) {
                if (value.toString().isNotEmpty) {
                  BlocProvider.of<AddStringingBloc>(context).add(
                      AddStringingSearchPipeDataEvent(
                          keyword: value, context: context));
                }
              },
              onClick: (value) {
                BlocProvider.of<AddStringingBloc>(context)
                    .add(AddStringingSelectPipeDataEvent(pipeData: value));
              },
              controller: dataState.searchPipeController,
              label: AppString.selectPipeNumber,
              list: dataState.searchPipeList),
        ),
        ButtonWidget(
            text: AppString.add,
            onPressed: () {
              BlocProvider.of<AddStringingBloc>(context)
                  .add(AddStringingAddPipeLengthEvent(context: context));
            })
      ],
    );
  }

  Widget _pipeLengthListWidget({required FetchAddStringingDataState dataState,}) {
    if (dataState.pipeLengthList.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Column(
      children: [
        ListView.separated(
          itemCount: dataState.pipeLengthList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => _verticalSpace(),
          itemBuilder: (context, index) {
            PipeModel pipeData = dataState.pipeLengthList[index];
            return Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: EnvironmentConfig.of(context)!.primaryTheme.withValues(alpha: 0.50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<AddStringingBloc>(context).add(
                            AddStringingDeletePipeLengthEvent(
                              context: context,
                              index: index,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  _verticalSpace(),
                  Row(
                    children: [
                      Flexible(
                        child: TextFieldWidget(
                          isRequired: true,
                          textInputType: TextInputType.number,
                          labelText: "Ch From",
                          fontSize: 8,
                          fontWeight: FontWeight.w100,
                          controller:
                          dataState.chainageFromController[index],
                          onChanged: (value) {
                            if (value.toString().isNotEmpty) {
                              BlocProvider.of<AddStringingBloc>(context).add(
                                AddStringingChainageFromAddEvent(
                                  context: context,
                                  index: index,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: TextFieldWidget(
                          enabled: false,
                          textInputType: TextInputType.number,
                          labelText: "Ch To",
                          controller:
                          dataState.chainageToController[index],
                        ),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: TextFieldWidget(
                          enabled: false,
                          textInputType: TextInputType.number,
                          labelText: "Length(m)",
                          controller: TextEditingController(
                            text: pipeData.pipeLength.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        _verticalSpace(),
      ],
    );
  }

  Widget _chainageToController(
      {required FetchAddStringingDataState dataState, required int index}) {
    return TextFieldWidget(
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController[index],
    );
  }

/*  Widget _pipeDropDown({required FetchAddStringingDataState dataState}) {
    LoginDataModel userData =  UserInfo.instanceInit()!.userData!;
    return  DropDownSearchWidget(
      selectedItem: dataState.pipeData.id != null ? dataState.pipeData  : null,
      hint: AppString.selectPipeNumber,
      items: dataState.pipeList,
      itemAsString: (pipeData) => pipeData.pipeNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingSelectPipeDataEvent(pipeData: value));
      },
    );
  }*/

  Widget _concreteCoatingDropDown({required FetchAddStringingDataState dataState}) {
    return DropdownWidget<ConcreteCoatingModel>(
        hint: _isPJPL ? "Coating Damage(if any)" : AppString.selectConcreteCoating,
        dropdownValue: dataState.concreteCoatingData.id != null
            ? dataState.concreteCoatingData
            : null,
        onChanged: (value) {
          BlocProvider.of<AddStringingBloc>(context).add(
              AddStringingSelectConcreteCoatingEvent(
                  concreteCoatingData: value!));
        },
        items: dataState.concreteCoatingList);
  }

  Widget _activityRemark({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddStringingDataState dataState}) {
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
        BlocProvider.of<AddStringingBloc>(context)
            .add(AddStringingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddStringingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
        dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddStringingBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }

  Widget _corrosionCoatingController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Type of corrosion coating",
      controller: dataState.corrosionCoatingCtrl,
    );
  }
  Widget _fromController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      labelText: "From",
      controller: dataState.fromCtrl,
    );
  }
  Widget _toController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      labelText: "To",
      controller: dataState.toCtrl,
    );
  }

  Widget _nameManufactureDropDown({required FetchAddStringingDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Name of the Manufacture",
        dropdownValue: dataState.manufactureData.id != null
            ? dataState.manufactureData
            : null,
        onChanged: (value) {
          BlocProvider.of<AddStringingBloc>(context)
              .add(SelectNameManufactureEvent(nameManufactureData: value!));
        },
        items: dataState.manufactureList);
  }

  Widget _weightCoatingDropDown({required FetchAddStringingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: _isPJPL ? "Concreate coating" : "Concrete weight coating",
      dropdownValue: dataState.weightCoatingData.id != null
          ? dataState.weightCoatingData
          : null,
      onChanged: (value) {
        context.read<AddStringingBloc>().add(
          SelectWeightCoatingEvent(
            weightCoatingData: value!,
          ),
        );
      },
      items: dataState.weightCoatingList,
    );
  }

  Widget _photo({required FetchAddStringingDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddStringingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddStringingBloc>(context)
              .add(AddStringingSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
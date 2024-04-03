import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/domain/bloc/add_tiein_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

class AddTieinPage extends StatefulWidget {
  const AddTieinPage({super.key});

  @override
  State<AddTieinPage> createState() => _AddTieinPageState();
}

class _AddTieinPageState extends State<AddTieinPage> {

  @override
  void initState() {
    BlocProvider.of<AddTieinBloc>(context).add(AddTieinPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddTieinBloc, AddTieinState>(
        builder: (context, state) {
          if(state is FetchAddTieinDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddTieinDataState dataState}) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child : Column(
              children: [
                _verticalSpace(),
                _dateController(dataState: dataState),
                _verticalSpace(),
                _alignmentDropdown(dataState: dataState),
                _verticalSpace(),
                _weatherDropDown(dataState: dataState),
                _verticalSpace(),
                _jointTypeDropDown(dataState: dataState),
                _verticalSpace(),
                _jointNumberDropDown(dataState: dataState),
                _verticalSpace(),
                _wpsDropDown(dataState: dataState),
                _verticalSpace(),
                _chainageFromController(dataState: dataState),
                _verticalSpace(),
                _chainageToController(dataState: dataState),
                _verticalSpace(),
                _electrodeDiaE6010Controller(dataState: dataState),
                _verticalSpace(),
                _electrodeDiaE6010BatchController(dataState: dataState),
                _verticalSpace(),
                _electrodeEiaE7010p1Controller(dataState: dataState),
                _verticalSpace(),
                _electrodeEiaE7010p1BatchController(dataState: dataState),
                _verticalSpace(),
                _leftPipeDropDown(dataState: dataState),
                _verticalSpace(),
                _rigthPipeDropDown(dataState: dataState),
                _verticalSpace(),
                _fitupDropDown(dataState: dataState),
                _verticalSpace(),
                _preheatTempController(dataState: dataState),
                _verticalSpace(),
                _rootWelders1Dropdown(dataState: dataState),
                _verticalSpace(),
                _weldVisualDropDown(dataState: dataState),
                _verticalSpace(),
                _activityRemark(dataState: dataState),
                _verticalSpace(),
                _photo(dataState: dataState),
                _verticalSpace(),
                _verticalSpace(),
                _button(dataState: dataState),
              ],
            )
        )
    );
  }

  Widget _dateController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectDateEvent(context: context,));
      },
    );
  }

  Widget _preheatTempController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.preHeatTemperature,
      controller: dataState.preheatTempController,
    );
  }

  Widget _chainageFromController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }
  Widget _leftPipeDropDown({required FetchAddTieinDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchLeftPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSearchPipeDataEvent(keyword: value, context: context, isLeftPipe: true, isRightPipe: false)
          );
        },
        onClick: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectLeftPipeDataEvent(leftPipeData: value));
        },
        controller: dataState.searchLeftPipeController,
        label: AppString.selectLeftPipeNumber,
        list: dataState.searchLeftPipeList
    );
  }

  Widget _rigthPipeDropDown({required FetchAddTieinDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchRightPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSearchPipeDataEvent(keyword: value, context: context, isLeftPipe: false, isRightPipe: true)
          );
        },
        onClick: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectRightPipeDataEvent(rightPipeData: value));
        },
        controller: dataState.searchPipeRightController,
        label: AppString.selectRightPipeNumber,
        list: dataState.searchRightPipeList
    );
  }

  Widget _rootWelders1Dropdown({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.selectWelder,
      dropdownValue: dataState.welderData.id != null ? dataState.welderData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectWelderEvent(welderData: value));
      },
      items: dataState.rootWelders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _rootWelders2Dropdown({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.rootWelders2,
      dropdownValue: dataState.rootWelders2Data.id != null ? dataState.rootWelders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.rootWelders2));
      },
      items: dataState.rootWelders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _hotWelders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.hotWelders,
      dropdownValue: dataState.hotWelders1Data.id != null ? dataState.hotWelders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.hotWelders1));
      },
      items: dataState.hotWelders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _hotWelders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.hotWelders2,
      dropdownValue: dataState.hotWelders2Data.id != null ? dataState.hotWelders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.hotWelders2));
      },
      items: dataState.hotWelders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler1Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.fillerWelders,
      dropdownValue: dataState.filler1Welders1Data.id != null ? dataState.filler1Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler1Welders1));
      },
      items: dataState.filler1Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler1Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler1Welders2,
      dropdownValue: dataState.filler1Welders2Data.id != null ? dataState.filler1Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler1Welders2));
      },
      items: dataState.filler1Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler2Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler2Welders1,
      dropdownValue: dataState.filler2Welders1Data.id != null ? dataState.filler2Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler2Welders1));
      },
      items: dataState.filler2Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler2Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler2Welders2,
      dropdownValue: dataState.filler2Welders2Data.id != null ? dataState.filler2Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler2Welders2));
      },
      items: dataState.filler2Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler3Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler3Welders1,
      dropdownValue: dataState.filler3Welders1Data.id != null ? dataState.filler3Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler3Welders1));
      },
      items: dataState.filler3Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler3Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler3Welders2,
      dropdownValue: dataState.filler3Welders2Data.id != null ? dataState.filler3Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler3Welders2));
      },
      items: dataState.filler3Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler4Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler4Welders1,
      dropdownValue: dataState.filler4Welders1Data.id != null ? dataState.filler4Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler4Welders1));
      },
      items: dataState.filler4Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler4Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler4Welders2,
      dropdownValue: dataState.filler4Welders2Data.id != null ? dataState.filler4Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler4Welders2));
      },
      items: dataState.filler4Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler5Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler5Welders1,
      dropdownValue: dataState.filler5Welders1Data.id != null ? dataState.filler5Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler5Welders1));
      },
      items: dataState.filler5Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler5Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler5Welders2,
      dropdownValue: dataState.filler5Welders2Data.id != null ? dataState.filler5Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler5Welders2));
      },
      items: dataState.filler5Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }


  Widget _filler6Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler6Welders1,
      dropdownValue: dataState.filler6Welders1Data.id != null ? dataState.filler6Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler6Welders1));
      },
      items: dataState.filler6Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler6Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler6Welders2,
      dropdownValue: dataState.filler6Welders2Data.id != null ? dataState.filler6Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler6Welders2));
      },
      items: dataState.filler6Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler7Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler7Welders1,
      dropdownValue: dataState.filler7Welders1Data.id != null ? dataState.filler7Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler7Welders1));
      },
      items: dataState.filler7Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler7Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler7Welders2,
      dropdownValue: dataState.filler7Welders2Data.id != null ? dataState.filler7Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler7Welders2));
      },
      items: dataState.filler7Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler8Welders1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler8Welders1,
      dropdownValue: dataState.filler8Welders1Data.id != null ? dataState.filler8Welders1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler8Welders1));
      },
      items: dataState.filler8Welders1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _filler8Welders2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.filler8Welders2,
      dropdownValue: dataState.filler8Welders2Data.id != null ? dataState.filler8Welders2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.filler8Welders2));
      },
      items: dataState.filler8Welders2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _stripWelder1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.stripWelder1,
      dropdownValue: dataState.stripWelder1Data.id != null ? dataState.stripWelder1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.stripWelder1));
      },
      items: dataState.stripWelder1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _stripWelder2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.stripWelder2,
      dropdownValue: dataState.stripWelder2Data.id != null ? dataState.stripWelder2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.stripWelder2));
      },
      items: dataState.stripWelder2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _cappingWelder1Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.cappingWelder,
      dropdownValue: dataState.cappingWelder1Data.id != null ? dataState.cappingWelder1Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.cappingWelder1));
      },
      items: dataState.cappingWelder1List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _cappingWelder2Controller({required FetchAddTieinDataState dataState}) {
    return  DropdownWidget(
      hint: AppString.cappingWelder2,
      dropdownValue: dataState.cappingWelder2Data.id != null ? dataState.cappingWelder2Data : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectMultiWelderEvent(welderData: value, name: AppString.cappingWelder2));
      },
      items: dataState.cappingWelder2List.map<DropdownMenuItem<WelderModel>>((WelderModel welderData) {
        return DropdownMenuItem<WelderModel>(
          value: welderData,
          child: Text(welderData.welderName.toString()),
        );
      }).toList(),
    );
  }

  Widget _electrodeDiaE6010Controller({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.electrodeDiaE6010,
      controller: dataState.electrodeDiaE6010Controller,
    );
  }

  Widget _electrodeDiaE6010BatchController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrodeDiaE6010Batch,
      controller: dataState.electrodeDiaE6010BatchController,
    );
  }

  Widget _electrodeEiaE7010p1Controller({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.electrodeDiaE7010P1,
      controller: dataState.electrodeEiaE8010p1Controller,
    );
  }

  Widget _electrodeEiaE7010p1BatchController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrodeDiaE7010P1Batch,
      controller: dataState.electrodeEiaE8010p1BatchController,
    );
  }

  Widget _electrodeDiaE9045p2Controller({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.electrodeDiaE9045p2,
      controller: dataState.electrodeDiaE9045p2Controller,
    );
  }

  Widget _electrodeDiaE9045p2BatchController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrodeDiaE9045p2Batch,
      controller: dataState.electrodeDiaE9045p2BatchController,
    );
  }

  Widget _electrodeDiaE81t8gController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.electrodeDiaE81t8g,
      controller: dataState.electrodeDiaE81t8gController,
    );
  }

  Widget _electrodeDiaE81t8gBatchController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrodeDiaE81t8gBatch,
      controller: dataState.electrodeDiaE81t8gBatchController,
    );
  }

  Widget _activityRemark({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddTieinDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            SelectWeatherEvent(weatherData: value));
      },
      items: dataState.weatherList.map<DropdownMenuItem<WeatherModel>>((WeatherModel weatherData) {
        return DropdownMenuItem<WeatherModel>(
          value: weatherData,
          child: Text(weatherData.name.toString()),
        );
      }).toList(),
    );
  }



  Widget _wpsDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWPS,
      dropdownValue: dataState.wpsData.id != null ? dataState.wpsData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectWPSEvent(wpsData: value, context: context));
      },
      items: dataState.wpsList.map<DropdownMenuItem<WPSModel>>((WPSModel wpsData) {
        return DropdownMenuItem<WPSModel>(
          value: wpsData,
          child: Text(wpsData.wps.toString()),
        );
      }).toList(),
    );
  }

  Widget _jointTypeDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectJointTypeEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _jointNumberDropDown({required FetchAddTieinDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointNumberData.id != null ? dataState.jointNumberData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectJointNumberEvent(jointNumberData: value));
      },
      items: dataState.jointNumberList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _fitupDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectFitup,
      dropdownValue: dataState.fitupData.id != null ? dataState.fitupData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectFitupDataEvent(fitupData: value));
      },
      items: dataState.fitupList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel fitupData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: fitupData,
          child: Text(fitupData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _weldVisualDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeldVisual,
      dropdownValue: dataState.weldVisualData.id != null ? dataState.weldVisualData : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            AddTieinSelectWeldVisualEvent(weldVisualData: value));
      },
      items: dataState.weldVisualList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel welderData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: welderData,
          child: Text(welderData.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _photo({required FetchAddTieinDataState dataState}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height:MediaQuery.of(context).size.width/3,
      child: InkWell(
        onTap: () {
          mediaType(context: context);
        },
        child: DottedBorder(
          color: AppColor.grey,
          strokeWidth: 1,
          child: dataState.file == null
              ||dataState.file.path.isEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Icon(Icons.photo_camera_back_outlined),),
              Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: TextWidget("Photo",
                  fontSize: AppFont.font_12,
                  color: AppColor.grey,),
              ),
            ],
          ):Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dataState.file.path.toString().toLowerCase().contains(".jpg")
                      || dataState.file.path.toString().toLowerCase().contains(".png")
                      || dataState.file.path.toString().toLowerCase().contains(".jpeg")
                      ? Image.file(dataState.file,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width/3,
                    height: MediaQuery.of(context).size.width/4.5 ,)
                      : dataState.file.path.toString().toLowerCase().contains(".pdf")
                      ? Icon(Icons.picture_as_pdf_outlined)
                      : Icon(Icons.document_scanner_outlined),
                  TextWidget(dataState.file.path.split('/').last.toString(),
                    color: AppColor.themeColor, fontSize: AppFont.font_12,),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width/3,
                  height:MediaQuery.of(context).size.width/3,
                  color : Colors.white.withOpacity(0.6),
                  child: Center(child: Icon(Icons.refresh, color: AppColor.themeColor,))),

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
              TextButton(onPressed: () {
                BlocProvider.of<AddTieinBloc>(context).add(AddTieinAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddTieinBloc>(context).add(AddTieinAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddTieinDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddTieinBloc>(context).add(AddTieinSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

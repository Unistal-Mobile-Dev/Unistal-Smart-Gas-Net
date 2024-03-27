import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/domain/bloc/add_dpt_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/domain/bloc/add_dpt_state.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

import '../../domain/bloc/add_dpt_bloc.dart';

class AddDptPage extends StatefulWidget {
  const AddDptPage({super.key});

  @override
  State<AddDptPage> createState() => _AddDptPageState();
}

class _AddDptPageState extends State<AddDptPage> {

  @override
  void initState() {
    BlocProvider.of<AddDptBloc>(context).add(AddDptPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddDptBloc, AddDptState>(
        builder: (context, state) {
          if(state is FetchAddDptDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddDptDataState dataState}){
    return Container(
      margin: const EdgeInsets.all(10),
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
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _pipeLengthController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _dptTestController(dataState: dataState),
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

  Widget _dateController({required FetchAddDptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddDptBloc>(context).add(
            AddDptSelectDateEvent(context: context,));
      },
    );
  }

  Widget _alignmentDropdown({required FetchAddDptDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddDptBloc>(context).add(
            AddDptSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddDptDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddDptBloc>(context).add(
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

  Widget _pipeLengthController({required FetchAddDptDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddDptBloc>(context).add(
              AddDptSearchPipeDataEvent(keyword: value, context: context)
          );
        },
        onClick: (value) {
          BlocProvider.of<AddDptBloc>(context).add(
              AddDptSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.searchPipeList
    );
  }

  Widget _visualChecksDropDown({required FetchAddDptDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null ? dataState.visualChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddDptBloc>(context).add(
            AddDptSelectVisualChecksDataEvent(visualChecksData: value));
      },
      items: dataState.visualsChecksList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksData,
          child: Text(visualChecksData.value.toString()),
        );
      }).toList(),
    );
  }


  Widget _jointTypeDropDown({required FetchAddDptDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddDptBloc>(context).add(
            AddDptSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddDptDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddDptBloc>(context).add(
            AddDptSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _dptTestController({required FetchAddDptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.dptTest,
      controller: dataState.dptTestController,
    );
  }


  Widget _activityRemark({required FetchAddDptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddDptDataState dataState}) {
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
          child: dataState.file.path.isEmpty ?
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
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      :  const Icon(Icons.document_scanner_outlined),
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
                BlocProvider.of<AddDptBloc>(context).add(AddDptAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddDptBloc>(context).add(AddDptAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddDptDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddDptBloc>(context).add(AddDptSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}



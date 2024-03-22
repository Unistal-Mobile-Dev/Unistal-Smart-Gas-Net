import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddBackFillingPage extends StatefulWidget {
  const AddBackFillingPage({super.key});

  @override
  State<AddBackFillingPage> createState() => _AddBackFillingPageState();
}

class _AddBackFillingPageState extends State<AddBackFillingPage> {

  @override
  void initState() {
    BlocProvider.of<AddBackFillingBloc>(context).add(AddBackFillingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddBackFillingBloc, AddBackFillingState>(
        builder: (context, state) {
          if(state is FetchAddBackFillingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddBackFillingDataState dataState}){
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
            _pipeDiaDropDown(dataState: dataState),
            _verticalSpace(),
            _thicknessDropDown(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),

            AppConfig.instanceInit()!.client !=  Client.purvaBharti
            ? Column(
              children: [
                _postPaddingController(dataState: dataState),
                _verticalSpace(),
                _slopeBreakerController(dataState: dataState),
                _verticalSpace(),
                _plasticGratingDropDown(dataState: dataState),
                _verticalSpace(),
                _antiBuoyancyController(dataState: dataState),
                _verticalSpace(),
                _warningMatController(dataState: dataState),
                _verticalSpace(),
              ],
            ) : const SizedBox.shrink(),


            _coverMeterController(dataState: dataState),
            _verticalSpace(),
            _crownController(dataState: dataState),
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

  Widget _dateController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddBackFillingDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
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

  Widget _pipeDiaDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeDia,
      dropdownValue: dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectPipeDiaDataEvent(pipeDiaData: value));
      },
      items: dataState.pipeDialList.map<DropdownMenuItem<PipeDiaModel>>((PipeDiaModel pipeDiaData) {
        return DropdownMenuItem<PipeDiaModel>(
          value: pipeDiaData,
          child: Text(pipeDiaData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _thicknessDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeThickness,
      dropdownValue: dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectThicknessDataEvent(thicknessData: value));
      },
      items: dataState.thicknessList.map<DropdownMenuItem<ThicknessModel>>((ThicknessModel thicknessData) {
        return DropdownMenuItem<ThicknessModel>(
          value: thicknessData,
          child: Text(thicknessData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _jointTypeDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddBackFillingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddBackFillingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _chainageFromController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _postPaddingController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.postPadding,
      controller: dataState.postPaddingController,
    );
  }

  Widget _slopeBreakerController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.slopBreaker,
      controller: dataState.slopeBreakerController,
    );
  }

  Widget _plasticGratingDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPlasticGrating,
      dropdownValue: dataState.plasticGratingData.id != null ? dataState.plasticGratingData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectPlasticGratingEvent(plasticGratingData: value));
      },
      items: dataState.plasticGratingList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel plasticGratingData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: plasticGratingData,
          child: Text(plasticGratingData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _antiBuoyancyController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.antiBuoyancy,
      controller: dataState.antiBuoyancyController,
    );
  }

  Widget _warningMatController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.warningMat,
      controller: dataState.warningMatController,
    );
  }


  Widget _coverMeterController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.coverMeter,
      controller: dataState.coverMeterController,
    );
  }

  Widget _crownController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.crowMeter,
      controller: dataState.crownController,
    );
  }

  Widget _activityRemark({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddBackFillingDataState dataState}) {
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
                BlocProvider.of<AddBackFillingBloc>(context).add(AddBackFillingAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddBackFillingBloc>(context).add(AddBackFillingAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddBackFillingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddBackFillingBloc>(context).add(AddBackFillingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/bloc/add_ndt_aut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';

class AddNdtAutPage extends StatefulWidget {
  const AddNdtAutPage({super.key});

  @override
  State<AddNdtAutPage> createState() => _AddNdtAutPageState();
}

class _AddNdtAutPageState extends State<AddNdtAutPage> {

  @override
  void initState() {
    BlocProvider.of<AddNdtAutBloc>(context).add(AddNdtAutLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddNdtAutBloc, AddNdtAutState>(
        builder: (context, state) {
          if(state is FetchAddNdtAutDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddNdtAutDataState dataState}){
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
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _autStatusDropDown(dataState: dataState),
            _verticalSpace(),
            _defectLocationController(dataState: dataState),
            _verticalSpace(),
            _defectLayerDropDown(dataState: dataState),
            _verticalSpace(),
            _defectTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _wpdTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _welderDropDown(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectDateEvent(context: context,));
      },
    );
  }


  Widget _alignmentDropdown({required FetchAddNdtAutDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
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


  Widget _jointTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectJointTypeEvent(jointTypeModel: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _jointNumberDropDown({required FetchAddNdtAutDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointNumberData.id != null ? dataState.jointNumberData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectJointNumberEvent(jointNumberData: value));
      },
      items: dataState.jointNumberList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _autStatusDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.autStatus,
      dropdownValue: dataState.autStatusData.id != null ? dataState.autStatusData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectAutDataEvent(autStatusData: value));
      },
      items: dataState.autStatusList.map<DropdownMenuItem<AutStatusModel>>((AutStatusModel autStatusData) {
        return DropdownMenuItem<AutStatusModel>(
          value: autStatusData,
          child: Text(autStatusData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _defectLocationController({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.defectLocation,
      controller: dataState.defectLocationController,
    );
  }


  Widget _defectTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.selectedDefectTypeList,
      hint: AppString.defectType,
      items: dataState.defectTypeList,
      itemAsString: (defectTypeData) => defectTypeData.name.toString(),
      onChanged: (selectedItems) {
        List<DefectTypeModel> selectedDefectTypeList = [];
        for(var data in selectedItems){
          selectedDefectTypeList.add(data);
        }
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectDefectTypeEvent(selectedDefectType: selectedDefectTypeList));
      },
    );
  }

  Widget _defectLayerDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.selectedDefectLayerList,
      hint: AppString.defectLayer,
      items: dataState.defectLayerList,
      itemAsString: (defectLayerData) => defectLayerData.value.toString(),
      onChanged: (selectedItems) {
        List<DefectLayerModel> selectedDefectLayerList = [];
        for(var data in selectedItems){
          selectedDefectLayerList.add(data);
        }
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectDefectLayerEvent(selectedDefectLayer: selectedDefectLayerList));
      },
    );
  }

  Widget _wpdTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWPS,
      dropdownValue: dataState.wpsTypeData.id != null ? dataState.wpsTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectWPSTypeEvent(wpsTypeData: value, context: context));
      },
      items: dataState.wpsTypeList.map<DropdownMenuItem<WPSModel>>((WPSModel wpsData) {
        return DropdownMenuItem<WPSModel>(
          value: wpsData,
          child: Text(wpsData.wps.toString()),
        );
      }).toList(),
    );
  }

  Widget _welderDropDown({required FetchAddNdtAutDataState dataState}) {
    return dataState.isWelderLoader == false ?
    DropDownSearchMultiSelectWidget(
      selectedItem: dataState.selectedWelderList,
      hint: AppString.defectWelder,
      items: dataState.welderList,
      itemAsString: (welderData) => welderData.welderName.toString(),
      onChanged: (selectedItems) {
        List<WelderModel> selectedWelderList = [];
        for(var data in selectedItems){
          selectedWelderList.add(data);
        }
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectWelderEvent(selectedWelderList: selectedWelderList));
      },
    ): const DottedLoaderWidget();
  }


  Widget _activityRemark({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddNdtAutDataState dataState}) {
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
                BlocProvider.of<AddNdtAutBloc>(context).add(AddNdtAutAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddNdtAutBloc>(context).add(AddNdtAutAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddNdtAutDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddNdtAutBloc>(context).add(AddNdtAutSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

}


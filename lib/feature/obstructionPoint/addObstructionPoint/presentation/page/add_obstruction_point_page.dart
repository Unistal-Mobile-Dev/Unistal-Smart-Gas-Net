import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/obstructionPoint/addObstructionPoint/domain/add_obstruction_point_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

class AddObstructionPointPage extends StatefulWidget {
  const AddObstructionPointPage({super.key});

  @override
  State<AddObstructionPointPage> createState() => _AddObstructionPointPageState();
}

class _AddObstructionPointPageState extends State<AddObstructionPointPage> {

  @override
  void initState() {
    BlocProvider.of<AddObstructionPointBloc>(context).add(AddObstructionPointPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddObstructionPointBloc, AddObstructionPointState>(
        builder: (context, state) {
          if(state is FetchAddObstructionPointDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddObstructionPointDataState dataState}){
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child : Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  TextWidget("Accuracy :  ", color: AppColor.themeColor,),
                  TextWidget(dataState.accuracy.isNotEmpty ?
                  double.parse(dataState.accuracy.toString()).toStringAsFixed(2)
                      : "0.0", color: AppColor.black, fontWeight: FontWeight.w700,),
                ],)
            ),
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _spreadDropDown(dataState: dataState),
            _verticalSpace(),
            _sectionDropDown(dataState: dataState),
            _verticalSpace(),
            _typeController(dataState: dataState),
            _verticalSpace(),
            _enterOtherController(dataState: dataState),
            _verticalSpace(),
            _nameController(dataState: dataState),
            _verticalSpace(),
            _locationController(dataState: dataState),
            _verticalSpace(),
            _coordinationButton(dataState: dataState),
            _latitudeController(dataState: dataState),
            _verticalSpace(),
            _longitudeController(dataState: dataState),
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

  Widget _dateController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddObstructionPointBloc>(context).add(
            AddObstructionPointSelectDateEvent(context: context,));
      },
    );
  }


  Widget _weatherDropDown({required FetchAddObstructionPointDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddObstructionPointBloc>(context).add(
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

  Widget _spreadDropDown({required FetchAddObstructionPointDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectSpread,
      dropdownValue: dataState.spreadTypeData.id != null ? dataState.spreadTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddObstructionPointBloc>(context).add(
            AddObstructionPointSelectSpreadEvent(spreadTypeData: value,));
      },
      items: dataState.spreadList.map<DropdownMenuItem<SpreadTypeModel>>((SpreadTypeModel spreadTypeData) {
        return DropdownMenuItem<SpreadTypeModel>(
          value: spreadTypeData,
          child: Text(spreadTypeData.spreadName.toString()),
        );
      }).toList(),
    );
  }

  Widget _sectionDropDown({required FetchAddObstructionPointDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectSection,
      dropdownValue: dataState.sectionTypeData.id != null ? dataState.sectionTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddObstructionPointBloc>(context).add(
            AddObstructionPointSelectSectionEvent(sectionTypeData: value,));
      },
      items: dataState.sectionList.map<DropdownMenuItem<SectionTypeModel>>((SectionTypeModel sectionTypeData) {
        return DropdownMenuItem<SectionTypeModel>(
          value: sectionTypeData,
          child: Text(sectionTypeData.sectionName.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }


  Widget _coordinationButton({required FetchAddObstructionPointDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.gpsCoordinate,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddObstructionPointBloc>(context).add(AddObstructionPointCaptureNorthingLocationEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }

  Widget _latitudeController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.latitude,
      controller: dataState.latitudeController,
    );
  }

  Widget _longitudeController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.longitude,
      controller: dataState.longitudeController,
    );
  }

  Widget _nameController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.name,
      controller: dataState.nameController,
    );
  }

  Widget _floorNoController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.floorNo,
      controller: dataState.floorNoController,
    );
  }



  Widget _locationController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }



  Widget _buildingCategoryControlller({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.buildingCategory,
      controller: dataState.buildingCategoryControlller,
    );
  }

  Widget _typeController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.type,
      controller: dataState.typeController,
    );
  }

  Widget _enterOtherController({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.enterOther,
      controller: dataState.enterOtherController,
    );
  }

  Widget _activityRemark({required FetchAddObstructionPointDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddObstructionPointDataState dataState}) {
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
/*                  TextWidget(dataState.file.path.split('/').last.toString(),
                    color: AppColor.themeColor, fontSize: AppFont.font_12,),*/
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
                BlocProvider.of<AddObstructionPointBloc>(context).add(AddObstructionPointAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddObstructionPointBloc>(context).add(AddObstructionPointAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddObstructionPointDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddObstructionPointBloc>(context).add(AddObstructionPointSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

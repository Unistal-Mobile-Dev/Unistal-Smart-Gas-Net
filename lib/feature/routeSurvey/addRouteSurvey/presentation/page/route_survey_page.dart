import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

class AddRouteSurveyPage extends StatefulWidget {
  const AddRouteSurveyPage({super.key});

  @override
  State<AddRouteSurveyPage> createState() => _AddRouteSurveyPageState();
}

class _AddRouteSurveyPageState extends State<AddRouteSurveyPage> {

  @override
  void initState() {
    BlocProvider.of<AddRouteSurveyBloc>(context).add(AddRouteSurveyPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddRouteSurveyBloc, AddRouteSurveyState>(
        builder: (context, state) {
          if(state is FetchAddRouteSurveyDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddRouteSurveyDataState dataState}){
    return Container(
       margin: EdgeInsets.all(10),
       child: SingleChildScrollView(
         child : Column(
           children: [
             _verticalSpace(),
             _dateController(dataState: dataState),
             _verticalSpace(),
             _alignmentDropdown(dataState: dataState),
             _verticalSpace(),
             _chainageFromController(dataState: dataState),
             _verticalSpace(),
             _chainageToController(dataState: dataState),
             _verticalSpace(),
             _weatherDropDown(dataState: dataState),
             _verticalSpace(),
             _tpIpChainageController(dataState: dataState),
             _verticalSpace(),
             _tpIpNOSController(dataState: dataState),
             _verticalSpace(),
             _tpRemarkController(dataState: dataState),
             _verticalSpace(),
             _bearingController(dataState: dataState),
             _verticalSpace(),
             _terrainController(dataState: dataState),
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

  Widget _dateController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRouteSurveyBloc>(context).add(
            AddRouteSurveySelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _tpIpChainageController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.tpFrom,
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpIpNOSController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.tpTo,
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _tpRemarkController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 2,
      labelText: AppString.tpRemark,
      controller: dataState.tpRemarkNumberController,
    );
  }

  Widget _bearingController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bearingAngle,
      controller: dataState.bearingAngleController,
    );
  }

  Widget _terrainController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.terrain,
      controller: dataState.terrainController,
    );
  }

  Widget _chainageFromController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _activityRemark({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddRouteSurveyDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddRouteSurveyBloc>(context).add(
            AddRouteSurveySelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddRouteSurveyDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddRouteSurveyBloc>(context).add(
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

  Widget _photo({required FetchAddRouteSurveyDataState dataState}) {
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
          height: MediaQuery.of(context).size.height * 0.23,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {
                BlocProvider.of<AddRouteSurveyBloc>(context).add(AddRouteSurveyAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddRouteSurveyBloc>(context).add(AddRouteSurveyAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddRouteSurveyDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        onPressed: () {
          BlocProvider.of<AddRouteSurveyBloc>(context).add(AddRouteSurveySubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

}

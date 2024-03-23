import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/valveChamber/addValveChamber/domain/bloc/add_valve_chamber_bloc.dart';

class AddValveChamberPage extends StatefulWidget {
  const AddValveChamberPage({super.key});

  @override
  State<AddValveChamberPage> createState() => _AddValveChamberPageState();
}

class _AddValveChamberPageState extends State<AddValveChamberPage> {

  @override
  void initState() {
    BlocProvider.of<AddValveChamberBloc>(context).add(AddValveChamberPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddValveChamberBloc, AddValveChamberState>(
        builder: (context, state) {
          if(state is FetchAddValveChamberDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddValveChamberDataState dataState}){
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
            _descriptionOfStructureMemberController(dataState: dataState),
            _verticalSpace(),
            _unitWeight(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _weightController(dataState: dataState),
            _verticalSpace(),
            _heightController(dataState: dataState),
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

  Widget _dateController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddValveChamberBloc>(context).add(
            AddValveChamberSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _chainageFromController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.weightController,
    );
  }

  Widget _alignmentDropdown({required FetchAddValveChamberDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddValveChamberBloc>(context).add(
            AddValveChamberSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddValveChamberDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddValveChamberBloc>(context).add(
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



  Widget _descriptionOfStructureMemberController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.description,
      controller: dataState.descriptionOfStructureMemberController,
    );
  }

  Widget _unitWeight({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.unitWeight,
      controller: dataState.unitWeight,
    );
  }

  Widget _lengthController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _weightController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.widthMeter,
      controller: dataState.weightController,
    );
  }

  Widget _heightController({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.height,
      controller: dataState.heightController,
    );
  }



  Widget _activityRemark({required FetchAddValveChamberDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }



  Widget _photo({required FetchAddValveChamberDataState dataState}) {
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
                BlocProvider.of<AddValveChamberBloc>(context).add(AddValveChamberAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddValveChamberBloc>(context).add(AddValveChamberAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddValveChamberDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddValveChamberBloc>(context).add(AddValveChamberSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

}


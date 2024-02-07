import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/domain/bloc/add_ofc_splicing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddOfcSplicingPage extends StatefulWidget {
  const AddOfcSplicingPage({super.key});

  @override
  State<AddOfcSplicingPage> createState() => _AddOfcSplicingPageState();
}

class _AddOfcSplicingPageState extends State<AddOfcSplicingPage> {

  @override
  void initState() {
    BlocProvider.of<AddOfcSplicingBloc>(context).add(AddOfcSplicingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddOfcSplicingBloc, AddOfcSplicingState>(
        builder: (context, state) {
          if(state is FetchAddOfcSplicingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddOfcSplicingDataState dataState}){
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
            _srNumberSplicingMachineController(dataState: dataState),
            _verticalSpace(),
            _makeModelMachineController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoPlusDirectionController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoMinusDirectionController(dataState: dataState),
            _verticalSpace(),
            _cableReadingPlusDirectionController(dataState: dataState),
            _verticalSpace(),
            _cableReadingMinusDirectionController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _jointPitController(dataState: dataState),
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

  Widget _dateController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddOfcSplicingDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddOfcSplicingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
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

  Widget _jointTypeDropDown({required FetchAddOfcSplicingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }


  Widget _jointNumberDropDown({required FetchAddOfcSplicingDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointNumberData.id != null ? dataState.jointNumberData : null,
      onChanged: (value) {
        BlocProvider.of<AddOfcSplicingBloc>(context).add(
            AddOfcSplicingSelectJointNumberDataEvent(jointNumberData: value));
      },
      items: dataState.jointNumberList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ) : const DottedLoaderWidget();
  }

  Widget _chainageFromController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _srNumberSplicingMachineController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.srNoSplicingMachine,
      controller: dataState.srNumberSplicingMachineController,
    );
  }

  Widget _makeModelMachineController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.makeModel,
      controller: dataState.makeModelMachineController,
    );
  }

  Widget _ofcDrumNoPlusDirectionController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ofcDrumNoPlusDirection,
      controller: dataState.ofcDrumNoPlusDirectionController,
    );
  }

  Widget _ofcDrumNoMinusDirectionController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ofcDrumNoMinusDirection,
      controller: dataState.ofcDrumNoMinusDirectionController,
    );
  }

  Widget _cableReadingPlusDirectionController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.cableReadingPlusDirection,
      controller: dataState.cableReadingPlusDirectionController,
    );
  }

  Widget _cableReadingMinusDirectionController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.cableReadingMinusDirection,
      controller: dataState.cableReadingMinusDirectionController,
    );
  }

  Widget _jointPitController({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.pitNumber,
      controller: dataState.jointPitController,
    );
  }


  Widget _activityRemark({required FetchAddOfcSplicingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddOfcSplicingDataState dataState}) {
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
                BlocProvider.of<AddOfcSplicingBloc>(context).add(AddOfcSplicingAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddOfcSplicingBloc>(context).add(AddOfcSplicingAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddOfcSplicingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        onPressed: () {
          BlocProvider.of<AddOfcSplicingBloc>(context).add(AddOfcSplicingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


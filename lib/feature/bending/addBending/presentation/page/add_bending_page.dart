import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/bending_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';

class AddBendingPage extends StatefulWidget {
  const AddBendingPage({super.key});

  @override
  State<AddBendingPage> createState() => _AddBendingPageState();
}

class _AddBendingPageState extends State<AddBendingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: TextWidget("Add Bending",
          color: AppColor.white, fontSize: AppFont.font_16, fontWeight: FontWeight.w700,),
      ),
      body: BlocBuilder<AddBendingBloc, AddBendingState>(
        builder: (context, state) {
          if(state is FetchAddBendingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddBendingDataState dataState}){
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
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _pipeDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _gaugingChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _disbomdmentChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _bendingTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _bendTpNumber(dataState: dataState),
            _verticalSpace(),
            _bendAngleDegreeController(dataState: dataState),
            _verticalSpace(),
            _bendAngleMinuteController(dataState: dataState),
            _verticalSpace(),
            _bendAngleSecondController(dataState: dataState),
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

  Widget _dateController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectDateEvent(context: context,));
      },
    );
  }

  Widget _reportNumberController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _pipeDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeNumber,
      dropdownValue: dataState.pipeData.id != null ? dataState.pipeData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectSelectPipeDataEvent(pipeData: value));
      },
      items: dataState.pipeList.map<DropdownMenuItem<PipeModel>>((PipeModel pipeData) {
        return DropdownMenuItem<PipeModel>(
          value: pipeData,
          child: Text(pipeData.pipeNumber.toString()),
        );
      }).toList(),
    );
  }

  Widget _chainageController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _visualChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null ? dataState.visualChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectVisualDataEvent(visualChecksData: value));
      },
      items: dataState.visualChecksList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksData,
          child: Text(visualChecksData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _gaugingChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectGaugingChecks,
      dropdownValue: dataState.gaugingChecksData.id != null ? dataState.gaugingChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectGaugingEvent(gaugingChecksData: value));
      },
      items: dataState.gaugingChecksList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel gaugingChecksData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: gaugingChecksData,
          child: Text(gaugingChecksData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _disbomdmentChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDisbomdmentChecks,
      dropdownValue: dataState.disbomdmentChecksData.id != null ? dataState.disbomdmentChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectDisbomdmentEvent(disbomdmentChecksData: value));
      },
      items: dataState.disbomdmentChecksList.map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel disbomdmentChecksData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: disbomdmentChecksData,
          child: Text(disbomdmentChecksData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _holidayChecksDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null ? dataState.holidayChecksData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectHolidayDataEvent(holidayChecksData: value));
      },
      items: dataState.holidayChecksList.map<DropdownMenuItem<HolidayChecksModel>>((HolidayChecksModel holidayChecksData) {
        return DropdownMenuItem<HolidayChecksModel>(
          value: holidayChecksData,
          child: Text(holidayChecksData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _bendingTypeDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectBendingType,
      dropdownValue: dataState.bendingTypeData.id != null ? dataState.bendingTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectBendingTypeEvent(bendingTypeData: value));
      },
      items: dataState.bendingTypeList.map<DropdownMenuItem<BendingTypeModel>>((BendingTypeModel bendingTypeData) {
        return DropdownMenuItem<BendingTypeModel>(
          value: bendingTypeData,
          child: Text(bendingTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _bendTpNumber({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.bendAngleTpNumber,
      controller: dataState.bendAngleTpNumberController,
    );
  }

  Widget _bendAngleDegreeController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleDegree,
      controller: dataState.bendAngleDegreeController,
    );
  }

  Widget _bendAngleMinuteController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleMinute,
      controller: dataState.bendAngleMinuteController,
    );
  }

  Widget _bendAngleSecondController({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.bendAngleSecond,
      controller: dataState.bendAngleSecondController,
    );
  }


  Widget _activityRemark({required FetchAddBendingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddBendingDataState dataState}) {
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
            AddBendingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddBendingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddBendingBloc>(context).add(
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

  Widget _photo({required FetchAddBendingDataState dataState}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height:MediaQuery.of(context).size.width/3,
      child: InkWell(
        onTap: () {
          BlocProvider.of<AddBendingBloc>(context).add(AddBendingAddImageEvent(context: context));
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

  Widget _button({required FetchAddBendingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        onPressed: () {
          BlocProvider.of<AddBendingBloc>(context).add(AddBendingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

}

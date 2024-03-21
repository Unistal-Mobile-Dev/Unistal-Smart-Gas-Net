import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

class AddStringingPage extends StatefulWidget {
  const AddStringingPage({super.key});

  @override
  State<AddStringingPage> createState() => _AddStringingPageState();
}

class _AddStringingPageState extends State<AddStringingPage> {

  @override
  void initState() {
    BlocProvider.of<AddStringingBloc>(context).add(AddStringingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddStringingBloc, AddStringingState>(
        builder: (context, state) {
          if(state is FetchAddStringingDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddStringingDataState dataState}){
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
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),

            AppConfig.instanceInit()!.client != Client.iglMZ
                ? Column(
              children: [
                _concreteCoatingDropDown(dataState: dataState),
                _verticalSpace(),
              ],
            ): const SizedBox.shrink(),

            _pipeLengthController(dataState: dataState),
            _verticalSpace(),
            _pipeLengthListWidget(dataState: dataState),
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

  Widget _dateController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingSelectDateEvent(context: context,));
      },
    );
  }

  Widget _chainageFromController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _pipeLengthController({required FetchAddStringingDataState dataState}) {
    return Row(
      children: [
        Expanded(
          child: SearchTextField(
              isLoader: dataState.searchPipeLoader,
              onChange: (value) {
                BlocProvider.of<AddStringingBloc>(context).add(
                    AddStringingSearchPipeDataEvent(keyword: value, context: context)
                );
              },
              onClick: (value) {
                BlocProvider.of<AddStringingBloc>(context).add(
                    AddStringingSelectPipeDataEvent(pipeData: value));
              },
              controller: dataState.searchPipeController,
              label: AppString.selectPipeNumber,
              list: dataState.searchPipeList
          ),
        ),
        ButtonWidget(text: AppString.add,
            onPressed: () {
            BlocProvider.of<AddStringingBloc>(context).add(AddStringingAddPipeLengthEvent(context: context));
        })
      ],
    );
  }

  Widget _pipeLengthListWidget({required FetchAddStringingDataState dataState}) {
    return dataState.pipeLengthList.isNotEmpty ?
    ListView.builder(
        itemCount: dataState.pipeLengthList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          PipeModel pipeData =  dataState.pipeLengthList[index];
        return Container(
           color: AppColor.lightGrey,
           padding: const EdgeInsets.all(5.0),
           child: Row(
             children: [
               Expanded(child: TextWidget("${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}")),
               IconButton(
                   onPressed: () {
                     BlocProvider.of<AddStringingBloc>(context).add(AddStringingDeletePipeLengthEvent(context: context,index: index));
               }, icon:  Icon(Icons.close, color: AppColor.themeLightColor,))
             ],
           ),
        ) ;
     }) : const SizedBox.shrink();
  }


  Widget _chainageToController({required FetchAddStringingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
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
    return DropdownWidget(
      hint: AppString.selectConcreteCoating,
      dropdownValue: dataState.concreteCoatingData.id != null ? dataState.concreteCoatingData : null,
      onChanged: (value) {
        BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingSelectConcreteCoatingEvent(concreteCoatingData: value));
      },
      items: dataState.concreteCoatingList.map<DropdownMenuItem<ConcreteCoatingModel>>((ConcreteCoatingModel concreteCoatingData) {
        return DropdownMenuItem<ConcreteCoatingModel>(
          value: concreteCoatingData,
          child: Text(concreteCoatingData.value.toString()),
        );
      }).toList(),
    );
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
    return  DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData  : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddStringingBloc>(context).add(
            AddStringingSelectAlignmentEvent(alignmentData: value,));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddStringingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue: dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddStringingBloc>(context).add(
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


  Widget _photo({required FetchAddStringingDataState dataState}) {
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
                BlocProvider.of<AddStringingBloc>(context).add(AddStringingAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddStringingBloc>(context).add(AddStringingAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddStringingDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddStringingBloc>(context).add(AddStringingSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

}

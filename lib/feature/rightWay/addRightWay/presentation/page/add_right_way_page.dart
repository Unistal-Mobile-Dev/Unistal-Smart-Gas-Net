import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rightWay/addRightWay/domain/bloc/add_right_way_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rightWay/addRightWay/domain/model/road_type_model.dart';

class AddRightWayPage extends StatefulWidget {
  const AddRightWayPage({super.key});

  @override
  State<AddRightWayPage> createState() => _AddRightWayPageState();
}

class _AddRightWayPageState extends State<AddRightWayPage> {

  @override
  void initState() {
    BlocProvider.of<AddRightWayBloc>(context).add(AddRightWayPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddRightWayBloc, AddRightWayState>(
        builder: (context, state) {
          if(state is FetchAddRightWayDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddRightWayDataState dataState}){
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
            _roadNameController(dataState: dataState),
            _verticalSpace(),
            _roadTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _otherController(dataState: dataState),
            _verticalSpace(),
            _materialTypeController(dataState: dataState),
            _verticalSpace(),
            _roadWidthController(dataState: dataState),
            _verticalSpace(),
            _roadLengthController(dataState: dataState),
            _verticalSpace(),
            _radioButton(dataState: dataState),
            _verticalSpace(),
            _locationController(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRightWayBloc>(context).add(
            AddRightWaySelectDateEvent(context: context,));
      },
    );
  }


  Widget _spreadDropDown({required FetchAddRightWayDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectSpread,
      dropdownValue: dataState.spreadTypeData.id != null ? dataState.spreadTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRightWayBloc>(context).add(
            AddRightWaySelectSpreadEvent(spreadTypeData: value,));
      },
      items: dataState.spreadList.map<DropdownMenuItem<SpreadTypeModel>>((SpreadTypeModel spreadTypeData) {
        return DropdownMenuItem<SpreadTypeModel>(
          value: spreadTypeData,
          child: Text(spreadTypeData.spreadName.toString()),
        );
      }).toList(),
    );
  }

  Widget _sectionDropDown({required FetchAddRightWayDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectSection,
      dropdownValue: dataState.sectionTypeData.id != null ? dataState.sectionTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRightWayBloc>(context).add(
            AddRightWaySelectSectionEvent(sectionTypeData: value,));
      },
      items: dataState.sectionList.map<DropdownMenuItem<SectionTypeModel>>((SectionTypeModel sectionTypeData) {
        return DropdownMenuItem<SectionTypeModel>(
          value: sectionTypeData,
          child: Text(sectionTypeData.sectionName.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _radioButton({required FetchAddRightWayDataState dataState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TextWidget("Road Side"),
        Row(
          children: [
            Radio(
              value: "Left",
              groupValue: dataState.rodeSideValue,
              onChanged: (val) {
                BlocProvider.of<AddRightWayBloc>(context).add(
                    AddRightWaySelectRodeSideEvent(rodeSideValue: val.toString()));
              },
            ),
            const TextWidget("Left"),

            Radio(
              value: "Right",
              groupValue: dataState.rodeSideValue,
              onChanged: (val) {
                BlocProvider.of<AddRightWayBloc>(context).add(
                    AddRightWaySelectRodeSideEvent(rodeSideValue: val.toString()));
              },
            ),
            const TextWidget("Right"),
          ],
        )
      ],
    );
  }


  Widget _coordinationButton({required FetchAddRightWayDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.gpsCoordinate,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddRightWayBloc>(context).add(AddRightWayCaptureNorthingLocationEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }

  Widget _latitudeController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.latitude,
      controller: dataState.latitudeController,
    );
  }

  Widget _longitudeController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.longitude,
      controller: dataState.longitudeController,
    );
  }

  Widget _materialTypeController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.materialType,
      controller: dataState.materialTypeController,
    );
  }

  Widget _roadWidthController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.roadWidth,
      controller: dataState.roadWidthController,
    );
  }



  Widget _locationController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }



  Widget _roadLengthController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.roadLength,
      controller: dataState.roadLengthController,
    );
  }

  Widget _otherController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.enterOther,
      controller: dataState.otherController,
    );
  }

  Widget _roadTypeDropDown({required FetchAddRightWayDataState dataState}) {
    return DropdownWidget(
      hint: AppString.type,
      dropdownValue: dataState.roadTypeData.id != null ? dataState.roadTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRightWayBloc>(context).add(
            AddRightWaySelectRoadTypeDataEvent(roadTypeData: value,));
      },
      items: dataState.roadTypeList.map<DropdownMenuItem<RoadTypeModel>>((RoadTypeModel roadTypeData) {
        return DropdownMenuItem<RoadTypeModel>(
          value: roadTypeData,
          child: Text(roadTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _roadNameController({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.roadName,
      controller: dataState.roadNameController,
    );
  }

  Widget _activityRemark({required FetchAddRightWayDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddRightWayDataState dataState}) {
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
                BlocProvider.of<AddRightWayBloc>(context).add(AddRightWayAddImageEvent(context: context, mediaType: 1));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddRightWayBloc>(context).add(AddRightWayAddImageEvent(context: context, mediaType: 2));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddRightWayDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddRightWayBloc>(context).add(AddRightWaySubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

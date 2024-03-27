import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/bloc/add_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/file_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddHydroTestPage extends StatefulWidget {
  const AddHydroTestPage({super.key});

  @override
  State<AddHydroTestPage> createState() => _AddHydroTestPageState();
}

class _AddHydroTestPageState extends State<AddHydroTestPage> {

  @override
  void initState() {
    BlocProvider.of<AddHydrotestBloc>(context).add(AddHydrotestPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddHydrotestBloc, AddHydrotestState>(
        builder: (context, state) {
          if(state is FetchAddHydrotestDataState) {
            return _itemBuilder(dataState: state);
          } else{
            return const Center(child: CenterLoaderWidget(),);
          }
        },
      ),
    );
  }


  Widget _itemBuilder({required FetchAddHydrotestDataState dataState}){
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child : Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
/*            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),*/
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _listBuilder(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHydrotestBloc>(context).add(
            AddHydrotestSelectDateEvent(context: context,));
      },
    );
  }

  Widget _jointTypeDropDown({required FetchAddHydrotestDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue: dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context).add(
            AddHydrotestSelectJointTypeDataEvent(jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>((JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddHydrotestDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context).add(
            AddHydrotestSelectFromJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointFromList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddHydrotestDataState dataState}) {
    return dataState.isJointNumberLoader == false ?
    DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue: dataState.toJointData.id != null ? dataState.toJointData : null,
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context).add(
            AddHydrotestSelectToJointDataEvent(jointNumberData: value));
      },
      items: dataState.jointToList.map<DropdownMenuItem<JointNumberModel>>((JointNumberModel jointNumberData) {
        return DropdownMenuItem<JointNumberModel>(
          value: jointNumberData,
          child: Text(jointNumberData.jointNumber.toString()),
        );
      }).toList(),
    ): const DottedLoaderWidget();
  }

  Widget _lengthController({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.hydrotestingLength,
      controller: dataState.lengthController,
    );
  }

  Widget _listBuilder({required FetchAddHydrotestDataState dataState}) {
    return GridView.count(
        crossAxisCount: 2,
       shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      children: [
        for(int i = 0; i < dataState.fileList.length; i++)
          _photo(fileData: dataState.fileList[i], index: i),
      ],
    );
  }

  Widget _activityRemark({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FileModel fileData, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width/3,
        height:MediaQuery.of(context).size.width/3,
        child: InkWell(
          onTap: () {
            mediaType(context: context, index: index);
          },
          child: DottedBorder(
            color: AppColor.grey,
            strokeWidth: 1,
            child: fileData.file.path.isEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Icon(Icons.photo_camera_back_outlined),),
                Padding(
                  padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  child: TextWidget(fileData.name.toString(),
                    textAlign: TextAlign.center,
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
                    fileData.file.path.toString().toLowerCase().contains(".jpg")
                        || fileData.file.path.toString().toLowerCase().contains(".png")
                        || fileData.file.path.toString().toLowerCase().contains(".jpeg")
                        ? Image.file(fileData.file,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.width/4.5 ,)
                        : fileData.file.path.toString().toLowerCase().contains(".pdf")
                        ? const Icon(Icons.picture_as_pdf_outlined)
                        : const Icon(Icons.document_scanner_outlined),
                    TextWidget(fileData.name,
                      textAlign: TextAlign.center,
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
      ),
    );
  }

  void mediaType({required BuildContext context, required int index}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(onPressed: () {
                BlocProvider.of<AddHydrotestBloc>(context).add(AddHydrotestAddImageEvent(context: context, mediaType: 1, index: index));
              }, child: TextWidget("Camera", fontSize: AppFont.font_16,)),
              const Divider(),
              TextButton(onPressed: () {
                BlocProvider.of<AddHydrotestBloc>(context).add(AddHydrotestAddImageEvent(context: context, mediaType: 2, index: index));
              }, child: TextWidget("Gallery",fontSize: AppFont.font_16,)),
            ],
          ),
        );
      },
    );
  }


  Widget _button({required FetchAddHydrotestDataState dataState}) {
    return dataState.isLoader == false ?
    ButtonWidget(text: AppString.submit,
        height: AppConfig.getDeviceType(context: context) == DeviceType.tablet ? MediaQuery.of(context).size.height * 0.13 : null,
        onPressed: () {
          BlocProvider.of<AddHydrotestBloc>(context).add(AddHydrotestSubmitDataEvent(context: context));
        }
    ): const DottedLoaderWidget();
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


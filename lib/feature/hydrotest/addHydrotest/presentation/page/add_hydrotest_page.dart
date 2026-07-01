import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/bloc/add_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_pop_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_widget.dart';

class AddHydroTestPage extends StatefulWidget {
  const AddHydroTestPage({super.key});

  @override
  State<AddHydroTestPage> createState() => _AddHydroTestPageState();
}

class _AddHydroTestPageState extends State<AddHydroTestPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddHydrotestBloc>(context)
        .add(AddHydrotestPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddHydrotestBloc, AddHydrotestState>(
        builder: (context, state) {
          if (state is FetchAddHydrotestDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddHydrotestDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
/*            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _photoList(dataState: dataState),
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

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }


  Widget _dateController({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHydrotestBloc>(context)
            .add(AddHydrotestSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHydrotestDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddHydrotestBloc>(context)
            .add(AddHydrotestMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _jointTypeDropDown({required FetchAddHydrotestDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context).add(
            AddHydrotestSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHydrotestDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context)
            .add(AddHydrotestSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown({required FetchAddHydrotestDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddHydrotestBloc>(context)
            .add(AddHydrotestSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _lengthController({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.hydrotestingLength,
      controller: dataState.lengthController,
    );
  }

  Widget _activityRemark({required FetchAddHydrotestDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photoList({required FetchAddHydrotestDataState dataState}) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      padding: EdgeInsets.zero,
    //  childAspectRatio: 1,

      children: List.generate(
        dataState.fileList.length,
            (index) {
          final fileModel = dataState.fileList[index];
          return ImageWidget(
            title: fileModel.key.toString(),
            imagePath: fileModel.path.toString(),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return ImagePopWidget(
                    onTapCamera: () {
                      Navigator.pop(context);
                      context.read<AddHydrotestBloc>().add(
                        SelectCameraCaptureEvent(index: index),
                      );
                    },
                    onTapGallery: () {
                      Navigator.pop(context);
                      context.read<AddHydrotestBloc>().add(
                        SelectGalleryCaptureEvent(index: index),
                      );
                    },
                  );
                },
              );
            },
          );
        },
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
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddHydrotestBloc>(context).add(
                        AddHydrotestAddImageEvent(
                            context: context, mediaType: 1, index: index));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddHydrotestBloc>(context).add(
                        AddHydrotestAddImageEvent(
                            context: context, mediaType: 2, index: index));
                  },
                  child: TextWidget(
                    "Gallery",
                    fontSize: AppFont.font_16,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddHydrotestDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddHydrotestBloc>(context)
                  .add(AddHydrotestSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

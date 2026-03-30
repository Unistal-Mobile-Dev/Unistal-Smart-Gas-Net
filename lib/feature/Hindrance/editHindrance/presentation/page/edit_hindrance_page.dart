import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/EditHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/editHindrance/domain/bloc/edit_hindrance_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/editHindrance/domain/bloc/edit_hindrance_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/editHindrance/domain/bloc/edit_hindrance_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_pop_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class EditHindrancePage extends StatefulWidget {
  const EditHindrancePage({super.key});

  @override
  State<EditHindrancePage> createState() => _EditHindrancePageState();
}

class _EditHindrancePageState extends State<EditHindrancePage> {
  @override
  void initState() {
    BlocProvider.of<EditHindranceBloc>(context)
        .add(EditHindrancePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: EnvironmentConfig.of(context)!.primaryTheme,
        title:TextWidget(
         "Hindrance",
          color: AppColor.white,
          fontSize: AppFont.font_16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: BlocBuilder<EditHindranceBloc, EditHindranceState>(
        builder: (context, state) {
          if (state is FetchEditHindranceDataState) {
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
 
  Widget _itemBuilder({required FetchEditHindranceDataState dataState}) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.04, // responsive height
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: EnvironmentConfig.of(context)!.primaryTheme,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _logoContainer(
                  context,
                  UserInfo.instance!.userData!.projectLogo,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    "${UserInfo.instance!.userData!.sectionName}\n (Dia - ${UserInfo.instance!.userData!.diameter}${UserInfo.instance!.userData!.diauom})",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                _logoContainer(
                  context,
                  UserInfo.instance!.userData!.smartLogo,
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _verticalSpace(),
                    _dateController(dataState: dataState),
                    _verticalSpace(),
                    _reportNumberController(dataState: dataState),
                    _verticalSpace(),
                    _hindranceCategoryDropDown(dataState: dataState),
                    _verticalSpace(),
                    _hindranceTypeDropDown(dataState: dataState),
                    _verticalSpace(),
                    _activityAffectedDropDown(dataState: dataState),
                    _verticalSpace(),
                    _responsibleByDropDown(dataState: dataState),
                    _verticalSpace(),
                    _locationController(dataState: dataState),
                    _verticalSpace(),
                    _chainageFromController(dataState: dataState),
                    _verticalSpace(),
                    _chainageToController(dataState: dataState),
                    _verticalSpace(),
                    _lengthController(dataState: dataState),
                    _verticalSpace(),
                    _activityRemark(dataState: dataState),
                    _verticalSpace(),
                    _resolutionCloseDateController(dataState: dataState),
                    _verticalSpace(),
                    _activityEditRemark(dataState: dataState),
                    _verticalSpace(),
                    _photo(dataState: dataState),
                    _verticalSpace(),
                    _verticalSpace(),
                    _button(dataState: dataState),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Report Date",
      controller: dataState.dateCtrl
    );
  }

  Widget _reportNumberController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberCtrl
    );
  }

  Widget _hindranceCategoryDropDown({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Hindrance Category",
      controller: dataState.hindranceCategoryCtrl
    );
  }

  Widget _hindranceTypeDropDown({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Hindrance Type",
      controller: dataState.hindranceTypeCtrl
    );
  }

  Widget _activityAffectedDropDown({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Activity Affected",
      controller: dataState.activityAffectedCtrl
    );
  }


  Widget _responsibleByDropDown({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText:  "Responsible By",
      controller:dataState.responsibleByCtrl
    );
  }

  Widget _locationController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.location,
      controller:dataState.locationCtrl
    );
  }

  Widget _chainageFromController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromCtrl
    );
  }

  Widget _chainageToController({required FetchEditHindranceDataState dataState,}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.chainageTo,
      controller:dataState.chainageToCtrl,
    );
  }

  Widget _lengthController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Length affected (m)",
      controller:dataState.lengthCtrl,
    );
  }

  Widget _activityRemark({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      enabled: false,
      labelText: "Resolution Notes",
      controller: dataState.resolutionNotesCtrl,
    );
  }

  Widget _resolutionCloseDateController({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Resolution Close Date",
      controller: dataState.resolutionDateCtrl,
      onTap: () {
        BlocProvider.of<EditHindranceBloc>(context)
            .add(EditHindranceResolutionCloseDateEvent(
          context: context,
        ));
      },
    );
  }


  Widget _activityEditRemark({required FetchEditHindranceDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      enabled: false,
      labelText: "Resolution Notes",
      controller:  dataState.resolutionEditNotesCtrl,
    );
  }

  Widget _photo({required FetchEditHindranceDataState dataState}) {
    return ImageWidget(
      // isRequired: true,
       title: "",
      imagePath: dataState.file.path,
      onPressed: () {
        showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return ImagePopWidget(
              onTapCamera: () async {
                Navigator.of(context).pop();
                BlocProvider.of<EditHindranceBloc>(
                  context,
                ).add(SelectCameraCaptureEvent());
              },
              onTapGallery: () async {
                Navigator.of(context).pop();
                BlocProvider.of<EditHindranceBloc>(
                  context,
                ).add(SelectGalleryCaptureEvent());
              },
            );
          },
        );
      },
    );
  }


  Widget _button({required FetchEditHindranceDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<EditHindranceBloc>(context)
                  .add(EditHindranceSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

  Widget _logoContainer(BuildContext context, String? url) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.09,
      // FIXED width (important)
      height: MediaQuery.of(context).size.width * 0.09,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url ?? "",
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

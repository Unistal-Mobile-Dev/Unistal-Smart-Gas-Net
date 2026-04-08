import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/bloc/add_hindrance_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/bloc/add_hindrance_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/bloc/add_hindrance_state.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_pop_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/image_widget.dart';

class AddHindrancePage extends StatefulWidget {
  const AddHindrancePage({super.key});

  @override
  State<AddHindrancePage> createState() => _AddHindrancePageState();
}

class _AddHindrancePageState extends State<AddHindrancePage> {
  @override
  void initState() {
    BlocProvider.of<AddHindranceBloc>(context)
        .add(AddHindrancePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddHindranceBloc, AddHindranceState>(
        builder: (context, state) {
          if (state is FetchAddHindranceDataState) {
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

  Widget _itemBuilder({required FetchAddHindranceDataState dataState}) {
    return Container(
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
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: "Report Date",
      controller: dataState.dateCtrl,
      onTap: () {
        BlocProvider.of<AddHindranceBloc>(context)
            .add(AddHindranceSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberCtrl,
    );
  }

  Widget _hindranceCategoryDropDown({required FetchAddHindranceDataState dataState}) {
    return DropdownWidget<HindranceCategoryData>(
      isRequired: true,
      hint: "Hindrance Category",
      dropdownValue: dataState.hindranceCategoryVal.id != null ? dataState.hindranceCategoryVal : null,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context)
            .add(AddHindranceSelectCategoryEvent(hindranceCategory: value!));
      },
      items: dataState.listOfHindranceCategory,
    );
  }

  Widget _hindranceTypeDropDown({required FetchAddHindranceDataState dataState}) {
    return dataState.isHindranceLoader == false ? DropdownWidget<HindranceCategoryData>(
      isRequired: true,
      hint: "Hindrance Type",
      dropdownValue: dataState.hindranceTypeVal.id != null ? dataState.hindranceTypeVal : null,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context)
            .add(AddHindranceSelectTypeEvent(hindranceType: value!));
      },
      items: dataState.listOfHindranceType,
    ) : DottedLoaderWidget();
  }

  Widget _activityAffectedDropDown({required FetchAddHindranceDataState dataState}) {
    return DropdownWidget<ActivitySectionData>(
      isRequired: true,
      hint: "Activity Affected",
      dropdownValue: dataState.activityAffectedVal.id != null ? dataState.activityAffectedVal : null,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context)
            .add(AddHindranceActivityAffectedEvent(activityAffected: value!));
      },
      items: dataState.listOfActivityAffected,
    );
  }


  Widget _responsibleByDropDown({required FetchAddHindranceDataState dataState}) {
    return DropdownWidget<HindranceCategoryData>(
      isRequired: true,
      hint: "Responsible By",
      dropdownValue: dataState.responsibleByVal.id != null ? dataState.responsibleByVal : null,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context)
            .add(AddHindranceResponsibleByEvent(responsibleBy: value!));
      },
      items: dataState.listOfResponsibleBy,
    );
  }

  Widget _locationController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.location,
      controller: dataState.locationCtrl,
    );
  }

  Widget _chainageFromController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromCtrl,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context).add(CalculateLengthEvent(
            isChainageTo: false, value: value, context: context));
      },
    );
  }

  Widget _chainageToController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToCtrl,
      onChanged: (value) {
        BlocProvider.of<AddHindranceBloc>(context).add(CalculateLengthEvent(
            isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthCtrl,
    );
  }



  Widget _activityRemark({required FetchAddHindranceDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: "Resolution Notes",
      controller: dataState.activityRemarkCtrl,
    );
  }

  Widget _photo({required FetchAddHindranceDataState dataState}) {
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
                BlocProvider.of<AddHindranceBloc>(
                  context,
                ).add(SelectCameraCaptureEvent());
              },
              onTapGallery: () async {
                Navigator.of(context).pop();
                BlocProvider.of<AddHindranceBloc>(
                  context,
                ).add(SelectGalleryCaptureEvent());
              },
            );
          },
        );
      },
    );
  }


  Widget _button({required FetchAddHindranceDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddHindranceBloc>(context)
                  .add(AddHindranceSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

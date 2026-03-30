import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/editHindrance/presentation/page/edit_hindrance_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/bloc/view_hindrance_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/bloc/view_hindrance_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/bloc/view_hindrance_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class ViewHindrancePage extends StatefulWidget {
  const ViewHindrancePage({super.key});

  @override
  State<ViewHindrancePage> createState() => _ViewHindrancePageState();
}

class _ViewHindrancePageState extends State<ViewHindrancePage> {

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();


  @override
  void initState() {
    BlocProvider.of<ViewHindranceBloc>(context)
        .add(ViewHindrancePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<ViewHindranceBloc, ViewHindranceState>(
        builder: (context, state) {
          if (state is FetchViewHindranceDataState) {
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

  Widget _itemBuilder({required FetchViewHindranceDataState dataState}) {
    return Column(
      children: [
        _searchTextField(dataState: dataState),
        Flexible(
          child: _dataTableWidget(dataState: dataState),
        ),
      ],
    );
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
  Widget _searchTextField({required FetchViewHindranceDataState dataState}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFieldWidget(
        labelText: "Search Report No.",
        controller: dataState.searchingCtrl,
        onChanged: (val) {
          BlocProvider.of<ViewHindranceBloc>(
            context,
          ).add(ViewHindranceSearchingEvent(context: context, searching: val));
        },
      ),
    );
  }

  Widget _dataTableWidget({required FetchViewHindranceDataState dataState}) {
    return dataState.isHindranceSearch == false
        ? dataState.listOfHindranceTableData.isEmpty
        ? Center(child: Text("No records found"))
        : Theme(
      data: ThemeData(highlightColor: EnvironmentConfig.of(context)!.secondaryTheme),
      child: Scrollbar(
        controller: _verticalScrollController,
        thickness: 3.0,
        scrollbarOrientation: ScrollbarOrientation.right,
        thumbVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _verticalScrollController,
          child: Theme(
            data: ThemeData(highlightColor: EnvironmentConfig.of(context)!.secondaryTheme),
            child: Scrollbar(
              controller: _horizontalScrollController,
              thickness: 3.0,
              scrollbarOrientation: ScrollbarOrientation.top,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: EnvironmentConfig.of(context)!.primaryTheme),
                  child: DataTable(
                    sortAscending: true,
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    showCheckboxColumn: false,
                    dataTextStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
                    dataRowHeight:
                    MediaQuery.of(context).size.height * 0.04,
                    headingRowColor: MaterialStateColor.resolveWith(
                          (states) => EnvironmentConfig.of(context)!.primaryTheme,
                    ),
                    dividerThickness: 1,
                    columns: [
                      dataColumn(label: "Sr No."),
                      dataColumn(label: "Status"),
                      dataColumn(label: "Spread"),
                      dataColumn(label: "Section"),
                      dataColumn(label: "Report No."),
                      dataColumn(label: "Report Date"),
                      dataColumn(label: "Hindrance Category"),
                      dataColumn(label: "Hindrance Type"),
                      dataColumn(label: "Activity Affected"),
                      dataColumn(label: "Responsible By"),
                      dataColumn(label: "Chainage From"),
                      dataColumn(label: "Chainage To"),
                      dataColumn(label: "Area Hold"),
                      dataColumn(label: "From Date"),
                      dataColumn(label: "To Date"),
                      dataColumn(label: "Reason"),
                      dataColumn(label: "Attachment"),
                      dataColumn(label: "Date Added"),
                    ],
                    rows:
                    dataState.listOfHindranceTableData
                        .mapIndexed(
                          (index, user) => DataRow(
                        onSelectChanged: (newValue) async {
                          AppConfig.instanceInit()?.setHindranceListData(newValue: user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditHindrancePage(),
                            ),
                          );
                        },
                        cells: <DataCell>[
                          DataCell(tableCellMin(text: '${index + 1}')),
                          DataCell( tableCell(text: user.status.toString())),
                          DataCell( tableCell(text: user.spreadName.toString())),
                          DataCell( tableCell(text: user.sectionName.toString())),
                          DataCell( tableCell(text: user.reportNo.toString())),
                          DataCell( tableCell(text: user.reportDate.toString())),
                          DataCell( tableCell(text: user.hindranceCategoryName.toString())),
                          DataCell( tableCell(text: user.hindranceTypeName.toString())),
                          DataCell( tableCell(text: user.activityAffected.toString())),
                          DataCell( tableCell(text: user.responsibleBy.toString())),
                          DataCell( tableCellMin(text: user.chainageFrom.toString())),
                          DataCell( tableCellMin(text: user.chainageTo.toString())),
                          DataCell( tableCellMin(text: user.areaHold.toString())),
                          DataCell( tableCell(text: user.fromDate.toString())),
                          DataCell( tableCell(text: user.toDate.toString())),
                          DataCell( tableCell(text: user.reason.toString())),
                          DataCell( tableCellLink(link: user.attachFile.toString())),
                          DataCell( tableCell(text: user.dateDifference.toString())),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
        : Center(child: DottedLoaderWidget());
  }


  static DataColumn dataColumn({required String label}) {
    return DataColumn(
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }


  Widget tableCellMin({required String text}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: Text(
        text.isEmpty ? "-"  : text,
      ),
    );
  }
  // Widget tableCell({required String text}) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.3,
  //     child: Text(
  //       text,
  //     ),
  //   );
  // }

  Widget tableCell({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text.isEmpty ? "-"  : text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCellLink({required String? link}) {
    if (link == null || link.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 100,
        child: const Center(
          child: Icon(Icons.error, color: Colors.grey),
        ),
      );
    }


    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Image.network(
                    link,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: Image.network(
          link,
          height: 100,
          errorBuilder: (context, error, stackTrace) =>
          const Text("No File"),
        ),
      ),
    );
  }
}

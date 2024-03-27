import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';

class PhoneDashboardWidget extends StatefulWidget {
  const PhoneDashboardWidget({super.key,});

  @override
  State<PhoneDashboardWidget> createState() => _PhoneDashboardWidgetState();
}

class _PhoneDashboardWidgetState extends State<PhoneDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if(state is FetchHomeDataState){
            return _listBuilder(dataState: state);
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }

  Widget _listBuilder({required FetchHomeDataState dataState}) {
    return Container(
       margin: const EdgeInsets.all(10.0),
       child:  ListView.builder(
           itemCount: dataState.drawerList.length,
           itemBuilder: (context, index) {
           return index != 0 ?
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Colors.white),
                 ),
                   onPressed: () {
                     BlocProvider.of<HomeBloc>(context).add(HomeDrawerItemSelectedEvent(
                         isSelected: true , index:  index, context: context));
                   },
                   icon: Icon(dataState.drawerList[index].icon, color: AppColor.themeColor,),
                   label: TextWidget(dataState.drawerList[index].label),
           ),
              ),
            ) : const SizedBox.shrink();
       }),
    );
  }
}

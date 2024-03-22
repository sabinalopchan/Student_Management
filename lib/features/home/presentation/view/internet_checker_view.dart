import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/common/provider/is_network_provider.dart';

class InternetCheckerView extends ConsumerStatefulWidget {
  const InternetCheckerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InternetCheckerViewState();
}

class _InternetCheckerViewState extends ConsumerState<InternetCheckerView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Internt Check")),
        body: Center(
          child : Consumer(
            builder: (context, ref, child){
              final connectivityStatus = ref.watch(connectivityStatusProvider);
              if( connectivityStatus == ConnectivityStatus.isConnected){
                return Text(
                  "Connected",
                  style: TextStyle(fontSize: 20),
                );
              }else{
                return Text(
                  "Discononnected",
                  style: TextStyle(fontSize: 20),
                );
              }
            }
        )));
        }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citybike/main_common.dart';

// REPOSITORIES (Firebase Versions)
import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/data/repositories/pass/pass_repository_firebase.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/data/repositories/station/station_repository_firebase.dart';

// GLOBAL STATES
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/states/station_state.dart';
import 'package:citybike/ui/states/user_state.dart';


List<InheritedProvider> get prodProviders {
  return [
    
    Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),
    Provider<PassRepository>(create: (_) => PassRepositoryFirebase()),

    
    ChangeNotifierProvider<UserState>(create: (_) => UserState()),
    ChangeNotifierProvider<PassState>(create: (_) => PassState()),
    ChangeNotifierProvider<StationState>(create: (_) => StationState()),
  ];
}

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  
 
  mainCommon(prodProviders);
}
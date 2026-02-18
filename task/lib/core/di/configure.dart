import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'configure.config.dart';

var getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

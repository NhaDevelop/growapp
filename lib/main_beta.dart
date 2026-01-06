import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:grow_tokyo_app/main.dart' as main_app;

void main() {
  BuildConfig.appFlavor = AppFlavor.prod;

  main_app.main();
}

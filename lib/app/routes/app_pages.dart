import 'package:get/get.dart';

import 'package:perpus_online/app/modules/home/bindings/home_binding.dart';
import 'package:perpus_online/app/modules/home/views/home_view.dart';
import 'package:perpus_online/app/modules/siswa/bindings/siswa_binding.dart';
import 'package:perpus_online/app/modules/siswa/views/siswa_view.dart';
import 'package:perpus_online/app/modules/staff/bindings/staff_binding.dart';
import 'package:perpus_online/app/modules/staff/views/staff_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STAFF,
      page: () => StaffView(),
      binding: StaffBinding(),
    ),
    GetPage(
      name: _Paths.SISWA,
      page: () => SiswaView(),
      binding: SiswaBinding(),
    ),
  ];
}

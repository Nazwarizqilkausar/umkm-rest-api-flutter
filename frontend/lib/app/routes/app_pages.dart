import 'package:get/get.dart';
import 'package:frontend/app/views/umkm_view.dart';
import 'package:frontend/app/views/umkm_form_page.dart';

class AppRoutes {
  static const umkmList = '/umkm';
  static const umkmForm = '/umkm/form';

  static final routes = [
    GetPage(name: umkmList, page: () => const UmkmView()),
    GetPage(name: umkmForm, page: () => const UmkmFormPage()),
  ];
}

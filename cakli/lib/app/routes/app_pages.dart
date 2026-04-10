import 'package:get/get.dart';

import '../modules/aktivitas/bindings/aktivitas_binding.dart';
import '../modules/aktivitas/views/aktivitas_view.dart';
import '../modules/carialamat/bindings/carialamat_binding.dart';
import '../modules/carialamat/views/carialamat_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/editalamat/bindings/editalamat_binding.dart';
import '../modules/editalamat/views/editalamat_view.dart';
import '../modules/editemail/bindings/editemail_binding.dart';
import '../modules/editemail/views/editemail_view.dart';
import '../modules/editpin/bindings/editpin_binding.dart';
import '../modules/editpin/views/editpin_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maptest/bindings/maptest_binding.dart';
import '../modules/maptest/views/maptest_view.dart';
import '../modules/pesan/bindings/pesan_binding.dart';
import '../modules/pesan/views/pesan_view.dart';
import '../modules/pesanalamat/bindings/pesanalamat_binding.dart';
import '../modules/pesanalamat/views/pesanalamat_view.dart';
import '../modules/pesandriver/bindings/pesandriver_binding.dart';
import '../modules/pesandriver/views/pesandriver_view.dart';
import '../modules/rating/bindings/rating_binding.dart';
import '../modules/rating/views/rating_view.dart';
import '../modules/setlokasi/bindings/setlokasi_binding.dart';
import '../modules/setlokasi/views/setlokasi_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/tambahalamat/bindings/tambahalamat_binding.dart';
import '../modules/tambahalamat/views/tambahalamat_view.dart';
import '../modules/voucher/bindings/voucher_binding.dart';
import '../modules/voucher/views/voucher_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.MAPTEST,
      page: () => const MaptestView(),
      binding: MaptestBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => const EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.EDITPIN,
      page: () => const EditpinView(),
      binding: EditpinBinding(),
    ),
    GetPage(
      name: _Paths.EDITEMAIL,
      page: () => const EditemailView(),
      binding: EditemailBinding(),
    ),
    GetPage(
      name: _Paths.EDITALAMAT,
      page: () => const EditalamatView(),
      binding: EditalamatBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHALAMAT,
      page: () => const TambahalamatView(),
      binding: TambahalamatBinding(),
    ),
    GetPage(
      name: _Paths.CARIALAMAT,
      page: () => const CarialamatView(),
      binding: CarialamatBinding(),
    ),
    GetPage(
      name: _Paths.SETLOKASI,
      page: () => const SetlokasiView(),
      binding: SetlokasiBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS,
      page: () => const AktivitasView(),
      binding: AktivitasBinding(),
    ),
    GetPage(
      name: _Paths.PESAN,
      page: () => const PesanView(),
      binding: PesanBinding(),
    ),
    GetPage(
      name: _Paths.PESANALAMAT,
      page: () => const PesanalamatView(),
      binding: PesanalamatBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PESANDRIVER,
      page: () => const PesandriverView(),
      binding: PesandriverBinding(),
    ),
    GetPage(
      name: _Paths.RATING,
      page: () => const RatingView(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: _Paths.VOUCHER,
      page: () => const VoucherView(),
      binding: VoucherBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}

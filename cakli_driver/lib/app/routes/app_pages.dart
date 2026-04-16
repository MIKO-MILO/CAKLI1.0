import 'package:get/get.dart';

import '../modules/antarorder/bindings/antarorder_binding.dart';
import '../modules/antarorder/views/antarorder_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listchat/bindings/listchat_binding.dart';
import '../modules/listchat/views/listchat_view.dart';
import '../modules/pendapatan/bindings/pendapatan_binding.dart';
import '../modules/pendapatan/views/pendapatan_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/terimaorder/bindings/terimaorder_binding.dart';
import '../modules/terimaorder/views/terimaorder_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PENDAPATAN,
      page: () => const PendapatanView(),
      binding: PendapatanBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
      children: [
        GetPage(
          name: _Paths.RIWAYAT,
          page: () => const RiwayatView(),
          binding: RiwayatBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.TERIMAORDER,
      page: () => const TerimaorderView(),
      binding: TerimaorderBinding(),
    ),
    GetPage(
      name: _Paths.ANTARORDER,
      page: () => const AntarorderView(),
      binding: AntarorderBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => const PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LISTCHAT,
      page: () => const ListchatView(),
      binding: ListchatBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => const EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}

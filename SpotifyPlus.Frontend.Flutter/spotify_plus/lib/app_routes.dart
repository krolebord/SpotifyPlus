import 'package:spotify_plus/guards/signed_in_guard.dart';
import 'package:spotify_plus/guards/signed_out_guard.dart';
import 'package:spotify_plus/widgets/auth/auth_view.dart';
import 'package:spotify_plus/widgets/home/home_view.dart';
import 'package:vrouter/vrouter.dart';

class AppRoutes {
  AppRoutes._();

  static const String auth = '/auth';

  static const String home = '/home';

  static List<VRouteElement> build() {
    return [
      SignedOutGuard([
        VWidget(
          path: auth,
          widget: const AuthView()
        )
      ]),
      SignedInGuard([
        VWidget(
          path: home,
          widget: HomeView()
        )
      ])
    ];
  }
}


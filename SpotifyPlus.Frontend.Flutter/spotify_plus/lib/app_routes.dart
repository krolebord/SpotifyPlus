import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
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
      SignedOutGuard( [_buildSignedOutRoute()] ),
      SignedInGuard([
        VWidget(
          path: home,
          widget: const HomeView()
        )
      ])
    ];
  }

  static VRouteElement _buildSignedOutRoute() {
    return VWidget(
      path: AppRoutes.auth,
      widget: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => previous is! AuthSignedIn && current is AuthSignedIn,
        listener: (context, state) => context.vRouter.to(home, isReplacement: true),
        child: const AuthView(),
      )
    );
  }
}


import 'package:get_it/get_it.dart';
import 'package:spotify_plus/app_routes.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:vrouter/vrouter.dart';

class SignedInGuard extends VGuard {
  final AuthService _authService;

  SignedInGuard(List<VRouteElement> stackedRoutes) :
    _authService = GetIt.instance.get<AuthService>(),
    super(stackedRoutes: stackedRoutes);

  @override
  Future<void> beforeEnter(VRedirector vRedirector) async {
    if(_authService.currentAuth == null) {
      vRedirector.to(AppRoutes.auth, isReplacement: true);
    }
  }
}
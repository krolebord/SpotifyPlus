import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_plus/app_routes.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:vrouter/vrouter.dart';

class SignedInGuard extends VGuard {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  SignedInGuard(List<VRouteElement> stackedRoutes) :
    super(stackedRoutes: _buildRoutes(stackedRoutes));

  @override
  Future<void> beforeEnter(VRedirector vRedirector) async {
    if(_authService.currentAuth == null) {
      vRedirector.to(AppRoutes.auth, isReplacement: true);
    }
  }

  static List<VRouteElement> _buildRoutes(List<VRouteElement> stackedRoutes) {
    return [
      VNester(
        path: null,
        widgetBuilder: _buildNester,
        nestedRoutes: stackedRoutes
      )
    ];
  }

  static Widget _buildNester(Widget child) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => current is AuthSignedOut,
      listener: (context, state) => context.vRouter.to(AppRoutes.auth, isReplacement: true),
      child: child,
    );
  }
}
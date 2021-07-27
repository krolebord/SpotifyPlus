import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
import 'package:spotify_plus/extensions/size_extension.dart';
import 'package:vrouter/vrouter.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'widgets/app_scaffold.dart';

class SpotifyPlusApp extends StatelessWidget {
  static const appTitle = "Spotify+";

  const SpotifyPlusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizingData.setConstraints(constraints);
        return VRouter(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: appTheme,
          title: appTitle,
          color: Colors.green,
          initialUrl: AppRoutes.home,
          routes: [
            VNester(
              path: null,
              widgetBuilder: _buildAppRoot,
              nestedRoutes: [
                _buildNotFoundRoute(),
                ...AppRoutes.build(),
                VRouteRedirector(
                  path: ':_(.+)',
                  redirectTo: "/404"
                )
              ]
            )
          ],
        );
      }
    );
  }

  Widget _buildAppRoot(Widget child) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(),
      child: child,
    );
  }

  VRouteElement _buildNotFoundRoute() {
    return VWidget(
      path: '/404',
      widget: const AppScaffold(
        body: Center(
          child: Text(
              'Error 404\nNot Found',
              textAlign: TextAlign.center
          ),
        ),
      )
    );
  }
}

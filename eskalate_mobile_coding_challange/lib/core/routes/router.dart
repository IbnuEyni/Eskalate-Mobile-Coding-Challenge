import 'package:eskalate_mobile_coding_challange/core/routes/app_routes.dart';
import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:eskalate_mobile_coding_challange/presentation/pages/country_detail_page.dart';
import 'package:eskalate_mobile_coding_challange/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: Routes.home, builder: (context, state) => const MainScreen()),
    GoRoute(
      path: Routes.countryDetail,
      builder:
          (context, state) =>
              CountryDetailPage(country: state.extra as Country),
    ),
    // GoRoute(
    //   path: Routes.favorite,
    //   builder: (context, state) => FavoritePage(),
    // ),
  ],
);

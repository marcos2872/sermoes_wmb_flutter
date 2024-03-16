import 'package:routefly/routefly.dart';

import 'app/app_page.dart' as a4;
import 'app/favorite/favorite_page.dart' as a2;
import 'app/home/home_page.dart' as a0;
import 'app/pdf/[id]_page.dart' as a1;
import 'app/player/[id]_page.dart' as a5;
import 'app/search/search_page.dart' as a3;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.HomePage(),
    ),
  ),
  RouteEntity(
    key: '/pdf/[id]',
    uri: Uri.parse('/pdf/[id]'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.PdfPage(),
    ),
  ),
  RouteEntity(
    key: '/favorite',
    uri: Uri.parse('/favorite'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.FavoritePage(),
    ),
  ),
  RouteEntity(
    key: '/search',
    uri: Uri.parse('/search'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a3.SearchPage(),
    ),
  ),
  RouteEntity(
    key: '/',
    uri: Uri.parse('/'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a4.AppPage(),
    ),
  ),
  RouteEntity(
    key: '/player/[id]',
    uri: Uri.parse('/player/[id]'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a5.PlayerPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  home: '/home',
  pdf: (
    path: '/pdf',
    $id: '/pdf/[id]',
  ),
  favorite: '/favorite',
  search: '/search',
  player: (
    path: '/player',
    $id: '/player/[id]',
  ),
);

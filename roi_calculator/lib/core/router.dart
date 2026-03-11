import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/features/calculator/presentation/calculator_screen.dart';
import 'package:roi_calculator/features/calculator/presentation/result.screen.dart';
import 'package:roi_calculator/features/finish/presentation/finish_screen.dart';
import 'package:roi_calculator/features/insights/presentation/insights_screen.dart';
import 'package:roi_calculator/features/start/presentation/start_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const StartScreen();
      },
    ),
    GoRoute(
      path: "/calculator",
      builder: (BuildContext context, GoRouterState state) {
        return const CalculatorScreen();
      },
    ),
    GoRoute(
      path: "/result",
      builder: (BuildContext context, GoRouterState state) {
        return const ResultScreen();
      },
    ),
    GoRoute(
      path: "/finish",
      builder: (BuildContext context, GoRouterState state) {
        return const FinishScreen();
      },
    ),
    GoRoute(
      path: "/insights",
      builder: (BuildContext context, GoRouterState state) {
        return const InsightsScreen();
      },
    ),
  ],
);

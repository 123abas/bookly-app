//No instance-
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/presentation/maneger/cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/data/presentation/views/book_detail_view.dart';
import 'package:bookly_app/features/home/data/presentation/views/home_views.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/search/presentation/views/search.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kBookDetailsView = '/BookDetailView';
  static const kSearchView = '/SearchView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/homeView',
        builder: (context, state) => const HomeViews(),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) {
          print('state.extra: ${state.extra}'); // تصحيح القيمة
          final bookModel = state.extra as BookModel?;
          if (bookModel == null) {
            return const Scaffold(
              body: Center(child: Text('لا توجد بيانات كتاب')),
            );
          }
          return BlocProvider(
            create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
            child: BookDetailView(bookModel: bookModel),
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}

import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl( this.apiService);
  @override
  //either=leftside_fail..rightside_success
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.getApiRequest(
        endPoint:
            'volumes?Filtering=free-ebooks&q=subject:computer science&sorting=newest',
      );
      List<BookModel> BooksList = [];
      for (var item in data['items']) {
        //path
        BooksList.add(BookModel.fromJson(item));
      }
      return right(BooksList);
      //1- create class Failure to handle errors--
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeatureBooks() async {
    try {
      var data = await apiService.getApiRequest(
        endPoint: 'volumes?Filtering=free-ebooks&q=subject:programming',
      );
      List<BookModel> booksList = [];
      for (var item in data['items']) {
        //path
        booksList.add(BookModel.fromJson(item));
      }
      return right(booksList);
      //1- create class Failure to handle errors--
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({required String category}) async{
      try {
      var data = await apiService.getApiRequest(
        endPoint:
            'volumes?Filtering=free-ebooks&q=subject:programming&sorting=relevance',
      );
      List<BookModel> BooksList = [];
      for (var item in data['items']) {
        //path
        BooksList.add(BookModel.fromJson(item));
      }
      return right(BooksList);
      //1- create class Failure to handle errors--
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

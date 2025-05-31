part of 'feature_books_cubit.dart';

sealed class FeatureBooksState extends Equatable {
  const FeatureBooksState();

  @override
  List<Object> get props => [];
}

final class FeatureBooksInitial extends FeatureBooksState {}
final class FeatureBooksLoading extends FeatureBooksState {}
final class FeatureBooksFailure extends FeatureBooksState {
  final String errorMessage;

 const FeatureBooksFailure(this.errorMessage);
}
final class FeatureBooksSuccess extends FeatureBooksState {
  final List<BookModel>books;

  const FeatureBooksSuccess(this.books);

}

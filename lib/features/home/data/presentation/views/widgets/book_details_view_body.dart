import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/features/home/data/presentation/views/widgets/books_action.dart';
import 'package:bookly_app/features/home/data/presentation/views/widgets/custom_book_detail_appbar.dart';
import 'package:bookly_app/features/home/data/presentation/views/widgets/feature_book_item.dart';
import 'package:bookly_app/features/home/data/presentation/views/widgets/similar_box_list_view.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                CustomBookDetailsAppBar(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .2),
                  child: CustomBookImage(
                    imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  book.volumeInfo.title!,
                  style: Styles.textStyle30.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),

                Opacity(
                  opacity: .7,
                  child: Text(
                    book.volumeInfo.authors?[0] ?? '',
                    style: Styles.textStyle18.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                const BookRating(mainAxisAlignment: MainAxisAlignment.center),
                const SizedBox(height: 20),
                BooksAction(bookModel: book,),
                Expanded(child: const SizedBox(height: 40)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You can also like',
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                SimilarBooxListView(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

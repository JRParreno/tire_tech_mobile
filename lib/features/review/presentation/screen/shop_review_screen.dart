import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/review/presentation/widgets/shop_review_card.dart';

class ShopReviewScreenArgs {
  const ShopReviewScreenArgs(this.pk);

  final String pk;
}

class ShopReviewScreen extends StatefulWidget {
  const ShopReviewScreen({
    super.key,
    required this.args,
  });

  static const String routeName = 'shop-review-screen';
  final ShopReviewScreenArgs args;

  @override
  State<ShopReviewScreen> createState() => _ShopReviewScreenState();
}

class _ShopReviewScreenState extends State<ShopReviewScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Reviews'),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ShopReviewBloc, ShopReviewState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(value: 1),
              );
            }

            if (state is ShopReviewLoaded) {
              if (state.shopReviews.isNotEmpty) {
                return SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.shopReviews.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = state.shopReviews[index];
                            return ShopReviewCard(shopReview: item);
                          },
                        ),
                        if (state.isPaginate) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(),
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CustomText(
                  text: 'No reviews',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent * 0.85)) {
        BlocProvider.of<ShopReviewBloc>(context)
            .add(GetShopReviewPaginateListEvent(widget.args.pk));
      }
    });
  }
}

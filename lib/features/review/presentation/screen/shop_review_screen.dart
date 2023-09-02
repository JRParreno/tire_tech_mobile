import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/features/review/presentation/screen/shop_add_update_review_screen.dart';
import 'package:tire_tech_mobile/features/review/presentation/widgets/shop_review_card.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ShopReviewScreenArgs {
  const ShopReviewScreenArgs({
    required this.pk,
    required this.shopRateUser,
  });

  final String pk;
  final ShopRateUser shopRateUser;
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
  late ShopRateUser shopRateUser;

  @override
  void initState() {
    shopRateUser = widget.args.shopRateUser;
    scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Rate & Reviews'),
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
              if (state.shopReviews.isNotEmpty ||
                  shopRateUser.userReview != null) {
                return SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 20,
                        ),
                        child: CustomText(
                          text: widget.args.shopRateUser.shopName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              if (shopRateUser.userReview != null) ...[
                                ShopReviewCard(
                                  shopReview: shopRateUser.userReview!,
                                  isEdit: true,
                                  onTap: handleAddUpdateReview,
                                ),
                              ],
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
                      ),
                    ],
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
      floatingActionButton:
          !shopRateUser.isOwner && shopRateUser.userReview == null
              ? FloatingActionButton.extended(
                  onPressed: handleAddUpdateReview,
                  label: const CustomText(text: 'Review'),
                  icon: const Icon(Icons.add),
                  backgroundColor: ColorName.primary,
                )
              : null,
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

  Future<void> handleAddUpdateReview() async {
    final navigate = await Navigator.of(context).pushNamed(
      ShopAddUpdateReviewScreen.routeName,
      arguments: ShopAddUpdateReviewScreenArgs(
        shopRateUser: shopRateUser,
        pk: widget.args.pk,
      ),
    ) as ShopReview?;

    if (navigate != null) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<ShopReviewBloc>(context)
          .add(GetShopReviewListEvent(widget.args.pk));
      setState(() {
        shopRateUser = shopRateUser.copyWith(
          userReview: navigate,
        );
      });
    }
  }
}

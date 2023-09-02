import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/presentation/screen/shop_review_screen.dart';

class ShopReviewBtn extends StatelessWidget {
  const ShopReviewBtn({
    super.key,
    required this.pk,
    required this.shopRateUser,
  });

  final String pk;
  final ShopRateUser shopRateUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 60,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: CustomBtn(
                onTap: () {
                  BlocProvider.of<ShopReviewBloc>(context)
                      .add(GetShopReviewListEvent(pk));
                  Navigator.of(context).pushNamed(
                    ShopReviewScreen.routeName,
                    arguments: ShopReviewScreenArgs(
                      pk: pk,
                      shopRateUser: shopRateUser,
                    ),
                  );
                },
                label: 'Reviews',
                backgroundColor: Colors.blue,
                btnStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

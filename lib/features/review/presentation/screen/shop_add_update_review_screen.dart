import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/features/review/data/repository/shop_review_repository_impl.dart';

class ShopAddUpdateReviewScreenArgs {
  const ShopAddUpdateReviewScreenArgs({
    required this.shopRateUser,
    required this.pk,
  });

  final ShopRateUser shopRateUser;
  final String pk;
}

class ShopAddUpdateReviewScreen extends StatefulWidget {
  const ShopAddUpdateReviewScreen({
    super.key,
    required this.args,
  });

  static const String routeName = 'shop-add-update-review-screen';
  final ShopAddUpdateReviewScreenArgs args;

  @override
  State<ShopAddUpdateReviewScreen> createState() =>
      _ShopAddUpdateReviewScreenState();
}

class _ShopAddUpdateReviewScreenState extends State<ShopAddUpdateReviewScreen> {
  final TextEditingController descriptionCtrl = TextEditingController();
  double rate = 0;

  @override
  void initState() {
    final shopReview = widget.args.shopRateUser.userReview;
    if (shopReview != null) {
      rate = shopReview.rate.toDouble();
      descriptionCtrl.text = shopReview.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Add Review'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: widget.args.shopRateUser.shopName,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                text: 'Rating',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Center(
                child: RatingBar.builder(
                  initialRating:
                      widget.args.shopRateUser.userReview != null ? rate : 0,
                  minRating: 1,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rate = rating;
                    });
                  },
                ),
              ),
              const Divider(
                height: 20,
              ),
              const CustomText(
                text: 'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                textController: descriptionCtrl,
                labelText: "Description",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                maxLines: 5,
                parametersValidate: 'required',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBtn(
                label: 'Submit',
                onTap: handleSubmitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleSubmitForm() async {
    if (rate > 0) {
      final repository = ShopReviewRepositoryImpl();
      EasyLoading.show();

      try {
        final response = await repository.addShopReview(
            pk: widget.args.pk,
            description: descriptionCtrl.value.text,
            rate: rate.toInt());
        EasyLoading.dismiss();

        await Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
              context: context,
              title: AppConstant.appName,
              body: widget.args.shopRateUser.userReview != null
                  ? "Successfully update your review"
                  : "Successfully add your review",
              buttons: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    handleNavigate(response);
                  },
                  child: const CustomText(text: 'Ok'),
                )
              ]);
        });
        // ignore: use_build_context_synchronously
      } catch (e) {
        EasyLoading.dismiss();
        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: AppConstant.appName,
            body: "something went wrong",
            isError: true,
          );
        });
      }
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: AppConstant.appName,
          body: "Please add rating",
          isError: true,
        );
      });
    }
  }

  void handleNavigate(ShopReview response) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop(response);
    });
  }
}

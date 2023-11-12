import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:tire_tech_mobile/core/bloc/view_status.dart';

import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/core/utils/spacing/v_space.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/recent_service_searches/recent_service_searches_bloc.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ServicesRecentSearch extends StatelessWidget {
  const ServicesRecentSearch({
    Key? key,
    required this.bloc,
    required this.onTapRecentSearch,
  }) : super(key: key);

  final RecentServiceSearchesBloc bloc;
  final Function(String query) onTapRecentSearch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentServiceSearchesBloc, RecentServiceSearchesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.viewStatus == ViewStatus.failed) {
          return const Center(
            child: CustomText(text: 'Something went wrong'),
          );
        }

        if (state.viewStatus == ViewStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.recentSearches.isEmpty) {
          return const Center(
            child: CustomText(text: 'No Recent Search.'),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Vspace.md,
                    const CustomText(
                      text: 'Recent Searches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Vspace.sm,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.recentSearches.length,
                      itemBuilder: (context, index) {
                        final items = state.recentSearches[index];

                        return GestureDetector(
                          onTap: () {
                            onTapRecentSearch(items);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: index == 0 ? 0 : 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: ColorName.primary,
                                      size: 20,
                                    ),
                                    Vspace.xxs,
                                    CustomText(
                                      text: items,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: ColorName.placeHolder,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            CustomBtn(
              label: 'Clear Recent Searches',
              onTap: () {
                handleClearDialog(context);
              },
              backgroundColor: Colors.red,
            )
          ],
        );
      },
    );
  }

  void handleClearDialog(BuildContext context) {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const CustomText(text: AppConstant.appName),
      content: const CustomText(text: "Clear all recent searches?"),
      actions: <Widget>[
        TextButton(
            child: const CustomText(text: "Yes"),
            onPressed: () async {
              bloc.add(ClearRecentSearchEvent());
              Navigator.pop(context);
            }),
        TextButton(
            child: const CustomText(text: "Close"),
            onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }
}

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/location/get_current_location.dart';
import 'package:tire_tech_mobile/core/permission/app_permission.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/recent_service_searches/recent_service_searches_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/body/services_recent_search.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/search_bar_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/screen/search_shops_screen.dart';

class SearchServicesScreen extends StatefulWidget {
  static const String routeName = 'home/search-services';

  const SearchServicesScreen({super.key});

  @override
  State<SearchServicesScreen> createState() => _SearchServicesScreenState();
}

class _SearchServicesScreenState extends State<SearchServicesScreen> {
  final TextEditingController queryCtrl = TextEditingController();
  late final RecentServiceSearchesBloc recentServiceSearchesBloc;

  List<ServiceOffer>? filterServices;

  @override
  void initState() {
    handleSetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context: context, title: 'Search Services & Shops'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 0,
                      child: SearchBarWidget(
                        onSearch: () {
                          handleSearch();
                        },
                        placeholder: "Search service",
                        query: queryCtrl.text,
                        controller: queryCtrl,
                      ),
                    ),
                    Expanded(
                      child: ServicesRecentSearch(
                        bloc: recentServiceSearchesBloc,
                        onTapRecentSearch: (query) {
                          handleSearch(query: query);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleSetBloc() {
    recentServiceSearchesBloc =
        BlocProvider.of<RecentServiceSearchesBloc>(context);
    recentServiceSearchesBloc.add(GetRecentSearchesEvent());
  }

  Future<void> handleSearch({String? query}) async {
    final locationPermGranted = await AppPermission.locationPermission();

    if (locationPermGranted) {
      EasyLoading.show();

      final currentLocation = await getCurrentLocation();

      EasyLoading.dismiss();

      Future.delayed(const Duration(milliseconds: 500), () {
        if (query == null) {
          recentServiceSearchesBloc.add(AddRecentSearchEvent(queryCtrl.text));
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(
          SearchShopsScreen.routeName,
          arguments: SearchShopsArgs(
            categoryQuery: query ?? queryCtrl.text,
            latitude: currentLocation?.latitude ?? 0,
            longitude: currentLocation?.longitude ?? 0,
          ),
        );

        queryCtrl.text = '';
      });
    } else {
      AppSettings.openAppSettings();
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';

class ShopImageSequenceViewArgs {
  const ShopImageSequenceViewArgs({
    required this.photoUrls,
    required this.shopName,
  });
  final List<String> photoUrls;
  final String shopName;
}

class ShopImageSequenceView extends StatefulWidget {
  const ShopImageSequenceView({
    super.key,
    required this.args,
  });

  static const String routeName = 'shop-image-sequence';
  final ShopImageSequenceViewArgs args;

  @override
  State<ShopImageSequenceView> createState() => _ShopImageSequenceViewState();
}

class _ShopImageSequenceViewState extends State<ShopImageSequenceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: widget.args.shopName),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _CompleteImageSequenceView(photoUrls: widget.args.photoUrls),
              _IncompleteImageSequenceView(photoUrls: widget.args.photoUrls),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompleteImageSequenceView extends StatelessWidget {
  const _CompleteImageSequenceView({required this.photoUrls});

  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    if (photoUrls.length >= 4) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCountLength(photoUrls),
        itemBuilder: (context, parentIndex) {
          final itemInSequenceUrls =
              itemSubListUrl(number: parentIndex, photoUrls: photoUrls);

          return Column(
            children: [
              _FirstImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: itemInSequenceUrls.first,
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: itemInSequenceUrls.first,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _SecondImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: itemInSequenceUrls[1],
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: itemInSequenceUrls[1],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _ThirdImageSequenceView(
                  photoUrls: photoUrls,
                  firstPhoto: itemInSequenceUrls[2],
                  secondPhoto: itemInSequenceUrls[3]),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        },
      );
    }

    return Container();
  }

  int getPhotoUrlsIndex({
    required String url,
    required List<String> photoUrls,
  }) {
    return photoUrls.indexOf(url);
  }

  int itemCountLength(List<String> photoUrls) {
    return photoUrls.length ~/ 4;
  }

  List<String> itemSubListUrl({
    required int number,
    required List<String> photoUrls,
  }) {
    final start = number == 0 ? 0 : (number * 3) + 1;
    final end = number == 0 ? 4 : start + 4;

    return photoUrls.sublist(start, end).toList();
  }
}

class _IncompleteImageSequenceView extends StatelessWidget {
  const _IncompleteImageSequenceView({required this.photoUrls});

  final List<String> photoUrls;
  @override
  Widget build(BuildContext context) {
    if (photoUrls.isNotEmpty && photoUrls.length != 4) {
      final remainPhotoUrls =
          photoUrls.length - (itemCountLength(photoUrls) * 4);

      switch (remainPhotoUrls) {
        case 1:
          return _FirstImageSequenceView(
            photoUrls: photoUrls,
            photoUrl: photoUrls.first,
            index: getPhotoUrlsIndex(
              photoUrls: photoUrls,
              url: photoUrls.first,
            ),
          );

        case 2:
          return Column(
            children: [
              _FirstImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: photoUrls.first,
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: photoUrls.first,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _SecondImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: photoUrls[1],
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: photoUrls[1],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        case 3:
          return Column(
            children: [
              _FirstImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: photoUrls.first,
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: photoUrls.first,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _SecondImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: photoUrls[1],
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: photoUrls[1],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _SecondImageSequenceView(
                photoUrls: photoUrls,
                photoUrl: photoUrls[2],
                index: getPhotoUrlsIndex(
                  photoUrls: photoUrls,
                  url: photoUrls[2],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        default:
      }
    }

    return Container();
  }

  int getPhotoUrlsIndex({
    required String url,
    required List<String> photoUrls,
  }) {
    return photoUrls.indexOf(url);
  }

  int itemCountLength(List<String> photoUrls) {
    return photoUrls.length ~/ 4;
  }
}

class _FirstImageSequenceView extends StatelessWidget {
  const _FirstImageSequenceView({
    required this.photoUrl,
    required this.index,
    required this.photoUrls,
  });
  final String photoUrl;

  final List<String> photoUrls;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ImageDetailView.routeName,
            arguments:
                ImageDetailViewArgs(photoUrls: photoUrls, initialPage: index));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: photoUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _SecondImageSequenceView extends StatelessWidget {
  const _SecondImageSequenceView({
    required this.photoUrl,
    required this.index,
    required this.photoUrls,
  });
  final String photoUrl;
  final List<String> photoUrls;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ImageDetailView.routeName,
            arguments:
                ImageDetailViewArgs(photoUrls: photoUrls, initialPage: index));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: photoUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _ThirdImageSequenceView extends StatelessWidget {
  const _ThirdImageSequenceView({
    required this.firstPhoto,
    required this.secondPhoto,
    required this.photoUrls,
  });
  final String firstPhoto;
  final String secondPhoto;
  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ImageDetailView.routeName,
                arguments: ImageDetailViewArgs(
                  photoUrls: photoUrls,
                  initialPage:
                      getPhotoUrlsIndex(url: firstPhoto, photoUrls: photoUrls),
                ),
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.48,
              height: MediaQuery.of(context).size.height * 0.15,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: firstPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ImageDetailView.routeName,
                arguments: ImageDetailViewArgs(
                  photoUrls: photoUrls,
                  initialPage:
                      getPhotoUrlsIndex(url: secondPhoto, photoUrls: photoUrls),
                ),
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.15,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: secondPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getPhotoUrlsIndex({
    required String url,
    required List<String> photoUrls,
  }) {
    return photoUrls.indexOf(url);
  }
}

class ImageDetailViewArgs {
  const ImageDetailViewArgs({
    required this.photoUrls,
    required this.initialPage,
  });

  final List<String> photoUrls;
  final int initialPage;
}

class ImageDetailView extends StatefulWidget {
  const ImageDetailView({
    super.key,
    required this.args,
  });

  final ImageDetailViewArgs args;
  static const String routeName = 'image-detail-view';

  @override
  State<ImageDetailView> createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  PageController controller = PageController();
  late int currentPage;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.args.initialPage);
    currentPage = widget.args.initialPage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(3),
          child: GestureDetector(
            onTap: onTapClose,
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: Column(
        children: [
          Text(
            '$currentPage/${widget.args.photoUrls.length}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: setCurrentPage,
              controller: controller,
              itemCount: widget.args.photoUrls.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.args.photoUrls.elementAt(index),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void setCurrentPage(int page) {
    setState(() {
      currentPage = page + 1;
    });
  }

  void onTapClose() {
    Navigator.pop(context);
  }
}

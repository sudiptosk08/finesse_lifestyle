import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/home/controllers/slider_controller.dart';
import 'package:finesse/src/features/home/models/slider_model.dart';
import 'package:finesse/src/features/home/state/slider_state.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/k_colors.dart';

class KSlider extends StatefulWidget {
  final int? selectSliders;

  const KSlider({this.selectSliders, Key? key}) : super(key: key);

  @override
  State<KSlider> createState() => _KSliderState();
}

class _KSliderState extends State<KSlider> {
  int pageSliders = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final sliderState = ref.watch(sliderProvider);
        final List<MainSlider>? sliderData = sliderState is SliderSuccessState
            ? sliderState.homeSliderModel?.mainSlider
            : [];
        // List<MainSlider> bannerList = sliderData!
        //     .map(
        //       (entry) =>MainSlider(
        //         imagePath: entry.image,
        //         id: entry.id.toString(),
        //       ),
        //     )
        //     .toList();
        return Container(
            key: UniqueKey(),
            width: context.screenWidth * 0.92,
            height: context.screenHeight * 0.3,
            color: KColor.appBackground,
            child: pageSliders == 1
                ? sliderState is LoadingState
                    ? Carousel(
                        boxFit: BoxFit.cover,
                        images: sliderData!
                            .map<Widget>(
                              (element) => ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                element.image,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                            .toList(),
                        borderRadius: true,
                        dotIncreaseSize: 0,
                        radius: Radius.circular(12),
                        dotBgColor: Colors.grey.withOpacity(0.0),
                        dotSize: 0,
                        autoplay: true,
                        autoplayDuration: Duration(seconds: 3),
                        animationCurve: Curves.easeInOut,
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.redAccent,
                        child: Container(height: 150),
                      )
                : Carousel(
                    boxFit: BoxFit.cover,
                    images: sliderData!
                        .map<Widget>(
                          (element) => ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                             element.image,
                              alignment: Alignment.center,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                        .toList(),
                    borderRadius: true,
                    dotIncreaseSize: 0,
                    radius: Radius.circular(12),
                    dotBgColor: Colors.grey.withOpacity(0.0),
                    dotSize: 0,
                    autoplay: true,
                    autoplayDuration: Duration(seconds: 3),
                    animationCurve: Curves.easeInOut,
                  ));
      },
    );
  }
}

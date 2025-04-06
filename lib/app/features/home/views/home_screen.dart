import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:momentsy/app/features/home/viewmodels/home_view_model.dart';
import 'package:momentsy/app/features/home/views/widgets/status_card.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/core/widgets/textfield/custom_send_message_field.dart';
import 'package:get/get.dart';
import 'package:momentsy/gen/assets.gen.dart';
import 'package:preload_page_view/preload_page_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.find<HomeViewModel>();
  late PreloadPageController _pageController;

  @override
  void initState() {
    _pageController = PreloadPageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          color: AppColor.background,
          child: Obx(
            () =>
                homeController.isLoading.value
                    ? Center(
                      child: CircularProgressIndicator(color: AppColor.primary),
                    )
                    : Padding(
                      padding: EdgeInsets.only(
                        bottom: space12,
                        top: MediaQuery.of(context).padding.top + space12,
                        left: space12,
                        right: space12,
                      ),
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity! > -1000) {
                            Get.toNamed(AppRoutes.CAMERA);
                          }
                        },
                        child:
                            homeController.images.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                        Assets.lotties.addFirstImage,
                                        width: context.getWidth / 2.5,
                                      ),
                                      Text(
                                        'Vuốt sang phải để thêm hình',
                                        style: AppStyle.bold12,
                                      ),
                                    ],
                                  ),
                                )
                                : Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: PreloadPageView.builder(
                                          key: PageStorageKey("pageView"),
                                          controller: _pageController,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              homeController.images.length,
                                          preloadPagesCount: 10,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final story =
                                                homeController.images[index];
                                            return AnimatedContainer(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColor.shadow,
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: StatusCardWidget(
                                                  story: story,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    CustomSendMessageField(),
                                  ],
                                ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

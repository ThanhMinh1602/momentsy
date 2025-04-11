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

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final FocusNode _focusNode = FocusNode();

  final homeController = Get.find<HomeViewModel>();

  bool isFocused = false;
  @override
  bool get wantKeepAlive => true; // 👈 GIỮ TRẠNG THÁI
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      scrollDirection: Axis.vertical,
                                      itemCount: homeController.images.length,
                                      preloadPagesCount: 10,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final story =
                                            homeController.images[index];
                                        return AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Center(
                                            child: StatusCardWidget(
                                              isFocus: isFocused,
                                              story: story,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                CustomSendMessageField(
                                  focusNode: _focusNode,
                                  hintText: 'Trả lời tin',
                                ),
                              ],
                            ),
                  ),
                ),
      ),
    );
  }
}

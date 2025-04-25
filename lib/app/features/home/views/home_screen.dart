import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:momentsy/core/widgets/progess/custom_circular_progress.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:momentsy/app/features/home/viewmodels/home_view_model.dart';
import 'package:momentsy/app/features/home/views/widgets/status_card.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/core/widgets/textfield/custom_send_message_field.dart';
import 'package:momentsy/gen/assets.gen.dart';

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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final horizontalPadding = space12;
    final verticalPadding = MediaQuery.of(context).padding.top + space12;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: CustomCircularProgress(),
          );
        }

        final images = homeController.images;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPadding,
            horizontalPadding,
            space12,
          ),
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > -1000) {
                Get.toNamed(AppRoutes.CAMERA);
              }
            },
            child:
                images.isEmpty
                    ? _buildEmptyView(context)
                    : _buildPageView(images),
          ),
        );
      }),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.lotties.addFirstImage,
            width: context.getWidth / 2.5,
          ),
          const SizedBox(height: 8),
          Text('Vuốt sang phải để thêm hình', style: AppStyle.bold12),
        ],
      ),
    );
  }

  Widget _buildPageView(List<dynamic> images) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PreloadPageView.builder(
              key: const PageStorageKey("pageView"),
              scrollDirection: Axis.vertical,
              itemCount: images.length,
              preloadPagesCount: 10,
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final story = images[index];
                return Center(
                  child: StatusCardWidget(isFocus: isFocused, story: story),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        CustomSendMessageField(focusNode: _focusNode, hintText: 'Trả lời tin'),
      ],
    );
  }
}

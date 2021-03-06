import 'package:flutter/material.dart';
import 'package:portfolio/app/core/app_extensions.dart';
import 'package:portfolio/app/core/app_responsive.dart';
import 'package:portfolio/app/modules/home/domain/entities/banner_entity.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sizes.dart';
import '../../../../core/app_text_styles.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
    required this.banner,
  }) : super(key: key);

  final BannerEntity banner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing32px),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!banner.tip.isNullOrEmpty)
                  SelectableText(
                    banner.tip!,
                    style: AppTextStyles.tipSpotlight.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                if (!banner.title.isNullOrEmpty)
                  SelectableText(
                    banner.title!,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.snow,
                    ),
                  ),
                if (!banner.description.isNullOrEmpty)
                  SelectableText(
                    banner.description!,
                    style: AppTextStyles.nav.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                if (!banner.textButton.isNullOrEmpty &&
                    !banner.downloadFileUrl.isNullOrEmpty) ...[
                  const SizedBox(height: AppSizes.spacing16px),
                  SizedBox(
                    width: AppResponsive.isMobile ? double.infinity : null,
                    child: ElevatedButton(
                      onPressed: () async {
                        final canLaunch =
                            await canLaunchUrlString(banner.downloadFileUrl!);

                        if (!canLaunch) return;

                        launchUrlString(banner.downloadFileUrl!);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        enabledMouseCursor: SystemMouseCursors.click,
                        shadowColor: AppColors.transparent,
                        primary: AppColors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.spacing16px,
                          horizontal: AppSizes.spacing32px,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSizes.borderRadius4px,
                          side: const BorderSide(
                            width: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      child: Text(
                        banner.textButton!,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (!AppResponsive.isMobile) ...[
            const SizedBox(width: AppSizes.spacing64px),
            Expanded(
              child: banner.imageUrl != null
                  ? Image.network(
                      banner.imageUrl!,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    )
                  : const SizedBox.shrink(),
            ),
          ]
        ],
      ),
    );
  }
}

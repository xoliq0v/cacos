import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/style.dart';
import '../../../components/custom_loader/custom_loader.dart';
class ExpandedFavWidget extends StatelessWidget {

  final String title;
  final IconData? iconData;
  final String? imageIcon;

  const ExpandedFavWidget({
    super.key,
    required this.title,
    this.iconData,
    this.imageIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.space10),
      padding: Dimensions.floatingButtonPadding,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50),
        // color: Get.find<ApiClient>().getSecondaryColor(),
        color: MyColor.drawerColorDarkMode
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.space10),
            child: CachedNetworkImage(
              imageUrl: imageIcon!,
              width: Dimensions.space20,
              color: MyColor.colorWhite,
              placeholder: (context, url) => CustomLoader(loaderColor: MyColor.getPrimaryColor(),size: 20,),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text(title,style: regularDefault.copyWith(color: MyColor.colorWhite)),
        ],
      ),
    );
  }
}
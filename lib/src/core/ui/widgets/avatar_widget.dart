import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadButton;
  const AvatarWidget({super.key}) : hideUploadButton = false;
  const AvatarWidget.hideUploadButton({super.key}) : hideUploadButton = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ConstantImages.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Offstage(
              offstage: hideUploadButton,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ConstantColors.brown, width: 4),
                      shape: BoxShape.circle),
                  child: const Icon(
                    BarbershopIcons.addEmployee,
                    color: ConstantColors.brown,
                    size: 20,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

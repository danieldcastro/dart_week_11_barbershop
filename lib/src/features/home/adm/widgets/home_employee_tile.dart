import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/string_formatters_extension.dart';
import 'package:flutter/material.dart';

import '../../../../model/user_model.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;
  const HomeEmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ConstantColors.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ConstantImages.avatar),
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name.firstAndLastWords,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      onPressed: () => Navigator.pushNamed(context, '/schedule',
                          arguments: employee),
                      child: const Text(
                        'AGENDAR',
                        style: TextStyle(),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      onPressed: () {},
                      child: const Text(
                        'VER AGENDA',
                        style: TextStyle(),
                      ),
                    ),
                    const Icon(
                      BarbershopIcons.penEdit,
                      size: 16,
                      color: ConstantColors.brown,
                    ),
                    const Icon(
                      BarbershopIcons.trash,
                      size: 16,
                      color: ConstantColors.red,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

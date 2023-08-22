import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final bool showFilter;
  const HomeHeader({super.key}) : showFilter = true;
  const HomeHeader.withoutFilter({super.key}) : showFilter = false;
  // Foi criado um novo construtor para escolher o showFilter

  @override
  Widget build(BuildContext context) {
    String firstUserName = 'Alexandre do Henrique'.split(' ').first;

    String lastUserName = 'Henrique'.split(' ').last;

    String formattedUserName = '$firstUserName $lastUserName';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          image: DecorationImage(
            image: AssetImage(ConstantImages.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
          color: Colors.black),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFBDBDBD),
              child: SizedBox.shrink(),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 2,
              child: Text(
                formattedUserName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'editar',
                style: TextStyle(
                  color: ConstantColors.brown,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                BarbershopIcons.exit,
                color: ConstantColors.brown,
                size: 32,
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Bem vindo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Agende um cliente',
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        Offstage(offstage: !showFilter, child: const SizedBox(height: 24)),
        Offstage(
          offstage: !showFilter,
          child: TextFormField(
            onTapOutside: (_) => context.unFocus(),
            decoration: const InputDecoration(
              hintText: 'Buscar colaborador',
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Icon(
                  BarbershopIcons.search,
                  size: 26,
                  color: ConstantColors.brown,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

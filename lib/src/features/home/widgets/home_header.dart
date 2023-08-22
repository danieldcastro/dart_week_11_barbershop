import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;
  const HomeHeader({super.key}) : showFilter = true;
  const HomeHeader.withoutFilter({super.key}) : showFilter = false;
  // Foi criado um novo construtor para escolher o showFilter

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);

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
        barbershop.maybeWhen(
          data: (barbershopData) {
            return Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFBDBDBD),
                  child: SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Text(
                          barbershopData.name,
                          maxLines: 2,
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
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(homeAdmVmProvider.notifier).logout();
                  },
                  icon: const Icon(
                    BarbershopIcons.exit,
                    color: ConstantColors.brown,
                    size: 32,
                  ),
                )
              ],
            );
          },
          orElse: () {
            return const Center(
              child: BarbershopLoader(),
            );
          },
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

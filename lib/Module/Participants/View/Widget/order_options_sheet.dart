import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/generated/l10n.dart';

class OrderOptionsSheet extends StatelessWidget {
    final ParticipantsCubit cubit;

  const OrderOptionsSheet({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title:  Text(S.of(context).Participants_tarteep),
            leading:  Icon(Icons.star),
            onTap: () {
              cubit.fetchAllParticipantsWithOrder(
                  orderBy: 'points', direction: 'desc');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title:  Text(S.of(context).participant_trtip),
            leading:  Icon(Icons.sort_by_alpha),
           onTap: () {
              cubit.fetchAllParticipantsWithOrder(
                  orderBy: 'name', direction: 'asc');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}






import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:uber/feature/ride/cubit/location_cubit.dart';
import 'package:uber/feature/ride/cubit/location_state.dart';
import 'package:uber/feature/ride/view/widgets/custome_floating_buttons.dart';
import 'package:uber/feature/ride/view/widgets/custome_map.dart';
import 'package:uber/feature/ride/view/widgets/customed_location_buttons.dart';

class WhereToWidget extends StatefulWidget {
  final VoidCallback onConfirmTap;
  final bool isDisabled;
  const WhereToWidget({
    super.key,
    required this.onConfirmTap,
    required this.isDisabled,
  });

  @override
  State<WhereToWidget> createState() => _WhereToWidgetState();
}

class _WhereToWidgetState extends State<WhereToWidget> {
  final MapController mapController = MapController();
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    print(widget.isDisabled);
    print('object');
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state.showInvalidLocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid location coordinates"),
              duration: Duration(seconds: 2),
            ),
          );
          context.read<LocationCubit>().clearError();
        }
      },
      builder: (context, state) {
        final cubit = context.read<LocationCubit>();
        final fromLocation = state.fromLocation;
        final toLocation = state.toLocation;
        final selectingFrom = state.selectingFrom;
        final isLoadingLocation = state.isLoadingLocation;

        return Stack(
          alignment: Alignment.topRight,
          children: [
            CustomedFlutterMap(
              mapController: mapController,
              isDisabled: widget.isDisabled,
              cubit: cubit,
              selectingFrom: selectingFrom,
              fromLocation: fromLocation,
              toLocation: toLocation,
            ),
            Positioned(
              top: 40,
              right: 10,
              child: MapFloatingIcons(
                cubit: cubit,
                mapController: mapController,
                isLoadingLocation: isLoadingLocation,
              ),
            ),
            CustomedLocationButtons(
              fromLocation: fromLocation,
              toLocation: toLocation,
              cubit: cubit,
              selectingFrom: selectingFrom,
              onConfirmTap: widget.onConfirmTap,
            ),
          ],
        );
      },
    );
  }
}

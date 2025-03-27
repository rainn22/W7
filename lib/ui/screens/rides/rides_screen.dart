import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/ui/providers/rides_preferences_provider.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allows users to select a ride, once ride preferences have been defined.
///  The screen also allows users to re-define the ride preferences and activate some filters.
///
class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  RidePreference? getCurrentPreference(BuildContext context) {
    return context.watch<RidesPreferencesProvider>().currentPreference;
  }

  List<Ride> getMatchingRides(BuildContext context) {
    final currentFilter = RideFilter(); // Adjust this as needed
    final currentPreference = getCurrentPreference(context);
    return RidesService.instance.getRidesFor(currentPreference!, currentFilter);
  }

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onRidePrefSelected(BuildContext context, RidePreference newPreference) {
    final provider = context.read<RidesPreferencesProvider>();
    provider.setCurrentPreference(newPreference);
  }

  void onPreferencePressed(BuildContext context) async {
    final currentPreference = getCurrentPreference(context);
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      onRidePrefSelected(context, newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchingRides = getMatchingRides(context);
    final currentPreference = getCurrentPreference(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search bar
            RidePrefBar(
              ridePreference: currentPreference!,
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context),
              onFilterPressed: () {
                // Handle filter pressed
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
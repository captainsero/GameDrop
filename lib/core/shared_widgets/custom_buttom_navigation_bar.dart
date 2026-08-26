// import 'package:flutter/material.dart';
// import '../../../generated/l10n.dart';
// import '../constants/values_manager.dart';
//TODO:
// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({
//     required this.currentIndex,
//     required this.onTap,
//     super.key,
//   });

//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadiusGeometry.only(
//         topLeft: Radius.circular(RadiusSize.r16),
//         topRight: Radius.circular(RadiusSize.r16),
//       ),
//       child: BottomNavigationBar(
//         currentIndex: currentIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Theme.of(context).colorScheme.primary,
//         backgroundColor: Theme.of(context).colorScheme.tertiary.withAlpha(220),
//         unselectedItemColor: Theme.of(context).colorScheme.surface,
//         onTap: onTap,
//         items: [
//           _buildNavItem(
//             label: S.current.dashboard,
//             icon: Icons.home_outlined,
//           ),
//           _buildNavItem(
//             label: S.current.groups,
//             icon: Icons.groups_outlined,
//           ),
//           _buildNavItem(
//             label: S.current.scanner,
//             icon: Icons.qr_code_scanner_outlined,
//           ),
//           _buildNavItem(
//             label: S.current.schedule,
//             icon: Icons.date_range_outlined,
//           ),
//           _buildNavItem(
//             label: S.current.settings,
//             icon: Icons.settings_outlined,
//           ),
//         ],
//       ),
//     );
//   }

//   BottomNavigationBarItem _buildNavItem({
//     required String label,
//     required IconData icon,
//   }) {
//     return BottomNavigationBarItem(
//       activeIcon: Icon(
//         icon,
//       ),
//       icon: Icon(
//         icon,
//       ),

//       label: label,
//     );
//   }
// }



class AssetsData {

}
// Widget _buildCustomTransition1(BuildContext context,
//     Animation<double> animation, Animation<double> animationTwo, Widget child) {
//   const begin = Offset(0.0, 1.0);
//   const end = Offset.zero;
//   const curve = Curves.easeInOutCirc;

//   var slideTween =
//       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//   var offsetAnimation = animation.drive(slideTween);

//   var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
//   var scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(animation);

//   return FadeTransition(
//     opacity: fadeAnimation,
//     child: ScaleTransition(
//       scale: scaleAnimation,
//       child: SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       ),
//     ),
//   );
// }

// Widget _buildCustomTransition2(BuildContext context,
//     Animation<double> animation, Animation<double> animationTwo, Widget child) {
//   const begin = Offset(1.0, 0.0);
//   const end = Offset.zero;
//   const curve = Curves.easeInOutCirc;

//   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//   var offsetAnimation = animation.drive(tween);

//   return SlideTransition(
//     position: offsetAnimation,
//     child:child,);}
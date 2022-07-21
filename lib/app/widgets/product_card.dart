// class _MovieSuggestion extends StatelessWidget {
//   final Movie movie;

//   const _MovieSuggestion({Key? key, required this.movie}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     movie.heroId = 'search-${movie.id}';

//     return ListTile(
//       leading: Hero(
//         tag: movie.heroId!,
//         child: FadeInImage(
//           placeholder: AssetImage('assets/no-image.jpg'),
//           image: NetworkImage(movie.fullPosterImg),
//           width: 50,
//           fit: BoxFit.contain,
//         ),
//       ),
//       title: Text(movie.title),
//       subtitle: Text(movie.originalTitle),
//       onTap: () {
//         Navigator.pushNamed(context, 'details', arguments: movie);
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class LizitProductCard extends StatelessWidget {
  const LizitProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/widgets.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';

class Labels {
  var lightStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Palette.darkBlue,
  );
  var boldStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Palette.darkBlue,
  );

  Widget welcome() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 22),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'Aquí tendrás una experiencia completa y el mejor servicio que un ',
          style: lightStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'marketplace de comida ',
              style: boldStyle,
            ),
            TextSpan(
              text: 'te pueda ofrecer.',
              style: lightStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget find() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 22),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Puedes solicitar tu comida ',
          style: lightStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'desde la comodiad de tu casa ',
              style: boldStyle,
            ),
            TextSpan(
              text: 'con la mejor atención que nuestro equipo te puede dar.',
              style: lightStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget become() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 22),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'En RondApp puedes tener todo ',
          style: lightStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'al alcance de tu mano, tenemos ',
              style: boldStyle,
            ),
            TextSpan(text: 'muchos restaurantes ', style: boldStyle),
            TextSpan(
              text: 'en los cuales puedas pedir lo que quieras.',
              style: lightStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget withLiz() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 22),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Tienes una ',
          style: lightStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'solución digital ',
              style: boldStyle,
            ),
            TextSpan(
              text: ' al alcance de tu mano y sin ningún tipo de suscripción',
              style: lightStyle,
            ),
          ],
        ),
      ),
    );
  }
}

Labels labels = Labels();

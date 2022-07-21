import 'package:flutter/material.dart';

///
/// Esta clase contiene todos los mensajes de dialogo que se mostrarán dentro de la aplicación
///

class CustomDialogs {
  showMessageDialog(message, context, hasloading) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message ?? ''),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ACEPTAR',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      /// en caso de que tenga un loading lo cierro tambien
      if (hasloading) {
        Navigator.pop(context);
      }
    });
  }

  showLoadingDialog(context) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: Container(
                  alignment: Alignment.center,
                ));
          });
    } catch (e) {
      debugPrint('No context for loader');
      debugPrint(e.toString());
    }
  }

  hideLoadingDialog(context) {
    try {
      Navigator.pop(context);
    } catch (e) {
      print('No context for loader');
      print(e);
    }
  }

  showDinamicDialog(Function whenComplete, BuildContext context, bool dimisible,
      Widget child) {
    return showDialog(
        context: context,
        barrierDismissible: dimisible,
        builder: (context) {
          return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: child);
        }).whenComplete(() {
      whenComplete();
    });
  }
}

CustomDialogs customDialogs = CustomDialogs();

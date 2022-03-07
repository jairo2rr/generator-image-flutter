import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generate_image_app/screens/construct_image.dart';


final isWebMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS || 
        defaultTargetPlatform == TargetPlatform.android);

class ImageGeneratorPage extends StatefulWidget {
  const ImageGeneratorPage({ Key? key }) : super(key: key);

  @override
  State<ImageGeneratorPage> createState() => _ImageGeneratorPageState();
}

class _ImageGeneratorPageState extends State<ImageGeneratorPage> {
  final GlobalKey _keyBoundary = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Generator'),
      ),

      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingresa tu nombre just for that', textAlign: TextAlign.center,),
            const SizedBox( height:10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: textEditingController,
                    maxLength: 10,
                  ),
                ),
                const SizedBox(width: 10,),
                IconButton( 
                  onPressed: () async {
                    if (textEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ingresa tu nombre')),
                      );
                      return;
                    }
                    setState(() {});
                    await Future<dynamic>.delayed(
                      const Duration(milliseconds: 400),
                    );
                    final currentContext = _keyBoundary.currentContext;
                    final boundary = currentContext!.findRenderObject()
                        as RenderRepaintBoundary?;
                    final image = await boundary!.toImage(pixelRatio: 3);
                    final byteData = await image.toByteData(
                      format: ui.ImageByteFormat.png,
                    );
                    final pngBytes = byteData!.buffer.asUint8List();

                    if (isWebMobile) {
                      await Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => Scaffold(
                            appBar: AppBar(),
                            body: SizedBox.expand(
                              child: Image.memory(pngBytes),
                            ),
                          ),
                        ),
                      );
                    } else {
                      final content = base64Encode(pngBytes);
                      AnchorElement(
                        href:
                            'data:application/octet-stream;charset=utf-16le;base64,$content',
                      )
                        ..setAttribute('download', 'tu_secreto_flutter.png')
                        ..click();
                    }
                  },
                  icon: Icon(isWebMobile ? Icons.arrow_forward_ios: Icons.download),
                ),
              ],
            ),
            SizedBox(
              width: 0,
              height: 0,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: RepaintBoundary(
                      key: _keyBoundary,
                      child: ConstructImage(
                        phraseImage: _getRandomFunnyPhrase(),
                        nameUser: textEditingController.text,
                      )
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRandomFunnyPhrase(){
    final funnyPhrases = <String>[
      'todos tus proyectos estan hechos con GetX y con -10% de coverage',
      'tardas 4 horas haciendo un contador con flutter_bloc',
      'haces codigo intesteable y cruzas los dedos cuando sales a producción',
      'hace 1 año que propones flutter en tu empresa y no te hacen caso',
      'miras los videos de DevGuy esperando que esta vez no sea bait',
      'entras a los en vivo de Flutter solo para saludar y te vas',
      'combinas todo lo que aprendes en Diegoveloper para hacer tus proyectos',
      'Apple te rechazó la app porque tu aplicación le pareció fea',
      'compras codigos en Codecanyon, le cambias el color y los revendes',
      'aprendiste mas con Fernando Herrara que con la universidad',
      'postulaste a un puesto de trabajo donde pedian 8 años experiencia en Flutter',
      'no sabe que hace el context',
      'ignoras el linter en todos tus archivos para ser mas productivo',
      'aceptas los pull request de tus compañeros sin revisar',
      'aprendiste a usar Hero y automaticamente pusiste en tu CV que dominas animaciones',
      'le tienes miedo al animation controller',
      'tiene un altar de Remi Rousselet y Felix Angelov en tu cuarto',
      "algunas vez te han pedido hacer una app 'tipo' Uber",
      'estimaste un proyecto para 2 meses y lo hiciste en 6',
    ];
    final index = _getRandomNumber(0, funnyPhrases.length - 1);
    return funnyPhrases[index];
  }

  int _getRandomNumber(int min, int max) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }

}
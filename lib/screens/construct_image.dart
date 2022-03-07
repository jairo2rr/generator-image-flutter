

import 'package:flutter/material.dart';

class ConstructImage extends StatelessWidget {

  final String phraseImage;
  final String nameUser;
  final IconData iconUser;

  const ConstructImage({ Key? key, 
    required this.phraseImage, 
    required this.nameUser, 
    this.iconUser = Icons.security_update_sharp 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[600],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hola $nameUser', style: const TextStyle(fontSize: 23, color: Colors.black45),),
          Text(phraseImage, style: const TextStyle(color: Colors.white, fontSize: 15),),
          Icon(iconUser)
        ],
      ),
    );
  }
}


import 'package:eplatform/model/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DeleteIconButton extends StatelessWidget {

  const DeleteIconButton({required this.onPressed,required this.isLoading, Key? key}) : super(key: key);
      final VoidCallback onPressed;
      final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return isLoading?CircularProgressIndicator():
                      IconButton(
                         onPressed:onPressed,
                        icon: Icon(Icons.delete, color: Colors.red,));
      }
    );
  }
}

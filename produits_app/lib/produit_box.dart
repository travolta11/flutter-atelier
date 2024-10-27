import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//stl
class ProduitBox extends StatelessWidget {


  const ProduitBox({super.key,required this.nomProduit,this.selProduit=false, this.onChanged, this.delProduit});

     final String nomProduit;
     final bool selProduit;
     final Function(bool?)?onChanged;

    final Function(BuildContext context)?delProduit;
     
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(10.0),
    
    
    child: Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(onPressed: delProduit,
         icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(45),
        ),
      ],
      ),
    
    
    child: Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(45),
        
      ),
      height: 120,
      child: Row(
        children: [
         
          Text(nomProduit),
           Checkbox(value: selProduit, onChanged: onChanged),
        ],
    ),
    ),
    ),
    );
  }
}
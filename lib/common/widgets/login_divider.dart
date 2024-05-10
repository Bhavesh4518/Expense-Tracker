import 'package:flutter/material.dart';

class MyFormDivider extends StatelessWidget {
  const MyFormDivider({
    super.key,
   required this.dividerText,
  });
  final String dividerText;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: Colors.grey.shade200,indent: 60,endIndent: 5,)),
        Text(dividerText,style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: Colors.grey.shade200,indent: 5,endIndent: 60,)),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class PasswordToolTip extends StatelessWidget {
  const PasswordToolTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Center(
        child: Text(
          "En az 1 büyük harf, 1 küçük harf, 1 rakam, 1 özel karakter "
          "içermeli ve en az 8 karakter uzunluğunda olmalıdır.",
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

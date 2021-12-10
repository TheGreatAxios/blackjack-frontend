import 'package:flutter/material.dart';
import 'package:test_one/types/table.dart';

class DealerWidget extends StatelessWidget {
  const DealerWidget({Key? key, required this.dealer}) : super(key: key);

  final Dealer dealer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15,
          left: 15,
          child: Text(
            "DEALER${_getCurrentHandValue(dealer.currentHandValue)}",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 24,
            )
          )
        ),
        Positioned(
          top: 35,
          left: 15,
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: dealer.cards.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  child: Image.asset('assets/Cards/${dealer.cards[index]}.png'),
                );
              }
            ),
          )
        )
      ]
    );
  }
}

String _getCurrentHandValue(int _value) {
  return _value == -1 ? '' : ' | $_value';
}
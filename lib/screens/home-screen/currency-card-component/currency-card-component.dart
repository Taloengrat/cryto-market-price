import 'package:demo_application/providers/currrency-provider.dart';
import 'package:demo_application/screens/detail-screen/detail-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CurrencyCardComponent extends StatefulWidget {
  final String id;
  final bool isFetch;
  final String symbol;

  const CurrencyCardComponent({
    Key? key,
    required this.id,
    required this.isFetch,
    required this.symbol,
  }) : super(key: key);

  @override
  _CurrencyCardComponentState createState() => _CurrencyCardComponentState();
}

class _CurrencyCardComponentState extends State<CurrencyCardComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyItem =
        Provider.of<CurrrencyProvider>(context).findItem(widget.id);

    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => setState(() {
                Provider.of<CurrrencyProvider>(context, listen: false)
                    .isFav(currencyItem.id);
              }),
              foregroundColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.green.shade50,
              icon: currencyItem.isFav
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
            SlidableAction(
              onPressed: (context) => setState(() {
                Provider.of<CurrrencyProvider>(context, listen: false)
                    .setNotif(currencyItem.id);
              }),
              foregroundColor: currencyItem.isNotif
                  ? Colors.deepOrangeAccent
                  : Colors.deepOrangeAccent.shade200,
              backgroundColor: Colors.pink.shade50,
              icon: currencyItem.isNotif
                  ? Icons.notifications_active_rounded
                  : Icons.notification_add_rounded,
            ),
          ],
        ),
        child: ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            DetailScreen.routeName,
            arguments: DetailScreenArgument(
                name: currencyItem.name,
                logo: currencyItem.logo!,
                symbol: currencyItem.symbol,
                usdPrice: currencyItem.margetPrice!.toStringAsFixed(
                    (currencyItem.margetPrice! > 0.009) ? 2 : 8)),
          ),
          selectedColor: Colors.black,
          selected: true,
          title: Text(
            currencyItem.symbol,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'h: ${currencyItem.high.toStringAsFixed((currencyItem.margetPrice! > 0.009) ? 2 : 8)}'),
              Text(
                  'l: ${currencyItem.low.toStringAsFixed((currencyItem.margetPrice! > 0.009) ? 2 : 8)}'),
            ],
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${currencyItem.margetPrice!.toStringAsFixed((currencyItem.margetPrice! > 0.009) ? 2 : 8)} \$',
                  ),
                  Text(
                      '${currencyItem.margetPriceBath!.toStringAsFixed(currencyItem.margetPrice! > 0.009 ? 2 : 8)} ฿')
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    currencyItem.isUp
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: currencyItem.isUp ? Colors.green : Colors.red,
                  ),
                  Text(
                    '${currencyItem.percentChange.toStringAsFixed(2)} %',
                    style: TextStyle(
                      fontSize: 12,
                      color: (currencyItem.percentChange < 0)
                          ? Colors.red
                          : Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
          leading: Hero(
            tag: currencyItem.symbol,
            child: CircleAvatar(
              backgroundColor: currencyItem.logo!.isNotEmpty
                  ? Colors.transparent
                  : Colors.yellow,
              child: currencyItem.logo!.isNotEmpty
                  ? Image.asset(currencyItem.logo!)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

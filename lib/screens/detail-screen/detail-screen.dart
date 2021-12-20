import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAddNotif = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArgument;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isAddNotif = !isAddNotif;
              });
            },
            icon: Icon(isAddNotif
                ? Icons.notifications_active_rounded
                : Icons.notification_add_rounded),
            color: Colors.yellow,
          )
        ],
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: args.symbol,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(args.logo),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              args.name,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Text(
            args.usdPrice,
          ),
        ],
      ),
    );
  }
}

class DetailScreenArgument {
  final String name;
  final String logo;
  final String symbol;
  final String usdPrice;

  DetailScreenArgument(
      {required this.name,
      required this.logo,
      required this.symbol,
      required this.usdPrice});
}

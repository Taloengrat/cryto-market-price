import 'package:demo_application/providers/currrency-provider.dart';
import 'package:demo_application/screens/detail-screen/detail-screen.dart';
import 'package:demo_application/screens/home-screen/currency-card-component/currency-card-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  final String title;

  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavPage = false;
  bool isFetch = true;
  bool isUp = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CurrrencyProvider>(context, listen: false)
        .fetch()
        .then((value) => callFetc());
  }

  @override
  void dispose() {
    isFetch = false;

    super.dispose();
  }

  callFetc() {
    Provider.of<CurrrencyProvider>(context, listen: false)
        .fetch()
        .then((value) => Future.delayed(const Duration(milliseconds: 1500), () {
              if (isFetch) {
                callFetc();
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    final currencyList = Provider.of<CurrrencyProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              isFavPage = !isFavPage;
            }),
            icon: Icon(
              isFavPage
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: Colors.yellow,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<CurrrencyProvider>(context, listen: false).fetch(),
        child: ListView(
          children: [
            ...currencyList.map(
              (e) {
                if (isFavPage == e.isFav) {
                  return CurrencyCardComponent(
                    id: e.id,
                    isFetch: isFetch,
                    symbol: e.symbol,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:collection';
import 'dart:convert';

import 'package:demo_application/models/currency-model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrrencyProvider with ChangeNotifier {
  List<CurrencyModel> _items = [];
  bool isFirsted = false;
  List<CurrencyModel> get items => UnmodifiableListView(_items);

  CurrencyModel findItem(String id) =>
      _items.firstWhere((element) => element.id == id);

  String messariApi = 'https://data.messari.io/api/v1/assets';

  add(CurrencyModel item) {
    if (_items.firstWhere((element) => element.id == item.id) == null) {
      _items.add(item);
      notifyListeners();
    } else {
      update(item, _items.indexWhere((element) => element.id == item.id));
    }
  }

  addAll(List<CurrencyModel> itemList) {
    _items.addAll(itemList);
    notifyListeners();
  }

  update(CurrencyModel item, int index) {
    bool isUp = false;
    bool isFav = _items[index].isFav;
    bool isNotif = _items[index].isNotif;

    if (_items[index].margetPrice! > item.margetPrice!) {
      isUp = false;
    } else {
      isUp = true;
    }

    _items[index] = item;
    _items[index].isFav = isFav;
    _items[index].isNotif = isNotif;
    _items[index].isUp = isUp;

    notifyListeners();
  }

  removeAll() {
    _items.clear();
    notifyListeners();
  }

  remove(String id) {
    _items.remove(_items.firstWhere((element) => element.id == id));
    notifyListeners();
  }

  isFav(String id) {
    final indexCurrency = _items.indexWhere((element) => element.id == id);
    _items.elementAt(indexCurrency).isFav =
        !_items.elementAt(indexCurrency).isFav;
  }

  setNotif(String id) {
    final indexCurrency = _items.indexWhere((element) => element.id == id);
    _items.elementAt(indexCurrency).isNotif =
        !_items.elementAt(indexCurrency).isNotif;
  }

  Future<void> fetch() async {
    print('fetch');
    final response = await http.get(
      Uri.parse(messariApi),
      headers: {"x-messari-api-key": "17712439-49c3-4a89-b644-ed966f583feb"},
    );

    if (response.statusCode == 200) {
      List<CurrencyModel> currencyModelList = [];

      List.from(jsonDecode(response.body)['data']).forEach((element) =>
          {currencyModelList.add(CurrencyModel.fromJson(element))});

      if (currencyModelList.isNotEmpty && !isFirsted) {
        addAll(currencyModelList);
        isFirsted = true;
      } else if (isFirsted) {
        currencyModelList.forEach((element) => add(element));
      }
    } else {
      print('request status error ${response.body}');
    }
  }

  Future<void> singleFetch(String currency) async {
    String singleApi = 'https://data.messari.io/api/v1/assets/$currency';

    print('single fetch api $currency');
    final response = await http.get(
      Uri.parse(singleApi),
      headers: {"x-messari-api-key": "17712439-49c3-4a89-b644-ed966f583feb"},
    );

    final responseModel = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var item = CurrencyModel.fromJson(responseModel);

      add(item);
      print('add $item');
    } else {
      print('request status error ${response.body}');
    }
  }
}

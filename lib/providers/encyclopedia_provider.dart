import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/model/encyclopedia_model.dart';
import 'package:fourtyfourties/providers/base_provider.dart';
import 'package:fourtyfourties/screens/main_screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncyclopediaProvider extends BaseProvider {
  TabController? encycleopediaTabController;
  int selectedIndex = 0;
  setSelectedIndex(int i) {
    selectedIndex = i;
    encycleopediaTabController?.animateTo(i);
    setBusy(false);
  }

  void goToNext() {
    if (encycleopediaTabController != null && encyclopedia.isNotEmpty) {
      int newIndex = (selectedIndex + 1) % encyclopedia.length;
      encycleopediaTabController!.animateTo(newIndex);
      selectedIndex = newIndex;
    }
    setBusy(false);
  }

  void goToPrevious() {
    if (encycleopediaTabController != null && encyclopedia.isNotEmpty) {
      int newIndex =
          (selectedIndex - 1 + encyclopedia.length) % encyclopedia.length;
      encycleopediaTabController!.animateTo(newIndex);
      selectedIndex = newIndex;
    }
    setBusy(false);
  }

  static const String _dataKey = 'encyclopedia_data';
  static const String _dataUrl =
      'https://raw.githubusercontent.com/ieasybooks/40x40s/main/data.json';

  List<EncyclopediaModel> encyclopedia = [];

  Future<void> loadData() async {
    setBusy(true);

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.last != ConnectivityResult.none) {
      // Online: fetch from network and save to local
      try {
        final response = await api.get(_dataUrl, {});
        if (response.statusCode == 200) {
          encyclopedia = //json.decode(response.body);
              (json.decode(response.body) as List)
                  .map((e) => EncyclopediaModel.fromJson(e))
                  .toList();

          await _saveToLocal(response.body);
          encycleopediaTabController = TabController(
            length: encyclopedia.length,
            vsync: homeScaffoldKey.currentState!,
          );
          encycleopediaTabController!.addListener(() {
            if (encycleopediaTabController!.indexIsChanging) {
              selectedIndex = encycleopediaTabController!.index;
              setBusy(false); // This will trigger notifyListeners()
            }
          });
          setBusy(false);
          return;
        } else {
          await _loadFromLocal();
          setBusy(false);
        }
      } catch (e) {
        // If network fails, fallback to local
        if (kDebugMode) {
          print('Network error: $e');
        }
      }
    }
    // Offline or network failed: load from local
    await _loadFromLocal();
    setBusy(false);
  }

  Future<void> _saveToLocal(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dataKey, data);
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_dataKey);
    if (data != null) {
      encyclopedia =
          (json.decode(data) as List)
              .map((e) => EncyclopediaModel.fromJson(e))
              .toList();
      encycleopediaTabController = TabController(
        length: encyclopedia.length,
        vsync: homeScaffoldKey.currentState!,
      );
      encycleopediaTabController!.addListener(() {
        if (encycleopediaTabController!.indexIsChanging) {
          selectedIndex = encycleopediaTabController!.index;
          setBusy(false); // This will trigger notifyListeners()
        }
      });
    } else {
      encyclopedia = [];
    }
  }
}

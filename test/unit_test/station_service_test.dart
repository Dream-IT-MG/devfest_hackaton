// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:devfest_hackaton/models/station.dart';
import 'package:devfest_hackaton/services/station_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:devfest_hackaton/main.dart';

void main() {
  test('Counter increments smoke test', () {
    // Build our app and trigger a frame.

    expect(
        getFilteredStations(
            "b", [Station(name: "Andreba", heureArrive: "10H")]),
        findsNothing);
  });
}

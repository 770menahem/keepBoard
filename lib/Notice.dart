import 'package:flutter/material.dart';

class Notice {
  final String title;
  final String name;
  final double price;
  final String picUrl;
  final String location;
  final String phone;

  Notice({
    required this.price,
    required this.name,
    required this.picUrl,
    required this.title,
    required this.location,
    required this.phone,
  });

  Widget asWidget() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Text(this.title, style: TextStyle(fontSize: 30)),
          Image.asset(
            this.picUrl,
            height: 200,
            width: 500,
          ),
          Text('${this.price}\$'),
          Text(this.location),
          Text(this.phone),
        ],
      ),
    );
  }
}

List<Notice> notices = [
  Notice(
      price: 55,
      name: 'men',
      picUrl: 'img/logo.JPEG',
      title: 'מורה לאנגלית',
      location: 'לוד',
      phone: '01561248'),
  Notice(
      price: 55,
      name: 'men',
      picUrl: 'img/bg2.jpg',
      title: 'שיפוצים',
      location: 'כפר חבד',
      phone: '01561248'),
  Notice(
      price: 55,
      name: 'men',
      picUrl: 'img/bg3.jpg',
      title: 'לק גל',
      location: 'ירושלים',
      phone: '01561248'),
  Notice(
      price: 55,
      name: 'men',
      picUrl: 'img/logo.jpg',
      title: 'סופר סתם',
      location: 'קרית גת',
      phone: '01561248'),
];

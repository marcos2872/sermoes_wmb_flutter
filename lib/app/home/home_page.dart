import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri _url = Uri.parse('https://branham.org/pt/williambranham');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          children: [
            Center(
              child: Text(
              'William Branham',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            ),
          
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage('assets/images/wmb.png'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 40,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
              'Profeta do século XXI',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            ),
            const SizedBox(height: 40),
            TextButton(
                onPressed: _launchUrl,
                child: Text(
                  'Saiba mais!',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

import 'package:contact_list/ui/contact_page_screen.dart';
import 'package:contact_list/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:math';
class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true,withPhoto: true);
      setState(() => _contacts = contacts);
      print(_contacts.toString());
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Contacts List')),
          body: _body()));

  Color _randomColor() {
    Color newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);

    while (_alreadyUsedColors.contains(newColor)) {
      newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(0.3);
    }
    _alreadyUsedColors.add(newColor);
    return newColor;
  }
  Color _randomColorDark() {
    Color newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    while (_alreadyUsedColors.contains(newColor)) {
      newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    }
    _alreadyUsedColors.add(newColor);
    return newColor;
  }
  final List<Color> _alreadyUsedColors = [];

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i){

          return ListTile(
              leading: Container(
                width: 45,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _randomColor(),
                  shape: BoxShape.circle,
                  image:_contacts![i].photoOrThumbnail != null?
                  DecorationImage(
                      image: MemoryImage(_contacts![i].photoOrThumbnail!),
                      fit: BoxFit.cover):
                  null,
                ),
                child: _contacts![i].photoOrThumbnail != null?null: Text(
                  _contacts![i].displayName.substring(0,1).toUpperCase(),
                  style: FontUtilities.h26(
                      fontColor: _randomColorDark(), fontWeight: FWT.regular),
                ),
              ),
              title: Text(
                _contacts![i].displayName.substring(0,1).toUpperCase()+_contacts![i].displayName.substring(1,_contacts![i].displayName.length),
              ),
              subtitle: _contacts![i].addresses.length>0?
              Text(_contacts![i].addresses[0].city.length>0?(_contacts![i].addresses[0].city+", "):""+
                  (_contacts![i].addresses[0].state.length>0?_contacts![i].addresses[0].state+", ":"")+
                  (_contacts![i].addresses[0].country.length>0?_contacts![i].addresses[0].country:"")
              ):null,
              titleTextStyle: FontUtilities.h16(
                  fontColor: const Color(0xff272d37), fontWeight: FWT.medium),
              onTap: () async {
                final fullContact =
                await FlutterContacts.getContact(_contacts![i].id);
                await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
              });
        }

    );
  }
}

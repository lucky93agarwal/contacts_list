import 'package:contact_list/ui/contact_page_screen.dart';
import 'package:contact_list/utils/font_utils.dart';
import 'package:contact_list/utils/get_data.dart';
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
  _incrementCounter(){

  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Contacts List')),
          body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),));



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
                  color: GetData.randomColor(),
                  shape: BoxShape.circle,
                  image:GetData.checkPhotoOrThumbnail(_contacts![i])?
                  DecorationImage(
                      image: MemoryImage(_contacts![i].photoOrThumbnail!),
                      fit: BoxFit.cover):
                  null,
                ),
                child: Visibility(
                  visible: !GetData.checkPhotoOrThumbnail(_contacts![i]),
                  child: Text(GetData.getUserNameFirstLatter(_contacts![i]),
                    style: FontUtilities.h26(
                        fontColor: GetData.randomColorDark(), fontWeight: FWT.regular),
                  ),
                ),
              ),
              title: Text(GetData.getUserName(_contacts![i])),
              subtitle: GetData.checkAddress(_contacts![i]) ? Text(GetData.getAddress(_contacts![i])) : null,
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

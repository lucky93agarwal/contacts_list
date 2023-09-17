import 'package:contact_list/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

import '../utils/get_data.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Container(height: 250,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.rectangle,
          image:contact.photoOrThumbnail != null?
          DecorationImage(
              image: MemoryImage(contact.photoOrThumbnail!),
              fit: BoxFit.cover):
          null,
        ),),
        SizedBox(height: 20,),
        Text(contact.name.first,style: FontUtilities.h24(
            fontColor: Colors.black, fontWeight: FWT.regular),),
        Text('Last name: ${contact.name.last}'),
        Text('Phone number: ${contact.phones.isNotEmpty ? GetData.getMobileNo(contact) : '(none)'}'),
        Text('Address: '+(GetData.checkAddress(contact)?GetData.getAddress(contact):"")),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));



}

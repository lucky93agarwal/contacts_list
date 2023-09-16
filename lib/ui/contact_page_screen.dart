import 'package:contact_list/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Container(height: 200,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //shadow color
              spreadRadius: 5, // spread radius
              blurRadius: 7, // shadow blur radius
              offset: const Offset(0, 3), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, -3), // changes position of shadow
            ),
          ],
          image:contact.photoOrThumbnail != null?
          DecorationImage(
              image: MemoryImage(contact.photoOrThumbnail!),
              fit: BoxFit.cover):
          null,

        ),),
        Text(contact.name.first,style: FontUtilities.h30(
            fontColor: Colors.black, fontWeight: FWT.regular),),
        Text('Last name: ${contact.name.last}'),
        Text('Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));

}

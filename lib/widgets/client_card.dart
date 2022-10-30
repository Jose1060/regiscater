import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';

Widget clientCard(Function()? onTapeed, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTapeed,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc['name'],
                    style: AppStyle.mainTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    doc['dni'].toString(),
                    style: AppStyle.dniTitle,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    doc['phone'].toString(),
                    style: AppStyle.phoneTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )));
}

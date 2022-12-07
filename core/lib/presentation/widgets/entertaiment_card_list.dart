// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class EntertaimentCard extends StatelessWidget {
  final Movie? movie;
  final Tv? tv;
  final bool isTV;

  EntertaimentCard({required this.isTV, this.movie, this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DETAIL_ROUTE,
            arguments: isTV == true
                ? EntertaimentDetailArguments(id: tv!.id, isTV: true)
                : EntertaimentDetailArguments(id: movie!.id, isTV: false),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTV == true ? tv!.name ?? '-' : movie!.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      isTV == true
                          ? tv!.overview ?? '-'
                          : movie!.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                // ignore: sort_child_properties_last
                child: CachedNetworkImage(
                  imageUrl:
                      '$BASE_IMAGE_URL${isTV == true ? tv!.posterPath : movie!.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

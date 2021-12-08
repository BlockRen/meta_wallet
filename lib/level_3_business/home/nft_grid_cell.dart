import 'package:flutter/material.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';

class NftGridCell extends StatelessWidget {
  const NftGridCell(this.model, {Key? key}) : super(key: key);

  final NftModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GridViewCover(model.url),
          const SizedBox(height: 10),
          GridViewTitle(model.title),
          GridViewTime(model.time)
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Theme.of(context).cardColor
      ),
    );
  }
}

class GridViewCover extends StatelessWidget {
  const GridViewCover(this.cover, {Key? key}) : super(key: key);

  final String cover;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        image: DecorationImage(
          image: NetworkImage(cover),
          fit: BoxFit.cover
        )
      ),
    );
  }
}

class GridViewTitle extends StatelessWidget {
  const GridViewTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
    );
  }
}

class GridViewTime extends StatelessWidget {
  const GridViewTime(this.time, {Key? key}) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        time,
        maxLines: 1,
        style: const TextStyle(fontSize: 10),
      ),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
    );
  }
}
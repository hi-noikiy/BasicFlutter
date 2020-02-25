
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/models/cart.dart';
import 'package:simple_app/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _MyAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => _MyListItem(index)))
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme
            .of(context)
            .textTheme
            .display4,
      ),
      floating: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'))
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var catalog = Provider.of<CatalogModel>(context);
    var item = catalog.getByPosition(index);
    var textTheme = Theme
        .of(context)
        .textTheme
        .title;

    return Padding(padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
    ),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: <Widget>[
            AspectRatio(aspectRatio: 1, child:
            Container(
              color: item.color,
            ),
            ),
            SizedBox(width: 42,),
            Expanded(
              child: Text(item.name, style: textTheme,),
            ),
            SizedBox(width: 24,),
            _AddButton(item: item)
          ],
        ),
      ),);
  }
}

class _AddButton extends StatelessWidget {

  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var cart = Provider.of<CartModel>(context);
    return FlatButton(
      onPressed: cart.items.contains(item) ? null : () => cart.add(item),
      splashColor: Theme
          .of(context)
          .primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADD',) : Text('ADD'),
    );
  }
}



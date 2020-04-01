import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  const CartItem(
      {this.id, this.productId, this.price, this.title, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white,
        size:40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx)=>
          AlertDialog(
            title: Text("Emin Misin ?"),
            content: Text("Ürünü kaldırmak istediginizi emin misiniz ?"),
            actions: <Widget>[
              FlatButton(
                 child: Text("Evet"),
                onPressed: (){
                  Navigator.of(context).pop(true);
              }),
              FlatButton(
                child: Text("Hayır"),
                onPressed:(){
                Navigator.of(context).pop(false);
              } ,)
            ],
          )
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: FittedBox(
                          child: Text("\$${price.toStringAsFixed(2)}")))),
            ),
            subtitle: Text("Total: \$${price * quantity}"),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}

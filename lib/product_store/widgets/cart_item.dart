import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_pro/product_store/model/icecream.dart';
import 'package:store_pro/themes/styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.quantity,
    required this.product,
    super.key,
  });

  final Icecreams product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          product.image!,
        ),
      ),

      title: Text(
        product.flavor!,
        style: Styles.productRowItemName.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black
        ),
      ),

      subtitle: Text(
        '${quantity > 1 ? '$quantity x ' : ''} ₹ ${
          product.price?.toStringAsFixed(2)
        }',
        style: Styles.productRowItemPrice.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white70
            : Colors.black54
        ),
      ),

      trailing: Text(
        '₹ ${(product.price! * quantity).toStringAsFixed(2)}',
        style: Styles.productRowItemName.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white70
            : Colors.black54
        ),
      )
      ),
    );
  }
}

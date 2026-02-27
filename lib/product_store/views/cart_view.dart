import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/model/app_state_model.dart';
import 'package:store_pro/product_store/widgets/cart_item.dart';
import 'package:store_pro/themes/styles.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String? name;
  String? email;
  String? mobile;
  String? address;
  DateTime dateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
        prefixIcon: Icon(Ionicons.person_outline),
      ),

      keyboardType: TextInputType.name,

      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },

      onSaved: (String? value) {
        name = value;
      },

      onChanged: (value) => setState(() => name = value),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        prefixIcon: Icon(Ionicons.mail_outline),
      ),

      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null;
      },

      onSaved: (String? value) {
        email = value;
      },

      onChanged: (value) => setState(() => email = value),
    );
  }

  Widget _buildMobile() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Mobile',
        prefixIcon: Icon(Ionicons.call_outline),
      ),

      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Mobile is Required';
        }

        return null;
      },

      onSaved: (String? value) {
        mobile = value;
      },

      onChanged: (value) => setState(() => mobile = value),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Address',
        prefixIcon: Icon(Ionicons.location_outline),
      ),

      keyboardType: TextInputType.streetAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Address is Required';
        }

        return null;
      },

      onSaved: (String? value) {
        address = value;
      },

      onChanged: (value) => setState(() => address = value),
    );
  }

  Widget _buildTimePicker() {
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: dateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime(
            DateTime.now().year + 1,
          ),
        );
        if (pickedDate != null) {
          setState(() {
            dateTime = pickedDate;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Icon(Ionicons.time_outline, size: 28),

                    SizedBox(width: 6),

                    Text(
                      'Delivery Time',
                      style: Styles.deliveryTime,
                    ),
                  ],
                ),

                Text(
                  DateFormat.yMMMd().add_jm().format(dateTime),
                  style: Styles.deliveryTime,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cart'),
        ),
      ),

      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          return ListView(
            children: [
              ExpansionTile(
                title: const Text('Address Details'),
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildName(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildEmail(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildMobile(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildAddress(),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildTimePicker(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Divider(),

                if (value.productsInCart.isNotEmpty) ...[
                ListView.builder(
                  itemCount: value.productsInCart.length,
                  itemBuilder: (context, index) {
                  return CartItem(
                    product: value.getProductById(
                    value.productsInCart.keys.toList()[index],
                    ),
                    quantity: value.productsInCart.values.toList()[index],
                  );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    'Shipping + Tax',
                    style: Styles.productRowItemPrice.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                    ),
                    ),

                    Text(
                    '₹ ${value.shippingCost.toStringAsFixed(2)} + ${
                      value.tax.toStringAsFixed(2)
                    }',
                    style: Styles.productRowItemPrice.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                    ),
                    ),
                  ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    'Total',
                    style: Styles.productRowItemName.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                    ),
                    ),

                    Text(
                    '₹ ${value.totalCost.toStringAsFixed(2)}',
                    style: Styles.productRowItemPrice.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                    ),
                    ),
                  ],
                  ),
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                  onPressed: () {
                    if (name == null || name!.isEmpty ||
                      email == null || email!.isEmpty ||
                      mobile == null || mobile!.isEmpty ||
                      address == null || address!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                      content: Text('Please fill in all address details'),
                      ),
                    );
                    } else if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    value.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                      content: Text('Order Placed Successfully'),
                      ),
                    );
                    }
                  },
                  child: const Text('Place Order'),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

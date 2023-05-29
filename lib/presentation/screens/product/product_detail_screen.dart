import 'package:agriapp/data/models/product.dart';
import 'package:agriapp/extensions.dart';
import 'package:agriapp/logic/cart/cart_bloc.dart';
import 'package:agriapp/presentation/screens/product/widgets/productDetailPrice.dart';
import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:agriapp/presentation/widgets/form/custom_drop_down.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final String categoryId;

  ProductDetailScreen({Key? key, required this.product, required this.categoryId}) : super(key: key);

  final _form = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  _addToCart(BuildContext context) {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      context.read<CartBloc>().add(CartUpdateEvent(categoryId: categoryId, productId: product.documentId, productName: product.name, productImage: product.image, quantity: int.parse(_controller.text), price: product.price));

      Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
    }
  }

  String? quantityValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter a quantity";
    }
    if (int.tryParse(text) == null) {
      return "Must be a number";
    }
    if (int.parse(text) <= 0) {
      return "Must be greater than zero";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  progressIndicatorBuilder: (_, __, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (_, __, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 2, offset: const Offset(0, -2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(product.name.capitalize(), style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.center, maxLines: 2),
                    const SizedBox(height: 12),
                    ProductDetailPrice(product: product),
                    const SizedBox(height: 50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _form,
                          child: Expanded(
                            flex: 3,
                            child: CustomTextFormField(controller: _controller, text: 'Quantity', keyboardType: TextInputType.number, validator: quantityValidation),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(flex: 2, child: CustomDropDown(options: product.unit.isNotEmpty ? [product.unit.capitalize()] : ['Units'])),
                      ],
                    ),
                    const SizedBox(height: 40),
                    FullWidthButton(text: "Add to Cart", primary: false, onPressed: () => _addToCart(context)),
                    const SizedBox(height: 16),
                    const FullWidthButton(text: "Buy now"),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

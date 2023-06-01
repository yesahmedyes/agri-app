import 'package:agriapp/data/models/cartItem.dart';
import 'package:agriapp/data/repositories/products_repository.dart';
import 'package:agriapp/extensions.dart';
import 'package:agriapp/presentation/screens/cart/bloc/suggestion_bloc.dart';
import 'package:agriapp/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionBox extends StatelessWidget {
  final List<CartItem> items;

  const SuggestionBox({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuggestionBloc(productsRepository: context.read<ProductsRepository>()),
      child: SuggestionBoxChild(items: items),
    );
  }
}

class SuggestionBoxChild extends StatefulWidget {
  final List<CartItem> items;

  const SuggestionBoxChild({Key? key, required this.items}) : super(key: key);

  @override
  State<SuggestionBoxChild> createState() => _SuggestionBoxChildState();
}

class _SuggestionBoxChildState extends State<SuggestionBoxChild> {
  fetchSuggestions() {
    context.read<SuggestionBloc>().add(SuggestionFetchEvent(productId: widget.items.first.productId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fetchSuggestions();
  }

  @override
  void didUpdateWidget(covariant SuggestionBoxChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    fetchSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionBloc, SuggestionState>(
      builder: (context, state) {
        if (state is SuggestionFetchedState) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('You may also like to buy', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/productDetail', arguments: ProductDetailArguments(product: state.product, categoryId: state.product.categoryId));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AspectRatio(
                          aspectRatio: 18 / 8,
                          child: CachedNetworkImage(
                            imageUrl: state.product.image,
                            progressIndicatorBuilder: (_, __, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                            errorWidget: (_, __, error) => const Icon(Icons.error),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(state.product.name.capitalize(), style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center, maxLines: 2),
                        const SizedBox(height: 8),
                        Text('Rs ${state.product.price} / ${state.product.unit}', style: Theme.of(context).textTheme.subtitle1),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

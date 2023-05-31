import 'package:agriapp/extensions.dart';
import 'package:agriapp/logic/cart/cart_bloc.dart';
import 'package:agriapp/logic/categories/categories_bloc.dart';
import 'package:agriapp/logic/product/product_bloc.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccessState) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomAppBar(),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                    itemCount: state.categories.length,
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            context.read<ProductBloc>().add(ProductOpenEvent(documentId: state.categories[index].documentId));
                            Navigator.of(context).pushNamed('/productsList');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: state.categories[index].image,
                                      progressIndicatorBuilder: (_, __, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                      errorWidget: (_, __, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Text(state.categories[index].name.capitalize(), style: Theme.of(context).textTheme.subtitle1),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const CustomProgressIndicator();
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('KissanDost', style: Theme.of(context).textTheme.headline1!.copyWith(height: 1.6)),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/cart');
              },
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartOpenedState && state.items.isNotEmpty) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_rounded, color: Colors.black87),
                        Positioned(
                          top: -6,
                          right: -6,
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            child: Center(child: Text(state.items.length.toString(), style: const TextStyle(fontSize: 7, color: Colors.white))),
                          ),
                        )
                      ],
                    );
                  }
                  return const Icon(Icons.shopping_cart_rounded, color: Colors.black87);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

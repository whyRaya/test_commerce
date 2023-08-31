import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_commerce/bloc/product_bloc.dart';
import 'package:test_commerce/styles/colors.dart';

import '../../bloc/product_event.dart';
import '../../bloc/product_state.dart';
import '../../data/model/product_model.dart';
import '../../data/product_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: ProductRepository())
        ..add(GetProductEvent()),
      child: Scaffold(
        backgroundColor: primary,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(child: Text("${state.error}"));
            } else if (state is SuccessState) {
              return SafeArea(
                child: Column(
                  children: [
                    const MainAppBar(),
                    MainHeader(
                      products: state.data.products,
                    ),
                    const SizedBox(height: 20,),
                    TabBar(
                      tabs: state.data.categories
                          .map((e) => Tab(text: e))
                          .toList(),
                      labelStyle: const TextStyle(fontSize: 16.0),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14.0,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.5),
                      isScrollable: true,
                      controller: tabController,
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Default"));
            }
          },
        ),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications))
        ],
      ),
    );
  }
}

class MainHeader extends StatelessWidget {
  MainHeader({super.key, required this.products});

  final List<ProductModel> products;
  final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.32;
    double cardWidth = MediaQuery.of(context).size.width * 0.45;

    return SizedBox(
      height: cardHeight,
      child: Swiper(
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductCard(
              height: cardHeight, width: cardWidth, product: products[index]);
        },
        scale: 0.8,
        controller: swiperController,
        viewportFraction: 0.5,
        loop: true,
        fade: 0.5,
        autoplay: true,
        autoplayDisableOnInteraction: true,
        autoplayDelay: 3000,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.height,
    required this.width,
  });

  final ProductModel product;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 0),
            height: height,
            width: width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Colors.black54,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.title.trim(),
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 16.0),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: accent,
                        ),
                        child: Text(
                          '\$${product.price}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 25,
            child: Hero(
              tag: product.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.image,
                  height: height * 0.6,
                  width: width * 0.65,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_commerce/bloc/product_bloc.dart';
import 'package:test_commerce/ext/strings.dart';
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
        body: BlocBuilder<ProductBloc, CommonState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(child: Text("${state.error}"));
            } else if (state is SuccessState) {
              return SafeArea(
                  child: NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                        child: Column(
                      children: [
                        const _MainAppBar(),
                        _MainHeader(
                          products: state.data.products,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: _MainBalance(),
                        ),
                      ],
                    ))
                  ];
                },
                body: _MainCategoryTabBar(
                  categories: state.data.categories,
                ),
              ));
            } else {
              return const Center(child: Text("Default"));
            }
          },
        ),
      ),
    );
  }
}

class _MainAppBar extends StatelessWidget {
  const _MainAppBar();

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

class _MainHeader extends StatelessWidget {
  _MainHeader({required this.products});

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
          return _MainProductHeader(
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

class _MainProductHeader extends StatelessWidget {
  const _MainProductHeader({
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

class _MainBalance extends StatelessWidget {
  const _MainBalance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: const Icon(Icons.qr_code_scanner),
                onTap: () {},
              ),
              const SizedBox(
                width: 1.0,
                height: 24.0,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(158, 158, 158, 0.6)),
                ),
              ),
              InkWell(
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wallet,
                      color: primary,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$ 50000',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          '1500 points',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () {},
              ),
              const SizedBox(
                width: 1.0,
                height: 24.0,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(158, 158, 158, 0.6)),
                ),
              ),
              InkWell(
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.loyalty,
                      color: accent,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Platinum",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '12 Coupons',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainCategoryTabBar extends StatefulWidget {
  const _MainCategoryTabBar({required this.categories});

  final List<String> categories;

  @override
  State<_MainCategoryTabBar> createState() => _MainCategoryTabBarState();
}

class _MainCategoryTabBarState extends State<_MainCategoryTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: widget.categories
              .map((e) => Tab(text: e.capitalizeFirstWord()))
              .toList(),
          onTap: (tabIndex) {},
          labelStyle: const TextStyle(fontSize: 16.0),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14.0,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.5),
          isScrollable: true,
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.categories
                .map((e) => _MainCategoryTabView(category: e))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _MainCategoryTabView extends StatefulWidget {
  const _MainCategoryTabView({required this.category});

  final String category;

  @override
  State<_MainCategoryTabView> createState() => _MainCategoryTabViewState();
}

class _MainCategoryTabViewState extends State<_MainCategoryTabView> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.5;
    double cardWidth = MediaQuery.of(context).size.width * 0.4;
    return BlocProvider(
      create: (context) =>
          ProductCategoriesBloc(productRepository: ProductRepository())
            ..add(GetProductByCategoriesEvent(category: widget.category)),
      child: Scaffold(
        backgroundColor: primary,
        body: BlocBuilder<ProductCategoriesBloc, CommonState>(
          builder: (event, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(child: Text("${state.error}"));
            } else if (state is SuccessState) {
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: state.data
                    .map<Widget>((e) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _MainCategoryProduct(
                              product: e, height: cardHeight, width: cardWidth),
                        ))
                    .toList(),
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

class _MainCategoryProduct extends StatelessWidget {
  const _MainCategoryProduct({
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
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5),
                          child: Text(
                            product.title.trim(),
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 14.0),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
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
                              fontSize: 14,
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
            left: 50,
            child: Hero(
              tag: product.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.image,
                  height: height * 0.225,
                  width: width * 0.35,
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

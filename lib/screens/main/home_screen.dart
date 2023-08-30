import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_commerce/bloc/product_bloc.dart';

import '../../bloc/product_event.dart';
import '../../bloc/product_state.dart';
import '../../data/product_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: ProductRepository())
        ..add(GetProductEvent()),
      child: Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text("${state.error}")
              );
            } else if (state is SuccessState) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: state.data.categories
                      .map((e) => ListTile(title: Text(e)))
                      .toList(),
                ),
              );
            } else {
              return const Center(
                  child: Text("Default")
              );
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
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

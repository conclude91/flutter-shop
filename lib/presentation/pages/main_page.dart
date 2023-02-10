import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/presentation/blocs/product/product_bloc.dart';
import 'package:shop/presentation/pages/form_page.dart';
import 'package:shop/presentation/widgets/product_card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: (value) => context
                    .read<ProductBloc>()
                    .add(ProductFetchEvent(key: value)),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is ProductLoadedState ||
                        state is ProductDeletedState) {
                      context
                          .read<ProductBloc>()
                          .add(const ProductFetchEvent());
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductFetchedState) {
                          return GridView.count(
                            scrollDirection: Axis.vertical,
                            childAspectRatio:
                                (MediaQuery.of(context).size.height / 6) /
                                    (MediaQuery.of(context).size.width / 2),
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: state.listProduct
                                .map((product) =>
                                    ProductCardWidget(product: product))
                                .toList(),
                          );
                        }
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        },
        backgroundColor: Colors.black87,
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

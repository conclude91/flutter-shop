import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/presentation/blocs/product/product_bloc.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, this.product});

  final ProductModel? product;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _imageController.dispose();
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product != null) {
      _idController.text = widget.product?.id ?? '';
      _imageController.text = widget.product?.image ?? '';
      _nameController.text = widget.product?.name ?? '';
      _descController.text = widget.product?.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 56,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.product != null ? 'Edit Product' : 'Add Product',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  widget.product != null
                      ? GestureDetector(
                          onTap: () {
                            context.read<ProductBloc>().add(
                                ProductDeleteEvent(id: _idController.text));
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(width: 20),
                        ),
                ],
              ),
            ),
            const Divider(height: 0, thickness: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextField(
                    controller: _idController,
                    readOnly: widget.product != null ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Id',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _imageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Image',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        ProductModel product = ProductModel(
                          id: _idController.text,
                          image: _imageController.text,
                          name: _nameController.text,
                          description: _descController.text,
                        );
                        if (widget.product != null) {
                          context
                              .read<ProductBloc>()
                              .add(ProductUpdateEvent(product: product));
                        } else {
                          context
                              .read<ProductBloc>()
                              .add(ProductAddEvent(product: product));
                        }
                        Navigator.pop(context);
                      },
                      child: Text(widget.product != null ? 'Edit' : 'Add'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

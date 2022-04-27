import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:products_app/providers/providers.dart';
import 'package:products_app/services/products_service.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final producService  = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(producService.selectedProduct),
      child: _ProductScreenBody(producService: producService),
    );
    // return 


  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.producService,
  }) : super(key: key);

  final ProductsService producService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: producService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white))
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async{
                      final picker = ImagePicker();

                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                      );
                      if(pickedFile == null){
                        // print("No se selecciono nada");
                        return;
                      }
                      // print('Tenemos imagen ${pickedFile.path}');
                      producService.updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white))
                ),
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: producService.isSaving
        ? const CircularProgressIndicator(color: Colors.white)
        : const Icon(Icons.save_outlined),
        onPressed: producService.isSaving
        ? null
        : () async{
          if(!productForm.isValidForm()) return;

          final String? imageUrl = await producService.uploadImage();
          
          if(imageUrl != null) productForm.product.picture = imageUrl;

          await producService.saveOrCreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                decoration: InputDecorations.authInputDecoration(
                  hinText:"Nombre del Producto",
                  lableText: 'Nombre:'
                ),
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hinText:'\$150',
                  lableText: 'Precio:'
                ),
                onChanged: (value){
                  if(double.tryParse(value) == null || value == ""){
                    product.price = 0;
                  }else{
                    product.price = double.parse(value);  
                  }
                },
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'El precio es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                value:product.available,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability //Send value by reference
              )
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}
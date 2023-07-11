import 'package:crud/RestApi/RestClient.dart';
import 'package:crud/Screen/ProductGridViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:crud/Style/style.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;

  const ProductUpdateScreen(this.productItem);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String, dynamic> FormValues = {
    "Img": "",
    "ProductName": "",
    "ProductCode": "",
    "Qty": "",
    "UnitPrice": "",
    "TotalPrice": ""
  };
  bool Loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      FormValues.update("Img", (value) => widget.productItem["Img"]);
      FormValues.update(
          "ProductName", (value) => widget.productItem["ProductName"]);
      FormValues.update(
          "ProductCode", (value) => widget.productItem["ProductCode"]);
      FormValues.update("Qty", (value) => widget.productItem["Qty"]);
      FormValues.update(
          "UnitPrice", (value) => widget.productItem["UnitPrice"]);
      FormValues.update(
          "TotalPrice", (value) => widget.productItem["TotalPrice"]);
    });
  }

  InputOnChange(Mapkey, Textvalue) {
    setState(() {
      FormValues.update(Mapkey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues["Img"]!.length == 0) {
      ErrorToast('Image Link Required!');
    } else if (FormValues['ProductCode']!.length == 0) {
      ErrorToast('Product Code Required!');
    } else if (FormValues['ProductName']!.length == 0) {
      ErrorToast('Product Name Required!');
    } else if (FormValues['Qty']!.length == 0) {
      ErrorToast('Product Quantity Required!');
    } else if (FormValues['UnitPrice']!.length == 0) {
      ErrorToast('Unit Price Required!');
    } else if (FormValues['TotalPrice']!.length == 0) {
      ErrorToast('Total Price Required!');
    } else {
      setState(() {
        Loading = true;
      });

      await ProductUpdateRequest(FormValues, widget.productItem['_id']);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductGridViewScreen()),
          (Route route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: FormValues['ProductName'],
                          onChanged: (Textvalue) {
                            InputOnChange('ProductName', Textvalue);
                          },
                          decoration: AppInputDecoration('Product Name'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: FormValues['ProductCode'],
                          onChanged: (Textvalue) {
                            InputOnChange('ProductCode', Textvalue);
                          },
                          decoration: AppInputDecoration('Product Code'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: FormValues['Img'],
                          onChanged: (Textvalue) {
                            InputOnChange("Img", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Image'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: FormValues['UnitPrice'],
                          onChanged: (Textvalue) {
                            InputOnChange("UnitPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Unit Price'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: FormValues['TotalPrice'],
                          onChanged: (Textvalue) {
                            InputOnChange("TotalPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Total Price'),
                        ),
                        const SizedBox(height: 20),
                        AppDropDownStyle(
                          DropdownButton(
                            value: FormValues['Qty'],
                            items:  [
                              DropdownMenuItem(
                                  child: Text('Select Qt'), value: ""),
                              DropdownMenuItem(
                                  child: Text('1 pcs'), value: "1"),
                              DropdownMenuItem(
                                  child: Text('2 pcs'), value: "2"),
                              DropdownMenuItem(
                                  child: Text('3 pcs'), value: "3"),
                              DropdownMenuItem(
                                  child: Text('4 pcs'), value: "4"),
                            ],
                            onChanged: (Textvalue) {
                              InputOnChange("Qty", Textvalue);
                            },
                            underline: Container(),
                            isExpanded: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: AppButtonStyle(),
                          onPressed: () {
                            FormOnSubmit();
                          },
                          child: SuccessButtonChild('Update'),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

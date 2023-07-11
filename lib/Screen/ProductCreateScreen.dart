import 'package:crud/RestApi/RestClient.dart';
import 'package:crud/Style/style.dart';
import 'package:flutter/material.dart';
import 'ProductGridViewScreen.dart';

class ProductCreateScreen extends StatefulWidget {
  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String, dynamic> FormValues = {
    "Img": "",
    "ProductName": "",
    "ProductCode": "",
    "Qty": "",
    "UnitPrice": "",
    "TotalPrice": ""
  };
  bool Loading = false;

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
      await ProductCreateRequest(FormValues);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductGridViewScreen()),
          (Route route) => false);
      setState(() {
        Loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
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
                          onChanged: (Textvalue) {
                            InputOnChange('ProductName', Textvalue);
                          },
                          decoration: AppInputDecoration('Product Name'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange('ProductCode', Textvalue);
                          },
                          decoration: AppInputDecoration('Product Code'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("Img", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Image'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("UnitPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Unit Price'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("TotalPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Total Price'),
                        ),
                        const SizedBox(height: 20),
                        AppDropDownStyle(
                          DropdownButton(
                            value: FormValues['Qty'],
                            items: [
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
                        SizedBox(height: 20),
                        Container(
                          child: ElevatedButton(
                            style: AppButtonStyle(),
                            onPressed: () {
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild('Submit'),
                          ),
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

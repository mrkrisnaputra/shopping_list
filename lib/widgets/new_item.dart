  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';


import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}
class _NewItemState extends State<NewItem>{
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1; 
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSubmitting = false;

  void _saveItem() async{
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      // Save the item
      _formKey.currentState!.save();
      final url=Uri.https(dotenv.env['FIREBASE_URL']!,'shopping-list.json');
      final response=await http.post(url,headers: {
        'Content-Type': 'application/json'
      }, body: json.encode({
        'name': _enteredName,
        'quantity': _enteredQuantity,
        'category': _selectedCategory.title,
      },
      ),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);

      if(!context.mounted) {
        return;
      }
      



    // http.
      Navigator.of(context).pop(GroceryItem(id: responseData['name'], name: _enteredName, quantity: _enteredQuantity, category: _selectedCategory));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child:Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator:(value) {
                if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50) {
                  return 'Please enter a name between 2 and 50 characters';
                }
                return null;
              } ,
              onSaved: (newValue) => _enteredName = newValue!,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _enteredQuantity.toString(),
                    decoration: const InputDecoration(
                      label: Text('Quantity'),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0) {
                        return 'Must be a valid positive number';
                      }
                      return null;
                    } ,
                    onSaved: (newValue) => _enteredQuantity = int.parse(newValue!),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _selectedCategory,
                    items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6),
                              Text(category.value.title),
                            ],
                          ),
                        ),
                    ],
                    onChanged:(value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    } ,
                  
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSubmitting ? null : () {
                      _formKey.currentState!.reset();
                  },
                  
                  child: const Text('Reset'),
                ),  
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _saveItem,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                          )
                      : const Text('Add Item'),
                ),
              ],
            ),
          ],
        ),
        ), 
     
      ),

    );
  }
}
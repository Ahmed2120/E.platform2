import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownRegister extends StatelessWidget {
  DropDownRegister(this.list, this.onChange, this.item, this.hintText, {Key? key}) : super(key: key);

  List<String> list; Function onChange; String? item, hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        // showSearchBox: true
      ),
      items: list,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15))
        ),
      ),
      onChanged:(value)=> onChange(value),
      selectedItem: item,
    );
  }
}

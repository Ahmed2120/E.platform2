import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownNote extends StatelessWidget {
  DropDownNote({required this.list, required this.onChange, required this.item, required this.hintText, Key? key}) : super(key: key);

  List<String> list; Function onChange; String? item, hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: true,
        // showSearchBox: true
      ),
      items: list,
      dropdownDecoratorProps: DropDownDecoratorProps(

        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: const Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
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
      dropdownButtonProps: const DropdownButtonProps(padding: EdgeInsets.zero, isVisible: false),
      onChanged:(value)=> onChange(value),
      selectedItem: item,
    );
  }
}

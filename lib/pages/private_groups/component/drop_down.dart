import 'package:dropdown_search/dropdown_search.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:flutter/material.dart';

class DropDownPrivateBooking extends StatelessWidget {

  DropDownPrivateBooking(this.list,
      this.onChange,
      this.item,
      this.hintText,
      {Key? key}) :
        super(key: key);

  List<Subject> list; Function onChange;
  Subject ? item; String? hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<Subject>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose
        // showSearchBox: true
      ),
      items: list,
      itemAsString: (Subject subject) => subject.Name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText!,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),

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
      onChanged:(value)=> onChange(value),
      selectedItem: item,
    );
  }
}

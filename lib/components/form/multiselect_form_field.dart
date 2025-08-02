import 'package:flutter/material.dart';

class MultiselectFormField<T> extends FormField<List<T>> {
  MultiselectFormField({
    super.key,
    required List<T> options,
    required String Function(T) itemTitleBuilder,
    required FormFieldSetter<List<T>> super.onSaved,
    required InputDecoration decoration,
    List<T>? initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: initialValue ?? [],
         builder: (FormFieldState<List<T>> state) {
           return InputDecorator(
             decoration: decoration,
             isEmpty: state.value == null || state.value!.isEmpty,
             child: Wrap(
               spacing: 8.0,
               runSpacing: 8.0,
               children: options.map((option) {
                 final selected = state.value!.contains(option);
                 return FilterChip(
                   label: Text(itemTitleBuilder(option)),
                   selected: selected,
                   onSelected: (bool value) {
                     if (value) {
                       state.didChange([...state.value!, option]);
                     } else {
                       state.didChange([...state.value!]..remove(option));
                     }
                   },
                 );
               }).toList(),
             ),
           );
         },
       );
}

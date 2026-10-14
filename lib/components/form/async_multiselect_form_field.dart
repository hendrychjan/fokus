import 'package:flutter/material.dart';

class AsyncMultiselectFormField<T> extends FormField<List<T>> {
  AsyncMultiselectFormField({
    super.key,
    required Future<List<T>> getOptions,
    required String Function(T) itemTitleBuilder,
    required FormFieldSetter<List<T>> super.onSaved,
    required InputDecoration decoration,
    List<T>? initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: initialValue ?? [],
         builder: (FormFieldState<List<T>> state) {
           return FutureBuilder<List<T>>(
             future: getOptions,
             builder: (context, asyncSnapshot) {
               if (asyncSnapshot.hasData) {
                 final options = asyncSnapshot.data ?? [];
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
               }

               return InputDecorator(
                 decoration: decoration,
                 isEmpty: state.value == null || state.value!.isEmpty,
                 child: Wrap(
                   spacing: 8.0,
                   runSpacing: 8.0,
                   children: [CircularProgressIndicator()],
                 ),
               );
             },
           );
         },
       );
}

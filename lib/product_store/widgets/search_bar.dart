import 'package:flutter/material.dart';
import 'package:store_pro/themes/styles.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
              ),

              const SizedBox(
                width: 8,
              ),

              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,

                  style: Styles.searchText,

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              IconButton(
                onPressed: controller.clear,
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

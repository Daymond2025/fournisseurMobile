import 'package:flutter/material.dart';

class PaginationorderWidget extends StatelessWidget {
  final int currentPage;
  final int lastPage;
  final ValueChanged<int> onPageChanged;

  const PaginationorderWidget({
    required this.currentPage,
    required this.lastPage,
    required this.onPageChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1
              ? () => onPageChanged(currentPage - 1)
              : null,
          icon: const Icon(Icons.arrow_back),
        ),
        Text('Page $currentPage / $lastPage'),
        IconButton(
          onPressed: currentPage < lastPage
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}

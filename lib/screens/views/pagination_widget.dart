import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int current_page;
  final int total_pages;
  final Function(int) on_page_change;

  const PaginationWidget({
    Key? key,
    required this.current_page,
    required this.total_pages,
    required this.on_page_change,
  }) : super(key: key);

  void handlePrevious() {
    if (current_page > 1) {
      on_page_change(current_page - 1);
    }
  }

  void handleNext() {
    if (current_page < total_pages) {
      on_page_change(current_page + 1);
    }
  }

  List<Widget> renderPage_numbers() {
    List<Widget> page_numbers = [];
    const int max_pages_to_show = 5;
    final int startPage = (current_page - max_pages_to_show ~/ 2).clamp(2, total_pages - 1);
    final int endPage = (current_page + max_pages_to_show ~/ 2).clamp(2, total_pages - 1);

    if (startPage > 2) {
      page_numbers.add(Text("..."));
    }

    for (int i = startPage; i <= endPage; i++) {
      page_numbers.add(
        TextButton(
          onPressed: () => on_page_change(i),
          style: TextButton.styleFrom(
            backgroundColor: i == current_page ? Colors.green : Colors.grey[200],
            foregroundColor: i == current_page ? Colors.white : Colors.black,
          ),
          child: Text(i.toString()),
        ),
      );
    }

    if (endPage < total_pages - 1) {
      page_numbers.add(Text("..."));
    }

    return page_numbers;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: current_page > 1 ? handlePrevious : null,
          icon: Icon(Icons.arrow_back),
          color: current_page > 1 ? Colors.orange : Colors.grey,
        ),
        TextButton(
          onPressed: () => on_page_change(1),
          style: TextButton.styleFrom(
            backgroundColor: current_page == 1 ? Colors.green : Colors.grey[200],
            foregroundColor: current_page == 1 ? Colors.white : Colors.black,
          ),
          child: Text("1"),
        ),
        ...renderPage_numbers(),
        if (total_pages > 1)
          TextButton(
            onPressed: () => on_page_change(total_pages),
            style: TextButton.styleFrom(
              backgroundColor: current_page == total_pages ? Colors.green : Colors.grey[200],
              foregroundColor: current_page == total_pages ? Colors.white : Colors.black,
            ),
            child: Text(total_pages.toString()),
          ),
        IconButton(
          onPressed: current_page < total_pages ? handleNext : null,
          icon: Icon(Icons.arrow_forward),
          color: current_page < total_pages ? Colors.orange : Colors.grey,
        ),
      ],
    );
  }
}

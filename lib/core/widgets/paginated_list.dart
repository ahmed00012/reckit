import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context, T item, int index);
typedef FetchPageCallback<T> = Future<List<T>> Function(int page);

class PaginatedList<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final FetchPageCallback<T> fetchPage;
  final int lastPage;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final EdgeInsetsGeometry padding;
  final List<T> items;
  final bool isGrid;

  const PaginatedList({
    super.key,
    required this.itemBuilder,
    required this.fetchPage,
    required this.items,
    this.lastPage = 10,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.isGrid = false,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<PaginatedList<T>> createState() => _PaginatedListState<T>();
}

class _PaginatedListState<T> extends State<PaginatedList<T>> {
  List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  bool _isError = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _items = List<T>.of(widget.items);
    // _fetchInitial();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchInitial() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final data = await widget.fetchPage(_currentPage);

      if (!mounted) return;
      setState(() {
        _items = List<T>.from(_items)..addAll(data);
        _hasMore = _currentPage < widget.lastPage;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  Future<void> _fetchMore() async {
    if (!mounted) return;
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);
    _currentPage++;
    try {
      final data = await widget.fetchPage(_currentPage);
      // int newItemsLength = data.length - _items.length  ;
      if (!mounted) return;
      setState(() {
        _items = List<T>.from(_items)..addAll(data.sublist(_items.length));
        _hasMore = _currentPage < widget.lastPage;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return widget.errorWidget ??
          const Center(
            child: Text("An error occurred. Please try again."),
          );
    }

    if (_isLoading && _items.isEmpty) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    if (_items.isEmpty) {
      return widget.emptyWidget ??
          const Center(
            child: Text("No items found."),
          );
    }

    return widget.isGrid
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio:
            1.sw > 900? 2.2 : 0.8,mainAxisSpacing: 2,crossAxisSpacing: 2),
            controller: _scrollController,
            padding: widget.padding,
            itemCount: _items.length + (_hasMore ? 1 : 0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index < _items.length) {
                return widget.itemBuilder(context, _items[index], index);
              } else {
                if (_isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
          )
        : ListView.builder(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: _items.length + (_hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < _items.length) {
                return widget.itemBuilder(context, _items[index], index);
              } else {
                if (_isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
          );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

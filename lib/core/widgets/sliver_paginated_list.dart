// ... existing code ...
// ... existing code ...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SliverPaginatedList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Future<List<T>> Function(int) fetchPage;
  final int lastPage;
  final bool isGrid;
  final EdgeInsetsGeometry? padding;

  const SliverPaginatedList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.fetchPage,
    required this.lastPage,
    this.isGrid = false,
    this.padding,
  });

  @override
  _SliverPaginatedListState<T> createState() =>
      _SliverPaginatedListState<T>();
}

class _SliverPaginatedListState<T> extends State<SliverPaginatedList<T>> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_currentPage < widget.lastPage) {
      setState(() {
        _isLoading = true;
        _currentPage++;
      });
      await widget.fetchPage(_currentPage);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return _buildSliverList();
  }

  Widget _buildSliverList() {
    if (widget.isGrid) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1.sw > 900 ? 2 : 1,
          childAspectRatio: 1.sw > 900 ? 2.2 : 1.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 2,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            if (index == widget.items.length) {
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }
            return widget.itemBuilder(context, widget.items[index], index);
          },
          childCount: widget.items.length + (_isLoading ? 1 : 0),
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            if (index == widget.items.length) {
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }
            return widget.itemBuilder(context, widget.items[index], index);
          },
          childCount: widget.items.length + (_isLoading ? 1 : 0),
        ),
      );
    }
  }
}

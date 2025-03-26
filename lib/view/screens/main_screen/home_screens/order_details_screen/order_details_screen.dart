import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/order_details_display_model.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/view/bloc/order_details/order_details_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  int currentPage = 1;
  bool _isFetchingMore = false;
  String searchQuery = '';
  List<OrderDetailsDisplayModel> filteredOrderDetails = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('Triggering initial fetch for page 1');
      final bloc = context.read<OrderDetailsBloc>();
      bloc.add(GetOrderDetailsEvent(page: 1));
    });
  }

  void _fetchMoreData() {
    setState(() {
      _isFetchingMore = true;
      currentPage++;
    });
    log('Fetching more data for page: $currentPage');
    context.read<OrderDetailsBloc>().add(GetOrderDetailsEvent(page: currentPage));
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applySearch();
    });
  }

  void _applySearch() {
    final state = context.read<OrderDetailsBloc>().state;
    if (state is OrderFetchSuccess || state is OrderLoadingMore) {
      final orderDetails = (state is OrderFetchSuccess)
          ? state.orderDetails
          : (state as OrderLoadingMore).orderDetails;
      filteredOrderDetails = orderDetails.where((order) {
        return order.date.toLowerCase().contains(searchQuery) ||
            order.name.toLowerCase().contains(searchQuery) ||
            order.phoneNumber.toLowerCase().contains(searchQuery);
      }).toList();
    }
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CommonAppBar(iconNeeded: false),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
            _isFetchingMore = false;
            searchQuery = '';
            filteredOrderDetails.clear();
          });
          log('Refreshing data for page 1');
          context.read<OrderDetailsBloc>().add(GetOrderDetailsEvent(page: 1));
        },
        child: Column(
          children: [
            ScreenRouteTitle(title: 'Order Details'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by date, name, or phone',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal[400]!),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
                listener: (context, state) {
                  log('State changed: $state');
                  if (state is OrderFetchSuccess || state is OrderLoadingMore) {
                    setState(() {
                      _isFetchingMore = false;
                    });
                    _applySearch();
                  }
                },
                builder: (context, state) {
                  log('Building UI with state: $state');

                  if (state is OrderDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is OrderFetchSuccess || state is OrderLoadingMore) {
                    final orderDetails = (state is OrderFetchSuccess)
                        ? state.orderDetails
                        : (state as OrderLoadingMore).orderDetails;
                    final displayOrderDetails =
                        searchQuery.isEmpty ? orderDetails : filteredOrderDetails;

                    if (displayOrderDetails.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No Order Details Found")),
                      );
                    }

                    return ScrollableTable(
                      columnLabels: const [
                        'Date', // Moved Date to the first column
                        'Name',
                        'Phone',
                        'Quantity',
                        'Tracking Status',
                      ],
                      rowData: displayOrderDetails
                          .map((order) => [
                                order.date, // Date first
                                order.name,
                                order.phoneNumber,
                                '${order.quantity} kg',
                                order.trackingStatus,
                              ])
                          .toList(),
                      verticalScrollController: _verticalScrollController,
                      horizontalScrollController: _horizontalScrollController,
                      loadMoreWidget: state is OrderFetchSuccess && !state.hasReachedMax && !_isFetchingMore
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: _fetchMoreData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal[400],
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 2,
                                    minimumSize: const Size(200, 50),
                                  ),
                                  child: const Text(
                                    "Load More",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : state is OrderLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              : null,
                    );
                  }

                  if (state is OrderDetailsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Error: ${state.message}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = 1;
                                _isFetchingMore = false;
                                searchQuery = '';
                                filteredOrderDetails.clear();
                              });
                              context.read<OrderDetailsBloc>().add(GetOrderDetailsEvent(page: 1));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollableTable extends StatelessWidget {
  final List<String> columnLabels;
  final List<List<String>> rowData;
  final ScrollController? verticalScrollController;
  final ScrollController? horizontalScrollController;
  final Widget? loadMoreWidget;

  const ScrollableTable({
    super.key,
    required this.columnLabels,
    required this.rowData,
    this.verticalScrollController,
    this.horizontalScrollController,
    this.loadMoreWidget,
  });

  @override
  Widget build(BuildContext context) {
    log('Building ScrollableTable with ${rowData.length} rows');
    return SingleChildScrollView(
      controller: verticalScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: horizontalScrollController,
              child: DataTable(
                columnSpacing: 16,
                dataRowHeight: 56,
                headingRowHeight: 56,
                horizontalMargin: 16,
                dividerThickness: 1,
                dataRowColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.grey.withOpacity(0.1);
                  }
                  return null;
                }),
                headingRowColor: WidgetStateProperty.all(
                  Colors.teal[50], // Light teal background for headers
                ),
                columns: columnLabels
                    .map(
                      (label) => DataColumn(
                        label: Text(
                          label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal[700],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                rows: rowData.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final row = entry.value;
                    return DataRow(
                      color: WidgetStateProperty.resolveWith((states) {
                        if (index % 2 == 0) {
                          return Colors.grey.withOpacity(0.02);
                        }
                        return null;
                      }),
                      cells: row
                          .map(
                            (cell) => DataCell(
                              Text(
                                cell,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          if (loadMoreWidget != null) loadMoreWidget!,
        ],
      ),
    );
  }
}
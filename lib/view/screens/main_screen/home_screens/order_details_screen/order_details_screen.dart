import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    // Initial data fetch
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
    context
        .read<OrderDetailsBloc>()
        .add(GetOrderDetailsEvent(page: currentPage));
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
          });
          log('Refreshing data for page 1');
          context.read<OrderDetailsBloc>().add(GetOrderDetailsEvent(page: 1));
        },
        child: Column(
          children: [
            ScreenRouteTitle(title: 'Order Details'),
            Expanded(
              child: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
                listener: (context, state) {
                  log('State changed: $state');
                  if (state is OrderFetchSuccess) {
                    log('Order details fetched: ${state.orderDetails.length} items');
                    setState(() {
                      _isFetchingMore = false;
                    });
                  } else if (state is OrderDetailsError) {
                    log('Error state: ${state.message}');
                    setState(() {
                      _isFetchingMore = false;
                    });
                  }
                },
                builder: (context, state) {
                  log('Building UI with state: $state');

                  if (state is OrderDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is OrderFetchSuccess) {
                    final orderDetails = state.orderDetails;
                    log('Rendering ${orderDetails.length} order details');

                    if (orderDetails.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No Order Details Found")),
                      );
                    }

                    return ScrollableTable(
                      columnLabels: const [
                        'Name',
                        'Phone',
                        'Quantity',
                        'Tracking Status',
                        'Date'
                      ],
                      rowData: orderDetails
                          .map((order) => [
                                order.name,
                                order.phoneNumber,
                                '${order.quantity} kg',
                                order.trackingStatus,
                                order.date,
                              ])
                          .toList(),
                      scrollController: _scrollController,
                      onRowTap: (index) {
                        final order = state.orderDetails[index];
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (c) => OrderDetailScreen(order: order),
                        ));
                      },
                      loadMoreWidget: state.hasReachedMax || _isFetchingMore
                          ? null
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: _fetchMoreData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
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
                            ),
                    );
                  }

                  if (state is OrderLoadingMore) {
                    final orderDetails = state.orderDetails;
                    log('Rendering ${orderDetails.length} order details while loading more');

                    return ScrollableTable(
                      columnLabels: const [
                        'Name',
                        'Phone',
                        'Quantity',
                        'Tracking Status',
                        'Date'
                      ],
                      rowData: orderDetails
                          .map((order) => [
                                order.name,
                                order.phoneNumber,
                                '${order.quantity} kg',
                                order.trackingStatus,
                                order.date,
                              ])
                          .toList(),
                      scrollController: _scrollController,
                      onRowTap: (index) {
                        final order = state.orderDetails[index];
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (c) => OrderDetailScreen(order: order),
                        ));
                      },
                      loadMoreWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
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
                              });
                              context
                                  .read<OrderDetailsBloc>()
                                  .add(GetOrderDetailsEvent(page: 1));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
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
  final ScrollController? scrollController;
  final Widget? loadMoreWidget;
  final Function(int)? onRowTap;

  const ScrollableTable({
    super.key,
    required this.columnLabels,
    required this.rowData,
    this.scrollController,
    this.loadMoreWidget,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    log('Building ScrollableTable with ${rowData.length} rows');
    return SingleChildScrollView(
      controller: scrollController,
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
                Colors.teal.withOpacity(0.1),
              ),
              columns: columnLabels
                  .map(
                    (label) => DataColumn(
                      label: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
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
                    onSelectChanged: onRowTap != null
                        ? (selected) {
                            if (selected == true) {
                              onRowTap!(index);
                            }
                          }
                        : null,
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
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ).toList(),
            ),
          ),
          if (loadMoreWidget != null) loadMoreWidget!,
        ],
      ),
    );
  }
}

// Detailed Order View Screen
class OrderDetailScreen extends StatelessWidget {
  final OrderDetailsDisplayModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(iconNeeded: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenRouteTitle(title: 'Order Details'),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Name', order.name, isTitle: true),
                    _buildDetailRow('Phone', order.phoneNumber),
                    _buildDetailRow('Address', order.address),
                    _buildDetailRow('Pincode', order.pincode),
                    _buildDetailRow('Quantity', '${order.quantity} kg'),
                    _buildDetailRow('Order Type', order.orderType),
                    _buildDetailRow('Item', order.item),
                    _buildDetailRow('Catalogue', order.catalogue),
                    _buildDetailRow('Courier Provider', order.courierProvider),
                    _buildDetailRow('Courier Ref No', order.courierRefNo),
                    _buildDetailRow('Tracking ID', order.trackingId),
                    _buildDetailRow('Tracking Status', order.trackingStatus),
                    _buildDetailRow('Payment Status', order.paymentStatus),
                    _buildDetailRow('Date', order.date),
                    _buildDetailRow('Created At', order.createdAt.toString()),
                    _buildDetailRow('Updated At', order.updatedAt.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTitle = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTitle ? 18 : 14,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isTitle ? AppColors.black : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

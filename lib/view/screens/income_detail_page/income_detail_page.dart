import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/view/bloc/income_expense/income_expense_bloc.dart';

class IncomeDetailPage extends StatefulWidget {
  const IncomeDetailPage({super.key});

  @override
  State<IncomeDetailPage> createState() => _IncomeDetailPageState();
}

class _IncomeDetailPageState extends State<IncomeDetailPage> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('Triggering initial fetch for page 1');
      final bloc = context.read<IncomeExpenseBloc>();
      if (bloc != null) {
        bloc.add(GetIncomeDetailsEvent(page: 1));
      } else {
        log('Error: IncomeExpenseBloc not found in context');
      }
    });
  }

  void _onScroll() {
    final state = context.read<IncomeExpenseBloc>().state;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50 &&
        state is IncomeFetchSuccess &&
        !state.hasReachedMax &&
        !_isFetchingMore) {
      _fetchMoreData();
    }
  }

  void _fetchMoreData() {
    setState(() {
      _isFetchingMore = true;
      currentPage++;
    });
    log('Fetching more data for page: $currentPage');
    context.read<IncomeExpenseBloc>().add(GetIncomeDetailsEvent(page: currentPage));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(iconNeeded: false),
      backgroundColor: const Color(0xFFF5F5F5),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
            _isFetchingMore = false;
          });
          log('Refreshing data for page 1');
          context.read<IncomeExpenseBloc>().add(GetIncomeDetailsEvent(page: 1));
        },
        child: Column(
          children: [
            ScreenRouteTitle(title: 'Income Details'),
            Expanded(
              child: BlocConsumer<IncomeExpenseBloc, IncomeExpenseState>(
                listener: (context, state) {
                  log('State changed: $state');
                  if (state is IncomeFetchSuccess) {
                    log('Income details fetched: ${state.incomeDetails.length} items');
                    setState(() {
                      _isFetchingMore = false;
                    });
                  } else if (state is IncomeExpenseErrorState) {
                    log('Error state: ${state.message}');
                    setState(() {
                      _isFetchingMore = false;
                    });
                  }
                },
                builder: (context, state) {
                  log('Building UI with state: $state');

                  if (state is IncomeExpenseLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is IncomeFetchSuccess) {
                    final incomeDetails = state.incomeDetails;
                    log('Rendering ${incomeDetails.length} income details');

                    if (incomeDetails.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No Income Details Found")),
                      );
                    }

                    return ScrollableTable(
                      columnLabels: const ['Date', 'Income Type', 'Amount'],
                      rowData: incomeDetails
                          .map((item) => [
                                item.date ?? 'N/A',
                                item.incomeType ?? 'N/A',
                                item.amount.toString(),
                              ])
                          .toList(),
                      scrollController: _scrollController,
                      loadMoreWidget: state.hasReachedMax || _isFetchingMore
                          ? null
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
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

                  if (state is IncomeLoadingMore) {
                    final incomeDetails = state.incomeDetails;
                    log('Rendering ${incomeDetails.length} income details while loading more');

                    return ScrollableTable(
                      columnLabels: const ['Date', 'Income Type', 'Amount'],
                      rowData: incomeDetails
                          .map((item) => [
                                item.date ?? 'N/A',
                                item.incomeType ?? 'N/A',
                                item.amount.toString(),
                              ])
                          .toList(),
                      scrollController: _scrollController,
                      loadMoreWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (state is IncomeExpenseErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error: ${state.message}"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = 1;
                                _isFetchingMore = false;
                              });
                              context
                                  .read<IncomeExpenseBloc>()
                                  .add(GetIncomeDetailsEvent(page: 1));
                            },
                            child: const Text("Retry"),
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

  const ScrollableTable({
    super.key,
    required this.columnLabels,
    required this.rowData,
    this.scrollController,
    this.loadMoreWidget,
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
              dataRowColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.grey.withOpacity(0.1);
                }
                return null;
              }),
              headingRowColor: MaterialStateProperty.all(
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
                    color: MaterialStateProperty.resolveWith((states) {
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
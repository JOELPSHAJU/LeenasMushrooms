// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
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
  }

  void _onScroll() {
    final state = context.read<IncomeExpenseBloc>().state;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50 &&
        state is IncomeExpenseFetchSuccess &&
        !state.hasReachedMax &&
        !_isFetchingMore) {
      _fetchMoreData();
    }
  }

  void _fetchMoreData() {
    final state = context.read<IncomeExpenseBloc>().state;
    if (state is IncomeExpenseFetchSuccess &&
        !state.hasReachedMax &&
        !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
        currentPage = state.currentPage + 1;
      });
      context
          .read<IncomeExpenseBloc>()
          .add(GetIncomeDetailsEvent(page: currentPage));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IncomeExpenseBloc(repo: context.read<DataVerseRepository>())
            ..add( GetIncomeDetailsEvent(page: 1)),
      child: Scaffold(
        appBar: const CommonAppBar(iconNeeded: false),
        backgroundColor: const Color(0xFFF5F5F5),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              currentPage = 1;
              _isFetchingMore = false;
            });
            context
                .read<IncomeExpenseBloc>()
                .add( GetIncomeDetailsEvent(page: 1));
          },
          child: Column(
            children: [
               ScreenRouteTitle(title: 'Income Details'),
              Expanded(
                child: BlocConsumer<IncomeExpenseBloc, IncomeExpenseState>(
                  listener: (context, state) {
                    if (state is IncomeExpenseFetchSuccess ||
                        state is IncomeExpenseLoadingMore) {
                      _isFetchingMore =
                          false; // Reset flag after fetch completes
                    }
                  },
                  builder: (context, state) {
                    if (state is IncomeExpenseLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is IncomeExpenseFetchSuccess ||
                        state is IncomeExpenseLoadingMore) {
                      final incomeDetails = (state is IncomeExpenseFetchSuccess)
                          ? state.incomeDetails
                          : (state as IncomeExpenseLoadingMore).incomeDetails;
                      final hasReachedMax =
                          state is IncomeExpenseFetchSuccess &&
                              state.hasReachedMax;

                      if (incomeDetails.isEmpty) {
                        return const SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(child: Text("No Income Details Found")),
                        );
                      }

                      final columnLabels = ['Date', 'Income Type', 'Amount'];
                      final rowData = incomeDetails
                          .map((item) => [
                                item.date,
                                item.incomeType,
                                item.amount,
                              ])
                          .toList();

                      return ScrollableTable(
                        columnLabels: columnLabels,
                        rowData: rowData,
                        scrollController: _scrollController,
                        loadMoreWidget: !hasReachedMax
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: _fetchMoreData,
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(200, 50),
                                    ),
                                    child: const Text("Load More"),
                                  ),
                                ),
                              )
                            : null,
                      );
                    } else if (state is IncomeExpenseErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Error: ${state.message}"),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<IncomeExpenseBloc>()
                                    .add( GetIncomeDetailsEvent(page: 1));
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
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          DataTable(
            columns: columnLabels
                .map((label) => DataColumn(label: Text(label)))
                .toList(),
            rows: rowData
                .map((row) => DataRow(
                      cells: row.map((cell) => DataCell(Text(cell))).toList(),
                    ))
                .toList(),
          ),
          if (loadMoreWidget != null) loadMoreWidget!,
        ],
      ),
    );
  }
}

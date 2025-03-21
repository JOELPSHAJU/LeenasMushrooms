// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_post_model.dart';
import 'package:leenas_mushrooms/view/bloc/call_details/call_details_bloc.dart';

class CallDetailsPage extends StatefulWidget {
  const CallDetailsPage({super.key});

  @override
  State<CallDetailsPage> createState() => _CallDetailsPageState();
}

class _CallDetailsPageState extends State<CallDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  String searchQuery = '';
  String? selectedCallType;
  String? selectedStatus;
  List<CallDetailsModel> filteredCallDetails = [];

  @override
  void initState() {
    super.initState();
    context.read<CallDetailsBloc>().add(GetCallDetailsEvent(page: currentPage));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<CallDetailsBloc>().state;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        state is CallDetailsFetchSuccess &&
        !state.hasReachedMax) {
      _fetchMoreData();
    }
  }

  void _fetchMoreData() {
    final state = context.read<CallDetailsBloc>().state;
    if (state is CallDetailsFetchSuccess && !state.hasReachedMax) {
      currentPage = currentPage + 1;

      context
          .read<CallDetailsBloc>()
          .add(GetCallDetailsEvent(page: currentPage));
    }
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applyFiltersAndSearch();
    });
  }

  void _applyFiltersAndSearch() {
    final state = context.read<CallDetailsBloc>().state;
    if (state is CallDetailsFetchSuccess) {
      filteredCallDetails = state.callDetails.where((call) {
        final matchesSearch = call.name.toLowerCase().contains(searchQuery) ||
            call.phoneNumber.toLowerCase().contains(searchQuery) ||
            call.date.toLowerCase().contains(searchQuery);

        final matchesCallType =
            selectedCallType == null || call.callType == selectedCallType;
        final matchesStatus =
            selectedStatus == null || call.currentStatus == selectedStatus;

        return matchesSearch && matchesCallType && matchesStatus;
      }).toList();
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? tempCallType = selectedCallType;
        String? tempStatus = selectedStatus;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filter Call Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Call Type'),
                    value: tempCallType,
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text('All'),
                      ),
                      // Replace with actual call types from your data or API
                      DropdownMenuItem(
                        value: 'Farm Consultancy Customer',
                        child: Text('Farm Consultancy Customer'),
                      ),
                      DropdownMenuItem(
                        value: 'Sales',
                        child: Text('Sales'),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        tempCallType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Status'),
                    value: tempStatus,
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text('All'),
                      ),
                      // Replace with actual statuses from your data or API
                      DropdownMenuItem(
                        value: 'On Track',
                        child: Text('On Track'),
                      ),
                      DropdownMenuItem(
                        value: 'Pending',
                        child: Text('Pending'),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        tempStatus = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCallType = tempCallType;
                      selectedStatus = tempStatus;
                      _applyFiltersAndSearch();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Call Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
            searchQuery = '';
            selectedCallType = null;
            selectedStatus = null;
          });
          context.read<CallDetailsBloc>().add(GetCallDetailsEvent(page: 1));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, phone, or date',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: BlocBuilder<CallDetailsBloc, CallDetailsState>(
                builder: (context, state) {
                  if (state is CallDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CallDetailsFetchSuccess) {
                    // Apply filters and search on the full list
                    _applyFiltersAndSearch();
                    if (filteredCallDetails.isEmpty) {
                      return const Center(child: Text("No Call Details Found"));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredCallDetails.length +
                          (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == filteredCallDetails.length &&
                            !state.hasReachedMax) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: _fetchMoreData,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50),
                                ),
                                child: const Text("Load More"),
                              ),
                            ),
                          );
                        }

                        final call = filteredCallDetails[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${call.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text("Phone: ${call.phoneNumber}"),
                                Text("Call Type: ${call.callType}"),
                                Text("Purpose: ${call.purpose}"),
                                Text("Status: ${call.currentStatus}"),
                                Text("Date: ${call.date}"),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CallDetailsFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error: ${state.message}"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CallDetailsBloc>()
                                  .add(GetCallDetailsEvent(page: 1));
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

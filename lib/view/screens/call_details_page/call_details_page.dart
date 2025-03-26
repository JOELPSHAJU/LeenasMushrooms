// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_post_model.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
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
  bool isLoadingMore = false;

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
        !state.hasReachedMax &&
        !isLoadingMore) {
      _fetchMoreData();
    }
  }

  void _fetchMoreData() {
    setState(() => isLoadingMore = true);
    currentPage++;
    context.read<CallDetailsBloc>().add(GetCallDetailsEvent(page: currentPage));
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white, // Light background
            elevation: 8,
            contentPadding: const EdgeInsets.all(20),
            title: const Text(
              'Filter Call Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            content: Container(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDropdown(
                    label: 'Call Type',
                    value: tempCallType,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(
                        value: 'Farm Consultancy Customer',
                        child: Text('Farm Consultancy Customer'),
                      ),
                      DropdownMenuItem(value: 'Sales', child: Text('Sales')),
                    ],
                    onChanged: (value) => setDialogState(() => tempCallType = value),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    label: 'Status',
                    value: tempStatus,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: 'On Track', child: Text('On Track')),
                      DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    ],
                    onChanged: (value) => setDialogState(() => tempStatus = value),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400], // Soft blue for the Apply button
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 2,
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

// Helper method for dropdowns
Widget _buildDropdown({
  required String label,
  required String? value,
  required List<DropdownMenuItem<String?>> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String?>(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.blue[50], // Light blue background for dropdowns
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
        borderSide: BorderSide(color: Colors.blue[400]!), // Matching blue on focus
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    value: value,
    items: items,
    onChanged: onChanged,
    style: const TextStyle(color: Colors.black87, fontSize: 16),
    icon: Icon(Icons.arrow_drop_down, color: Colors.blue[400]), // Matching blue dropdown icon
    dropdownColor: Colors.white, // White dropdown menu background
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
        backgroundColor: AppColors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          setState(() {
            currentPage = 1;
            searchQuery = '';
            selectedCallType = null;
            selectedStatus = null;
            filteredCallDetails.clear();
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
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: BlocListener<CallDetailsBloc, CallDetailsState>(
                listener: (context, state) {
                  if (state is CallDetailsFetchSuccess) {
                    setState(() {
                      if (currentPage == 1) {
                        filteredCallDetails = List.from(state.callDetails);
                      } else {
                        filteredCallDetails.addAll(state.callDetails
                            .skip(filteredCallDetails.length)
                            .where(
                                (call) => !filteredCallDetails.contains(call)));
                      }
                      isLoadingMore = false;
                    });
                    _applyFiltersAndSearch();
                  } else if (state is CallDetailsLoadingMore) {
                    setState(() => isLoadingMore = true);
                  }
                },
                child: filteredCallDetails.isEmpty && currentPage == 1
                    ? BlocBuilder<CallDetailsBloc, CallDetailsState>(
                        builder: (context, state) {
                          if (state is CallDetailsLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is CallDetailsFailure) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Error: ${state.message}"),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      currentPage = 1;
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
                          return const Center(
                              child: Text("No Call Details Found"));
                        },
                      )
                    : ListView.builder(
                        key: const ValueKey(
                            'call_details_list'), // Preserve list state
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredCallDetails.length +
                            (isLoadingMore ||
                                    (context.read<CallDetailsBloc>().state
                                            is CallDetailsFetchSuccess &&
                                        !(context.read<CallDetailsBloc>().state
                                                as CallDetailsFetchSuccess)
                                            .hasReachedMax)
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (index == filteredCallDetails.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: isLoadingMore
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: _fetchMoreData,
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(200, 50)),
                                        child: const Text("Load More"),
                                      ),
                              ),
                            );
                          }

                          final call = filteredCallDetails[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.grey[200]!, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.purple[50],
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.call,
                                                  color: Colors.purple[700],
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                call.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          _buildBorderedInfo(
                                              "Phone", call.phoneNumber),
                                          _buildBorderedInfo(
                                              "Call Type", call.callType),
                                          _buildBorderedInfo(
                                              "Purpose", call.purpose),
                                          _buildBorderedInfo(
                                              "Status",
                                              call.currentStatus,
                                              _getStatusColor(
                                                  call.currentStatus)),
                                          _buildBorderedInfo("Date", call.date),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper method for info rows
Widget _buildInfoRow(IconData icon, String text, Color textColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'in progress':
      return Colors.orange[700]!;
    case 'active':
      return Colors.green[700]!;
    default:
      return Colors.grey[600]!;
  }
}

// Helper method for bordered info
Widget _buildBorderedInfo(String label, String value, [Color? valueColor]) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[200]!),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// Helper method for status color

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/bed_details_display_model.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/view/bloc/add_bed_details/add_bed_details_bloc.dart';

class BedHarvestDetails extends StatefulWidget {
  const BedHarvestDetails({super.key});

  @override
  State<BedHarvestDetails> createState() => _BedHarvestDetailsState();
}

class _BedHarvestDetailsState extends State<BedHarvestDetails> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool _isLoadingMore = false;
  List<BedDetailsDisplayModel> bedDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchBedDetails(1);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _fetchBedDetails(int page) {
    context.read<AddBedDetailsBloc>().add(GetBedDetailsEvent(page: page));
  }

  void _loadMore() {
    final state = context.read<AddBedDetailsBloc>().state;
    if (state is BedFetchSuccess && !state.hasReachedMax && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        currentPage++;
      });
      _fetchBedDetails(currentPage);
    }
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
      body: Column(
        children: [
          ScreenRouteTitle(title: 'Bed Harvest Details'),
          Expanded(
            child: BlocConsumer<AddBedDetailsBloc, AddBedDetailsState>(
              listener: (context, state) {
                if (state is AddBedDetailsSuccess) {
                  currentPage = 1;
                  bedDetails.clear();
                  _fetchBedDetails(currentPage);
                } else if (state is BedFetchSuccess) {
                  setState(() {
                    _isLoadingMore = false;
                    bedDetails = state.bedDetails;
                    // Sort by date (optional, adjust based on needs)
                    bedDetails.sort((a, b) => b.date.compareTo(a.date));
                  });
                } else if (state is AddBedDetailsFailure) {
                  setState(() {
                    _isLoadingMore = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is AddBedDetailsLoading && currentPage == 1) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is AddBedDetailsFailure && bedDetails.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: ${state.message}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _fetchBedDetails(1),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: bedDetails.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == bedDetails.length && _isLoadingMore) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return BedCard(
                      detail: bedDetails[index],
                      length: index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BedCard extends StatelessWidget {
  final BedDetailsDisplayModel detail;
  final int length;

  const BedCard({super.key, required this.detail, required this.length});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
          bottom: 8), // Fixed typo: changed 'bottom' to correct parameter
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[50]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    detail.date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: detail.harvestTime.toLowerCase() == 'morning'
                          ? Colors.orange[100]
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      detail.harvestTime,
                      style: TextStyle(
                        color: detail.harvestTime.toLowerCase() == 'morning'
                            ? Colors.orange[800]
                            : Colors.blue[800],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(
                    label: 'Quantity',
                    value: '${detail.quantity}kg',
                    color: Colors.green,
                  ),
                  _buildInfoChip(
                    label: 'Packets',
                    value: '${detail.noOfPackets}',
                    color: Colors.blue,
                  ),
                ],
              ),
              if (detail.remarks.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Remarks: ${detail.remarks}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

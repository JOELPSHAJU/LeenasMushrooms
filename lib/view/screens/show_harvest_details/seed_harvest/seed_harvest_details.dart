import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/seed_detail_display_model.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/view/bloc/seed_details/seed_details_bloc.dart';

class SeedHarvestDetails extends StatefulWidget {
  const SeedHarvestDetails({super.key});

  @override
  State<SeedHarvestDetails> createState() => _SeedHarvestDetailsState();
}

class _SeedHarvestDetailsState extends State<SeedHarvestDetails> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool _isLoadingMore = false;
  List<SeedDetailDisplayModel> seedDetails = [];

  @override
  void initState() {
    super.initState();
    // Initialize seedDetails with current BLoC state if available
    final state = context.read<SeedDetailsBloc>().state;
    if (state is SeedFetchSuccess) {
      seedDetails = state.seedDetails;
    } else if (state is SeedLoadingMore) {
      seedDetails = state.seedDetails;
    } else {
      _fetchSeedDetails(1);
    }
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _fetchSeedDetails(int page) {
    context.read<SeedDetailsBloc>().add(GetSeedDetailsEvent(page: page));
  }

  void _loadMore() {
    final state = context.read<SeedDetailsBloc>().state;
    if (state is SeedFetchSuccess && !state.hasReachedMax && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        currentPage++;
      });
      _fetchSeedDetails(currentPage);
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
          ScreenRouteTitle(title: 'Seed Harvest Details'),
          Expanded(
            child: BlocConsumer<SeedDetailsBloc, SeedDetailsState>(
              listener: (context, state) {
                if (state is SeedDetailsSuccess) {
                  currentPage = 1;
                  seedDetails.clear();
                  _fetchSeedDetails(currentPage);
                } else if (state is SeedFetchSuccess) {
                  setState(() {
                    _isLoadingMore = false;
                    seedDetails = state.seedDetails;
                    seedDetails.sort((a, b) => b.date.compareTo(a.date));
                  });
                } else if (state is SeedDetailsFailure) {
                  setState(() {
                    _isLoadingMore = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is SeedDetailsLoading && currentPage == 1) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SeedDetailsFailure && seedDetails.isEmpty) {
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
                          onPressed: () => _fetchSeedDetails(1),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SeedLoadingMore) {
                  seedDetails = state.seedDetails;
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: seedDetails.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == seedDetails.length && _isLoadingMore) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return SeedCard(
                      detail: seedDetails[index],
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

class SeedCard extends StatelessWidget {
  final SeedDetailDisplayModel detail;
  final int length;

  const SeedCard({super.key, required this.detail, required this.length});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
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
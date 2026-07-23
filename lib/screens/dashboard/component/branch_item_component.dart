import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/app_common.dart';
import '../../../utils/build_config.dart';
import '../../branch/model/branch_response.dart';

class BranchItemComponent extends StatefulWidget {
  final BranchData branchData;
  final int? selectedBranchId;
  final int? currentBranchIndex;
  final bool isFormSignIn;
  final Position? position;

  const BranchItemComponent({
    super.key,
    required this.branchData,
    this.selectedBranchId,
    this.currentBranchIndex,
    this.isFormSignIn = false,
    this.position,
  });

  @override
  State<BranchItemComponent> createState() => _BranchItemComponentState();
}

class _BranchItemComponentState extends State<BranchItemComponent> {
  double? cardSize;
  List<String> stylistImageUrls = [];
  bool isLoadingStylists = true;

  /// Cache stylist images per branch so scrolling doesn't re-fetch
  static final Map<int, List<String>> _cache = {};

  @override
  void initState() {
    super.initState();
    _loadStylistImages();
  }

  void _loadStylistImages() async {
    final branchId = widget.branchData.id;
    if (branchId == null) {
      if (mounted) setState(() => isLoadingStylists = false);
      return;
    }

    // Use cached data if available
    if (_cache.containsKey(branchId)) {
      setState(() {
        stylistImageUrls = _cache[branchId]!;
        isLoadingStylists = false;
      });
      return;
    }

    try {
      // Request more items (15) to get enough real stylists after filtering out "Any" entries
      final url =
          '${BuildConfig.baseUrl}employee-list?branch_id=$branchId&per_page=15&page=1';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 && mounted) {
        final body = json.decode(response.body);
        if (body['status'] == true && body['data'] != null) {
          final List data = body['data'];
          final urls = <String>[];
          for (final employee in data) {
            final name = employee['full_name'] ?? '';
            // Skip "Any Cambodian", "Any Japanese" etc. — they have flag images, not person photos
            if (name.toString().startsWith('Any')) continue;

            final img = employee['profile_image'];
            if (img != null && img is String && img.isNotEmpty) {
              urls.add(img);
            }
            if (urls.length >= 5) break;
          }
          _cache[branchId] = urls;
          setState(() {
            stylistImageUrls = urls;
            isLoadingStylists = false;
          });
        } else {
          setState(() => isLoadingStylists = false);
        }
      } else {
        if (mounted) setState(() => isLoadingStylists = false);
      }
    } catch (_) {
      if (mounted) setState(() => isLoadingStylists = false);
    }
  }

  double get getDistance {
    if (widget.position == null) return 0;
    if (widget.branchData.latitude == null ||
        widget.branchData.longitude == null) {
      return 0;
    }
    return calculateDistance(
      widget.branchData.latitude!.toDouble(),
      widget.branchData.longitude!.toDouble(),
      widget.position!.latitude,
      widget.position!.longitude,
    );
  }

  Widget _buildStylistAvatars() {
    if (isLoadingStylists) {
      return Row(
        children: List.generate(
          4,
          (i) => Container(
            width: 54,
            height: 64,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
          ),
        ),
      );
    }

    if (stylistImageUrls.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stylistImageUrls.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            width: 54,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: CachedImageWidget(
                url: stylistImageUrls[index],
                height: 64,
                width: 54,
                fit: BoxFit.cover,
                child: const DefaultUserImagePlaceholder(size: 24),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizeListener(
          onSizeChange: (s) {
            cardSize = s.height - 16;
            setState(() {});
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor, borderRadius: radius()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: radiusOnly(
                      topRight: defaultRadius, topLeft: defaultRadius),
                  child: CachedImageWidget(
                    url: widget.branchData.branchImg.validate(),
                    height: 150,
                    width: context.width(),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Marquee(
                          child: Text(
                            widget.branchData.name.validate(),
                            style: boldTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ).expand(),
                        16.width,
                      ],
                    ),
                    12.height,
                    _buildStylistAvatars(),
                    if (!isLoadingStylists && stylistImageUrls.isNotEmpty)
                      4.height,
                  ],
                ).paddingAll(16),
              ],
            ),
          ),
        ),
        if ((widget.currentBranchIndex == widget.selectedBranchId) &&
            widget.isFormSignIn)
          Container(
            height: cardSize,
            width: context.width(),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.primaryColor.withValues(alpha: 0.6),
                borderRadius: radius()),
            child: const Icon(Icons.check_rounded, size: 50, color: white),
          ),
      ],
    );
  }
}

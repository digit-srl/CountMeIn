import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderCard extends ConsumerWidget {
  final GenderCount genderCount;

  const GenderCard({
    Key? key,
    required this.genderCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (genderCount.male +
            genderCount.female +
            genderCount.notBinary +
            genderCount.notAvailable ==
        0) {
      return const SizedBox.shrink();
    }
    return CMICard(
      child: Column(
        children: [
          const Text('Genere'),
          SizedBox(
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          // setState(() {
                          //   if (!event.isInterestedForInteractions ||
                          //       pieTouchResponse == null ||
                          //       pieTouchResponse.touchedSection == null) {
                          //     touchedIndex = -1;
                          //     return;
                          //   }
                          //   touchedIndex = pieTouchResponse
                          //       .touchedSection!.touchedSectionIndex;
                          // });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: genderCount.male +
                                  genderCount.female +
                                  genderCount.notBinary +
                                  genderCount.notAvailable ==
                              0
                          ? []
                          : showingSections(
                              genderCount.male,
                              genderCount.female,
                              genderCount.notBinary,
                              genderCount.notAvailable,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Text('M'),
                        const Icon(
                          Icons.male,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(genderCount.male.toString())
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Text('F'),
                        const Icon(
                          Icons.female,
                          color: Colors.pink,
                        ),
                        const SizedBox(width: 8),
                        Text(genderCount.female.toString()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Text('?'),
                        const Icon(Icons.not_interested, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(genderCount.notBinary.toString()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.not_interested, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(genderCount.notAvailable.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(int m, int f, int nB, int na) {
    final total = m + f + na;
    final mPercentage = m / total * 100;
    final fPercentage = f / total * 100;
    final nbPercentage = nB / total * 100;
    final naPercentage = na / total * 100;
    return List.generate(4, (i) {
      // final isTouched = i == touchedIndex;
      final isTouched = false;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: mPercentage,
            title: '${mPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget:
                const CircleAvatar(radius: 20, child: Icon(Icons.male)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.pink,
            value: fPercentage,
            title: '${fPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget:
                const CircleAvatar(radius: 20, child: Icon(Icons.female)),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: nbPercentage,
            title: '${nbPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: const Icon(Icons.female),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey,
            value: naPercentage,
            title: '${naPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: const Icon(Icons.female),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

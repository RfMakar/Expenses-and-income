import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WidgetGroupCategories extends StatelessWidget {
  const WidgetGroupCategories({
    super.key,
    required this.color,
    required this.name,
    required this.percent,
    required this.value,
    required this.onTap,
  });
  final Color color;
  final String name;
  final double percent;
  final String value;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              LinearPercentIndicator(
                backgroundColor: Colors.white,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 500,
                percent: percent / 100,
                barRadius: const Radius.circular(6),
                trailing: Text(
                  '$percent %',
                  style: const TextStyle(color: Colors.grey),
                ),
                progressColor: color,
              )
            ],
          ),
        ),
      ),
    );
  }
}

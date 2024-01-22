import 'package:atlobha/modules/my_orders/model/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartsRequestCard extends StatelessWidget {
  final PartsRequest partsRequest;

  const PartsRequestCard({Key? key, required this.partsRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'Car Name:'.tr} ${partsRequest.nameCar}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Parts:'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...partsRequest.parts.map(
                (part) => ListTile(
                  leading: Image.network(part.image,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(part.name),
                  trailing: Text('${'Quantity:'.tr} ${part.quantity}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

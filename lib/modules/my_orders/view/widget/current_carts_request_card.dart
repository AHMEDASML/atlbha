import 'package:atlobha/modules/my_orders/model/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentCartsRequestCard extends StatelessWidget {
  final CurrentCartsRequest currentCartsRequest;

  const CurrentCartsRequestCard({Key? key, required this.currentCartsRequest})
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

              const SizedBox(height: 8),
              Text(
                '${'Date:'.tr} ${currentCartsRequest.date}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '${'Total Count:'.tr} ${currentCartsRequest.totalCount}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Products'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...currentCartsRequest.products.map(
                    (product) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(product.productName),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
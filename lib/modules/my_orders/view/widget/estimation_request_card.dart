import 'package:atlobha/modules/my_orders/model/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimationRequestCard extends StatelessWidget {
  final EstimisionRequest estimationRequest;

  const EstimationRequestCard({Key? key, required this.estimationRequest})
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
                '${'Amount:'.tr} ${estimationRequest.money}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '${'Date:'.tr} ${estimationRequest.date}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '${'Location:'.tr} ${estimationRequest.location}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '${'Description:'.tr} ${estimationRequest.description}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '${'Car Name:'.tr} ${estimationRequest.nameCar}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

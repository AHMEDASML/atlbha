import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/modules/car/models/my_cars_model.dart';
import 'package:atlobha/modules/car/view/widget/deletion_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMyCarWidget extends StatelessWidget {
  final bool isVirtual;
  final Datum data;
  final void Function() funEdite;
  final void Function() funDelete;

  const ItemMyCarWidget(
      {Key? key,
      required this.isVirtual,
      required this.data,
      required this.funEdite,
      required this.funDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(width: 1.2, color: Colors.black.withOpacity(0.4)),
            color: ColorManager.white4),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
                  child: Image.asset(
                    ImageApp.logoAppImage,
                    width: 65,
                    height: 65,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 1,
                  height: 70,
                  color: Colors.yellow,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          TextBoldeWidget(text: data.company, fontSize: 18),
                          const SizedBox(
                            width: 8,
                          ),
                          TextBoldeWidget(text: data.year, fontSize: 18),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextNourmalWidget(
                        text: data.model,
                        fontSize: 14,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: ColorManager.yellow2,
                          child: IconButton(
                              color: ColorManager.black5.withOpacity(0.9),
                              onPressed: () {
                                deletionMessage(
                                    onPressed: funEdite,
                                    context: context,
                                    title: 'Confirmation message'.tr,
                                    titleDesc:
                                        'Are you sure you want to modify this car and make it virtual?'.tr,
                                    mess: 'Edite'.tr);
                              },
                              icon: const Icon(Icons.edit_note)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: ColorManager.black5,
                          child: IconButton(
                              color: Colors.white.withOpacity(0.9),
                              onPressed: () {
                                deletionMessage(
                                    context: context,
                                    title: 'Warning'.tr,
                                    titleDesc:
                                        'Are you sure you want to delete this item?'.tr,
                                    mess: 'Delete'.tr,
                                    onPressed: funDelete);
                              },
                              icon: const Icon(Icons.delete_forever)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(''),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextBoldeWidget(
                        text: data.number,
                        color: ColorManager.gray6.withOpacity(0.4),
                        fontSize: 28,
                      )),
                ),
                data.status == 'default'.tr ? essentialCar() : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget essentialCar() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: ColorManager.yellow2, width: 2),
    ),
    child: TextNourmalWidget(
      text: 'Default'.tr,
      color: Colors.black,
      fontSize: 14,
    ),
  );
}

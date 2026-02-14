import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildTable extends StatelessWidget {
  const BuildTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingAnimation();
      }

      final rows = _buildRows(controller);

      return Flexible(
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: rows,
        ),
      );
    });
  }

  List<TableRow> _buildRows(ProfilePageController controller) {
    final List<TableRow> rows = [];

    rows.add(_headerRow(cells: ['Date', 'W(KG)', 'H(M)', 'BMI']));

    final historyMap = controller.profile.historyMap;

    for (int i = 0; i < 7; i++) {
      final date = DateTime.now().subtract(Duration(days: i));
      final isoDate = _onlyDate(date);
      final label = DateFormat('dd MMM').format(date);

      final bmi = historyMap[isoDate];

      rows.add(
        _dataRow(
          controller: controller,
          dateLabel: label,
          isoDate: isoDate,
          weight: bmi?.weight,
          height: bmi?.height,
          bmiValue: bmi?.bmi,
        ),
      );
    }

    return rows;
  }



  TableRow _headerRow({required List<String> cells}) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      children: cells
          .map(
            (text) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 1),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow _dataRow({
    required ProfilePageController controller,
    required String dateLabel,
    required String isoDate,
    double? weight,
    double? height,
    double? bmiValue,
  }) {
    return TableRow(
      children: [
        InkWell(
          onTap: (){
            controller.isoDate = isoDate;
            controller.onReqEdit();
          } ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(dateLabel,style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                Icon(Icons.edit,color: Colors.blue,),
              ],
            ),
          ),
        ),

        _cell(weight?.toStringAsFixed(1) ?? 'N/A'),
        _cell(height?.toStringAsFixed(2) ?? 'N/A'),
        _cell(bmiValue?.toStringAsFixed(1) ?? 'N/A'),
      ],
    );
  }

  Widget _cell(String text) {
    return Center(
     child:  Text(text, textAlign: TextAlign.center),
    );
  }

  String _onlyDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }
}

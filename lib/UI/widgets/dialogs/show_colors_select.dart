import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:top_menu/app/app_colors.dart';

Future<Color?> showColorPicker(BuildContext context) async {
  try {
    return await showDialog<Color?>(
      context: context,
      builder: (context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: Column(
              children: [
                //Col
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Seleciona un Color',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                //Colors List
                Expanded(
                  child: SingleChildScrollView(
                    child: BlockPicker(
                      useInShowDialog: true,
                      pickerColor: Colors.blue,
                      layoutBuilder: (context, colors, child) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 40,
                              ),
                          itemCount: colors.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(child: child(colors[index]));
                          },
                        );
                      },
                      itemBuilder: (color, isCurrentColor, changeColor) =>
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                              ),
                              child: InkWell(
                                onTap: changeColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                      onColorChanged: (color) {
                        Navigator.pop(context, color);
                      },
                      availableColors: [
                        AppColors.red50,
                        AppColors.red100,
                        AppColors.red300,
                        AppColors.red500,
                        AppColors.red700,

                        // Rosado
                        AppColors.pink50,
                        AppColors.pink100,
                        AppColors.pink300,
                        AppColors.pink500,
                        AppColors.pink700,

                        // Amarillo
                        AppColors.yellow50,
                        AppColors.yellow100,
                        AppColors.yellow300,
                        AppColors.yellow500,
                        AppColors.yellow700,

                        // Naranja
                        AppColors.orange50,
                        AppColors.orange100,
                        AppColors.orange300,
                        AppColors.orange500,
                        AppColors.orange700,

                        // Azul
                        AppColors.blue50,
                        AppColors.blue100,
                        AppColors.blue300,
                        AppColors.blue500,
                        AppColors.blue700,

                        // Índigo
                        AppColors.indigo50,
                        AppColors.indigo100,
                        AppColors.indigo300,
                        AppColors.indigo500,
                        AppColors.indigo700,

                        // Morado
                        AppColors.purple50,
                        AppColors.purple100,
                        AppColors.purple300,
                        AppColors.purple500,
                        AppColors.purple700,

                        // Verde
                        AppColors.green50,
                        AppColors.green100,
                        AppColors.green300,
                        AppColors.green500,
                        AppColors.green700,

                        // Teal
                        AppColors.teal50,
                        AppColors.teal100,
                        AppColors.teal300,
                        AppColors.teal500,
                        AppColors.teal700,

                        // Cian
                        AppColors.cyan50,
                        AppColors.cyan100,
                        AppColors.cyan300,
                        AppColors.cyan500,
                        AppColors.cyan700,

                        // Marrón
                        AppColors.brown50,
                        AppColors.brown100,
                        AppColors.brown300,
                        AppColors.brown500,
                        AppColors.brown700,

                        // Gris
                        AppColors.grey50,
                        AppColors.grey100,
                        AppColors.grey300,
                        AppColors.grey500,
                        AppColors.grey700,

                        // Azul grisáceo
                        AppColors.blueGrey50,
                        AppColors.blueGrey100,
                        AppColors.blueGrey300,
                        AppColors.blueGrey500,
                        AppColors.blueGrey700,
                        AppColors.black,
                        AppColors.white,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    rethrow;
  }
}

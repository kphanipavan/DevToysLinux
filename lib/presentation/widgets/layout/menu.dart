import 'package:auto_size_text/auto_size_text.dart';
import 'package:devtoys/domain/models/groups/group.dart';
import 'package:devtoys/domain/models/tools/tool.dart';
import 'package:devtoys/presentation/widgets/layout/landscape_layout.dart';
import 'package:devtoys/presentation/widgets/layout/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

const double _kScrollbarThickness = 8.0;
const double _kScrollbarMargin = 2.0;

class Menu extends StatelessWidget {
  const Menu({super.key, required this.selectedToolName, required this.tools});

  final List<Tool> tools;
  final String selectedToolName;

  @override
  Widget build(BuildContext context) {
    final scrollbarThicknessWithTrack =
        _calcScrollbarThicknessWithTrack(context);

    return ListView(
      semanticChildCount: tools.length,
      padding: EdgeInsets.symmetric(
        horizontal: scrollbarThicknessWithTrack,
        vertical: 8.0,
      ),
      children: [
        for (var group in Get.find<List<Group>>())
          Visibility(
            visible: !LandscapeLayout.compactMode.value,
            replacement: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: FaIcon(group.icon),
                  onPressed: () {
                    Get.toNamed('/home', arguments: [group.name]);
                  }),
            ),
            child: YaruExpandable(
              isExpanded: true,
              header: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: LandscapeLayout.compactMode.value
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      FaIcon(
                        group.icon,
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          group.name,
                          style: TextStyle(fontSize: 17),
                        ),
                      )
                    ]),
              ),
              child: Column(children: [
                for (var tool in tools.where((t) => t.group.name == group.name))
                  MenuTile(
                    selected: LandscapeLayout.selectedToolName.value ==
                        tool.runtimeType.toString(),
                    title: YaruPageItemTitle.text(tool.title),
                    icon: tool.icon,
                    onTap: () {
                      LandscapeLayout.selectedToolName.value =
                          tool.runtimeType.toString();
                      Get.toNamed(tool.route);
                    },
                  )
              ]),
            ),
          )
      ],
    );
  }

  double _calcScrollbarThicknessWithTrack(final BuildContext context) {
    final scrollbarTheme = Theme.of(context).scrollbarTheme;

    final doubleMarginWidth = scrollbarTheme.crossAxisMargin != null
        ? scrollbarTheme.crossAxisMargin! * 2
        : _kScrollbarMargin * 2;

    final scrollBarThumbThikness =
        scrollbarTheme.thickness?.resolve({MaterialState.hovered}) ??
            _kScrollbarThickness;

    return doubleMarginWidth + scrollBarThumbThikness;
  }
}
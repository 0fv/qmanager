import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qmanager/api/resultstatisticsapi.dart';
import 'package:qmanager/modules/choicecountmodule.dart';
import 'package:qmanager/modules/choicestatisticsmodule.dart';
import 'package:qmanager/modules/resultstatisticsgroupmodule.dart';
import 'package:qmanager/modules/resultstatisticsmodule.dart';
import 'package:qmanager/widget/misc.dart';

class ResultStatisticsView extends StatelessWidget {
  final arguments;
  final ResultStatisticsApi _api = ResultStatisticsApi();

  ResultStatisticsView({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("统计信息"),
          actions: <Widget>[
            FlatButton(
              child: Text("导出问卷数据",style:TextStyle(color: Colors.white),),
              onPressed: () {
                _api.export(arguments['id']);
              },
            )
          ],
        ),
        body: _buildContainer());
  }

  Widget _buildContainer() {
    Future<dynamic> data = _api.getData(arguments['id']);
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ResultStatistics resultStatistics =
              ResultStatistics.fromJson(snapshot.data['data']);
          return Container(
            child: _buildLayout(resultStatistics),
          );
        } else if (snapshot.hasError) {
          popToast(snapshot.error, context);
          return Container();
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildLayout(ResultStatistics resultStatistics) {
    List<ResultStatisticsGroup> groups =
        resultStatistics.choiceStatisticsGroups;
    List<Widget> groupList = List();
    groups.forEach((group) {
      groupList.add(Card(
        child: Container(
          height: 100,
          child: Center(
            child: Text(
              group.groupTitle,
              style: TextStyle(fontSize: 26),
            ),
          ),
        ),
      ));
      group.choiceStatistics.forEach((choice) {
        groupList.add(_buildChoiceStatistics(choice));
      });
    });
    return Container(
      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: groupList.length,
        itemBuilder: (context, index) => Container(
          child: groupList[index],
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  List<Series<ChoiceCount, String>> _formatData(
      List<ChoiceCount> choiceCount, String id) {
    return [
      Series<ChoiceCount, String>(
          id: id,
          colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
          domainFn: (ChoiceCount choiceCount, _) => choiceCount.choice,
          measureFn: (ChoiceCount choiceCount, _) => choiceCount.count,
          data: choiceCount,
          labelAccessorFn: (ChoiceCount choiceCount, _) =>
              '${choiceCount.choice}: ${choiceCount.count}票')
    ];
  }

  Widget _buildChoiceStatistics(ChoiceStatistics choiceStatistics) {
    Map<String, int> choices = choiceStatistics.choice;
    List<ChoiceCount> choiceCount =
        choices.keys.map((e) => ChoiceCount(e, choices[e])).toList();
    var listData = _formatData(choiceCount, choiceStatistics.title);
    var container = Container(
      padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(choiceStatistics.title, style: TextStyle(fontSize: 20)),
          Container(
            height: 360,
            child: BarChart(
              listData,
              vertical: false,
              barRendererDecorator: BarLabelDecorator<String>(),
              domainAxis: OrdinalAxisSpec(renderSpec: NoneRenderSpec()),
            ),
          )
        ],
      ),
    );
    return Container(width: 500, height: 500, child: Card(child: container));
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app/model/doctor_model.dart';
import 'package:app/model/data.dart';
import 'package:app/theme/extention.dart';
import 'package:app/theme/light_color.dart';
import 'package:app/theme/text_styles.dart';
import 'package:app/theme/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DoctorModel> doctorDataList;
  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: Icon(Icons.short_text, size: 30, color: Colors.black),
      actions: <Widget>[
        Icon(Icons.notifications_none, size: 30, color: ColorResources.grey),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          child: Container(
            // height: 40,
            // width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Image.asset("assets/face.jpg", fit: BoxFit.fill),
          ),
        ).p(8),
      ],
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Olá,", style: TextStyles.title.subTitleColor),
        Text("Caio Zampini", style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorResources.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Pesquisar",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
            width: 50,
            child: Icon(Icons.search, color: ColorResources.purple).alignCenter
                .ripple(() {}, borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Serviços", style: TextStyles.title.bold),
              Text(
                "Ver Mais",
                style: TextStyles.titleNormal.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ).p(8).ripple(() {}),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard(
                "Agendar Teleconsulta",
                "",
                color: ColorResources.green,
                lightColor: ColorResources.lightGreen,
                icon: Icons.remember_me_rounded,
              ),
              _categoryCard(
                "Agendar Consulta",
                "",
                color: ColorResources.skyBlue,
                lightColor: ColorResources.lightBlue,
                icon: Icons.calendar_month,
                path: '/test',
              ),
              _categoryCard(
                "Agendar Exame",
                "",
                color: ColorResources.orange,
                lightColor: ColorResources.lightOrange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(
    String title,
    String subtitle, {
    required Color color,
    required Color lightColor,
    String? path,
    IconData icon = Icons.category,
  }) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;

    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }

    return AspectRatio(
      aspectRatio: 6 / 8,
      child: GestureDetector(
        onTap: () { if (path != null) Navigator.pushNamed(context, path); },
        child: Container(
          height: 280,
          width: AppTheme.fullWidth(context) * .3,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 20,
            top: 10,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: lightColor.withOpacity(.8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                    child: Icon(icon, color: Colors.white, size: 40),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(child: Text(title, style: titleStyle).hP8),
                    const SizedBox(height: 10),
                    Flexible(child: Text(subtitle, style: subtitleStyle).hP8),
                  ],
                ).p16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Médicos Disponíveis", style: TextStyles.title.bold),
            IconButton(
              icon: Icon(Icons.sort, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
          ],
        ).hP16,
        getdoctorWidgetList(),
      ]),
    );
  }

  Widget getdoctorWidgetList() {
    return Column(
      children:
          doctorDataList.map((x) {
            return _doctorTile(x);
          }).toList(),
    );
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: ColorResources.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: ColorResources.grey.withOpacity(.1),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                model.image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
            model.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(() {
        Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      ColorResources.orange,
      ColorResources.green,
      ColorResources.grey,
      ColorResources.lightOrange,
      ColorResources.skyBlue,
      ColorResources.titleTextColor,
      Colors.red,
      Colors.brown,
      ColorResources.purpleExtraLight,
      ColorResources.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _header(),
              _searchField(),
              _category(),
            ]),
          ),
          _doctorsList(),
        ],
      ),
    );
  }
}

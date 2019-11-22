import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip_info/IPInfoModel.dart';
import 'package:ip_info/IPInfoRepo.dart';
import 'IPInfoBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[900],
        body: BlocProvider(
          builder: (context) => IPInfoBloc(IPInfoRepo()),
          child: HomePage(),
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<IPInfoBloc>(context);
    var ipController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            child: FlareActor("assets/wifi_animO.flr", fit: BoxFit.fitHeight, animation: "roll", ),
            height: 300,
            width: 300,
          ),
        ),

        BlocBuilder<IPInfoBloc, FetchIPInfoState>(
          builder: (context, state){
            if(state is IPInfoIsNotSearched)
              return Container(
                padding: EdgeInsets.only(left: 32, right: 32,),
                child: Column(
                  children: <Widget>[
                    Text("Search IP", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: ipController,

                      decoration: InputDecoration(

                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "IP Address",
                        hintStyle: TextStyle(color: Colors.white70),

                      ),
                      style: TextStyle(color: Colors.white70),

                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: (){
                          weatherBloc.add(FetchIPInfoEvent(ipController.text));
                        },
                        color: Colors.lightBlue,
                        child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                      ),
                    )

                  ],
                ),
              );
            else if(state is IPInfoIsLoading)
              return Center(child : CircularProgressIndicator());
            else if(state is IPInfoIsLoaded)
              return ShowIPInfo(state.getIPInfo);
            else
              return Text("Error",style: TextStyle(color: Colors.white),);
          },
        )
      ],
    );
  }
}



class ShowIPInfo extends StatelessWidget {
  
  IPInfoModel ipInfoModel;

  ShowIPInfo(this.ipInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(right: 32, left: 32, top: 10),
          child: Column(
            children: <Widget>[
              Text(ipInfoModel.isp,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),

              Text(ipInfoModel.country.toString(),style: TextStyle(color: Colors.white70, fontSize: 18)),
              Text("Country",style: TextStyle(color: Colors.white70, fontSize: 14),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(ipInfoModel.city.toString(),style: TextStyle(color: Colors.white70, fontSize: 18)),
                      Text("City",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(ipInfoModel.zip.toString(),style: TextStyle(color: Colors.white70, fontSize: 18)),
                      Text("Zip",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    // BlocProvider.of<IPInfoBloc>(context).add(ResetIPInfo);
                  },
                  color: Colors.lightBlue,
                  child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                ),
              )
            ],
          )
      );
  }
}
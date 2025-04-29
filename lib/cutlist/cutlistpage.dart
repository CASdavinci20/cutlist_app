import 'package:cutlist/cutlist/containers/cuttypecard.dart';
import 'package:cutlist/cutlist/createcutlistpage.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:cutlist/main_utils/utils/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../cutlistsummary/cutlistsummarypage.dart';
import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/next_page.dart';
import 'containers/mylist.dart';

class CutListPage extends StatefulWidget {
  final projectName;
  final projectID;

  const CutListPage(
      {super.key,
      this.projectName,
      this.projectID, });

  @override
  CutListPageState createState() => CutListPageState();
}

class CutListPageState extends State<CutListPage> {
  final MyList myList = MyList();
  final CutTypeCard cutTypeCard = CutTypeCard();
  late AppBloc appBloc;
  late bool isloading = false;

  loadAllTask() async {
    appBloc.hasTasks = false;
    print("Project ID: ${widget.projectID}");
    await Server().loadAllTask(
        appBloc: appBloc, context: context, projectID: widget.projectID);
  }

  loadAllCategories() async {
    await Server().getAction(appBloc: appBloc, url: Urls.cutCategories);
    appBloc.cutCategories = appBloc.mapSuccess;
  }

  @override
  Widget build(BuildContextcontext) {
    appBloc = Provider.of<AppBloc>(context);
    if (!isloading) {
      appBloc.cutlistData=[];
      loadAllTask();
      loadAllCategories();
      isloading = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            )),
        title: Text(
          '${widget.projectName}',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          appBloc.cutCategories.length>0? TextButton(
              onPressed: () {
                final List<Map<String, dynamic>> typedData =
                    appBloc.cutlistData.cast<Map<String, dynamic>>();
                exportPdf(typedData);
              },
              child: const Center(
                  child: Text(
                'Generate Cutlist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE0f2c94c),
                ),
              ))):SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            appBloc.hasTasks == false
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  )
                : appBloc.cutlistData.isEmpty
                    ? const Center(
                        child: Text('No list created'),
                      )
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appBloc.cutlistData.length,
                        itemBuilder: (cxt, i) {
                          var tasks = appBloc.cutlistData[i]['cutlist']
                              as List<dynamic>;
                          var cutData = appBloc.cutlistData[i];
                          var cutList = cutData['cutlist'];
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: myList.myListCard(
                                  todoTitle: cutData['name'],
                                  todoCat: "Type - ${cutData['category']["name"].toString().toUpperCase()}",
                                  onTap: () {
                                    NextPage().nextRoute(context,
                                        CutListSummaryPage(cutData: cutData));
                                  }));
                        })
          ],
        ),
      ),
      floatingActionButton:appBloc.cutCategories.length>0? FloatingActionButton(
          onPressed: () {
            openCategories();
            context;
          
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Color(0xFFE0f2c94c),
          shape: const CircleBorder()):SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  openCategories(){
    AppActions().showAppDialog(context,
        title: "Choose Type",
        descp: "Select the type of Cutlist you want to create",
        child: Container(
          child: ListView.separated(
            separatorBuilder: (ctxx,ii){
              return Divider();
            },
            itemCount:appBloc.cutCategories.length ,
            itemBuilder: (ctx, i){
              return ListTile(leading: Icon(Icons.list_alt), title: Text("${appBloc.cutCategories[i]['name'].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:20 ),),
              onTap: (){
                Navigator.pop(context);
                NextPage().nextRoute(context, CreateCutListPage(projectID:widget.projectID, catID:appBloc.cutCategories[i]['_id'] , catName:appBloc.cutCategories[i]['name'] ,));
              }, 
              trailing: Icon(Icons.keyboard_arrow_right),);
            },
            shrinkWrap: true,
            physics: ScrollPhysics(),

          ),
        ),
        singlAction: true,
        okText: "Close");

    // return SizedBox(
    //     width: 350,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const Text(
    //           'Cut Type',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w600,
    //             color: Color(0xFFE0f2851),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         appBloc.cutCategories.isEmpty
    //             ? const Center(
    //           child: CircularProgressIndicator(
    //               color: Colors.grey),
    //         )
    //             : SizedBox(
    //           height: 40,
    //           child: ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount:
    //             appBloc.cutCategories.length,
    //             itemBuilder: (ctx, i) {
    //               return Padding(
    //                 padding: const EdgeInsets.only(
    //                     right: 10.0),
    //                 child: cutTypeCard.cutTypeCard(
    //                   selected:categoryName ,
    //                   title:
    //                   '${appBloc.cutCategories[i]['name']}',
    //                   onTap: () {
    //                     setState(() {
    //                       categoryName =
    //                       '${appBloc.cutCategories[i]['name']}';
    //                       categoryId =
    //                       '${appBloc.cutCategories[i]['_id']}';
    //                     });
    //                   },
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ));
  }

  Future<Uint8List> generatePdf(List<dynamic> rawData) async {
    final List<Map<String, dynamic>> data =
        rawData.cast<Map<String, dynamic>>();
    final pdf = pw.Document();

    pdf.addPage(

      pw.MultiPage(
        build: (context) => [
          pw.Text(
            "Vancutz",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
                fontSize: 50,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(PublicVar.primaryColor)),
          ),
          pw.SizedBox(height: 10),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: data.map((project) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Project Name
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    pw.TextSpan(text: "${project['name'] ?? 'Unknown Project'}  ", style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    )),
                        pw.WidgetSpan(child: pw.Container(
                          width: 30,
                          child: pw.Divider(thickness: 1),
                        ), ),

                        pw.TextSpan(text: "  ${widget.projectName}", style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.normal,
                        )),

                  ])),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "TYPE: ${project['category']["name"].toString().toUpperCase()}",
                    style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 140,
                        child: pw.Text(
                          "PART",
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 60,
                        child: pw.Text(
                          "EDGING",
                          style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 60,
                        child: pw.Text(
                          "LENGTH",
                           textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white
                          ),
                        ),
                      ),

                      pw.Container(
                        width: 60,
                        child: pw.Text(
                          "WIDTH",
                           textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white
                          ),
                        ),
                      ),

                      pw.Container(
                        width: 70,
                        child: pw.Text(
                          "QUANTITY",
                           textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white
                          ),
                        ),
                      ),
                    ],
                  ), padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5), color: PdfColors.orange),
                  pw.SizedBox(height: 10),
                  // Tasks for the Project
                  if (project['cutlist'] != null &&
                      project['cutlist'].isNotEmpty)
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: project['cutlist'].map<pw.Widget>((task) {
                        print(project['cutlist']);
                        return pw.Column(children: [

                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: 140,
                                child: pw.Text(
                                  "${task['part'] ?? 'Unnamed Task'} ",
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  width: 1,
                                  height: 20,
                                  color: PdfColors.grey400

                              ),
                              pw.Container(
                                width: 60,
                                child: pw.Text(
                                  "${task['edging']?? '0.00'}",
                                   textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),pw.Container(
                                  width: 1,
                                  height: 20,
                                  color: PdfColors.grey400

                              ),
                              pw.Container(
                                width: 60,
                                child: pw.Text(
                                  "${task['length']?.toStringAsFixed(2) ?? '0.00'}",
                                   textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  width: 1,
                                  height: 20,
                                  color: PdfColors.grey400

                              ),
                              pw.Container(
                                width: 60,
                                child: pw.Text(
                                  "${task['width']?.toStringAsFixed(2) ?? '0.00'}",
                                   textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                width: 1,
                                height: 20,
                        color: PdfColors.grey400

                              ),
                              pw.Container(
                                width: 60,
                                child: pw.Text(
                                  "${task['quantity']?.toStringAsFixed(2) ?? '0.00'}",
                                   textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          pw.Divider(thickness: 1, color: PdfColors.grey400),
                        ]);
                      }).toList(),
                    )
                  else
                    pw.Text(
                      "No tasks available.",
                      style: pw.TextStyle(
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColors.grey600,
                      ),
                    ),
                  pw.SizedBox(height: 10),
                  pw.Divider(thickness: 2),
                  pw.Text(
                    'All measurement are in c.m',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.RichText(
                        textAlign:  pw.TextAlign.center,
                        text:  pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Height ',
                              style:  pw.TextStyle(
                                fontSize: 16,
                                color: PdfColor.fromInt(0xFFEf5af71),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: '- Means(height of the door).',
                              style:  pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xFFE0f2851),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                       pw.SizedBox(height: 10,),

                      pw.RichText(
                        textAlign:  pw.TextAlign.center,
                        text:  pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Width ',
                              style:  pw.TextStyle(
                                fontSize: 16,
                                color: PdfColor.fromInt(0xFFEf5af71),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: '- Means(Width of the door),',
                              style:  pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xFFE0f2851),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      pw.SizedBox(height: 10,),

                      pw.RichText(
                        textAlign:  pw.TextAlign.center,
                        text:  pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Depth ',
                              style:  pw.TextStyle(
                                fontSize: 16,
                                color: PdfColor.fromInt(0xFFEf5af71),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: '- Means(Wall thickness).',
                              style:  pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xFFE0f2851),
                                fontWeight:  pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      pw.SizedBox(height: 10),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  void exportPdf(List<Map<String, dynamic>> data) async {
    final pdfBytes = await generatePdf(data);

    await Printing.layoutPdf(
      onLayout: (format) async => pdfBytes,
    );
  }


}

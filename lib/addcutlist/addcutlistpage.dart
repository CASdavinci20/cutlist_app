import 'package:cutlist/createcutlist/createcutlistpage.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
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
import '../mylist/containers/mylist.dart';

class AddCutListPage extends StatefulWidget {
  final projectName;
  final projectID;
  final projectIndex;
  final cutData;
  const AddCutListPage(
      {super.key,
      this.projectName,
      this.projectID,
      this.projectIndex,
      this.cutData});

  @override
  AddCutListPageState createState() => AddCutListPageState();
}

class AddCutListPageState extends State<AddCutListPage> {
  final MyList myList = MyList();
  late AppBloc appBloc;
  late bool isloading = false;

  loadAllTask() async {
    appBloc.hasTasks = false;
    await Server().loadAllTask(
        appBloc: appBloc, context: context, projectID: widget.projectID);
  }

  @override
  Widget build(BuildContextcontext) {
    appBloc = Provider.of<AppBloc>(context);
    if (!isloading) {
      loadAllTask();
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
          TextButton(
              onPressed: () {
                final List<Map<String, dynamic>> typedData =
                    appBloc.cutlistData.cast<Map<String, dynamic>>();
                exportPdf(typedData);
              },
              child: const Center(
                  child: Text(
                'Generate cutlist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE0f2c94c),
                ),
              )))
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
                                  todoTotal: "${tasks.length}",
                                  onTap: () {
                                    NextPage().nextRoute(context,
                                        CutListSummaryPage(cutData: cutData));
                                  }));
                        })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCutListPage(
                        projectID: widget.projectID,
                      )),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Color(0xFFE0f2c94c),
          shape: const CircleBorder()),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
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
                        width: 140,
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
                          // textAlign: pw.TextAlign.center,
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
                          // textAlign: pw.TextAlign.center,
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
                          // textAlign: pw.TextAlign.center,
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
                                  "${task['length']?.toStringAsFixed(2) ?? '0.00'}",
                                  // textAlign: pw.TextAlign.center,
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
                                  // textAlign: pw.TextAlign.center,
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
                                  // textAlign: pw.TextAlign.center,
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

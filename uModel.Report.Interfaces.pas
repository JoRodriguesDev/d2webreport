unit uModel.Report.Interfaces;

interface

uses
  System.Classes,
  System.UITypes;

type
  iModelReportData = interface;
  iModelReportDataSet = interface;

  iModelReport = interface
  ['{E0762740-9340-4B03-9F39-83C83166F3CD}']
    function AddReportDataSet(AColLabels: TArray<string>): iModelReportDataSet;
    function DataSets(Index: Integer): iModelReportDataSet;
    function Titulo: string; overload;
    function Titulo(AValue: string): iModelReport; overload;
    function ClearDataSets: iModelReport;
    function HeaderColor(ABackgroundColor, ATextColor: TColor): iModelReport;
    function BackgroundColor(ABackgroundColor: TColor): iModelReport;
    function SaveToFile(const AFileName: string): Boolean;
    function Generate: string;
   end;

  iModelReportDataSet = interface
  ['{C1DCD6FF-E775-45D9-B4A2-273CD4156CE0}']
    function AddReportData(AValues: TArray<Variant>): iModelReportDataSet;
    function Data(Index: Integer): iModelReportData;
    function Generate: string;
    function RecordCount: integer;
    function ClearData: iModelReportDataSet;
    function &End: iModelReport;
    function ColumnLabels: TArray<string>;
  end;

  iModelReportData = interface
  ['{F67BF8BA-8B7E-4CF9-A217-4474D8161A3F}']
    function Value(AValue: Variant): iModelReportData; overload;
    function Value: Variant; overload;
    function &End: iModelReportDataSet;
  end;

  iModelReportFactory = interface
  ['{C4F3ABF5-E907-450C-AA34-E0F4A7110BFC}']
    function HTMLReport: iModelReport;
    function PDFReport: iModelReport;
  end;

implementation

end.


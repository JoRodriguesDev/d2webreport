unit uModel.Report.Factory;

interface

uses
  uModel.Report.Interfaces;

type
  TModelReportFactory = class(TInterfacedObject, iModelReportFactory)
  public
    class function New: iModelReportFactory;
    function HTMLReport: iModelReport;
    function PDFReport: iModelReport;
  end;

implementation

uses
  uModel.Report.Html;

{ TModelReportFactory }

function TModelReportFactory.HTMLReport: iModelReport;
begin
  Result := TModelReportHTML.New;
end;

class function TModelReportFactory.New: iModelReportFactory;
begin
  result := Self.Create;
end;

function TModelReportFactory.PDFReport: iModelReport;
begin
  Result := nil;
end;

end.


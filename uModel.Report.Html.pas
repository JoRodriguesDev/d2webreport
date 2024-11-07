unit uModel.Report.HTML;

interface

uses
  uModel.Report.Interfaces,
  System.Generics.Collections,
  System.Classes,
  System.UITypes;

type
  TModelReportHTML = class(TInterfacedObject, iModelReport)
  private
    FTitle: string;
    FDataSets: TInterfaceList;
    FBackgroundColor: TColor;
    FHeaderBackgroundColor: TColor;
    FHeaderTextColor: TColor;
    function TColorToHex(Color: TColor): string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelReport;
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

implementation

uses
  uModel.Report.DataSet,
  System.Variants,
  Vcl.Graphics,
  Winapi.Windows,
  System.SysUtils;

constructor TModelReportHTML.Create;
begin
  FDataSets := TInterfaceList.Create;
end;

destructor TModelReportHTML.Destroy;
begin
  FDataSets.Free;
  inherited;
end;

function TModelReportHTML.TColorToHex(Color: TColor): string;
var
  RGBColor: Longint;
  Red, Green, Blue: Byte;
begin
  RGBColor := ColorToRGB(Color);
  Red := GetRValue(RGBColor);
  Green := GetGValue(RGBColor);
  Blue := GetBValue(RGBColor);
  Result := Format('#%.2x%.2x%.2x', [Red, Green, Blue]);
end;

function TModelReportHTML.SaveToFile(const AFileName: string): Boolean;
var
  LContent: TBytes;
  LFileStream: TFileStream;
begin
  Result := False;
  LContent := TEncoding.UTF8.GetBytes(Generate);
  LFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    LFileStream.WriteBuffer(LContent[0], Length(LContent));
    Result := True;
  finally
    LFileStream.Free;
  end;
end;

class function TModelReportHTML.New: iModelReport;
begin
  Result := Self.Create;
end;

function TModelReportHTML.HeaderColor(ABackgroundColor, ATextColor: TColor): iModelReport;
begin
  result := Self;
  FHeaderBackgroundColor := ABackgroundColor;
  FHeaderTextColor := ATextColor;
end;

function TModelReportHTML.AddReportDataSet(AColLabels: TArray<string>): iModelReportDataSet;
begin
  Result := TModelReportDataSet.New(Self, AColLabels);
  FDataSets.Add(Result);
end;

function TModelReportHTML.DataSets(Index: Integer): iModelReportDataSet;
begin
  result := FDataSets.Items[Index] as iModelReportDataSet;
end;

function TModelReportHTML.Titulo: string;
begin
  Result := FTitle;
end;

function TModelReportHTML.Titulo(AValue: string): iModelReport;
begin
  FTitle := AValue;
  Result := Self;
end;

function TModelReportHTML.BackgroundColor(ABackgroundColor: TColor): iModelReport;
begin
  result := Self;
  FBackgroundColor := ABackgroundColor;
end;

function TModelReportHTML.ClearDataSets: iModelReport;
begin
  FDataSets.Clear;
  Result := Self;
end;

function TModelReportHTML.Generate: string;
var
  I: Integer;
  DataSet: iModelReportDataSet;
begin
  Result := '<html><head>';
  Result := Result + '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">';
  Result := Result + '<title>' + FTitle + '</title>';
  Result := Result + '<style>';
  Result := Result + '@import url(''https://fonts.googleapis.com/css2?family=Asap:wght@400;700&display=swap'');';
  Result := Result + 'body { font-family: "Asap", sans-serif; background-color: ' + TColorToHex(FBackgroundColor) + ';}';
  Result := Result + 'h2 { text-align: left; color: #333; margin-top: 20px; }';
  Result := Result + 'table { width: 100%; border-collapse: collapse; }';
  Result := Result + 'th, td { padding: 10px; text-align: left; border: 1px solid #ddd; }';
  Result := Result + 'th { background-color: ' + TColorToHex(FHeaderBackgroundColor) + '; color: ' + TColorToHex(FHeaderTextColor) + '; }';
  Result := Result + 'tr:nth-child(even) { background-color: #f2f2f2; }';
  Result := Result + 'tr:hover { background-color: #ddd; }';
  Result := Result + '</style>';
  Result := Result + '</head><body>';

  Result := Result + '<div class="container">';
  Result := Result + '<div class="header-container" style="display: flex; justify-content: space-between; align-items: center;">';
  Result := Result + '<h2>' + FTitle + '</h2>';
//  Result := Result + '<button class="btn btn-primary" onclick="window.print()">Imprimir</button>';
  Result := Result + '</div>';

  if FDataSets.Count > 0 then
  begin
    for I := 0 to FDataSets.Count - 1 do
    begin
      DataSet := FDataSets[I] as iModelReportDataSet;
      Result := Result + DataSet.Generate;
    end;
  end else
    Result := Result + '<p>Nenhum dado encontrado.</p>';

  Result := Result + '</div>';
  Result := Result + '</body></html>';
end;


end.


unit uModel.Report.DataSet;

interface

uses
  uModel.Report.Interfaces,
  System.Generics.Collections,
  System.Variants,
  System.Classes;

type
  TModelReportDataSet = class(TInterfacedObject, iModelReportDataSet)
  private
    FDataList: TInterfaceList;
    FParent: iModelReport;
    FColumnLabels: TArray<string>;
  public
    constructor Create(AParent: iModelReport; AColLabels: TArray<string>);
    destructor Destroy; override;
    class function New(AParent: iModelReport; AColLabels: TArray<string>): iModelReportDataSet;
    function AddReportData(AColLabels: TArray<Variant>): iModelReportDataSet;
    function Data(Index: Integer): iModelReportData;
    function Generate: string;
    function RecordCount: Integer;
    function ClearData: iModelReportDataSet;
    function &End: iModelReport;
    function ColumnLabels: TArray<string>;
  end;

implementation

uses
  uModel.Report.Data;

constructor TModelReportDataSet.Create(AParent: iModelReport; AColLabels: TArray<string>);
begin
  FParent := AParent;
  FDataList := TInterfaceList.Create;
  FColumnLabels := AColLabels;
end;

destructor TModelReportDataSet.Destroy;
begin
  FDataList.Free;
  inherited;
end;

class function TModelReportDataSet.New(AParent: iModelReport; AColLabels: TArray<string>): iModelReportDataSet;
begin
  Result := Self.Create(AParent, AColLabels);
end;

function TModelReportDataSet.AddReportData(AColLabels: TArray<Variant>): iModelReportDataSet;
var
  I: Integer;
  ReportData: iModelReportData;
begin
  Result := Self;

  if Length(FColumnLabels) = 0 then
  begin
    SetLength(FColumnLabels, Length(AColLabels));
    for I := 0 to High(AColLabels) do
      FColumnLabels[I] := VarToStr(AColLabels[I]);
  end;

  for I := 0 to High(AColLabels) do
  begin
    ReportData := TModelReportData.Create(self);
    ReportData.Value(AColLabels[I]);
    FDataList.Add(ReportData);
  end;
end;

function TModelReportDataSet.Data(Index: Integer): iModelReportData;
begin
  Result := FDataList.Items[Index] as iModelReportData;
end;

function TModelReportDataSet.Generate: string;
var
  I, J: Integer;
  RowData: iModelReportData;
begin
  Result := '<table border="1" cellspacing="0" cellpadding="5">';
  Result := Result + '<tr>';

  for I := 0 to High(FColumnLabels) do
    Result := Result + '<th>' + FColumnLabels[I] + '</th>';
  Result := Result + '</tr>';

  for I := 0 to (FDataList.Count div Length(FColumnLabels)) - 1 do
  begin
    Result := Result + '<tr>';
    for J := 0 to High(FColumnLabels) do
      if (I * Length(FColumnLabels) + J) < FDataList.Count then
      begin
        RowData := FDataList.Items[I * Length(FColumnLabels) + J] as iModelReportData;
        Result := Result + '<td>' + VarToStr(RowData.Value) + '</td>';
      end;

    Result := Result + '</tr>';
  end;
  Result := Result + '</table>';
end;


function TModelReportDataSet.RecordCount: Integer;
begin
  Result := FDataList.Count;
end;

function TModelReportDataSet.ClearData: iModelReportDataSet;
begin
  FDataList.Clear;
  Result := Self;
end;

function TModelReportDataSet.ColumnLabels: TArray<string>;
begin
  Result := FColumnLabels;
end;

function TModelReportDataSet.&End: iModelReport;
begin
  Result := FParent;
end;

end.


unit uModel.Report.Data;

interface

uses
  uModel.Report.Interfaces,
  System.Variants;

type
  TModelReportData = class(TInterfacedObject, iModelReportData)
  private
    FValue: Variant;
    FParent: iModelReportDataSet;
  public
    constructor Create(AParent: iModelReportDataSet);
    destructor Destroy; override;
    class function New(AParent: iModelReportDataSet): iModelReportData;
    function Value(AValue: Variant): iModelReportData; overload;
    function Value: Variant; overload;
    function &End: iModelReportDataSet;
  end;

implementation

constructor TModelReportData.Create(AParent: iModelReportDataSet);
begin
  FParent := AParent;
end;

destructor TModelReportData.Destroy;
begin
  inherited;
end;

class function TModelReportData.New(AParent: iModelReportDataSet): iModelReportData;
begin
  Result := Self.Create(AParent);
end;

function TModelReportData.Value(AValue: Variant): iModelReportData;
begin
  FValue := AValue;
  Result := Self;
end;

function TModelReportData.Value: Variant;
begin
  Result := FValue;
end;

function TModelReportData.&End: iModelReportDataSet;
begin
  Result := FParent;
end;

end.


unit CSV.Adapter.RESTRequest4D;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  System.Classes,
  VCL.Dialogs,
  CSV.Adapter.RESTRequest4D.Config,
  RESTRequest4D.Request.Adapter.Contract;

type
  TCSVAdapterRESTRequest4D = class(TInterfacedObject, IRequestAdapter)
  private
    FFileName: string;
    FRootElement: string;
    FCSV: TStrings;
    FStringListResult: TStrings;
    FCaptionsCreated: Boolean;
    procedure Execute(const AContent: string);
    procedure Process(const AValue: string); overload;
    procedure Process(const AJSONObject: TJSONObject); overload;
    procedure Process(const AJSONArray: TJSONArray); overload;
    procedure GetItems(const AJSONObject: TJSONObject);
    procedure GetColumns(const AJSONObject: TJSONObject);
    procedure ProcessResult;
  public
    class function Config: TCSVAdapterRESTRequest4DConfig;
    class function New(const AFileName: string; const ARootElement: string = ''): IRequestAdapter; overload;
    class function New(const AStringList: TStrings; const ARootElement: string = ''): IRequestAdapter; overload;
    constructor Create(const AFileName: string; const ARootElement: string = ''); overload;
    constructor Create(const AStringList: TStrings; const ARootElement: string = ''); overload;
    destructor Destroy; override;
  end;

implementation

uses
  CSV.Adapter.RESTRequest4D.Utils;

class function TCSVAdapterRESTRequest4D.Config: TCSVAdapterRESTRequest4DConfig;
begin
  Result := TCSVAdapterRESTRequest4DConfig.GetInstance;
end;

class function TCSVAdapterRESTRequest4D.New(const AFileName: string; const ARootElement: string = ''): IRequestAdapter;
begin
  Result := Self.Create(AFileName, ARootElement);
end;

class function TCSVAdapterRESTRequest4D.New(const AStringList: TStrings; const ARootElement: string = ''): IRequestAdapter;
begin
  Result := Self.Create(AStringList, ARootElement);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AFileName: string; const ARootElement: string = '');
begin
  FFileName := AFileName;
  FRootElement := ARootElement;
  FCaptionsCreated := False;
  FCSV := TStringList.Create;
end;

constructor TCSVAdapterRESTRequest4D.Create(const AStringList: TStrings; const ARootElement: string = '');
begin
  FStringListResult := AStringList;
  Self.Create('', ARootElement);
end;

destructor TCSVAdapterRESTRequest4D.Destroy;
begin
  FCSV.Free;
  inherited;
end;

procedure TCSVAdapterRESTRequest4D.Execute(const AContent: string);
begin
  Self.Process(AContent.Trim);
end;

procedure TCSVAdapterRESTRequest4D.Process(const AValue: string);
begin
  if AValue.Trim.StartsWith('{') then
    Self.Process(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AValue), 0) as TJSONObject)
  else if Trim(AValue).StartsWith('[') then
    Self.Process(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AValue), 0) as TJSONArray);

  Self.ProcessResult;
end;

procedure TCSVAdapterRESTRequest4D.Process(const AJSONArray: TJSONArray);
var
  i: Integer;
begin
  if not Assigned(AJSONArray) then
    Exit;

  for i := 0 to Pred(AJSONArray.Count) do
  begin
    if AJSONArray.Items[i] is TJSONObject then
    begin
      if not FCaptionsCreated then
        Self.GetColumns(AJSONArray.Items[i] as TJSONObject);

      Self.GetItems(AJSONArray.Items[i] as TJSONObject);
    end;
  end;
end;
procedure TCSVAdapterRESTRequest4D.GetColumns(const AJSONObject: TJSONObject);
var
  LJSONPair: TJSONPair;
  LLine: string;
begin
  LLine := '';
  for LJSONPair in AJSONObject do
    LLine := LLine + TCSVAdapterRESTRequest4DUtils.PrepareStr(LJSONPair.JsonString.Value) + TCSVAdapterRESTRequest4DConfig.GetInstance.Separator;

  FCSV.Add(TCSVAdapterRESTRequest4DUtils.RemoveLastChar(LLine));
  FCaptionsCreated := True;
end;

procedure TCSVAdapterRESTRequest4D.GetItems(const AJSONObject: TJSONObject);
var
  LJSONPair: TJSONPair;
  LLine: string;
begin
  LLine := '';
  for LJSONPair in AJSONObject do
    LLine := LLine + TCSVAdapterRESTRequest4DUtils.PrepareStr(LJSONPair.JsonValue.Value) + TCSVAdapterRESTRequest4DConfig.GetInstance.Separator;

  FCSV.Add(TCSVAdapterRESTRequest4DUtils.RemoveLastChar(LLine));
end;

procedure TCSVAdapterRESTRequest4D.Process(const AJSONObject: TJSONObject);
var
  LJSONValue: TJSONValue;
begin
  try
    if FRootElement.Trim.IsEmpty then
      LJSONValue := AJSONObject
    else
      LJSONValue := AJSONObject.FindValue(FRootElement);

    if not Assigned(LJSONValue) then
      raise Exception.Create('Root element not found');

    if LJSONValue.InheritsFrom(TJSONArray) then
      Self.Process(LJSONValue as TJSONArray)
    else
    begin
      Self.GetColumns(LJSONValue as TJSONObject);
      Self.GetItems(LJSONValue as TJSONObject);
    end;
  finally
    AJSONObject.Free;
  end;
end;

procedure TCSVAdapterRESTRequest4D.ProcessResult;
begin
  if not FFileName.Trim.IsEmpty then
    FCSV.SaveToFile(FFileName)
  else if Assigned(FStringListResult) then
    FStringListResult.Text := FCSV.Text;
end;

end.

unit CSV.Adapter.RESTRequest4D;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  System.Classes,
  VCL.Dialogs,
  CSV.Adapter.RESTRequest4D.Config,
  RESTRequest4D.Request.Adapter.Contract,
  CSV.Adapter.RESTRequest4D.Utils;

type
  ICSVAdapterRESTRequest4DConfig = CSV.Adapter.RESTRequest4D.Config.ICSVAdapterRESTRequest4DConfig;
  TCSVAdapterRESTRequest4DConfig = CSV.Adapter.RESTRequest4D.Config.TCSVAdapterRESTRequest4DConfig;

  TCSVAdapterRESTRequest4D = class(TInterfacedObject, IRequestAdapter)
  private
    FConfig: ICSVAdapterRESTRequest4DConfig;
    FFileName: string;
    FRootElement: string;
    FCSV: TStrings;
    FStringListResult: TStrings;
    FCaptionsCreated: Boolean;
    procedure CreateInternal(const AConfig: ICSVAdapterRESTRequest4DConfig = nil);
    procedure Execute(const AContent: string);
    procedure Process(const AValue: string); overload;
    procedure Process(const AJSONObject: TJSONObject); overload;
    procedure Process(const AJSONArray: TJSONArray); overload;
    procedure GetItems(const AJSONObject: TJSONObject);
    procedure GetColumns(const AJSONObject: TJSONObject);
    procedure ProcessResult;
  public
    class function New(const AFileName: string; const ARootElement: string = ''): IRequestAdapter; overload;
    constructor Create(const AFileName: string; const ARootElement: string = ''); overload;

    class function New(const AFileName: string; const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter; overload;
    constructor Create(const AFileName: string; const AConfig: ICSVAdapterRESTRequest4DConfig); overload;

    class function New(const AFileName: string; const ARootElement: string;
      const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter; overload;
    constructor Create(const AFileName: string; const ARootElement: string;
      const AConfig: ICSVAdapterRESTRequest4DConfig); overload;

    class function New(const AStringList: TStrings; const ARootElement: string = ''): IRequestAdapter; overload;
    constructor Create(const AStringList: TStrings; const ARootElement: string = ''); overload;

    class function New(const AStringList: TStrings; const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter; overload;
    constructor Create(const AStringList: TStrings; const AConfig: ICSVAdapterRESTRequest4DConfig); overload;

    class function New(const AStringList: TStrings; const ARootElement: string;
      const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter; overload;
    constructor Create(const AStringList: TStrings; const ARootElement: string;
      const AConfig: ICSVAdapterRESTRequest4DConfig); overload;

    destructor Destroy; override;
  end;

implementation

procedure TCSVAdapterRESTRequest4D.CreateInternal(const AConfig: ICSVAdapterRESTRequest4DConfig = nil);
begin
  FConfig := AConfig;
  if FConfig = nil then
    FConfig := TCSVAdapterRESTRequest4DConfig.New;

  FCaptionsCreated := False;
  FCSV := TStringList.Create;
  FFileName := '';
  FRootElement := '';
end;

class function TCSVAdapterRESTRequest4D.New(const AFileName: string; const ARootElement: string = ''): IRequestAdapter;
begin
  Result := Self.Create(AFileName, ARootElement);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AFileName: string; const ARootElement: string = '');
begin
  Self.CreateInternal;
  FFileName := AFileName;
  FRootElement := ARootElement;
end;

class function TCSVAdapterRESTRequest4D.New(const AFileName: string; const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter;
begin
  Result := Self.Create(AFileName, AConfig);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AFileName: string; const AConfig: ICSVAdapterRESTRequest4DConfig);
begin
  Self.CreateInternal(AConfig);
  FFileName := AFileName;
end;

class function TCSVAdapterRESTRequest4D.New(const AFileName: string; const ARootElement: string;
  const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter;
begin
  Self.Create(AFileName, ARootElement, AConfig);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AFileName: string; const ARootElement: string;
  const AConfig: ICSVAdapterRESTRequest4DConfig);
begin
  Self.CreateInternal(AConfig);
  FFileName := AFileName;
  FRootElement := ARootElement;
end;

class function TCSVAdapterRESTRequest4D.New(const AStringList: TStrings; const ARootElement: string = ''): IRequestAdapter;
begin
  Result := Self.Create(AStringList, ARootElement);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AStringList: TStrings; const ARootElement: string = '');
begin
  Self.CreateInternal;
  FStringListResult := AStringList;
  FRootElement := ARootElement;
end;

class function TCSVAdapterRESTRequest4D.New(const AStringList: TStrings; const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter;
begin
  Result := Self.Create(AStringList, AConfig);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AStringList: TStrings; const AConfig: ICSVAdapterRESTRequest4DConfig);
begin
  Self.CreateInternal(AConfig);
  FStringListResult := AStringList;
end;

class function TCSVAdapterRESTRequest4D.New(const AStringList: TStrings; const ARootElement: string;
  const AConfig: ICSVAdapterRESTRequest4DConfig): IRequestAdapter;
begin
  Result := Self.Create(AStringList, ARootElement, AConfig);
end;

constructor TCSVAdapterRESTRequest4D.Create(const AStringList: TStrings; const ARootElement: string;
  const AConfig: ICSVAdapterRESTRequest4DConfig);
begin
  Self.CreateInternal(AConfig);
  FStringListResult := AStringList;
  FRootElement := ARootElement;
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
    LLine := LLine + TCSVAdapterRESTRequest4DUtils.PrepareStr(LJSONPair.JsonString.Value, FConfig.Separator) + FConfig.Separator;

  FCSV.Add(TCSVAdapterRESTRequest4DUtils.RemoveLastSeparator(LLine, FConfig.Separator));
  FCaptionsCreated := True;
end;

procedure TCSVAdapterRESTRequest4D.GetItems(const AJSONObject: TJSONObject);
var
  LJSONPair: TJSONPair;
  LLine: string;
begin
  LLine := '';
  for LJSONPair in AJSONObject do
    LLine := LLine + TCSVAdapterRESTRequest4DUtils.PrepareStr(LJSONPair.JsonValue.Value, FConfig.Separator) + FConfig.Separator;

  FCSV.Add(TCSVAdapterRESTRequest4DUtils.RemoveLastSeparator(LLine, FConfig.Separator));
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

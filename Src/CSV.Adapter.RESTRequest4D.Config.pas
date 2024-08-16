unit CSV.Adapter.RESTRequest4D.Config;

interface

uses
  System.SysUtils,
  RESTRequest4D.Request.Adapter.Contract;

type
  ICSVAdapterRESTRequest4DConfig = interface
    ['{B5BF0D7A-8CEF-44AB-8721-9BDFF54921BC}']
    function Separator: string; overload;
    function Separator(const Value: string): ICSVAdapterRESTRequest4DConfig; overload;
  end;

  TCSVAdapterRESTRequest4DConfig = class(TInterfacedObject, ICSVAdapterRESTRequest4DConfig)
  private
    FSeparator: string;
  protected
    function Separator: string; overload;
    function Separator(const Value: string): ICSVAdapterRESTRequest4DConfig; overload;
  public
    class function New: ICSVAdapterRESTRequest4DConfig;
    constructor Create;
  end;

implementation

const
  SEMICOLON = ';';

class function TCSVAdapterRESTRequest4DConfig.New: ICSVAdapterRESTRequest4DConfig;
begin
  Result := Self.Create;
end;

constructor TCSVAdapterRESTRequest4DConfig.Create;
begin
  FSeparator := SEMICOLON;
end;

function TCSVAdapterRESTRequest4DConfig.Separator: string;
begin
  Result := FSeparator;
end;

function TCSVAdapterRESTRequest4DConfig.Separator(const Value: string): ICSVAdapterRESTRequest4DConfig;
begin
  Result := Self;
  FSeparator := Value;

  if FSeparator.Trim.IsEmpty then
    FSeparator := SEMICOLON;
end;

end.

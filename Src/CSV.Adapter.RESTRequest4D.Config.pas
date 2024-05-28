unit CSV.Adapter.RESTRequest4D.Config;

interface

uses
  System.SysUtils;

type
  TCSVAdapterRESTRequest4DConfig = class
  private
    FSeparator: string;
    constructor Create;
  public
    class function GetInstance: TCSVAdapterRESTRequest4DConfig;
    function Separator: string; overload;
    function Separator(const Value: string): TCSVAdapterRESTRequest4DConfig; overload;
  end;

implementation

var
  Instance: TCSVAdapterRESTRequest4DConfig;

const
  SEMICOLON = ';';

constructor TCSVAdapterRESTRequest4DConfig.Create;
begin
  FSeparator := SEMICOLON;
end;

class function TCSVAdapterRESTRequest4DConfig.GetInstance: TCSVAdapterRESTRequest4DConfig;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
end;

function TCSVAdapterRESTRequest4DConfig.Separator: string;
begin
  if FSeparator.Trim.IsEmpty then
    FSeparator := SEMICOLON;
  Result := FSeparator;
end;

function TCSVAdapterRESTRequest4DConfig.Separator(const Value: string): TCSVAdapterRESTRequest4DConfig;
begin
  Result := Self;
  FSeparator := Value;
end;

initialization

finalization
  if(Assigned(Instance))then
    FreeAndNil(Instance);

end.

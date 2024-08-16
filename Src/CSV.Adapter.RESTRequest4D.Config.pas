unit CSV.Adapter.RESTRequest4D.Config;

interface

uses
  System.SysUtils,
  RESTRequest4D.Request.Adapter.Contract;

type
  TCSVAdapterRESTRequest4DConfig = class
  private
    FParent: IRequestAdapter;
    FSeparator: string;
  public
    constructor Create(const AParent: IRequestAdapter);
    function Separator: string; overload;
    function Separator(const Value: string): TCSVAdapterRESTRequest4DConfig; overload;
    function End_: IRequestAdapter;
  end;

implementation

const
  SEMICOLON = ';';

constructor TCSVAdapterRESTRequest4DConfig.Create(const AParent: IRequestAdapter);
begin
  FParent := AParent;
  FSeparator := SEMICOLON;
end;

function TCSVAdapterRESTRequest4DConfig.Separator: string;
begin
  Result := FSeparator;
end;

function TCSVAdapterRESTRequest4DConfig.Separator(const Value: string): TCSVAdapterRESTRequest4DConfig;
begin
  Result := Self;
  FSeparator := Value;

  if FSeparator.Trim.IsEmpty then
    FSeparator := SEMICOLON;
end;

function TCSVAdapterRESTRequest4DConfig.End_: IRequestAdapter;
begin
  Result := FParent;
end;

end.

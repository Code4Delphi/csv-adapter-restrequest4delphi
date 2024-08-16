unit CSV.Adapter.RESTRequest4D.Utils;

interface

uses
  System.SysUtils;

type
  TCSVAdapterRESTRequest4DUtils = class
  private
  public
    class function RemoveLastSeparator(const AValue: string; const ASeparator: string): string;
    ///<summary>Remove if the string has characters used as separator</summary>
    class function PrepareStr(const AValue: string; const ASeparator: string): string;
  end;

implementation

uses
  CSV.Adapter.RESTRequest4D.Config;

class function TCSVAdapterRESTRequest4DUtils.RemoveLastSeparator(const AValue: string; const ASeparator: string): string;
begin
  Result := AValue.Trim;

  if Result.EndsWith(ASeparator) then
    Result := copy(AValue, 1, Pred(AValue.Length));
end;

class function TCSVAdapterRESTRequest4DUtils.PrepareStr(const AValue: string; const ASeparator: string): string;
begin
  Result := AValue.Replace(ASeparator, '', [rfReplaceAll, rfIgnoreCase]);
end;

end.

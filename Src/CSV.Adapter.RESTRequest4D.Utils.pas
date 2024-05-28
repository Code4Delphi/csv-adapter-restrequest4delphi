unit CSV.Adapter.RESTRequest4D.Utils;

interface

uses
  System.SysUtils;

type
  TCSVAdapterRESTRequest4DUtils = class
  private
  public
    class function RemoveLastChar(const AValue: string): string;
    ///<summary>Remove if the string has characters used as separator</summary>
    class function PrepareStr(const AValue: string): string;
  end;

implementation

uses
  CSV.Adapter.RESTRequest4D.Config;

class function TCSVAdapterRESTRequest4DUtils.RemoveLastChar(const AValue: string): string;
begin
  Result := AValue.Trim;

  if Result.EndsWith(TCSVAdapterRESTRequest4DConfig.GetInstance.Separator) then
    Result := copy(AValue, 1, Pred(AValue.Length));
end;

class function TCSVAdapterRESTRequest4DUtils.PrepareStr(const AValue: string): string;
begin
  Result := AValue.Replace(TCSVAdapterRESTRequest4DConfig.GetInstance.Separator, '', [rfReplaceAll, rfIgnoreCase]);
end;

end.

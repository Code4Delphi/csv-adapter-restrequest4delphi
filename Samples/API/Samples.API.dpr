program Samples.API;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Jhonson;

const
  PORT = 9050;

begin
  ReportMemoryLeaksOnShutdown := True;
  THorse.Use(Jhonson());

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

  THorse.Get('/clients',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LJSONObjectRetorno: TJSONObject;
      LJSONObjectCliente: TJSONObject;
      LJSONArray: TJSONArray;
      LNumRegistrosGerar: Integer;
      i: Integer;
    begin
      LNumRegistrosGerar := 10;
      if Req.Query.ContainsKey('number-records') then
        LNumRegistrosGerar := Req.Query.Field('number-records').AsInteger;

      LJSONArray := TJSONArray.Create;
      for i := 1 to LNumRegistrosGerar do
      begin
        LJSONObjectCliente := TJSONObject.Create;
        LJSONObjectCliente.AddPair('id', TJSONNumber.Create(i));
        LJSONObjectCliente.AddPair('nome', 'Name client ' + i.ToString);
        LJSONObjectCliente.AddPair('email','name' + i.ToString + '@code4delphi.com.br');
        LJSONArray.AddElement(LJSONObjectCliente);
      end;

      LJSONObjectRetorno := TJSONObject.Create;
      LJSONObjectRetorno.AddPair('data', LJSONArray);
      LJSONObjectRetorno.AddPair('records', TJSONNumber.Create(LNumRegistrosGerar));
      Res.Send<TJSONObject>(LJSONObjectRetorno);
    end);

  THorse.Get('/clients/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LJSONObject: TJSONObject;
      LId: string;
    begin
      Req.Params.TryGetValue('id', LId);

      LJSONObject := TJSONObject.Create;
      LJSONObject.AddPair('id', TJSONNumber.Create(LId.ToInteger));
      LJSONObject.AddPair('name', 'Name client ' + LId);
      LJSONObject.AddPair('email','nome' + LId + '@code4delphi.com.br');
      Res.Send<TJSONObject>(LJSONObject);
    end);

  THorse.Listen(PORT,
    procedure
    begin
      Writeln('CSV Adapter For RESTRequest4D is running on the port ' + PORT.ToString);
    end);
end.

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
      LJSONObjectResult: TJSONObject;
      LJSONObjectClient: TJSONObject;
      LJSONArray: TJSONArray;
      LNumberRecords: Integer;
      i: Integer;
    begin
      LNumberRecords := 10;
      if Req.Query.ContainsKey('number-records') then
        LNumberRecords := Req.Query.Field('number-records').AsInteger;

      LJSONArray := TJSONArray.Create;
      for i := 1 to LNumberRecords do
      begin
        LJSONObjectClient := TJSONObject.Create;
        LJSONObjectClient.AddPair('id', TJSONNumber.Create(i));
        LJSONObjectClient.AddPair('name', 'Name Client ' + i.ToString);
        LJSONObjectClient.AddPair('email', 'name' + i.ToString + '@code4delphi.com.br');
        LJSONArray.AddElement(LJSONObjectClient);
      end;

      LJSONObjectResult := TJSONObject.Create;
      LJSONObjectResult.AddPair('data', LJSONArray);
      LJSONObjectResult.AddPair('records', TJSONNumber.Create(LNumberRecords));
      Res.Send<TJSONObject>(LJSONObjectResult);
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
      LJSONObject.AddPair('name', 'Name Client ' + LId);
      LJSONObject.AddPair('email', 'name' + LId + '@code4delphi.com.br');
      Res.Send<TJSONObject>(LJSONObject);
    end);

  THorse.Listen(PORT,
    procedure
    begin
      Writeln('CSV Adapter For RESTRequest4D is running on the port ' + PORT.ToString);
    end);
end.

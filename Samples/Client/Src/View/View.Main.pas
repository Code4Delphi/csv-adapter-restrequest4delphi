unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  json,
  REST.Json,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  RESTRequest4D,
  CSV.Adapter.RESTRequest4D;

type
  TViewMain = class(TForm)
    Panel9: TPanel;
    Label1: TLabel;
    edtNumRegistros: TEdit;
    Panel1: TPanel;
    gBoxJSON: TGroupBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    mmCSV: TMemo;
    mmJSON: TMemo;
    Panel2: TPanel;
    Label2: TLabel;
    btnGetObjectSaveToFile: TButton;
    btnGetArraySaveToFile: TButton;
    Label3: TLabel;
    edtBaseURL: TEdit;
    Panel3: TPanel;
    Label4: TLabel;
    btnGetObjectToTString: TButton;
    btnGetArrayToTString: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGetObjectSaveToFileClick(Sender: TObject);
    procedure btnGetArraySaveToFileClick(Sender: TObject);
    procedure btnGetObjectToTStringClick(Sender: TObject);
    procedure btnGetArrayToTStringClick(Sender: TObject);
  private
    function GetNameFile: string;
    function FormatJSON(AValue: string; Indentation: Integer = 2): string;
  public

  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

procedure TViewMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

function TViewMain.GetNameFile: string;
var
  LSaveDialog: TSaveDialog;
begin
  LSaveDialog := TSaveDialog.Create(nil);
  try
    LSaveDialog.Title := 'Salvar em arquivo';
    LSaveDialog.DefaulText := '*.csv';
    LSaveDialog.Filter := 'Arquivos CSV (*.csv)|*.csv|Todos os Arquivos (*.*)|*.*';
    LSaveDialog.InitialDir := 'C:\Temp\';
    LSaveDialog.FileName := FormatDateTime('yyyyMMdd-hhnnss', now) + '.csv';

    if not LSaveDialog.Execute then
      Abort;

    Result := LSaveDialog.FileName;
  finally
    LSaveDialog.Free;
  end;
end;

function TViewMain.FormatJSON(AValue: string; Indentation: Integer = 2): string;
var
  LJSONValue: TJSONValue;
begin
  LJSONValue := nil;
  try
    LJSONValue := TJSONObject.ParseJSONValue(AValue);
    Result := LJSONValue.Format(Indentation);
  finally
    FreeAndNil(LJSONValue);
  end;
end;

procedure TViewMain.btnGetObjectSaveToFileClick(Sender: TObject);
var
  LResponse: IResponse;
  LNomeArquivo: string;
begin
  LNomeArquivo := Self.GetNameFile;

  LResponse := TRequest.New.BaseURL(edtBaseURL.Text)
    .Resource('clientes')
    .ResourceSuffix(edtNumRegistros.Text)
    .Adapters(TCSVAdapterRESTRequest4D.New(LNomeArquivo))
    .Accept('application/json')
    .Get;

  mmJSON.Lines.Text := FormatJSON(LResponse.Content);
end;

procedure TViewMain.btnGetArraySaveToFileClick(Sender: TObject);
var
  LResponse: IResponse;
  LNomeArquivo: string;
begin
  LNomeArquivo := Self.GetNameFile;

  LResponse := TRequest.New.BaseURL(edtBaseURL.Text)
    .Resource('clientes')
    .AddParam('numero-registros-gerar', edtNumRegistros.Text)
    .Adapters(TCSVAdapterRESTRequest4D.New(LNomeArquivo, 'data'))
    .Accept('application/json')
    .Get;

  mmJSON.Lines.Text := FormatJSON(LResponse.Content);
end;

procedure TViewMain.btnGetObjectToTStringClick(Sender: TObject);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(edtBaseURL.Text)
    .Resource('clientes')
    .ResourceSuffix(edtNumRegistros.Text)
    .Adapters(TCSVAdapterRESTRequest4D.New(mmCSV.Lines))
    .Accept('application/json')
    .Get;

  mmJSON.Lines.Text := FormatJSON(LResponse.Content);
end;

procedure TViewMain.btnGetArrayToTStringClick(Sender: TObject);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(edtBaseURL.Text)
    .Resource('clientes')
    .AddParam('numero-registros-gerar', edtNumRegistros.Text)
    .Adapters(TCSVAdapterRESTRequest4D.New(mmCSV.Lines, 'data'))
    .Accept('application/json')
    .Get;

  mmJSON.Lines.Text := FormatJSON(LResponse.Content);
end;

end.

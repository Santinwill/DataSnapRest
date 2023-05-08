unit UnitCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON, Data.fireDACJSONReflect, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    MostrarDados: TTabSheet;
    CadastrarEditar: TTabSheet;
    Panel1: TPanel;
    DBGrid: TDBGrid;
    FDStanStorageJSONLink: TFDStanStorageJSONLink;
    FDStanStorageBinLink: TFDStanStorageBinLink;
    FDMemTable: TFDMemTable;
    DataSource: TDataSource;
    Panel2: TPanel;
    ButtonSalvar: TButton;
    ButtonAtualizar: TButton;
    ButtonDeletar: TButton;
    EditIdPessoa: TEdit;
    EditFlnatureza: TEdit;
    EditDsdocumento: TEdit;
    EditNmprimeiro: TEdit;
    EditNmsegundo: TEdit;
    EditDtregistro: TEdit;
    EditDscep: TEdit;
    EditDsuf: TEdit;
    EditNmcidade: TEdit;
    EditNmbairro: TEdit;
    EditNmlogradouro: TEdit;
    EditDscomplemento: TEdit;
    Panel3: TPanel;
    ButtonNovo: TButton;
    ButtonBuscar: TButton;
    EditIdendereco: TEdit;
    EditIdpessoaendereco: TEdit;
    EditIdendereco_integracao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ButtonCancelar: TButton;
    ButtonInserirLotePessoas: TButton;
    procedure ButtonBuscarClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonAtualizarClick(Sender: TObject);
    procedure ButtonDeletarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonInserirLotePessoasClick(Sender: TObject);
    procedure EditDscepExit(Sender: TObject);
  private
    { Private declarations }
    procedure ListarPessoasEndereco;
    procedure LimparCampos;
    function CamposVazios: Boolean;
    procedure ItemGrid;
  public
    { Public declarations }
    function CriarJSONobject :TJSONObject;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses ClientClassesUnit1, ClientModuleUnit1;

{ TForm3 }

procedure TForm3.ButtonAtualizarClick(Sender: TObject);
var
  ObjetoPessoas: TJSONObject;
  idPessoa: Integer;
  idEndereco: Integer;
  Retorno: string;
begin
  if CamposVazios then
    Exit;
  ObjetoPessoas := CriarJSONobject;
  idPessoa := StrToInt(EditIdPessoa.Text);
  idEndereco := StrToIntDef(EditIdendereco.Text, 0);
  try
    Retorno := ClientModule1.ServerMethods1Client.AcceptPessoas(idPessoa, idEndereco, ObjetoPessoas);
  except on E: Exception do
    ShowMessage('Erro:' + E.Message );
  end;
  ShowMessage(Retorno);
  PageControl1.ActivePageIndex := 0;
  ListarPessoasEndereco;
end;

procedure TForm3.ButtonBuscarClick(Sender: TObject);
begin
  ListarPessoasEndereco;
end;


procedure TForm3.ButtonCancelarClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  LimparCampos;
  ListarPessoasEndereco;
end;

procedure TForm3.ButtonDeletarClick(Sender: TObject);
var
  idpessoa: Integer;
  Retorno: string;
begin
  idpessoa := StrToInt(EditIdPessoa.Text);
  try
    Retorno := ClientModule1.ServerMethods1Client.CancelPessoas(idpessoa);
  except on E: Exception do
    ShowMessage('Erro:' + E.Message );
  end;
  ShowMessage(Retorno);
  PageControl1.ActivePageIndex := 0;
  ListarPessoasEndereco;
end;

procedure TForm3.ButtonInserirLotePessoasClick(Sender: TObject);
var
  Retorno: string;
begin
   try
    Retorno := ClientModule1.ServerMethods1Client.UpdateLote;
  except on E: Exception do
    ShowMessage('Erro:' + E.Message );
  end;
  ShowMessage(Retorno);
  PageControl1.ActivePageIndex := 0;
  ListarPessoasEndereco;
end;

procedure TForm3.ButtonNovoClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  ButtonAtualizar.Enabled := False;
  ButtonSalvar.Enabled := True;
  ButtonDeletar.Enabled := False;
end;


procedure TForm3.ButtonSalvarClick(Sender: TObject);
var
  ObjetoPessoa: TJSONObject;
  Retorno: String;
begin
  if CamposVazios then
  begin
    Exit;
  end
  else
  ObjetoPessoa := CriarJSONobject;

  try
    Retorno := ClientModule1.ServerMethods1Client.UpdatePessoas(ObjetoPessoa);
  except on E: Exception do
    ShowMessage('Erro:' + E.Message );
  end;
  ShowMessage(Retorno);
  PageControl1.ActivePageIndex := 0;
  ListarPessoasEndereco;
end;

function TForm3.CamposVazios: Boolean;
begin
  if EditFlnatureza.Text = '' then
  begin
    EditFlnatureza.SetFocus;
    ShowMessage('Campo Obrigatório natureza Vazio');
    Result := True;
  end
  else if EditDsdocumento.Text = '' then
  begin
    EditDsdocumento.SetFocus;
    ShowMessage('Campo Obrigatório documento Vazio');
    Result := True;
  end
  else if EditNmprimeiro.Text = '' then
  begin
    EditNmprimeiro.SetFocus;
    ShowMessage('Campo Obrigatório primeiro nome Vazio');
    Result := True;
  end
  else if EditNmsegundo.Text = '' then
  begin
    EditNmsegundo.SetFocus;
    ShowMessage('Campo Obrigatório segundo nome Vazio');
    Result := True;
  end
  else if EditDscep.Text = '' then
  begin
    EditDscep.SetFocus;
    ShowMessage('Campo Obrigatório CEP Vazio');
    Result := True;
  end
  else if EditDscomplemento.Text = '' then
  begin
    EditDscomplemento.SetFocus;
    ShowMessage('Campo Obrigatório Complemento Vazio');
    Result := True;
  end
  else if EditDsuf.Text = '' then
  begin
    EditDscep.SetFocus;
    ShowMessage('Informe o CEP e clique em pesquisar');
    Result := True;
  end
  else
    Result := False;
end;

function TForm3.CriarJSONobject: TJSONObject;
var
  Pessoa: TJSONObject;
begin
  Pessoa := TJSONObject.Create;
  Pessoa.AddPair('IDPESSOA', EditIdPessoa.Text);
  Pessoa.AddPair('FLNATUREZA', EditFlnatureza.Text);
  Pessoa.AddPair('DSDOCUMENTO', EditDsdocumento.Text);
  Pessoa.AddPair('NMPRIMEIRO', EditNmprimeiro.Text);
  Pessoa.AddPair('NMSEGUNDO', EditNmsegundo.Text);
  Pessoa.AddPair('DTREGISTRO', EditDtregistro.Text);
  Pessoa.AddPair('IDENDERECO', EditIdendereco.Text);
  Pessoa.AddPair('IDPESSOA', EditIdpessoaendereco.Text);
  Pessoa.AddPair('DSCEP', EditDscep.Text);
  Pessoa.AddPair('IDENDERECO', EditIdendereco_integracao.Text);
  Pessoa.AddPair('DSUF', EditDsuf.Text);
  Pessoa.AddPair('NMCIDADE', EditNmcidade.Text);
  Pessoa.AddPair('NMBAIRRO', EditNmbairro.Text);
  Pessoa.AddPair('NMLOGRADOURO', EditNmlogradouro.Text);
  Pessoa.AddPair('DSCOMPLEMENTO', EditDscomplemento.Text);

  Result := Pessoa;
end;

procedure TForm3.DBGridDblClick(Sender: TObject);
begin
  ButtonSalvar.Enabled := False;
  ButtonAtualizar.Enabled := True;
  ButtonDeletar.Enabled := True;
  PageControl1.ActivePageIndex := 1;
  EditIdPessoa.Text := DataSource.DataSet.FieldByName('IDPESSOA').AsString;
  EditFlnatureza.Text := DataSource.DataSet.FieldByName('FLNATUREZA').AsString;
  EditDsdocumento.Text := DataSource.DataSet.FieldByName('DSDOCUMENTO').AsString;
  EditNmprimeiro.Text := DataSource.DataSet.FieldByName('NMPRIMEIRO').AsString;
  EditNmsegundo.Text := DataSource.DataSet.FieldByName('NMSEGUNDO').AsString;
  EditDtregistro.Text := DataSource.DataSet.FieldByName('DTREGISTRO').AsString;
  EditIdendereco.Text := DataSource.DataSet.FieldByName('IDENDERECO').AsString;
  EditIdpessoaendereco.Text := DataSource.DataSet.FieldByName('IDPESSOA').AsString;
  EditDscep.Text := DataSource.DataSet.FieldByName('DSCEP').AsString;
  EditIdendereco_integracao.Text := DataSource.DataSet.FieldByName('IDENDERECO').AsString;
  EditDsuf.Text := DataSource.DataSet.FieldByName('DSUF').AsString;
  EditNmcidade.Text := DataSource.DataSet.FieldByName('NMCIDADE').AsString;
  EditNmbairro.Text := DataSource.DataSet.FieldByName('NMBAIRRO').AsString;
  EditNmlogradouro.Text := DataSource.DataSet.FieldByName('NMLOGRADOURO').AsString;
  EditDscomplemento.Text := DataSource.DataSet.FieldByName('DSCOMPLEMENTO').AsString;
end;

procedure TForm3.EditDscepExit(Sender: TObject);
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  Endereco: TJSONObject;
  value: TJSONValue;
begin
  if Length(EditDscep.Text) < 8 then
  begin
    ShowMessage('Digite 8 Numeros');
    exit;
  end;

  RESTClient := TRESTClient.Create('https://viacep.com.br');
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.Accept := 'application/json';
    RESTClient.BaseURL := RESTClient.BaseURL + '/ws/' + EditDscep.Text + '/json/';
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Execute;
    Endereco := TJSONObject.ParseJSONValue(RESTResponse.Content) as TJSONObject;
    if Endereco.GetValue('erro') <> nil then
    begin
      ShowMessage('CEP inválido ou não encontrado.');
      Exit;
    end;
    EditDsuf.Text := Endereco.GetValue('uf').Value;
    EditNmcidade.Text := Endereco.GetValue('localidade').Value;
    EditNmbairro.Text := Endereco.GetValue('bairro').Value;
    EditNmlogradouro.Text := Endereco.GetValue('logradouro').Value;

  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  ItemGrid;

  DBGrid.OnDblClick := DBGridDblClick;
  ButtonSalvar.OnClick :=  ButtonSalvarClick;
  ButtonAtualizar.OnClick :=  ButtonAtualizarClick;
  ButtonDeletar.OnClick :=  ButtonDeletarClick;
  ButtonNovo.OnClick :=  ButtonNovoClick;
  ButtonBuscar.OnClick :=  ButtonBuscarClick;
  ButtonCancelar.OnClick :=  ButtonCancelarClick;
  ButtonInserirLotePessoas.OnClick :=  ButtonInserirLotePessoasClick;
  EditDscep.OnExit := EditDscepExit;

end;

procedure TForm3.ItemGrid;
var
  AColumn: TColumn;
begin
  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'IDPESSOA';
  AColumn.Title.Caption := 'Cód.';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'FLNATUREZA';
  AColumn.Title.Caption := 'Natureza';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'DSDOCUMENTO';
  AColumn.Title.Caption := 'Documento';
  AColumn.Width := 100;
  AColumn.Alignment := taLeftJustify;


  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'NMPRIMEIRO';
  AColumn.Title.Caption := 'Nome';
  AColumn.Width := 400;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'NMSEGUNDO';
  AColumn.Title.Caption := 'Sobrenome';
  AColumn.Width := 400;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'DTREGISTRO';
  AColumn.Title.Caption := 'Data Registro';
  AColumn.Width := 70;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'IDENDERECO';
  AColumn.Title.Caption := 'Cód.';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'IDPESSOA';
  AColumn.Title.Caption := 'Cód.';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'DSCEP';
  AColumn.Title.Caption := 'Cep';
  AColumn.Width := 80;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'IDENDERECO';
  AColumn.Title.Caption := 'Cód.';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'DSUF';
  AColumn.Title.Caption := 'UF';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'NMCIDADE';
  AColumn.Title.Caption := 'Cidade';
  AColumn.Width := 100;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'NMBAIRRO';
  AColumn.Title.Caption := 'Bairro';
  AColumn.Width := 100;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'NMLOGRADOURO';
  AColumn.Title.Caption := 'Logradouro';
  AColumn.Width := 200;
  AColumn.Alignment := taLeftJustify;

  AColumn := DBGrid.Columns.Add;
  AColumn.FieldName := 'DSCOMPLEMENTO';
  AColumn.Title.Caption := 'Complemento';
  AColumn.Width := 50;
  AColumn.Alignment := taLeftJustify;

end;

procedure TForm3.LimparCampos;
begin
  EditIdPessoa.Text := '';
  EditFlnatureza.Text := '';
  EditDsdocumento.Text := '';
  EditNmprimeiro.Text := '';
  EditNmsegundo.Text := '';
  EditDtregistro.Text := '';
  EditIdendereco.Text := '';
  EditIdpessoaendereco.Text := '';
  EditDscep.Text := '';
  EditIdendereco_integracao.Text := '';
  EditDsuf.Text := '';
  EditNmcidade.Text := '';
  EditNmbairro.Text := '';
  EditNmlogradouro.Text := '';
  EditDscomplemento.Text := '';
end;

procedure TForm3.ListarPessoasEndereco;
var
  ListaPessoas: TFDJSONDataSets;
begin
  FDMemTable.Close;
  ListaPessoas := ClientModule1.ServerMethods1Client.Pessoas;
  FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(ListaPessoas, 0));
  FDMemTable.Open;
  LimparCampos;
end;

end.

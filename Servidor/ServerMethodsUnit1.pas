unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON,
  Data.fireDACJSONReflect, System.Generics.Collections, Dialogs;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDStanStorageJSONLink: TFDStanStorageJSONLink;
    FDStanStorageBinLink: TFDStanStorageBinLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sqlBase: string;
    sqlAuxiliar: string;
    procedure AtualizarPessoa(IDpessoa: Integer; Pessoas: TJSONObject);
    procedure AtualizarEnderecoCep(IDpessoa: Integer; Pessoas: TJSONObject);
    procedure AtualizarInegracaoEndereco(IDendereco: Integer; Pessoas: TJSONObject);
    function InserirPessoa(Pessoa: TJSONObject): Integer;
    function InserirEnderecoCep(UltimaPessoa: Integer; Pessoa: TJSONObject): Integer;
    procedure InserirEnderecoIntegracao(UltimoEndereco: integer; Pessoa: TJSONObject);
  public
    { Public declarations }
    function Pessoas: TFDJSONDataSets;
    function AcceptPessoas(IDpessoa: Integer; IDendereco: Integer;
Pessoas: TJSONObject): String;
    function UpdatePessoas(Pessoa: TJSONObject): String;
    function UpdateLote: String;
    function CancelPessoas(const IdPessoa: Integer): String;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}

uses WebModuleUnit1;


{ TServerMethods1 }

function TServerMethods1.AcceptPessoas(IDpessoa: Integer; IDendereco: Integer;
Pessoas: TJSONObject): String;
var
  UltimoEndereco: Integer;
begin
  AtualizarPessoa(IDpessoa, Pessoas);
  if IDendereco = 0 then
  begin
    UltimoEndereco := InserirEnderecoCep(IDpessoa, Pessoas);
    InserirEnderecoIntegracao(UltimoEndereco, Pessoas);
  end
  else
  begin
    AtualizarEnderecoCep(IDpessoa, Pessoas);
    AtualizarInegracaoEndereco(IDendereco, Pessoas);
  end;
  Result:= 'Atualizado com sucesso';
end;

procedure TServerMethods1.AtualizarEnderecoCep(IDpessoa: Integer; Pessoas: TJSONObject);
const
  _UpdateEndereco =
  'UPDATE ENDERECO  ' +
  '   SET DSCEP = :pDSCEP ' +
  ' WHERE IDPESSOA = :pIDPESSOA ' ;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _UpdateEndereco;
    FDQuery.ParamByName('pDSCEP').AsString := Pessoas.GetValue('DSCEP').Value;
    FDQuery.ParamByName('pIDPESSOA').AsInteger := IDpessoa;
    FDQuery.ExecSQL;
  finally
    FDQuery.Close;
  end;
end;

procedure TServerMethods1.AtualizarInegracaoEndereco(IDendereco: Integer; Pessoas: TJSONObject);
const
  _UpdateEnderecoIntegracao =
  ' UPDATE ENDERECO_INTEGRACAO  ' +
  '    SET NMBAIRRO = :pNMBAIRRO, ' +
  '	       NMLOGRADOURO = :pNMLOGRADOURO, ' +
  '        DSCOMPLEMENTO = :pDSCOMPLEMENTO, ' +
  '	       NMCIDADE = :pNMCIDADE, ' +
  '	       DSUF = :pDSUF ' +
  '  WHERE IDENDERECO = :pIDENDERECO ' ;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _UpdateEnderecoIntegracao;
    FDQuery.ParamByName('pNMBAIRRO').AsString := Pessoas.GetValue('NMBAIRRO').Value;
    FDQuery.ParamByName('pNMLOGRADOURO').AsString := Pessoas.GetValue('NMLOGRADOURO').Value;
    FDQuery.ParamByName('pDSCOMPLEMENTO').AsString := Pessoas.GetValue('DSCOMPLEMENTO').Value;
    FDQuery.ParamByName('pNMCIDADE').AsString := Pessoas.GetValue('NMCIDADE').Value;
    FDQuery.ParamByName('pDSUF').AsString := Pessoas.GetValue('DSUF').Value;
    FDQuery.ParamByName('pIDENDERECO').AsInteger := IDendereco;
    FDQuery.ExecSQL;
  finally
    FDQuery.Close;
  end;
end;

procedure TServerMethods1.AtualizarPessoa(IDpessoa: Integer; Pessoas: TJSONObject);
const
  _UpdatePessoa =
  '    UPDATE PESSOA ' +
  '       SET FLNATUREZA = :pFLNATUREZA, ' +
  '  	        DSDOCUMENTO = :pDSDOCUMENTO, ' +
  '	          NMPRIMEIRO = :pNMPRIMEIRO, ' +
  '	          NMSEGUNDO = :pNMSEGUNDO ' +
  '     WHERE IDPESSOA = :pIDPESSOA ' ;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _UpdatePessoa;
    FDQuery.ParamByName('pFLNATUREZA').AsInteger := StrToInt(Pessoas.GetValue('FLNATUREZA').Value);
    FDQuery.ParamByName('pDSDOCUMENTO').AsString := Pessoas.GetValue('DSDOCUMENTO').Value;
    FDQuery.ParamByName('pNMPRIMEIRO').AsString := Pessoas.GetValue('NMPRIMEIRO').Value;
    FDQuery.ParamByName('pNMSEGUNDO').AsString := Pessoas.GetValue('NMSEGUNDO').Value;
    FDQuery.ParamByName('pIDPESSOA').AsInteger := IDpessoa;
    FDQuery.ExecSQL;
  finally
    FDQuery.Close;
  end;
end;

function TServerMethods1.CancelPessoas(const IdPessoa: Integer): String;
const
  _Delete =
  'DELETE FROM PESSOA ' +
  '      WHERE IDPESSOA = :pIDPESSOA ';

begin
  try
    FDQuery.Close;
    FDQuery.SQL.Text := _Delete;
    FDQuery.ParamByName('pIDPESSOA').AsInteger := IdPessoa;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;

  Result := 'Excluido com sucesso';
end;

procedure TServerMethods1.DataModuleCreate(Sender: TObject);
begin
  sqlBase :=
  '  SELECT PESSOA.IDPESSOA, ' +
  '   	    PESSOA.FLNATUREZA, ' +
  '	        PESSOA.DSDOCUMENTO, ' +
  '	        PESSOA.NMPRIMEIRO, ' +
  '	        PESSOA.NMSEGUNDO, ' +
  '	        PESSOA.DTREGISTRO, ' +
  '         ENDERECO.IDENDERECO, ' +
  '         ENDERECO.IDPESSOA, ' +
  '  	      ENDERECO.DSCEP, ' +
  '         ENDERECO_INTEGRACAO.IDENDERECO, ' +
  '	        ENDERECO_INTEGRACAO.NMBAIRRO, ' +
  '	        ENDERECO_INTEGRACAO.NMLOGRADOURO, ' +
  '	        ENDERECO_INTEGRACAO.DSCOMPLEMENTO, ' +
  '	        ENDERECO_INTEGRACAO.NMCIDADE, ' +
  '	        ENDERECO_INTEGRACAO.DSUF ' +
  '    FROM PESSOA ' +
  'LEFT JOIN ENDERECO ' +
  '      ON PESSOA.IDPESSOA = ENDERECO.IDPESSOA  ' +
  'LEFT JOIN ENDERECO_INTEGRACAO ' +
  '      ON ENDERECO.IDENDERECO = ENDERECO_INTEGRACAO.IDENDERECO ' +
  '   WHERE 1 = 1 ' ;

  sqlAuxiliar := sqlBase;
end;

function TServerMethods1.InserirEnderecoCep(UltimaPessoa: Integer; Pessoa: TJSONObject): Integer;
const
  _InsertEndereco =
  ' INSERT INTO ENDERECO ( ' +
  '             IDPESSOA, ' +
  ' 	          DSCEP) ' +
  '      VALUES(:pIDPESSOA, ' +
  '             :pDSCEP) ' +
  '   RETURNING IDENDERECO ';
var
  UltimoEndereco: string;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _InsertEndereco;
    FDQuery.ParamByName('pIDPESSOA').AsInteger := UltimaPessoa;
    FDQuery.ParamByName('pDSCEP').AsString := Pessoa.GetValue('DSCEP').Value;
    FDQuery.open;
    UltimoEndereco := FDQuery.FieldByName('IDENDERECO').AsString;
  finally
    FDQuery.Close;
  end;
  Result := StrToInt(UltimoEndereco);
end;

procedure TServerMethods1.InserirEnderecoIntegracao(UltimoEndereco: integer; Pessoa: TJSONObject);
const
  _InsertEnderecoIntegracao =
  ' INSERT INTO ENDERECO_INTEGRACAO ( ' +
  '             IDENDERECO, ' +
  ' 	          DSUF, ' +
  '             NMCIDADE, ' +
  '             NMBAIRRO, ' +
  '             NMLOGRADOURO, ' +
  '             DSCOMPLEMENTO) ' +
  '      VALUES(:pIDENDERECO, ' +
  '             :pDSUF, ' +
  '             :pNMCIDADE, ' +
  '             :pNMBAIRRO, ' +
  '             :pNMLOGRADOURO, ' +
  '             :pDSCOMPLEMENTO) ' ;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _InsertEnderecoIntegracao;
    FDQuery.ParamByName('pIDENDERECO').AsInteger := UltimoEndereco;
    FDQuery.ParamByName('pNMBAIRRO').AsString := Pessoa.GetValue('NMBAIRRO').Value;
    FDQuery.ParamByName('pNMLOGRADOURO').AsString := Pessoa.GetValue('NMLOGRADOURO').Value;
    FDQuery.ParamByName('pDSCOMPLEMENTO').AsString := Pessoa.GetValue('DSCOMPLEMENTO').Value;
    FDQuery.ParamByName('pNMCIDADE').AsString := Pessoa.GetValue('NMCIDADE').Value;
    FDQuery.ParamByName('pDSUF').AsString := Pessoa.GetValue('DSUF').Value;
    FDQuery.ExecSQL;
  finally
    FDQuery.Close;
  end;
end;

function TServerMethods1.InserirPessoa(Pessoa: TJSONObject): Integer;
const
  _InsertPessoa =
  ' INSERT INTO PESSOA( ' +
  '             FLNATUREZA, ' +
  ' 	          DSDOCUMENTO, ' +
  '             NMPRIMEIRO, ' +
  '	            NMSEGUNDO, ' +
  '	            DTREGISTRO ) ' +
  '      VALUES(:pFLNATUREZA, ' +
  '             :pDSDOCUMENTO, ' +
  '             :pNMPRIMEIRO, ' +
  '             :pNMSEGUNDO, ' +
  '             :pDTREGISTRO)' +
  '   RETURNING IDPESSOA ';

var
  UltimaPessoa: string;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _InsertPessoa;
    FDQuery.ParamByName('pFLNATUREZA').AsInteger := StrToInt(Pessoa.GetValue('FLNATUREZA').Value);
    FDQuery.ParamByName('pDSDOCUMENTO').AsString := Pessoa.GetValue('DSDOCUMENTO').Value;
    FDQuery.ParamByName('pNMPRIMEIRO').AsString := Pessoa.GetValue('NMPRIMEIRO').Value;
    FDQuery.ParamByName('pNMSEGUNDO').AsString := Pessoa.GetValue('NMSEGUNDO').Value;
    FDQuery.ParamByName('pDTREGISTRO').AsDate := Now;
    FDQuery.Open;
    UltimaPessoa := FDQuery.FieldByName('IDPESSOA').AsString;
  finally
    FDQuery.Close;
  end;
  Result := StrToInt(UltimaPessoa);
end;

function TServerMethods1.Pessoas: TFDJSONDataSets;
begin
  FDQuery.Close;
  FDQuery.SQL.Text := sqlAuxiliar;
  FDQuery.Open;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQuery);
end;

function TServerMethods1.UpdateLote: String;
const
  _InsertPessoa =
  ' INSERT INTO PESSOA( ' +
  '             FLNATUREZA, ' +
  ' 	          DSDOCUMENTO, ' +
  '             NMPRIMEIRO, ' +
  '	            NMSEGUNDO, ' +
  '	            DTREGISTRO ) ' +
  '      VALUES(:pFLNATUREZA, ' +
  '             :pDSDOCUMENTO, ' +
  '             :pNMPRIMEIRO, ' +
  '             :pNMSEGUNDO, ' +
  '             :pDTREGISTRO)' ;

var
  ListaArquivo: TStringList;
  ListaLinha: TStringList;
  i: Integer;
begin
  ListaArquivo := TStringList.Create;
  ListaLinha := TStringList.Create;
  try
    ListaArquivo.LoadFromFile('.\pessoas.csv');
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Text := _InsertPessoa;
    FDQuery.Params.ArraySize := ListaArquivo.Count;

    for i := 0 to ListaArquivo.Count -1 do
    begin
      ListaLinha.StrictDelimiter := True;
      ListaLinha.CommaText := ListaArquivo[i];
      FDQuery.ParamByName('pFLNATUREZA').AsIntegers[i] := StrToInt(ListaLinha[0]);
      FDQuery.ParamByName('pNMPRIMEIRO').AsStrings[i] := ListaLinha[1];
      FDQuery.ParamByName('pNMSEGUNDO').AsStrings[i] := ListaLinha[2];
      FDQuery.ParamByName('pDSDOCUMENTO').AsStrings[i] := ListaLinha[3];
      FDQuery.ParamByName('pDTREGISTRO').AsDates[i] := now;
    end;

    FDQuery.Execute(ListaArquivo.Count, 0);

  finally
    ListaArquivo.Free;
    ListaLinha.Free;
    FDQuery.Close;
  end;
  Result := 'Lote Cadastrado com sucesso';
end;

function TServerMethods1.UpdatePessoas(Pessoa: TJSONObject): String;
var
  UltimaPessoa: Integer;
  UltimoEndereco: Integer;

begin
  UltimaPessoa := InserirPessoa(Pessoa);
  UltimoEndereco := InserirEnderecoCep(UltimaPessoa, Pessoa);
  InserirEnderecoIntegracao(UltimoEndereco, Pessoa);
  Result := 'Cadastrado com sucesso';
end;

end.


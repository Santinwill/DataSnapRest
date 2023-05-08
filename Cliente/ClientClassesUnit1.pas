//
// Created by the DataSnap proxy generator.
// 05/05/2023 11:28:35
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDataModuleCreateCommand: TDSRestCommand;
    FPessoasCommand: TDSRestCommand;
    FPessoasCommand_Cache: TDSRestCommand;
    FAcceptPessoasCommand: TDSRestCommand;
    FUpdatePessoasCommand: TDSRestCommand;
    FUpdateLoteCommand: TDSRestCommand;
    FCancelPessoasCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleCreate(Sender: TObject);
    function Pessoas(const ARequestFilter: string = ''): TFDJSONDataSets;
    function Pessoas_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function AcceptPessoas(IDpessoa: Integer; IDendereco: Integer; Pessoas: TJSONObject; const ARequestFilter: string = ''): string;
    function UpdatePessoas(Pessoa: TJSONObject; const ARequestFilter: string = ''): string;
    function UpdateLote(const ARequestFilter: string = ''): string;
    function CancelPessoas(IdPessoa: Integer; const ARequestFilter: string = ''): string;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_Pessoas: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_Pessoas_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_AcceptPessoas: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'IDpessoa'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'IDendereco'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Pessoas'; Direction: 1; DBXType: 37; TypeName: 'TJSONObject'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_UpdatePessoas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Pessoa'; Direction: 1; DBXType: 37; TypeName: 'TJSONObject'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_UpdateLote: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_CancelPessoas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'IdPessoa'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

implementation

procedure TServerMethods1Client.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TServerMethods1."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TServerMethods1_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

function TServerMethods1Client.Pessoas(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FPessoasCommand = nil then
  begin
    FPessoasCommand := FConnection.CreateCommand;
    FPessoasCommand.RequestType := 'GET';
    FPessoasCommand.Text := 'TServerMethods1.Pessoas';
    FPessoasCommand.Prepare(TServerMethods1_Pessoas);
  end;
  FPessoasCommand.Execute(ARequestFilter);
  if not FPessoasCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FPessoasCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FPessoasCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FPessoasCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.Pessoas_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FPessoasCommand_Cache = nil then
  begin
    FPessoasCommand_Cache := FConnection.CreateCommand;
    FPessoasCommand_Cache.RequestType := 'GET';
    FPessoasCommand_Cache.Text := 'TServerMethods1.Pessoas';
    FPessoasCommand_Cache.Prepare(TServerMethods1_Pessoas_Cache);
  end;
  FPessoasCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FPessoasCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.AcceptPessoas(IDpessoa: Integer; IDendereco: Integer; Pessoas: TJSONObject; const ARequestFilter: string): string;
begin
  if FAcceptPessoasCommand = nil then
  begin
    FAcceptPessoasCommand := FConnection.CreateCommand;
    FAcceptPessoasCommand.RequestType := 'POST';
    FAcceptPessoasCommand.Text := 'TServerMethods1."AcceptPessoas"';
    FAcceptPessoasCommand.Prepare(TServerMethods1_AcceptPessoas);
  end;
  FAcceptPessoasCommand.Parameters[0].Value.SetInt32(IDpessoa);
  FAcceptPessoasCommand.Parameters[1].Value.SetInt32(IDendereco);
  FAcceptPessoasCommand.Parameters[2].Value.SetJSONValue(Pessoas, FInstanceOwner);
  FAcceptPessoasCommand.Execute(ARequestFilter);
  Result := FAcceptPessoasCommand.Parameters[3].Value.GetWideString;
end;

function TServerMethods1Client.UpdatePessoas(Pessoa: TJSONObject; const ARequestFilter: string): string;
begin
  if FUpdatePessoasCommand = nil then
  begin
    FUpdatePessoasCommand := FConnection.CreateCommand;
    FUpdatePessoasCommand.RequestType := 'POST';
    FUpdatePessoasCommand.Text := 'TServerMethods1."UpdatePessoas"';
    FUpdatePessoasCommand.Prepare(TServerMethods1_UpdatePessoas);
  end;
  FUpdatePessoasCommand.Parameters[0].Value.SetJSONValue(Pessoa, FInstanceOwner);
  FUpdatePessoasCommand.Execute(ARequestFilter);
  Result := FUpdatePessoasCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.UpdateLote(const ARequestFilter: string): string;
begin
  if FUpdateLoteCommand = nil then
  begin
    FUpdateLoteCommand := FConnection.CreateCommand;
    FUpdateLoteCommand.RequestType := 'GET';
    FUpdateLoteCommand.Text := 'TServerMethods1.UpdateLote';
    FUpdateLoteCommand.Prepare(TServerMethods1_UpdateLote);
  end;
  FUpdateLoteCommand.Execute(ARequestFilter);
  Result := FUpdateLoteCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.CancelPessoas(IdPessoa: Integer; const ARequestFilter: string): string;
begin
  if FCancelPessoasCommand = nil then
  begin
    FCancelPessoasCommand := FConnection.CreateCommand;
    FCancelPessoasCommand.RequestType := 'GET';
    FCancelPessoasCommand.Text := 'TServerMethods1.CancelPessoas';
    FCancelPessoasCommand.Prepare(TServerMethods1_CancelPessoas);
  end;
  FCancelPessoasCommand.Parameters[0].Value.SetInt32(IdPessoa);
  FCancelPessoasCommand.Execute(ARequestFilter);
  Result := FCancelPessoasCommand.Parameters[1].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FDataModuleCreateCommand.DisposeOf;
  FPessoasCommand.DisposeOf;
  FPessoasCommand_Cache.DisposeOf;
  FAcceptPessoasCommand.DisposeOf;
  FUpdatePessoasCommand.DisposeOf;
  FUpdateLoteCommand.DisposeOf;
  FCancelPessoasCommand.DisposeOf;
  inherited;
end;

end.


unit Flying4D.Database.BigQueryDatabase;

interface

uses
  FireDAC.UI.Intf,
  FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util,
  FireDAC.VCLUI.Script,
  FireDAC.Comp.UI,
  FireDAC.Stan.Intf,
  FireDAC.Comp.Script,
  FireDAC.Comp.Client,
  SysUtils,
  Flying4D.Database.Interfaces,
  Flying4D.Resources.Interfaces,
  Flying4D.Database.Query,
  Flying4D.Database.Ignite.Thin.Interfaces,
  Flying4D.Database.Ignite.Thin.Database,
  FireDAC.Comp.DataSet;

type
  TBigQueryDatabase = class(TInterfacedObject, iBigQueryDatabase)
    private
      [weak]
      FParent : iConexao;
      FScript : TFDScript;
      FQuery : iQuery;
      FHistory : iIgniteThinDatabase;
      function Checksum(Value : Integer) : Integer;
      function ValidFile(Value : String) : Boolean;
      procedure Persistencehistory(Value: string);
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iBigQueryDatabase;
      function FileScript(Value : String) : iBigQueryDatabase;
  end;

implementation

function TBigQueryDatabase.Checksum(Value : Integer) : Integer;
begin
  Result := Random(Value);
end;

constructor TBigQueryDatabase.Create(Parent : iConexao);
begin
  FParent := Parent;
  FScript := TFDScript.Create(nil);
  FScript.Connection := FParent.Connection;
  FQuery := TQuery.New(FParent);
  FHistory := TIgniteThinDatabase.New(FParent);
end;

destructor TBigQueryDatabase.Destroy;
begin
  FScript.DisposeOf;
  inherited;
end;

function TBigQueryDatabase.FileScript(Value: String): iBigQueryDatabase;
begin
  if ValidFile(Value) then begin
    FScript.SQLScriptFileName := Value;

    FScript.ValidateAll;
    FScript.ExecuteAll;

    Persistencehistory(Value);
  end else
    raise Exception.Create('Arquivo não está no padrão recomentadado');
end;

procedure TBigQueryDatabase.Persistencehistory(Value: string);
var
  ds: TFDMemTable;
begin
  ds := TFDMemTable.Create(nil);
  try
    ds.CopyDataSet(FQuery.SQL(FHistory.MigrationVersion).Open.DataSet,
      [coStructure, coRestart, coAppend]);

    FQuery
      .SQL(FHistory
            .InsertStatement)
      .Params('INSTALLED_RANK', ds.FieldByName('RANK').AsInteger)
      .Params('VERSION', ds.FieldByName('VERSION').AsInteger)
      .Params('SCRIPT', Value)
      .Params('CHECKSUM', Checksum(ds.FieldByName('CHK').AsInteger))
      .Params('INSTALLED_BY', 'root')
      .Params('EXECUTION_TIME', FScript.TotalJobDone)
      .Params('SUCCESS', 1)
      .ExecSQL;
  finally
    ds.DisposeOf;
  end;
end;

class function TBigQueryDatabase.New(Parent : iConexao) : iBigQueryDatabase;
begin
  Result := Self.Create(Parent);
end;

function TBigQueryDatabase.ValidFile(Value: String): Boolean;
var
  searchDir : TSearchRec;
  I : Integer;
begin
  Result := False;

//  I := FindFirst()
//  FQuery
//    .SQL(FHistory.SelectStatement)
//    .DataSet

  if (Copy(Value, 1, 1) = 'V') then
    Result := True;
end;

end.

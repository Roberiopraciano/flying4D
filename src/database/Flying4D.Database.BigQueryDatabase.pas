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
  FireDAC.Comp.DataSet,
  Flying4D.Core.Interfaces,
  Flying4D.Database.BigQueryTable;

type
  TBigQueryDatabase = class(TInterfacedObject, iBigQueryDatabase)
    private
      [weak]
      FParent : iConfiguration;
      FScript : TFDScript;
      FSks : String;
      FQuery : iQuery;
      FHistory : iIgniteThinDatabase;
      FTable : iBigQueryTable;
      FIgniteThinDatabase : iIgniteThinDatabase;
      function Checksum(Value : Integer) : Integer;
      function ValidFile(Value : String) : Boolean;
      procedure Persistencehistory(Value: string);
      procedure VerifyTable;
    public
      constructor Create(Parent : iConfiguration);
      destructor Destroy; override;
      class function New(Parent : iConfiguration) : iBigQueryDatabase;
      function FileScript(Value : String) : iBigQueryDatabase;
  end;

implementation

function TBigQueryDatabase.Checksum(Value : Integer) : Integer;
begin
  if Value.ToString.IsEmpty then
    Value := 1;
  Result := Random(Value);
end;

constructor TBigQueryDatabase.Create(Parent : iConfiguration);
begin
  FParent := Parent;
  FScript := TFDScript.Create(nil);

  FScript.Connection := FParent.Connection;

  FQuery := TQuery.New(FParent.Connect);

  FHistory := TIgniteThinDatabase.New(FParent);

  FTable := TBigQueryTable.New(FParent.Connect);

  VerifyTable;
end;

destructor TBigQueryDatabase.Destroy;
begin
  FScript.DisposeOf;
  inherited;
end;

function TBigQueryDatabase.FileScript(Value: String): iBigQueryDatabase;
begin
  FSks := Value;

  if ValidFile(FSks) then begin
    FScript.SQLScriptFileName := FSks;

    FScript.ValidateAll;

    FScript.ExecuteAll;

    Persistencehistory(FSks);
  end else
    raise Exception.Create('Arquivo não está no padrão recomentadado');
end;

procedure TBigQueryDatabase.Persistencehistory(Value: string);
var
  ds: TFDMemTable;
  Rank, Version : Integer;
begin
  ds := TFDMemTable.Create(nil);
  try
    ds.CopyDataSet(FQuery.SQL(FHistory.MigrationVersion).Open.DataSet,
      [coStructure, coRestart, coAppend]);

    FQuery
    .SQL(FHistory
          .INSTALLED_RANK(ds.FieldByName('RANK').AsInteger)
          .VERSION(ds.FieldByName('VERSION').AsInteger)
          .SCRIPT(Value)
          .CHECKSUM(ds.FieldByName('CHK').AsInteger)
          .DESCRIPTION(Value)
          .INSTALLED_BY('root')
          .EXECUTION_TIME(FScript.TotalJobDone)
          .SUCCESS(1)
          .InsertStatement)
    .ExecSQL;
  finally
    ds.DisposeOf;
  end;
end;

class function TBigQueryDatabase.New(Parent : iConfiguration) : iBigQueryDatabase;
begin
  Result := Self.Create(Parent);
end;

function TBigQueryDatabase.ValidFile(Value: String): Boolean;
var
  searchDir : TSearchRec;
  I : Integer;
begin
  Result := False;
  I := FindFirst(Value+'\*', faAnyFile, searchDir);
  while I = 0 do begin
    if ((searchDir.Name <> '.') and
          (searchDir.Name <> '..')) then begin
      if Copy(searchDir.Name,2,Pos('_',searchDir.Name)-2)<>
      FQuery
        .SQL(FHistory.MigrationVersion)
        .Open
        .DataSet.FieldByName('VERSION').AsString then begin
        Result := True;
        FSks := FSks+'\'+searchDir.Name;
      end;
    end;
    I := FindNext(searchDir);
  end;
end;

procedure TBigQueryDatabase.VerifyTable;
begin
  if FTable.Table(FParent.TableHistory).Table.IsEmpty then begin
    FQuery
      .SQL(FHistory.RawCreateScript)
      .ExecSQL;
    FQuery
      .SQL(FHistory.NewSchema)
      .ExecSQL;
  end;
end;

end.

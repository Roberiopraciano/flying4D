unit Flying4D.Database.Ignite.Thin.Database;

interface

uses
  Flying4D.Database.Ignite.Thin.Interfaces,
  System.Classes,
  Flying4D.Resources.Interfaces,
  Flying4D.Database.Interfaces,
  Flying4D.Database.BigQueryTable, System.SysUtils, Flying4D.Core.Interfaces;

type
  TIgniteThinDatabase = class(TInterfacedObject, iIgniteThinDatabase)
    private
      [weak]
      FParent : iConexao;
      FTable : iBigQueryTable;
      FValidExecution : Integer;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iIgniteThinDatabase;
      function MigrationVersion : String;
      function RawCreateScript : String;
      function SelectStatement : String;
      function InsertStatement : String;
  end;

const
  FLYING_HISTORY =
    'CREATE TABLE IF NOT EXISTS FLYING_HISTORY('+
    ' INSTALLED_RANK INT NOT NULL,'+
    ' VERSION VARCHAR(50),'+
    ' DESCRIPTION VARCHAR(200) NOT NULL,'+
    ' TYPE VARCHAR(20) NOT NULL,'+
    ' SCRIPT VARCHAR(1000) NOT NULL,'+
    ' CHECKSUM INT,'+
    ' INSTALLED_BY VARCHAR(100) NOT NULL,'+
    ' INSTALLED_ON TIMESTAMP NOT NULL,'+
    ' EXECUTION_TIME INT NOT NULL,'+
    ' SUCCESS INT,'+
    ' PRIMARY KEY (INSTALLED_RANK));';

  SELECT_STATEMENT =
    'SELECT '+
    ' INSTALLED_RANK,'+
    ' VERSION,'+
    ' DESCRIPTION,'+
    ' TYPE,'+
    ' SCRIPT,'+
    ' CHECKSUM,'+
    ' INSTALLED_BY,'+
    ' INSTALLED_ON,'+
    ' EXECUTION_TIME,'+
    ' SUCCESS'+
    ' FROM'+
    ' FLYING_HISTORY '+
    ' WHERE TYPE <> ''TABLE'''+
    ' AND INSTALLED_RANK > :INSTRANK'+
    ' ORDER BY INSTALLED_RANK:';

    INSERT_STATEMENT =
      'INSERT INTO FLYING_HISTORY ('+
      ' INSTALLED_RANK,'+
      ' VERSION,'+
      ' DESCRIPTION,'+
      ' TYPE,'+
      ' SCRIPT,'+
      ' CHECKSUM,'+
      ' INSTALLED_BY,'+
      ' INSTALLED_ON,'+
      ' EXECUTION_TIME,'+
      ' SUCCESS) VALUES ('+
      ' (:INSTALLED_RANK,'+
      ' :VERSION,'+
      ' :DESCRIPTION,'+
      ' :TYPE,'+
      ' :SCRIPT,'+
      ' :CHECKSUM,'+
      ' :INSTALLED_BY,'+
      ' CURRENT_TIMESTAMP,'+
      ' :EXECUTION_TIME,'+
      ' :SUCCESS);';

    VERSION =
      'SELECT MAX(VERSION)+1 AS VERSION, MAX(INSTALLED_RANK)+1 AS RANK, MAX(CHECKSUM) as CHK FROM FLYING_HISTORY;';

implementation

constructor TIgniteThinDatabase.Create(Parent : iConexao);
begin
  FParent := Parent;
  FTable := TBigQueryTable.New(FParent);
end;

destructor TIgniteThinDatabase.Destroy;
begin

  inherited;
end;

function TIgniteThinDatabase.InsertStatement: String;
begin
  Result := INSERT_STATEMENT;
end;

function TIgniteThinDatabase.MigrationVersion: String;
begin
  Result := VERSION;
end;

class function TIgniteThinDatabase.New (Parent : iConexao) : iIgniteThinDatabase;
begin
  Result := Self.Create(Parent);
end;

function TIgniteThinDatabase.RawCreateScript: String;
begin
  Result := FLYING_HISTORY;
end;

function TIgniteThinDatabase.SelectStatement: String;
begin
  Result := SELECT_STATEMENT;
end;

end.

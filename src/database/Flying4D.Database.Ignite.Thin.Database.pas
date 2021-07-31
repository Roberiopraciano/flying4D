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
      FParent : iConfiguration;
      FTable : iBigQueryTable;
      FValidExecution : Integer;
      FPk : Integer;
      FINSTALLED_RANK : Integer;
      FVERSION : Integer;
      FDESCRIPTION : String;
      FTYPES : String;
      FSCRIPT : String;
      FCHECKSUM : Integer;
      FINSTALLED_BY : String;
      FINSTALLED_ON : TDateTime;
      FEXECUTION_TIME : Integer;
      FSUCCESS : Integer;
    public
      constructor Create(Parent : iConfiguration);
      destructor Destroy; override;
      class function New(Parent : iConfiguration) : iIgniteThinDatabase;
      function MigrationVersion : String;
      function RawCreateScript : String;
      function SelectStatement : String;
      function InsertStatement : String;
      function NewSchema : String;
      function Pk(Value : Integer) : iIgniteThinDatabase; overload;
      function Pk : Integer; overload;
      function INSTALLED_RANK(Value : Integer) : iIgniteThinDatabase; overload;
      function INSTALLED_RANK : Integer; overload;
      function VERSION(Value : Integer)  : iIgniteThinDatabase; overload;
      function VERSION : Integer; overload;
      function DESCRIPTION(Value : String) : iIgniteThinDatabase; overload;
      function DESCRIPTION : String; overload;
      function TYPES(Value : String) : iIgniteThinDatabase; overload;
      function TYPES : String; overload;
      function SCRIPT(Value : String)  : iIgniteThinDatabase; overload;
      function SCRIPT : String; overload;
      function CHECKSUM(Value : Integer) : iIgniteThinDatabase; overload;
      function CHECKSUM : Integer; overload;
      function INSTALLED_BY(Value : String)  : iIgniteThinDatabase; overload;
      function INSTALLED_BY : String; overload;
      function INSTALLED_ON(Value : TDateTime) : iIgniteThinDatabase; overload;
      function INSTALLED_ON : TDateTime; overload;
      function EXECUTION_TIME(Value : Integer)  : iIgniteThinDatabase; overload;
      function EXECUTION_TIME : Integer; overload;
      function SUCCESS(Value : Integer) : iIgniteThinDatabase; overload;
      function SUCCESS : Integer; overload;
  end;

implementation

function TIgniteThinDatabase.CHECKSUM: Integer;
begin
  Result := FCHECKSUM;
end;

function TIgniteThinDatabase.CHECKSUM(Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FCHECKSUM := Random(Value);
end;

constructor TIgniteThinDatabase.Create(Parent : iConfiguration);
begin
  FParent := Parent;
  FTable := TBigQueryTable.New(FParent.Connect);

  if FParent.TableHistory.IsEmpty then
    FParent.TableHistory('FLYING_HISTORY');
end;

function TIgniteThinDatabase.DESCRIPTION(Value: String): iIgniteThinDatabase;
begin
  Result := Self;
  FDESCRIPTION := Copy(Value,Pos('_',Value)+2,Pos('.',Value)-1);
end;

function TIgniteThinDatabase.DESCRIPTION: String;
begin
  Result := FDESCRIPTION;
end;

destructor TIgniteThinDatabase.Destroy;
begin

  inherited;
end;

function TIgniteThinDatabase.EXECUTION_TIME: Integer;
begin
  Result := FEXECUTION_TIME;
end;

function TIgniteThinDatabase.EXECUTION_TIME(
  Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FEXECUTION_TIME := Value;
end;

function TIgniteThinDatabase.InsertStatement: String;
begin
  Result :=
    'INSERT INTO '+FParent.TableHistory+' ('+
    ' INSTALLED_RANK,'+
    ' VERSION,'+
    ' DESCRIPTION,'+
    ' TYPES,'+
    ' SCRIPT,'+
    ' CHECKSUM,'+
    ' INSTALLED_BY,'+
    ' INSTALLED_ON,'+
    ' EXECUTION_TIME,'+
    ' SUCCESS) VALUES ('+FINSTALLED_RANK.ToString+','+
    VERSION.ToString+','+
    QuotedStr(FDESCRIPTION)+','+
    QuotedStr(FTYPES)+','+
    QuotedStr(FSCRIPT)+','+
    FCHECKSUM.ToString+','+
    QuotedStr(FINSTALLED_BY)+','+
    ' CURRENT_TIMESTAMP,'+
    FEXECUTION_TIME.ToString+','+
    FSUCCESS.ToString+');';
end;

function TIgniteThinDatabase.INSTALLED_BY(Value: String): iIgniteThinDatabase;
begin
  Result := Self;
  FINSTALLED_BY := Value;
end;

function TIgniteThinDatabase.INSTALLED_BY: String;
begin
  Result := FINSTALLED_BY;
end;

function TIgniteThinDatabase.INSTALLED_ON(
  Value: TDateTime): iIgniteThinDatabase;
begin
  Result := Self;
  FINSTALLED_ON := Value;
end;

function TIgniteThinDatabase.INSTALLED_ON: TDateTime;
begin
  Result := FINSTALLED_ON;
end;

function TIgniteThinDatabase.INSTALLED_RANK(
  Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FINSTALLED_RANK := Value+1;
end;

function TIgniteThinDatabase.INSTALLED_RANK: Integer;
begin
  Result := FINSTALLED_RANK;
end;

function TIgniteThinDatabase.MigrationVersion: String;
begin
  Result :=
    'SELECT MAX(VERSION) AS VERSION,'+
    ' MAX(INSTALLED_RANK) AS RANK,'+
    ' MAX(CHECKSUM) as CHK FROM '+FParent.TableHistory+';';;
end;

class function TIgniteThinDatabase.New (Parent : iConfiguration) : iIgniteThinDatabase;
begin
  Result := Self.Create(Parent);
end;

function TIgniteThinDatabase.NewSchema: String;
begin
  Result :=
    'INSERT INTO '+FParent.TableHistory+' ('+
    ' INSTALLED_RANK,'+
    ' VERSION,'+
    ' DESCRIPTION,'+
    ' TYPES,'+
    ' SCRIPT,'+
    ' CHECKSUM,'+
    ' INSTALLED_BY,'+
    ' INSTALLED_ON,'+
    ' EXECUTION_TIME,'+
    ' SUCCESS) VALUES ('+
    ' 0,'+
    ' 0,'+
    ' '+QuotedStr('<<Flying New Schema>>')+','+
    ' '+QuotedStr('New Create')+','+
    ' '+QuotedStr('New Create')+','+
    ' 0,'+
    ' '+QuotedStr('root')+','+
    ' '+QuotedStr(DateToStr(Now))+','+
    ' 0,'+
    ' 0)';
end;

function TIgniteThinDatabase.Pk: Integer;
begin
  Result := FPk;
end;

function TIgniteThinDatabase.Pk(Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FPk := Value.Size+1;
end;

function TIgniteThinDatabase.RawCreateScript: String;
begin
  Result :=
    'CREATE TABLE IF NOT EXISTS '+FParent.TableHistory+'('+
    ' INSTALLED_RANK INT NOT NULL,'+
    ' VERSION VARCHAR(50),'+
    ' DESCRIPTION VARCHAR(200) NOT NULL,'+
    ' TYPES VARCHAR(20) NOT NULL,'+
    ' SCRIPT VARCHAR(1000) NOT NULL,'+
    ' CHECKSUM INT,'+
    ' INSTALLED_BY VARCHAR(100) NOT NULL,'+
    ' INSTALLED_ON TIMESTAMP NOT NULL,'+
    ' EXECUTION_TIME INT NOT NULL,'+
    ' SUCCESS INT,'+
    ' PRIMARY KEY (INSTALLED_RANK));';
end;

function TIgniteThinDatabase.SCRIPT(Value: String): iIgniteThinDatabase;
begin
  Result := Self;
  FSCRIPT := Value;
end;

function TIgniteThinDatabase.SCRIPT: String;
begin
  Result := FSCRIPT;
end;

function TIgniteThinDatabase.SelectStatement: String;
begin
  Result :=
    'SELECT '+
    ' INSTALLED_RANK,'+
    ' VERSION,'+
    ' DESCRIPTION,'+
    ' TYPES,'+
    ' SCRIPT,'+
    ' CHECKSUM,'+
    ' INSTALLED_BY,'+
    ' INSTALLED_ON,'+
    ' EXECUTION_TIME,'+
    ' SUCCESS'+
    ' FROM '+
    FParent.TableHistory+
    ' WHERE TYPE <> ''TABLE'''+
    ' AND INSTALLED_RANK > '+FINSTALLED_RANK.ToString+
    ' ORDER BY INSTALLED_RANK;';
end;

function TIgniteThinDatabase.SUCCESS: Integer;
begin
  Result := FSUCCESS;
end;


function TIgniteThinDatabase.SUCCESS(Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FSUCCESS := Value;
end;


function TIgniteThinDatabase.TYPES: String;
begin
  Result := FTYPES;
end;


function TIgniteThinDatabase.TYPES(Value: String): iIgniteThinDatabase;
begin
  Result := Self;
  FTYPES := VAlue;
end;


function TIgniteThinDatabase.VERSION: Integer;
begin
  Result := FVERSION;
end;


function TIgniteThinDatabase.VERSION(Value: Integer): iIgniteThinDatabase;
begin
  Result := Self;
  FVERSION := Value+1;
end;

end.



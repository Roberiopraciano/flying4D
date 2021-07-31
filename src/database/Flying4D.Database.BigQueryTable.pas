unit Flying4D.Database.BigQueryTable;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.DatS,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.Error,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Flying4D.Database.Interfaces,
  Flying4D.Resources.Interfaces,
  System.SysUtils,
  Flying4D.Core.Interfaces;

type
  TBigQueryTable = class(TInterfacedObject, iBigQueryTable)
    private
      [weak]
      FParent : iConexao;
      FTables : TFDMetaInfoQuery;
      FFields : TFDMetaInfoQuery;
      FTable : String;
      FField : String;
      FFIeldType : String;
      procedure SetOptions(MetaInfo : TFDMetaInfoQuery);
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iBigQueryTable;
      function Table(Value : String) : iBigQueryTable; overload;
      function Table : String; overload;
      function Field(Value : String) : iBigQueryTable; overload;
      function Field : String; overload;
      function FieldType(Value : String) : iBigQueryTable; overload;
      function FieldType : String; overload;
  end;

implementation

function TBigQueryTable.Field: String;
begin
  Result := FField;
end;

function TBigQueryTable.Field(Value: String): iBigQueryTable;
begin
  Result := Self;
  while not FFields.Eof do begin
    if UpperCase(Value) = UpperCase(FTables.FieldByName('COLUMN_NAME').AsString) then
      FField := value;
    FFields.Next;
  end;
end;

function TBigQueryTable.FieldType(Value: String): iBigQueryTable;
begin
  Result := Self;
  while not FFields.Eof do begin
    if UpperCase(Value) = UpperCase(FFields.FieldByName('COLUMN_TYPENAME').AsString) then
      FFIeldType := VAlue;
    FFields.Next;
  end;
end;

function TBigQueryTable.FieldType: String;
begin
  Result := FFIeldType;
end;

constructor TBigQueryTable.Create(Parent : iConexao);
begin
  FParent := Parent;
  FTables := TFDMetaInfoQuery.Create(nil);
  FFields := TFDMetaInfoQuery.Create(nil);
  FTables.Connection := FParent.Connection;
  FFields.Connection := FParent.Connection;
  FTables.MetaInfoKind := mkTables;
  FFields.MetaInfoKind := mkTableFields;
  FTables.Close;
  SetOptions(FTables);
  FFields.Close;
  SetOptions(FFields);
  FTables.Open;
end;

destructor TBigQueryTable.Destroy;
begin
  FTables.DisposeOf;
  FFields.DisposeOf;
  inherited;
end;

class function TBigQueryTable.New(Parent : iConexao) : iBigQueryTable;
begin
  Result := Self.Create(Parent);
end;

procedure TBigQueryTable.SetOptions(MetaInfo: TFDMetaInfoQuery);
var
  os: TFDPhysObjectScopes;
  tk: TFDPhysTableKinds;
begin
  os := [];
  Include(os, osMy);
  tk := [];
  Include(tk, tkTable);
  FTables.ObjectScopes := os;
  FTables.TableKinds := tk;
end;

function TBigQueryTable.Table(Value: String): iBigQueryTable;
begin
  Result := Self;
  while not FTables.Eof do begin
    if UpperCase(Value) = UpperCase(FTables.FieldByName('TABLE_NAME').AsString) then
      FTable := Value;
    FTables.Next;
  end;
end;

function TBigQueryTable.Table: String;
begin
  Result := FTable;
end;

end.

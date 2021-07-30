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
  Flying4D.Resources.Interfaces, System.SysUtils, Flying4D.Core.Interfaces;

type
  TBigQueryTable = class(TInterfacedObject, iBigQueryTable)
    private
      [weak]
      FParent : iConexao;
      FTable : TFDMetaInfoQuery;
      FFields : TFDMetaInfoQuery;
      procedure SetOptions(MetaInfo : TFDMetaInfoQuery);
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iBigQueryTable;
      function Table : String;
      function Field : String;
      function FieldType : String;
  end;

implementation

function TBigQueryTable.Field: String;
begin
  Result := FFields.FieldByName('COLUMN_NAME').AsString;
end;

function TBigQueryTable.FieldType: String;
begin
  Result := FFields.FieldByName('COLUMN_TYPENAME').AsString;
end;

constructor TBigQueryTable.Create(Parent : iConexao);
begin
  FParent := Parent;
  FTable := TFDMetaInfoQuery.Create(nil);
  FFields := TFDMetaInfoQuery.Create(nil);

  FTable.Connection := FParent.Connection;
  FFields.Connection := FParent.Connection;

  FTable.MetaInfoKind := mkTables;
  FFields.MetaInfoKind := mkTableFields;

  FTable.Close;
  SetOptions(FTable);
  FFields.Close;
  SetOptions(FFields);

  FTable.Open;
end;

destructor TBigQueryTable.Destroy;
begin
  FTable.DisposeOf;
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

  FTable.ObjectScopes := os;
  FTable.TableKinds := tk;
end;

function TBigQueryTable.Table: String;
begin
  Result := FTable.FieldByName('TABLE_NAME').AsString;
end;

end.

unit Flying4D.Database.Query;

interface

uses
  Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Firedac.Phys.SQLite,
  Firedac.Phys.SQLiteDef,
  Firedac.Stan.ExprFuncs,
  Firedac.Phys.SQLiteWrapper.Stat,
  Firedac.VCLUI.Wait,
  Firedac.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Data.DB,
  Flying4D.Database.Interfaces,
  Flying4D.Resources.Interfaces;

type
  TQuery = class(TInterfacedObject, iQuery)
    private
      [weak]
      FParent : iConexao;
      FQuery : TFDQuery;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iQuery;
      function Params(Param : String; Value : Variant) : iQuery;
      function ExecSQL : iQuery;
      function Open : iQuery;
      function SQL(Value : String) : iQuery;
      function DataSet : TDataSet;
  end;

implementation

constructor TQuery.Create(Parent : iConexao);
begin
  FParent := Parent;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FParent.Connection;
end;

function TQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TQuery.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

function TQuery.ExecSQL: iQuery;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

class function TQuery.New (Parent : iConexao) : iQuery;
begin
  Result := Self.Create(Parent);
end;

function TQuery.Open: iQuery;
begin
  Result := Self;
  FQuery.Open;
end;

function TQuery.Params(Param: String; Value: Variant): iQuery;
begin
  Result := Self;
  FQuery.ParamByName(Param).Value := Value;
end;

function TQuery.SQL(Value: String): iQuery;
begin
  Result := Self;
  FQuery.SQL.Add(Value);
end;

end.

unit Flying4D.Resources.Conexao;

interface

uses
  Flying4D.Resources.Interfaces,
  Flying4D.Resources.Parameter,
  SysUtils,
  FireDAC.Comp.Client, Flying4D.Core.Interfaces;

type
  TConexao = class(TInterfacedObject, iConexao)
    private
      [weak]
      FParent : iConfiguration;
      FConexao : TFDConnection;
    public
      constructor Create(Parent : iConfiguration);
      destructor Destroy; override;
      class function New(Parent : iConfiguration) : iConexao;
      function Connection : TFDConnection;
  end;

implementation

function TConexao.Connection: TFDConnection;
var
  I: Integer;
begin
  FConexao.Params.DriverID := FParent.Driver;
  FConexao.Params.Database := FParent.DataBase;
  FConexao.Params.UserName := FParent.UserName;
  FConexao.Params.Password := FParent.Password;

  for I := 0 to Pred(FParent.Params.Count) do
    FConexao.Params.Add(FParent.Params[I]);

  FConexao.Connected;

  if not Assigned(FParent.Connection) then begin
    Result := FConexao;
    FParent.Connection(FConexao);
  end else
    Result := FParent.Connection;
end;

constructor TConexao.Create(Parent : iConfiguration);
begin
  FParent := Parent;
  FConexao := TFDConnection.Create(nil);
end;

destructor TConexao.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

class function TConexao.New(Parent : iConfiguration) : iConexao;
begin
  Result := Self.Create(Parent);
end;

end.

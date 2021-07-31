unit Flying4D.Core.Configuration;

interface

uses
  Flying4D.Core.Interfaces,
  System.Generics.Collections,
  System.SysUtils,
  FireDAC.Comp.Client,
  Flying4D.Database.Interfaces,
  Flying4D.Database.BigQueryDatabase,
  Flying4D.Resources.Interfaces,
  Flying4D.Resources.Conexao;

type
  TConfiguration = class(TInterfacedObject, iConfiguration)
    private
      FScript : iBigQueryDatabase;
      FConexao : iConexao;
      FDriver : String;
      FDataBase : String;
      FUserName : String;
      FPassword : String;
      FParams : TList<String>;
      FLocationScript : String;
      FLocationLog : String;
      FTable : String;
      FConnection : TFDConnection;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConfiguration;
      function Connection(Value : TFDConnection) : iConfiguration; overload;
      function Connection : TFDConnection; overload;
      function Connect : iConexao;
      function Driver(Value : String) : iConfiguration; overload;
      function Driver : String; overload;
      function DataBase(Value : String) : iConfiguration; overload;
      function DataBase : String; overload;
      function UserName(Value : String) : iConfiguration; overload;
      function UserName : String; overload;
      function Password(Value : String) : iConfiguration; overload;
      function Password : String; overload;
      function Params(Value : String) : iConfiguration; overload;
      function Params : TList<String>; overload;
      function LocationScript(Value : String) : iConfiguration; overload;
      function LocationScript : String; overload;
      function LocationLog(Value : String) : iConfiguration; overload;
      function LocationLog : String; overload;
      function TableHistory(Value : String) : iConfiguration; overload;
      function TableHistory : String; overload;
      function Verify : iConfiguration;
  end;

implementation

function TConfiguration.LocationLog: String;
begin
  if FLocationLog.IsEmpty then begin
    FLocationLog := '/Log';
    if not DirectoryExists(ExtractFileDir(GetCurrentDir)+FLocationLog) then
      ForceDirectories(ExtractFileDir(GetCurrentDir)+FLocationLog);
  end;

  Result := FLocationLog;
end;

function TConfiguration.LocationLog(Value: String): iConfiguration;
begin
  Result := Self;

  if Value.IsEmpty then
    Value := ExtractFileDir(GetCurrentDir) + FLocationLog;

  FLocationLog := Value;
end;

function TConfiguration.LocationScript(Value: String): iConfiguration;
begin
  Result := Self;

  if Value.IsEmpty then
    Value := ExtractFileDir(GetCurrentDir) + FLocationScript;

  FLocationScript := Value;
end;

function TConfiguration.LocationScript: String;
begin
  if FLocationScript.IsEmpty then begin
    FLocationScript := 'db';
    if not DirectoryExists(FLocationScript) then
      CreateDir(FLocationScript);
  end;
  Result := FLocationScript;
end;

function TConfiguration.Connection(Value: TFDConnection): iConfiguration;
begin
  Result := Self;
  FConnection := Value;
end;

function TConfiguration.Connect: iConexao;
begin
  Result := FConexao;
end;

function TConfiguration.Connection: TFDConnection;
begin
  Result := FConnection;
end;

constructor TConfiguration.Create;
begin
  FParams := TList<String>.Create;
  FConexao := TConexao.New(Self);
end;

function TConfiguration.DataBase(Value: String): iConfiguration;
begin
  Result := Self;
  FDataBase := Value;
end;

function TConfiguration.DataBase: String;
begin
  Result := FDataBase;
end;

destructor TConfiguration.Destroy;
begin
  FParams.DisposeOf;
  inherited;
end;

function TConfiguration.Driver(Value: String): iConfiguration;
begin
  Result := Self;
  FDriver := Value;
end;

function TConfiguration.Driver: String;
begin
  Result := FDriver;
end;

class function TConfiguration.New: iConfiguration;
begin
  Result := Self.Create;
end;

function TConfiguration.Params: TList<String>;
begin
  Result := FParams;
end;

function TConfiguration.Params(Value: String): iConfiguration;
begin
  Result := Self;
  FParams.Add(Value);
end;

function TConfiguration.Password(Value: String): iConfiguration;
begin
  Result := Self;
  FPassword := Value;
end;

function TConfiguration.Password: String;
begin
  Result := FPassword;
end;

function TConfiguration.TableHistory: String;
begin
  Result := FTable;
end;

function TConfiguration.TableHistory(Value: String): iConfiguration;
begin
  Result := Self;
  FTable := Value;
end;

function TConfiguration.UserName(Value: String): iConfiguration;
begin
  Result := Self;
  FUserName := Value;
end;

function TConfiguration.UserName: String;
begin
  Result := FUserName;
end;

function TConfiguration.Verify: iConfiguration;
begin
  FScript := TBigQueryDatabase
              .New(Self)
              .FileScript(Self.LocationScript);
end;

end.

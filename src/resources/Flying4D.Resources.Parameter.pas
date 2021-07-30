unit Flying4D.Resources.Parameter;

interface

uses
  System.Generics.Collections,
  Flying4D.Resources.Interfaces;

type
  TParameter<T : IInterface> = class(TInterfacedObject, iParameter<T>)
    private
      [weak]
      FParent : iConexao;
      FDriverID : String;
      FDataBase : String;
      FUserName : String;
      FPassword : String;
      FPort : String;
      FParams : TList<String>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iParameter<T>;
      function DriverID(Value : String) : iParameter<T>; overload;
      function DriverID : String; overload;
      function DataBase(Value : String) : iParameter<T>; overload;
      function DataBase : String; overload;
      function UserName(Value : String) : iParameter<T>; overload;
      function UserName : String; overload;
      function Password(Value : String) : iParameter<T>; overload;
      function Password : String; overload;
      function Params(Value : String) : iParameter<T>; overload;
      function Params : TList<String>; overload;
      function &End : T;
  end;

implementation

function TParameter<T>.&End: T;
begin
  Result := FParent;
end;

constructor TParameter<T>.Create;
begin
  FParams := TList<String>.Create;
end;

function TParameter<T>.DataBase(Value: String): iParameter<T>;
begin
  Result := Self;
  FDataBase := Value;
end;

function TParameter<T>.DataBase: String;
begin
  Result := FDataBase;
end;

destructor TParameter<T>.Destroy;
begin
  FParams.DisposeOf;
  inherited;
end;

function TParameter<T>.DriverID: String;
begin
  Result := FDriverID;
end;

function TParameter<T>.DriverID(Value: String): iParameter<T>;
begin
  Result := Self;
  FDriverID := Value;
end;

class function TParameter<T>.New : iParameter<T>;
begin
  Result := Self.Create;
end;

function TParameter<T>.Params(Value: String): iParameter<T>;
begin
  Result := Self;
  FParams.Add(Value);
end;

function TParameter<T>.Password(Value: String): iParameter<T>;
begin
  Result := Self;
  FPassword := Value;
end;

function TParameter<T>.Params: TList<String>;
begin
  Result := FParams;
end;

function TParameter<T>.Password: String;
begin
  Result := FPassword;
end;

function TParameter<T>.UserName(Value: String): iParameter<T>;
begin
  Result := Self;
  FUserName := Value;
end;

function TParameter<T>.UserName: String;
begin
  Result := FUserName;
end;

end.

unit Flying4D.Resources.Interfaces;

interface

uses
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  iParameter<T> = interface;

  iConexao = interface
    function Connection : TFDConnection;
  end;

  iParameter<T> = interface
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

end.

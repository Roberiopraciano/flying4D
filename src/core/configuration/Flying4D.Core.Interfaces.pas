unit Flying4D.Core.Interfaces;

interface

uses
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Flying4D.Resources.Interfaces;

type
  iConfiguration = interface
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

end.

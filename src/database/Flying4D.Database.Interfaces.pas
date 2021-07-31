unit Flying4D.Database.Interfaces;

interface

uses
  Data.DB;

type
  iBigQueryDatabase = interface
    function FileScript(Value : String) : iBigQueryDatabase;
  end;

  iBigQueryTable = interface
    function Table(Value : String) : iBigQueryTable; overload;
    function Table : String; overload;
    function Field(Value : String) : iBigQueryTable; overload;
    function Field : String; overload;
    function FieldType(Value : String) : iBigQueryTable; overload;
    function FieldType : String; overload;
  end;

  iQuery = interface
    function Params(Param : String; Value : Variant) : iQuery;
    function ExecSQL : iQuery;
    function Open : iQuery;
    function SQL(Value : String) : iQuery;
    function DataSet : TDataSet;
  end;

implementation

end.

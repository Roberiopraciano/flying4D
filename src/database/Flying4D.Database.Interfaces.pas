unit Flying4D.Database.Interfaces;

interface

uses
  Data.DB;

type
  iBigQueryDatabase = interface
    function FileScript(Value : String) : iBigQueryDatabase;
  end;

  iBigQueryTable = interface
    function Table : String;
    function Field : String;
    function FieldType : String;
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

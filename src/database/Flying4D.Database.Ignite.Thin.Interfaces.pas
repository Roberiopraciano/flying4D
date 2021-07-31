unit Flying4D.Database.Ignite.Thin.Interfaces;

interface

type
  iIgniteThinDatabase = interface
    function MigrationVersion : String;
    function RawCreateScript : String;
    function SelectStatement : String;
    function InsertStatement : String;
    function NewSchema : String;
    function Pk(Value : Integer) : iIgniteThinDatabase; overload;
    function Pk : Integer; overload;
    function INSTALLED_RANK(Value : Integer) : iIgniteThinDatabase; overload;
    function INSTALLED_RANK : Integer; overload;
    function VERSION(Value : Integer)  : iIgniteThinDatabase; overload;
    function VERSION : Integer; overload;
    function DESCRIPTION(Value : String) : iIgniteThinDatabase; overload;
    function DESCRIPTION : String; overload;
    function TYPES(Value : String) : iIgniteThinDatabase; overload;
    function TYPES : String; overload;
    function SCRIPT(Value : String)  : iIgniteThinDatabase; overload;
    function SCRIPT : String; overload;
    function CHECKSUM(Value : Integer) : iIgniteThinDatabase; overload;
    function CHECKSUM : Integer; overload;
    function INSTALLED_BY(Value : String)  : iIgniteThinDatabase; overload;
    function INSTALLED_BY : String; overload;
    function INSTALLED_ON(Value : TDateTime) : iIgniteThinDatabase; overload;
    function INSTALLED_ON : TDateTime; overload;
    function EXECUTION_TIME(Value : Integer)  : iIgniteThinDatabase; overload;
    function EXECUTION_TIME : Integer; overload;
    function SUCCESS(Value : Integer) : iIgniteThinDatabase; overload;
    function SUCCESS : Integer; overload;
  end;

implementation

end.

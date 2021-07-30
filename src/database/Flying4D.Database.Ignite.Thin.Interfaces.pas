unit Flying4D.Database.Ignite.Thin.Interfaces;

interface

type
  iIgniteThinDatabase = interface
    function MigrationVersion : String;
    function RawCreateScript : String;
    function SelectStatement : String;
    function InsertStatement : String;
  end;

implementation

end.

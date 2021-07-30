unit Flying4D;

interface

uses
  Flying4D.Core.Interfaces,
  Flying4D.Core.Configuration;

type
  iFlying4D = interface
    function Configuration : iConfiguration;
  end;

  TFlying4D = class(TInterfacedObject, iFlying4D)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFlying4D;
      function Configuration : iConfiguration;
  end;

implementation

function TFlying4D.Configuration: iConfiguration;
begin
  Result := TConfiguration.New;
end;

constructor TFlying4D.Create;
begin

end;

destructor TFlying4D.Destroy;
begin

  inherited;
end;

class function TFlying4D.New : iFlying4D;
begin
  Result := Self.Create;
end;

end.

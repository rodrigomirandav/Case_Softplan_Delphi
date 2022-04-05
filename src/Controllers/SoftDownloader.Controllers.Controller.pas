unit SoftDownloader.Controllers.Controller;

interface

uses
  SoftDownloader.Controllers.Interfaces,
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Models.Entity.Factory;

Type
    TController = class(TInterfacedObject, iController)
    private
        FModelEntities : iModelsEntityFactory;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iController;

        function Entities : iModelsEntityFactory;
    end;

implementation

{ TController }

constructor TController.Create;
begin
  FModelEntities := TModelsEntityFactory.New;
end;

destructor TController.Destroy;
begin
    inherited;
end;

function TController.Entities: iModelsEntityFactory;
begin
  Result := FModelEntities;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

end.

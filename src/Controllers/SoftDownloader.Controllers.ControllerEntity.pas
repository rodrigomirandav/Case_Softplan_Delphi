unit SoftDownloader.Controllers.ControllerEntity;

interface

uses
  SoftDownloader.Controllers.Interfaces,
  SoftDownloader.Models.Entity.Interfaces;

Type
    TControllerEntity = class(TInterfacedObject, iControllerEntity)
    private
        FModelEntities : iModelsEntityFactory;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iControllerEntity;

        function Entities : iModelsEntityFactory;
    end;

implementation

uses
  SoftDownloader.Models.Entity.Factory;

{ TController }

constructor TControllerEntity.Create;
begin
  FModelEntities := TModelsEntityFactory.New;
end;

destructor TControllerEntity.Destroy;
begin
    inherited;
end;

function TControllerEntity.Entities: iModelsEntityFactory;
begin
  Result := FModelEntities;
end;

class function TControllerEntity.New: iControllerEntity;
begin
  Result := Self.Create;
end;

end.

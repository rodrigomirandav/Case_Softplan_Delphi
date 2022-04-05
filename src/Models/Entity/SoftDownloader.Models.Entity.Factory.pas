unit SoftDownloader.Models.Entity.Factory;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  TModelsEntityFactory = class(TInterfacedObject, iModelsEntityFactory)
    private
      FLogDownload : iModelsEntity;
    public
      constructor create;
      destructor destroy; override;
      class function New : iModelsEntityFactory;

      function LogDownload : iModelsEntity;
  end;

implementation

uses
  SoftDownloader.Models.Entity.LogDownload;

{ TModelsEntityFactory }

constructor TModelsEntityFactory.create;
begin

end;

destructor TModelsEntityFactory.destroy;
begin

  inherited;
end;

function TModelsEntityFactory.LogDownload: iModelsEntity;
begin
  if not Assigned(FLogDownload) then
    FLogDownload := TModelsEntityLogDownload.New;
  Result := FLogDownload;
end;

class function TModelsEntityFactory.New: iModelsEntityFactory;
begin
  Result := Self.Create;
end;

end.

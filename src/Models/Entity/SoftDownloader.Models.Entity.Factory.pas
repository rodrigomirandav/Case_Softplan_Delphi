unit SoftDownloader.Models.Entity.Factory;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  TModelsEntityFactory = class(TInterfacedObject, iModelsEntityFactory)
    private
      FLogDownload : iModelsEntityDAODB;
    public
      constructor create;
      destructor Destroy; override;
      class function New : iModelsEntityFactory;

      function LogDownload : iModelsEntityDAODB;
  end;

implementation

uses
  SoftDownloader.Models.Entity.DAO.LogDownload;

{ TModelsEntityFactory }

constructor TModelsEntityFactory.create;
begin

end;

destructor TModelsEntityFactory.Destroy;
begin

  inherited;
end;

function TModelsEntityFactory.LogDownload: iModelsEntityDAODB;
begin
  if not Assigned(FLogDownload) then
    FLogDownload := TModelsEntityDAOLogDownload.New;
  Result := FLogDownload;
end;

class function TModelsEntityFactory.New: iModelsEntityFactory;
begin
  Result := Self.Create;
end;

end.

unit SoftDownloader.Models.Entity.Factory;

interface

uses
  SoftDownloader.Models.Entity.DAO.Interfaces;

type

  TModelsEntityDAOFactory = class(TInterfacedObject, iModelsEntityDAOFactory)
    private
      FLogDownload : iModelsEntityDAODB;
    public
      constructor create;
      destructor destroy; override;
      class function New : iModelsEntityDAOFactory;

      function LogDownload : iModelsEntityDAODB;
  end;

implementation

uses
  SoftDownloader.Models.Entity.DAO.LogDownload;

{ TModelsEntityFactory }

constructor TModelsEntityDAOFactory.create;
begin

end;

destructor TModelsEntityDAOFactory.destroy;
begin

  inherited;
end;

function TModelsEntityDAOFactory.LogDownload: iModelsEntityDAODB;
begin
  if not Assigned(FLogDownload) then
    FLogDownload := TModelsEntityDAOLogDownload.New;
  Result := FLogDownload;
end;

class function TModelsEntityDAOFactory.New: iModelsEntityDAOFactory;
begin
  Result := Self.Create;
end;

end.

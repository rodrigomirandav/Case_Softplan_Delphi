unit SoftDownloader.Models.Entity.LogDownload;

interface

uses
  SoftDownloader.Models.Entity.Interfaces, Data.DB;

type

  TModelsEntityLogDownload = class(TInterfacedObject, iModelsEntity)
    private
      //FQuery : imode
    public
      constructor create;
      destructor destroy; override;
      class function New : iModelsEntity;
      function DataSet ( aValue : TDataSource ) : iModelsEntity;
      procedure Open;
  end;

implementation

{ TModelsEntityLogDownload }

constructor TModelsEntityLogDownload.create;
begin

end;

function TModelsEntityLogDownload.DataSet(aValue: TDataSource): iModelsEntity;
begin

end;

destructor TModelsEntityLogDownload.destroy;
begin

  inherited;
end;

class function TModelsEntityLogDownload.New: iModelsEntity;
begin

end;

procedure TModelsEntityLogDownload.Open;
begin

end;

end.

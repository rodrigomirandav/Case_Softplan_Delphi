unit SoftDownloader.Models.Entity.LogDownload;

interface

uses
  Data.DB,
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Models.DBConnection.Interfaces;

type

  TModelsEntityLogDownload = class(TInterfacedObject, iModelsEntity)
    private
      FQuery : iDBQuery;
    public
      constructor create;
      destructor destroy; override;
      class function New : iModelsEntity;
      function DataSet ( aValue : TDataSource ) : iModelsEntity;
      procedure Open;
  end;

implementation

uses
  SoftDownloader.Models.DBConnection.ConnectionFactory;

{ TModelsEntityLogDownload }

constructor TModelsEntityLogDownload.create;
begin
  FQuery := TConnectionFactory.New.Query;
end;

function TModelsEntityLogDownload.DataSet(aValue: TDataSource): iModelsEntity;
begin
  Result := Self;
  aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelsEntityLogDownload.destroy;
begin

  inherited;
end;

class function TModelsEntityLogDownload.New: iModelsEntity;
begin
  Result := Self.Create;
end;

procedure TModelsEntityLogDownload.Open;
begin
  FQuery.Open('SELECT * FROM logdownload');
end;

end.

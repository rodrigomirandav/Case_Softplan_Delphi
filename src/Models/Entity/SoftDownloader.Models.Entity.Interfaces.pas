unit SoftDownloader.Models.Entity.Interfaces;

interface

uses
  Data.DB;

type

  iModelsEntity = interface
    ['{4752E709-16CF-4277-BC8E-0AE7A0BF4348}']
    function DataSet ( aValue : TDataSource ) : iModelsEntity;
    procedure Open;
  end;

  iModelsEntityFactory = interface
    ['{01B7A93E-D8D4-4CCC-89D3-B5DAA93370BA}']
    function LogDownload : iModelsEntity;
  end;

implementation

end.

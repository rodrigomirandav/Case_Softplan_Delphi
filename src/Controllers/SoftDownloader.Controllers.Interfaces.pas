unit SoftDownloader.Controllers.Interfaces;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  iController = interface
    ['{3F43BF4C-6C07-4667-990D-0CB85626559A}']
    function Entities : iModelsEntityFactory;
  end;

implementation

end.

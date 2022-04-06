unit SoftDownloader.Models.Entity.Download;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  TDownload = class(TInterfacedObject, iModelsEntity)
    private
    public
      constructor create;
      destructor destroy; override;
      class function New : TDownload;
  end;

implementation

{ TDownload }

constructor TDownload.create;
begin

end;

destructor TDownload.destroy;
begin

  inherited;
end;

class function TDownload.New: TDownload;
begin
  Result := self.create;
end;

end.

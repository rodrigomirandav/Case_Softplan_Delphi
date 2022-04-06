unit SoftDownloader.Models.Entity.LogDownload;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  TLogDownload = class(TInterfacedObject, iModelsEntity)
    private
    FCodigo : string;
    FDataInicio : TDateTime;
    FDataFim : TDateTime;
    FURL: String;
    public
      constructor create;
      destructor Destroy; override;
      class function New : TLogDownload;
      property URL : String read FURL write FURL;
      property Codigo : String read FCodigo write FCodigo;
      property DataInicio : TDateTime read FDataInicio write FDataInicio;
      property DataFim : TDateTime read FDataFim write FDataFim;

      procedure SetDataFim;
      procedure SetDataInicio;
  end;

implementation

uses
  System.SysUtils;

{ TLogDownload }

constructor TLogDownload.create;
begin
  FDataInicio := Now;
end;

destructor TLogDownload.Destroy;
begin

  inherited;
end;

class function TLogDownload.New: TLogDownload;
begin
  Result := Self.create;
end;

procedure TLogDownload.SetDataFim;
begin
  FDataFim := Now;
end;

procedure TLogDownload.SetDataInicio;
begin
  FDataInicio := Now;
end;

end.

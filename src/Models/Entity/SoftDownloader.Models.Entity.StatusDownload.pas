unit SoftDownloader.Models.Entity.StatusDownload;

interface

uses
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Types.Status;

type

  TStatusDownload = class(TInterfacedObject, iModelsEntity)
    private
    FTotalSize: Int64;
    FStatus: TStatus;
    FActualSize: Int64;
    FMessageError: String;
    public
      constructor create;
      destructor Destroy; override;
      class function New : TStatusDownload;

      property Status : TStatus read FStatus write FStatus;
      property TotalSize : Int64 read FTotalSize write FTotalSize;
      property ActualSize : Int64 read FActualSize write FActualSize;
      property MessageError : String read FMessageError write FMessageError;
      procedure ResetStatus;
  end;

implementation

{ TStatusDownload }

constructor TStatusDownload.create;
begin
  ResetStatus;
end;

destructor TStatusDownload.Destroy;
begin

  inherited;
end;

class function TStatusDownload.New: TStatusDownload;
begin
  Result := Self.create;
end;

procedure TStatusDownload.ResetStatus;
begin
  Status := TStatus.notStarted;
  TotalSize := 0;
  ActualSize := 0;
  MessageError := '';
end;

end.

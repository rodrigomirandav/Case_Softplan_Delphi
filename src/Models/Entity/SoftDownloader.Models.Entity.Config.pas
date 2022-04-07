unit SoftDownloader.Models.Entity.Config;

interface

uses
  SoftDownloader.Models.Entity.Interfaces;

type

  TConfig = class(TInterfacedObject, iModelsEntity)
    private
    FDriverID: String;
    FDatabase: String;
    FPassword: String;
    FUserName: String;
    FDirBaseDownload: String;
    public
      constructor create;
      destructor Destroy; override;
      class function New : TConfig;

      property DriverID : String read FDriverID write FDriverID;
      property Database : String read FDatabase write FDatabase;
      property UserName  : String read FUserName  write FUserName;
      property Password  : String read FPassword  write FPassword;
      property DirBaseDownload  : String read FDirBaseDownload  write FDirBaseDownload;
  end;

implementation

{ TConfig }

constructor TConfig.create;
begin
  FDriverID := '';
  FDatabase := '';
  FPassword := '';
  FUserName := '';
end;

destructor TConfig.Destroy;
begin

  inherited;
end;

class function TConfig.New: TConfig;
begin
  Result := Self.create;
end;

end.

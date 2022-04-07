unit SoftDownloader.Models.HTTPConnection.HttpConnection;

interface

uses
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdSSLOpenSSL,
  System.StrUtils,
  UrlMon,
  SoftDownloader.Models.HTTPConnection.Interfaces,
  SoftDownloader.Controllers.Interfaces;

type

  THttpConnection = class(TInterfacedObject, iHTTPConnection)
    private
      [weak]
      FParent : iControllerDownload;
      FIdHttp : TIdHttp;
      FAuthSSL : TIdSSLIOHandlerSocketOpenSSL;
      FURL : String;
      FFileName : String;
    public
      constructor create(aParent : iControllerDownload);
      destructor Destroy; override;
      class function New(aParent : iControllerDownload): THttpConnection;
      function Connected : Boolean;
      procedure Disconnect;
      function SetURL(const aURL : String) : iHTTPConnection;
      procedure GetDownload;
      function SetFileName : iHTTPConnection;

      procedure Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
      procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode;  AWorkCountMax: Int64);
      procedure CreateAuthSSL;
      procedure CreateIdHttp;
  end;



implementation

uses
  System.Classes, System.SysUtils, System.Types, Vcl.Forms,
  SoftDownloader.Types.Status;

{ THttpConnection }

function THttpConnection.Connected: Boolean;
begin
  Result := FIdHttp.Connected;
end;

constructor THttpConnection.create(aParent : iControllerDownload);
begin
  FParent := aParent;
  CreateAuthSSL;
  CreateIdHttp;
end;

destructor THttpConnection.Destroy;
begin
  if FIdHttp.Connected then
    FIdHttp.Disconnect;

  FIdHttp.Free;
  FAuthSSL.Free;
  inherited;
end;

procedure THttpConnection.Disconnect;
begin
  if FIdHttp.Connected then
    FIdHttp.Disconnect;
end;

procedure THttpConnection.GetDownload;
var
  afileDownload : TStream;
  aFilePath : String;
begin
  afileDownload := TMemoryStream.Create;

  aFilePath := ExtractFilePath(Application.ExeName);

  if not DirectoryExists(aFilePath + 'download') then
    CreateDir(aFilePath + 'download');

  try
    try
      FIdHttp.Get(FURL, afileDownload);
      TMemoryStream(afileDownload).SaveToFile(aFilePath + 'download\' + FFileName);
    except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
  finally
    afileDownload.Free;
    Self.Disconnect;
  end;
end;

class function THttpConnection.New(aParent : iControllerDownload): THttpConnection;
begin
  Result := Self.create(aParent);
end;

function THttpConnection.SetFileName: iHTTPConnection;
Var
  aURLStringArray : TStringDynArray;
begin
  Result := Self;

  if FURL = '' then
    raise Exception.Create('A URL não foi informada.');

  aURLStringArray := SplitString(FURL, '/');
  FFileName := aURLStringArray[ Length(aURLStringArray) - 1];
end;

procedure THttpConnection.CreateIdHttp;
begin
  FIdHttp := TIdHttp.Create(nil);
  FIdHttp.IOHandler := FAuthSSL;
  FIdHttp.OnWorkBegin := WorkBegin;
  FIdHttp.OnWork := Work;
end;

procedure THttpConnection.CreateAuthSSL;
begin
  FAuthSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FAuthSSL.SSLOptions.Method := sslvSSLv23;
  FAuthSSL.SSLOptions.Mode := sslmUnassigned;
  FAuthSSL.SSLOptions.VerifyMode := [];
  FAuthSSL.SSLOptions.VerifyDepth := 0;
  FAuthSSL.MaxLineLength := MaxInt;
  FAuthSSL.RecvBufferSize := 1000;
  FAuthSSL.CheckForDisconnect(False, True);
end;

function THttpConnection.SetURL(const aURL: String): iHTTPConnection;
begin
  Result := Self;
  FURL := aURL;
end;

procedure THttpConnection.Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  FParent.SetStatusDownload(AWorkCount);
end;

procedure THttpConnection.WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  FParent.SetStatusDownload(0);
  FParent.SetSizeDownload(AWorkCountMax);
end;

end.

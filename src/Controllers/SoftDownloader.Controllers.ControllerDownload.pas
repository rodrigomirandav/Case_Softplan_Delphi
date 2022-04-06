unit SoftDownloader.Controllers.ControllerDownload;

interface

uses
  System.Threading,
  System.Classes,
  System.Generics.Collections,
  System.Net.URLClient,
  SoftDownloader.Controllers.Interfaces,
  SoftDownloader.Models.Entity.LogDownload,
  SoftDownloader.Models.Entity.StatusDownload,
  SoftDownloader.Types.Status,
  SoftDownloader.Models.HTTPConnection.HttpConnection,
  SoftDownloader.Models.HTTPConnection.Interfaces;

type
  TControllerDownload = class(TInterfacedObject, iControllerDownload, iObserved)
    private
      FTaskThreadDownload : TThread;

      FStatusDownload : TStatusDownload;
      FHttpConnection : THttpConnection;
      FLogDownload : TLogDownload;
      FURL : String;

      FObservers : TList<iObserver>;
    public
      constructor create(aObserver : iObserver = nil);
      destructor Destroy; override;
      class function New(aObserver : iObserver = nil) : TControllerDownload;

      function SetURL(const aURL : string) : iControllerDownload;
      function StartDownload : iControllerDownload;
      function AbortDownload : iControllerDownload;
      function SaveLogDownload : iControllerDownload;
      function ResetarStatusDownload : iControllerDownload;
      procedure OnStoppedTaskDownload(Sender: TObject);
      function DownloadNotStarted : Boolean;
      function SetSizeDownload(aTotalSize : Int64) : iControllerDownload;
      function SetStatusDownload(aActualSize : Int64) : iControllerDownload;
      function GetStatus: String;
      function GetURL: String;
      function GetHttpCon: iHTTPConnection;

      procedure AddObserver(const Observer: iObserver);
      procedure RemoveObserver(const Observer: iObserver);
      procedure Notify;
  end;






implementation

uses
  System.SysUtils, Vcl.ComCtrls, SoftDownloader.Controllers.ControllerEntity,
  SoftDownloader.Models.Entity.DAO.LogDownload,
  SoftDownloader.Controllers.ControllerDownloadThread;

{ TControllerDownload }

function TControllerDownload.AbortDownload: iControllerDownload;
begin
  Result := Self;

  Self
    .ResetarStatusDownload;

  if Assigned(FTaskThreadDownload) then
    FTaskThreadDownload.Terminate;

  Notify;
end;

procedure TControllerDownload.AddObserver(const Observer: iObserver);
begin
  if FObservers.IndexOf(Observer) = -1 then
    FObservers.Add(Observer);
end;

destructor TControllerDownload.Destroy;
begin
  if Assigned(FTaskThreadDownload) then
    FTaskThreadDownload.Terminate;

  FLogDownload.Free;
  FObservers.Free;
  FHttpConnection.Free;
  FStatusDownload.Free;

  inherited;
end;

function TControllerDownload.DownloadNotStarted: Boolean;
begin
  Result := (Self.FStatusDownload.Status = TStatus.notStarted);
end;

function TControllerDownload.GetHttpCon: iHTTPConnection;
begin
  Result := FHttpConnection;
end;

function TControllerDownload.GetStatus: String;
begin
  Result := Format('O percentual total do download é de %f%%.',
                    [Self.FStatusDownload.PercentualStatus]);
end;

function TControllerDownload.GetURL: String;
begin
  Result := FURL;
end;

constructor TControllerDownload.create(aObserver : iObserver = nil);
begin
  FLogDownload := TLogDownload.create;
  FStatusDownload := TStatusDownload.New;
  FObservers := TList<iObserver>.Create;
  FHttpConnection := THttpConnection.New(Self);

  if Assigned(aObserver) then
    AddObserver(aObserver);
end;

class function TControllerDownload.New(aObserver : iObserver = nil) : TControllerDownload;
begin
  Result := Self.create(aObserver);
end;

procedure TControllerDownload.Notify;
var
  lObserver: iObserver;
begin
  for lObserver  in FObservers do
    lObserver.OnNewOperation(Self.FStatusDownload);
end;

procedure TControllerDownload.RemoveObserver(const Observer: iObserver);
begin
  FObservers.Delete(FObservers.IndexOf(Observer));
end;


function TControllerDownload.ResetarStatusDownload: iControllerDownload;
begin
  Result := Self;
  FStatusDownload.ResetStatus;
  Notify;
end;

function TControllerDownload.SaveLogDownload: iControllerDownload;
begin
  FLogDownload.SetDataFim;
  FLogDownload.URL := FURL;

  TModelsEntityDAOLogDownload
    .New
    .Insert(FLogDownload)
end;

function TControllerDownload.SetSizeDownload(
  aTotalSize: Int64): iControllerDownload;
begin
  FStatusDownload.TotalSize := aTotalSize;
  FStatusDownload.Status := TStatus.inProgress;
  Notify;
end;

function TControllerDownload.SetStatusDownload(aActualSize : Int64) : iControllerDownload;
begin
  Result := Self;
  FStatusDownload.ActualSize := aActualSize;
  Notify;

  if FStatusDownload.Status = TStatus.Error then
    exit;

  if (FStatusDownload.TotalSize = aActualSize) then
  begin
    FStatusDownload.Status := TStatus.Completed;
    Notify;

    Self
      .SaveLogDownload;

    FStatusDownload.Status := TStatus.notStarted;
    Notify;
  end;
end;

function TControllerDownload.SetURL(const aURL: string): iControllerDownload;
begin
  Result := Self;

  try
    TURI.Create(aURL)
  except
    raise Exception.Create('A URL informada não é válida');
  end;

  FURL := aURL;
end;

function TControllerDownload.StartDownload: iControllerDownload;
begin
  Result := Self;

  FLogDownload.SetDataInicio;

  FTaskThreadDownload:= TThreadDownload.Create(self);
  FTaskThreadDownload.FreeOnTerminate := True;
  FTaskThreadDownload.OnTerminate := OnStoppedTaskDownload;
  FTaskThreadDownload.Start;
end;

procedure TControllerDownload.OnStoppedTaskDownload(Sender: TObject);
begin
  if not (Sender is TThread) then
    exit;

  if not Assigned(TThread(Sender).FatalException) then
    exit;

  FStatusDownload.Status := TStatus.Error;
  Notify;
end;

End.

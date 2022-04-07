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
  SoftDownloader.Models.HTTPConnection.Interfaces, IdHTTP;

type
  TControllerDownload = class(TInterfacedObject, iControllerDownload, iObserved)
    private
      FTaskThreadDownload : TThread;
      FStatusDownload : TStatusDownload;
      FURL : String;

      FDateDownloadStart : TDateTime;
      FTotalSizeFile : Int64;
      FActualSizeFile : Int64;

      FObservers : TList<iObserver>;
    public
      constructor create(aObserver : iObserver = nil);
      destructor Destroy; override;
      class function New(aObserver : iObserver = nil) : TControllerDownload;

      function SetURL(const aURL : string) : iControllerDownload;
      function StartDownload : iControllerDownload;
      function AbortDownload : iControllerDownload;
      function SaveLogDownload : iControllerDownload;
      procedure OnStoppedTaskDownload(Sender: TObject);
      function DownloadNotStarted : Boolean;
      function SetSizeDownload(aTotalSize : Int64) : iControllerDownload;
      function SetStatusDownload(aActualSize : Int64) : iControllerDownload;
      function GetStatus: String;
      function GetURL: String;
      function GetStatusDownload : TStatus;

      procedure AddObserver(const Observer: iObserver);
      procedure RemoveObserver(const Observer: iObserver);
      procedure Notify(aStatus: TStatusDownload);
  end;

  TThreadDownload = class(TThread)
    [weak]
    private
      FControllerDownload : TControllerDownload;
      FHTTP: iHTTPConnection;
      FTerminateThread : Boolean;
      FMSGException : string;
    public
      constructor Create(AController : TControllerDownload); reintroduce;

      destructor Destroy; override;
      procedure Execute; override;
      procedure RaiseExcept(aMSG: string);
      property TerminateThread : Boolean read FTerminateThread write FTerminateThread;
  end;

implementation

uses
  System.SysUtils, Vcl.ComCtrls, SoftDownloader.Controllers.ControllerEntity,
  SoftDownloader.Models.Entity.DAO.LogDownload;

{ TControllerDownload }

function TControllerDownload.AbortDownload: iControllerDownload;
begin
  Result := Self;

  if Assigned(FTaskThreadDownload) then
  begin
    FStatusDownload.Status := TStatus.Abort;
    TThreadDownload(FTaskThreadDownload).TerminateThread := True;
    FTaskThreadDownload.WaitFor;
    FTaskThreadDownload.Free;
  end;

  Notify(FStatusDownload);
end;

procedure TControllerDownload.AddObserver(const Observer: iObserver);
begin
  if FObservers.IndexOf(Observer) = -1 then
    FObservers.Add(Observer);
end;

destructor TControllerDownload.Destroy;
begin
  FStatusDownload.Free;
  FObservers.Free;

  if Assigned(FTaskThreadDownload) then
  begin
    TThreadDownload(FTaskThreadDownload).TerminateThread := True;
    FTaskThreadDownload.WaitFor;
    FTaskThreadDownload.Free;
  end;

  inherited;
end;

function TControllerDownload.DownloadNotStarted: Boolean;
begin
  Result := FStatusDownload.Status <> TStatus.inProgress;
end;

function TControllerDownload.GetStatus: String;
var
  aSizePercent : Double;
begin
  aSizePercent := FActualSizeFile / FTotalSizeFile * 100;

  Result := Format('O percentual total do download é de %f%%.',
                    [aSizePercent]);
end;

function TControllerDownload.GetStatusDownload: TStatus;
begin
  Result := FStatusDownload.Status;
end;

function TControllerDownload.GetURL: String;
begin
  Result := FURL;
end;

constructor TControllerDownload.create(aObserver : iObserver = nil);
begin
  FStatusDownload := TStatusDownload.New;
  FObservers := TList<iObserver>.Create;
  FTotalSizeFile := 0;
  FDateDownloadStart := Now;

  if Assigned(aObserver) then
    AddObserver(aObserver);
end;

class function TControllerDownload.New(aObserver : iObserver = nil) : TControllerDownload;
begin
  Result := Self.create(aObserver);
end;

procedure TControllerDownload.Notify(aStatus: TStatusDownload);
var
  lObserver: iObserver;
begin
  for lObserver  in FObservers do
    lObserver.OnNewOperation(aStatus);
end;

procedure TControllerDownload.RemoveObserver(const Observer: iObserver);
begin
  FObservers.Delete(FObservers.IndexOf(Observer));
end;

function TControllerDownload.SaveLogDownload: iControllerDownload;
Var
  aLogDownload : TLogDownload;
begin
  aLogDownload := TLogDownload.New;
  with aLogDownload do
  begin
    URL := FURL;
    DataInicio := FDateDownloadStart;
    SetDataFim;
  end;

  TModelsEntityDAOLogDownload
    .New
    .Insert(aLogDownload)
end;

function TControllerDownload.SetSizeDownload(
  aTotalSize: Int64): iControllerDownload;
begin
  if aTotalSize = 0 then
    exit;

  FTotalSizeFile := aTotalSize;

  FStatusDownload.TotalSize := aTotalSize;
  FStatusDownload.ActualSize := 0;
  FStatusDownload.Status :=TStatus.inProgress;

  Notify(FStatusDownload);
end;

function TControllerDownload.SetStatusDownload(aActualSize : Int64) : iControllerDownload;
begin
  Result := Self;

  FActualSizeFile := aActualSize;
  FStatusDownload.TotalSize := FTotalSizeFile;
  FStatusDownload.ActualSize := aActualSize;
  FStatusDownload.Status := TStatus.inProgress;

  Notify(FStatusDownload);
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

  if Assigned(FTaskThreadDownload) then
  begin
    TThreadDownload(FTaskThreadDownload).TerminateThread := True;
    FTaskThreadDownload.WaitFor;
    FTaskThreadDownload.Free;
  end;

  FTaskThreadDownload := TThreadDownload.Create(Self);
  FTaskThreadDownload.OnTerminate := OnStoppedTaskDownload;
  FTaskThreadDownload.Start;
end;

procedure TControllerDownload.OnStoppedTaskDownload(Sender: TObject);
begin
  if not (Sender is TThread) then
    exit;

  if (FStatusDownload.Status = TStatus.Abort) then
  begin
    Notify(FStatusDownload);
    exit;
  end;

  FStatusDownload.Status := TStatus.Completed;

  if Assigned(TThread(Sender).FatalException) then
  begin
    FStatusDownload.MessageError := Exception(TThread(Sender).FatalException).Message;
    FStatusDownload.Status := TStatus.Error
  end
  else
    Self
      .SaveLogDownload;

  Notify(FStatusDownload);
end;

{ TThreadDownload }

constructor TThreadDownload.Create(AController : TControllerDownload);
begin
  inherited Create(True);
  FControllerDownload := AController;
  FHTTP := THttpConnection.
              New(FControllerDownload);
  TerminateThread := False;
end;

destructor TThreadDownload.Destroy;
begin
  inherited;
end;

procedure TThreadDownload.Execute;
Var
  aTask : ITask;
begin
  inherited;

  aTask := TTask.Create(procedure
    begin
      try

        FHTTP.SetURL(FControllerDownload.GetURL)
                  .SetFileName
                  .GetDownload;
      except on E: Exception do
        begin
          RaiseExcept('Ocorreu um erro no download do arquivo: erro ' + e.Message)
        end;
      end;
    end);

  aTask.Start;


  while not Terminated do
  begin

    if (FMSGException <> '') then
    Begin
      raise Exception.Create(FMSGException);
    End;

    if (TerminateThread) or (aTask.Status = TTaskStatus.Completed) then
    begin
      aTask.Cancel;
      FHTTP.Disconnect;
      TerminateThread := False;
      Break;
    end;

  end;
end;

procedure TThreadDownload.RaiseExcept(aMSG: string);
begin
  FMSGException := aMSG;
end;

End.

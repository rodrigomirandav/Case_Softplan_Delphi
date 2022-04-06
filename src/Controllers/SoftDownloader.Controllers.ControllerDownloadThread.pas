unit SoftDownloader.Controllers.ControllerDownloadThread;

interface

uses
  System.Classes,
  SoftDownloader.Controllers.ControllerDownload,
  SoftDownloader.Models.HTTPConnection.HttpConnection;

type
  TThreadDownload = class(TThread)
    private
      FControllerDownload : TControllerDownload;
      FHttpConnection : THttpConnection;
    public
      constructor Create (aController : TControllerDownload); reintroduce;
      procedure Execute; override;
  end;

implementation

uses
  System.SysUtils;

{ TThreadDownload }

constructor TThreadDownload.Create(aController: TControllerDownload);
begin
  inherited Create(True);
  Self.FreeOnTerminate := True;
  FControllerDownload := aController;
end;

procedure TThreadDownload.Execute;
begin
  inherited;

  try
    FControllerDownload
      .GetHttpCon
      .SetURL(FControllerDownload.GetURL)
      .SetFileName
      .GetDownload;

  except on E: Exception do
    begin
      raise Exception.Create('Ocorreu um erro ao baixar o arquivo ' + e.Message);
    end;
  end;
end;

end.

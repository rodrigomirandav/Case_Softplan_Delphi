unit SoftDownloader.Controllers.Interfaces;

interface

uses
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Models.Entity.StatusDownload,
  SoftDownloader.Types.Status, SoftDownloader.Models.HTTPConnection.Interfaces;

type

  iControllerEntity = interface
    ['{3F43BF4C-6C07-4667-990D-0CB85626559A}']
    function Entities : iModelsEntityFactory;
  end;

  iControllerDownload = interface
    ['{3F43BF4C-6C07-4667-990D-0CB85626559A}']
    function SetURL(const aURL : string) : iControllerDownload;
    function SetSizeDownload(aTotalSize : Int64) : iControllerDownload;
    function SetStatusDownload(aActualSize : Int64) : iControllerDownload;
    function StartDownload : iControllerDownload;
    function AbortDownload : iControllerDownload;
    function SaveLogDownload : iControllerDownload;
    procedure OnStoppedTaskDownload(Sender: TObject);
    function DownloadNotStarted : Boolean;
    function GetURL: String;
    function GetStatus: String;
    function GetStatusDownload : TStatus;
  end;

  iObserver = interface
    ['{785A31AC-C48A-44B0-A8E7-C0D966CAD669}']
    procedure OnNewOperation(const StatusDownload: TStatusDownload);
  end;

  iObserved = interface
    ['{CAE39279-5C22-49F3-9CBF-2FD078B7C564}']
    procedure AddObserver(const Observer: iObserver);
    procedure RemoveObserver(const Observer: iObserver);
    procedure Notify(aStatus: TStatusDownload);
  end;

implementation

end.

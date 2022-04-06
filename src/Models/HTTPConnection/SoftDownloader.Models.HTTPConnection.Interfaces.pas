unit SoftDownloader.Models.HTTPConnection.Interfaces;

interface

uses
  IdComponent;

type

  iHTTPConnection = interface
    ['{6C595BEE-FCA4-4770-B944-9C09DF2A7017}']
    function Disconnect : iHTTPConnection;
    function SetURL(const aURL : String) : iHTTPConnection;
    procedure GetDownload;
    function SetFileName : iHTTPConnection;

    procedure Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode;  AWorkCountMax: Int64);
    procedure CreateAuthSSL;
    procedure CreateIdHttp;
  end;

implementation

end.

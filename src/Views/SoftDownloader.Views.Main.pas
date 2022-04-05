unit SoftDownloader.Views.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList,
  SoftDownloader.Controllers.Interfaces;

type
  TfrmMain = class(TForm)
    pnlPrincipal: TPanel;
    pnlTop: TPanel;
    pnlActions: TPanel;
    pnlDownload: TPanel;
    pgbStatusDownload: TProgressBar;
    btnStartDownload: TButton;
    btnStopDownload: TButton;
    btnShowMensageDownload: TButton;
    btnShowHistoryDownload: TButton;
    pnlLogo: TPanel;
    imgLogo: TImage;
    lblURL: TLabel;
    edtURL: TEdit;
    imgListMain: TImageList;
    lblLogo: TLabel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  SoftDownloader.Controllers.Controller;

{$R *.dfm}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FController := TController.New;
end;

end.

unit SoftDownloader.Views.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList;

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
    Label1: TLabel;
    btnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

end.

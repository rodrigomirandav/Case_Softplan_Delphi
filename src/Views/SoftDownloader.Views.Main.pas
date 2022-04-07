unit SoftDownloader.Views.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList,
  SoftDownloader.Controllers.Interfaces, SoftDownloader.Controllers.ControllerEntity,
  SoftDownloader.Controllers.ControllerDownload,
  SoftDownloader.Models.Entity.StatusDownload;

type
  TfrmMain = class(TForm, iObserver)
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
    lblLogo: TLabel;
    btnClose: TButton;
    imgIcons: TImageList;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnStartDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStopDownloadClick(Sender: TObject);
    procedure btnShowMensageDownloadClick(Sender: TObject);
    procedure btnShowHistoryDownloadClick(Sender: TObject);
  private
    { Private declarations }
    FController : iControllerDownload;
  public
    { Public declarations }
    procedure OnNewOperation(const StatusDownload: TStatusDownload);

    procedure SetButtonEnable(const StatusDownload: TStatusDownload);
    procedure SetProgress(const StatusDownload: TStatusDownload);
    procedure NotifyDownloadComplete(const StatusDownload: TStatusDownload);
    procedure NotifyDownloadError(const StatusDownload: TStatusDownload);
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Vcl.Dialogs,
  System.UITypes, SoftDownloader.Types.Status,
  SoftDownloader.Models.HTTPConnection.HttpConnection,
  SoftDownloader.Views.Download.ListDownload;

{$R *.dfm}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnShowHistoryDownloadClick(Sender: TObject);
begin
  Application.CreateForm(TfrmListDownloads, frmListDownloads);
  frmListDownloads.ShowModal;
end;

procedure TfrmMain.btnShowMensageDownloadClick(Sender: TObject);
begin
  MessageDlg(FController.GetStatus, TMsgDlgType.mtInformation, [mbok],0);
end;

procedure TfrmMain.btnStartDownloadClick(Sender: TObject);
begin
  try

    FController
      .SetURL(edtURL.Text)
      .StartDownload;

  except on E: Exception do
    begin
      MessageDlg(e.Message, mtInformation, [mbok], 0);
      edtURL.SetFocus;
    end;
  end;
end;

procedure TfrmMain.btnStopDownloadClick(Sender: TObject);
Var
  mr : TModalResult;
Begin
  mr := MessageDlg('Existe um download em andamento, deseja realmente interrompe-lo? [Sim, Não]',
                          TMsgDlgType.mtConfirmation, [mbyes, mbNo],0);
  if mr = mrno then
    exit;

  FController.AbortDownload;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var
  mr : TModalResult;
begin
  if (FController.DownloadNotStarted) then
  Begin
    CanClose := True;
    exit;
  End;

  mr := MessageDlg('Existe um download em andamento, deseja interrompe-lo? [Sim, Não]',
                          TMsgDlgType.mtConfirmation, [mbyes, mbNo],0);
  if mr = mrno then
  Begin
    CanClose := False;
    Exit;
  End;

  FController.AbortDownload;
  CanClose := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FController := TControllerDownload.New(self);
end;

procedure TfrmMain.NotifyDownloadComplete(
  const StatusDownload: TStatusDownload);
begin
  if StatusDownload.Status <> TStatus.Completed then
    Exit;

  MessageDlg('O download foi concluido com sucesso.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],0);
  edtURL.Text := EmptyStr;
  pgbStatusDownload.Position := 0;
end;

procedure TfrmMain.NotifyDownloadError(const StatusDownload: TStatusDownload);
begin
  if StatusDownload.Status <> TStatus.Error then
    Exit;

  MessageDlg(StatusDownload.MessageError, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],0);
  edtURL.Text := EmptyStr;
  pgbStatusDownload.Position := 0;
end;

procedure TfrmMain.OnNewOperation(const StatusDownload: TStatusDownload);
begin
  SetButtonEnable(StatusDownload);
  SetProgress(StatusDownload);
  NotifyDownloadComplete(StatusDownload);
  NotifyDownloadError(StatusDownload);
end;

procedure TfrmMain.SetButtonEnable(const StatusDownload: TStatusDownload);
begin
  btnStartDownload.Enabled := (StatusDownload.Status <> TStatus.inProgress);
  btnStopDownload.Enabled := (StatusDownload.Status = TStatus.inProgress);
  btnShowMensageDownload.Enabled := (StatusDownload.Status = TStatus.inProgress);
end;

procedure TfrmMain.SetProgress(const StatusDownload: TStatusDownload);
begin
  if StatusDownload.TotalSize > 0 then
    pgbStatusDownload.Max := StatusDownload.TotalSize;

  pgbStatusDownload.Position := StatusDownload.ActualSize;
end;

end.

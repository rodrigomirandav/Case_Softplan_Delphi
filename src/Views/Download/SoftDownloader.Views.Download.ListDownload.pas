unit SoftDownloader.Views.Download.ListDownload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, SoftDownloader.Controllers.Interfaces;

type
  TfrmListDownloads = class(TForm)
    dbgDownloads: TDBGrid;
    dsDownloads: TDataSource;
    pnlList: TPanel;
    pnlActions: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgDownloadsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FControllerEntity : iControllerEntity;
  public
    { Public declarations }
    procedure ZebrarGrid(Sender: TObject; const Rect: TRect; DataCol: Integer;Column: TColumn; State: TGridDrawState);
  end;

var
  frmListDownloads: TfrmListDownloads;

implementation

uses
  SoftDownloader.Controllers.ControllerEntity;

{$R *.dfm}

procedure TfrmListDownloads.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListDownloads.dbgDownloadsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
end;

procedure TfrmListDownloads.FormCreate(Sender: TObject);
begin
  FControllerEntity := TControllerEntity.New;
end;

procedure TfrmListDownloads.FormShow(Sender: TObject);
begin
  Try
    FControllerEntity
      .Entities
        .LogDownload
        .DataSet(dsDownloads)
      .Open;
  Except on E : Exception do
    Begin
      MessageDlg(e.Message, TMsgDlgType.mtInformation, [mbok],0);
    End;
  End;
end;

procedure TfrmListDownloads.ZebrarGrid(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := $00F7F7F7;
    TDBGrid(Sender).Canvas.FillRect(Rect);
    TDBGrid(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if (gdSelected in state ) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color:= $00ECDAB7;
    TDBGrid(Sender).Canvas.FillRect(Rect);
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.

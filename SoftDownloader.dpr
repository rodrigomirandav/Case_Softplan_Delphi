program SoftDownloader;

uses
  Vcl.Forms,
  SysUtils,
  SoftDownloader.Views.Main in 'src\Views\SoftDownloader.Views.Main.pas' {frmMain},
  SoftDownloader.Views.Splash in 'src\Views\SoftDownloader.Views.Splash.pas' {frmSplash},
  SoftDownloader.Models.Entity.Interfaces in 'src\Models\Entity\SoftDownloader.Models.Entity.Interfaces.pas',
  SoftDownloader.Models.Entity.LogDownload in 'src\Models\Entity\SoftDownloader.Models.Entity.LogDownload.pas',
  SoftDownloader.Models.DBConnection.ConnectionFactory in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.ConnectionFactory.pas',
  SoftDownloader.Models.DBConnection.FiredacConnection in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.FiredacConnection.pas',
  SoftDownloader.Models.DBConnection.FiredacQuery in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.FiredacQuery.pas',
  SoftDownloader.Models.DBConnection.Interfaces in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  ReportMemoryLeaksOnShutdown := True;

  Application.CreateForm(TfrmSplash, frmSplash);
  try
    frmSplash.Show;
    frmSplash.Update;
    Sleep(2000);
  finally
    FreeAndNil(frmSplash);
  end;

  Application.Run;
end.

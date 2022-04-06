program SoftDownloader;

uses
  Vcl.Forms,
  SysUtils,
  SoftDownloader.Views.Main in 'src\Views\SoftDownloader.Views.Main.pas' {frmMain},
  SoftDownloader.Views.Splash in 'src\Views\SoftDownloader.Views.Splash.pas' {frmSplash},
  SoftDownloader.Models.Entity.DAO.LogDownload in 'src\Models\Entity\DAO\SoftDownloader.Models.Entity.DAO.LogDownload.pas',
  SoftDownloader.Models.DBConnection.ConnectionFactory in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.ConnectionFactory.pas',
  SoftDownloader.Models.DBConnection.FiredacConnection in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.FiredacConnection.pas',
  SoftDownloader.Models.DBConnection.FiredacQuery in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.FiredacQuery.pas',
  SoftDownloader.Models.HTTPConnection.Interfaces in 'src\Models\HTTPConnection\SoftDownloader.Models.HTTPConnection.Interfaces.pas',
  SoftDownloader.Models.Entity.Factory in 'src\Models\Entity\SoftDownloader.Models.Entity.Factory.pas',
  SoftDownloader.Controllers.Interfaces in 'src\Controllers\SoftDownloader.Controllers.Interfaces.pas',
  SoftDownloader.Models.Entity.Config in 'src\Models\Entity\SoftDownloader.Models.Entity.Config.pas',
  SoftDownloader.Models.Entity.Interfaces in 'src\Models\Entity\SoftDownloader.Models.Entity.Interfaces.pas',
  SoftDownloader.Models.Entity.LogDownload in 'src\Models\Entity\SoftDownloader.Models.Entity.LogDownload.pas',
  SoftDownloader.Controllers.ControllerEntity in 'src\Controllers\SoftDownloader.Controllers.ControllerEntity.pas',
  SoftDownloader.Controllers.ControllerDownload in 'src\Controllers\SoftDownloader.Controllers.ControllerDownload.pas',
  SoftDownloader.Types.Status in 'src\Types\SoftDownloader.Types.Status.pas',
  SoftDownloader.Models.Entity.StatusDownload in 'src\Models\Entity\SoftDownloader.Models.Entity.StatusDownload.pas',
  SoftDownloader.Models.HTTPConnection.HttpConnection in 'src\Models\HTTPConnection\SoftDownloader.Models.HTTPConnection.HttpConnection.pas',
  SoftDownloader.Models.DBConnection.Interfaces in 'src\Models\DBConnection\SoftDownloader.Models.DBConnection.Interfaces.pas',
  SoftDownloader.Views.Download.ListDownload in 'src\Views\Download\SoftDownloader.Views.Download.ListDownload.pas' {frmListDownloads};

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

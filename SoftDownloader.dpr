program SoftDownloader;

uses
  Vcl.Forms,
  SysUtils,
  SoftDownloader.Views.Main in 'src\Views\SoftDownloader.Views.Main.pas' {frmMain},
  SoftDownloader.Views.Splash in 'src\Views\SoftDownloader.Views.Splash.pas' {frmSplash};

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

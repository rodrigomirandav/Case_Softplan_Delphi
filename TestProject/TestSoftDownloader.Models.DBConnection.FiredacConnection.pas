unit TestSoftDownloader.Models.DBConnection.FiredacConnection;

interface

uses
  DUnitX.TestFramework,
  SoftDownloader.Models.DBConnection.FiredacConnection;

type
  [TestFixture]
  TTestFiredacConnection = class
  private
    FModelsDBConnectionFiredacConnection : TModelsDBConnectionFiredacConnection;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
  end;

implementation

procedure TTestFiredacConnection.Setup;
begin
  FModelsDBConnectionFiredacConnection := TModelsDBConnectionFiredacConnection.Create;
end;

procedure TTestFiredacConnection.TearDown;
begin
  FModelsDBConnectionFiredacConnection.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestFiredacConnection);

end.

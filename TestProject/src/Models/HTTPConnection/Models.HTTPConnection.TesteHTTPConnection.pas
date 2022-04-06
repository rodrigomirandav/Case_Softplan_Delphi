unit Models.HTTPConnection.TesteHTTPConnection;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TMyTestObject = class
  [Setup]
  procedure Setup;
  [TearDown]
  procedure TearDown;
  public
    [Test]
    procedure Test1;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

uses
  SoftDownloader.Controllers.ControllerDownload;

{ TMyTestObject }

procedure TMyTestObject.Setup;
begin

end;

procedure TMyTestObject.TearDown;
begin
  TControllerDownload.Free;
end;

procedure TMyTestObject.Test1;
begin

end;

procedure TMyTestObject.Test2(const AValue1, AValue2: Integer);
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.

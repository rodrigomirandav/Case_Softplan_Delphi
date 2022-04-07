unit SoftDownloader.Models.DBConnection.FiredacConnection;

interface

uses
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.ADSDef,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MSAccDef,
  FireDAC.Moni.RemoteClient,
  FireDAC.Moni.Custom,
  FireDAC.Moni.Base,
  FireDAC.Moni.FlatFile,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSAcc,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.ADS,
  FireDAC.Phys.FB,
  FireDAC.Phys.PG,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IB,
  FireDAC.DApt,
  SoftDownloader.Models.DBConnection.Interfaces,
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Models.Entity.Config;

type

  TModelsDBConnectionFiredacConnection = class(TInterfacedObject, iDBConnection)
  private
    FConnection : TFDConnection;
    FConfig : TConfig;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iDBConnection;
    function Connection : TObject;
    function SetConfig(aConfig : TConfig): iDBConnection;
    function ApplyConfigDB: iDBConnection;
    function DriverValidate: iDBConnection;
    function ConfigValidate: iDBConnection;
    function ConnectDB: iDBConnection;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,
  SoftDownloader.Types.FiredacDriverID;

{ TModelsDBConnectionFiredacConnection }

function TModelsDBConnectionFiredacConnection.ApplyConfigDB: iDBConnection;
begin
  Result := Self;

  FConnection.Params.DriverID := FConfig.DriverID;
  FConnection.Params.Database := FConfig.Database;
  FConnection.Params.UserName := FConfig.UserName;
  FConnection.Params.Password := FConfig.Password;
end;

function TModelsDBConnectionFiredacConnection.ConfigValidate: iDBConnection;
begin
  Result := Self;

  if FConfig.Database = '' then
    raise Exception.Create('É necessário informar o caminho/nome da instância do banco de dados.');
end;

function TModelsDBConnectionFiredacConnection.ConnectDB: iDBConnection;
begin
  Result := Self;
  FConnection.Connected := True;
end;

function TModelsDBConnectionFiredacConnection.Connection: TObject;
begin
  Result := FConnection;
end;

constructor TModelsDBConnectionFiredacConnection.Create;
begin
  FConfig := TConfig.create;
  FConnection := TFDConnection.Create(nil);
end;

destructor TModelsDBConnectionFiredacConnection.Destroy;
begin
  FConnection.Free;
  FConfig.Free;
  inherited;
end;

function TModelsDBConnectionFiredacConnection.DriverValidate: iDBConnection;
begin
  Result := Self;

  if not TFiredacDriverIDHelper.DriverIdInFiredacDriverID(FConfig.DriverID) then
    raise Exception.Create('Este drive de banco de dados não possui suporte');

end;

class function TModelsDBConnectionFiredacConnection.New : iDBConnection;
begin
  Result := Self.Create;
end;

function TModelsDBConnectionFiredacConnection.SetConfig(aConfig : TConfig): iDBConnection;
begin
  Result := Self;
  FConfig.DriverID := aConfig.DriverID;
  FConfig.Database := aConfig.Database;
  FConfig.UserName := aConfig.UserName;
  FConfig.Password := aConfig.Password;
end;

end.

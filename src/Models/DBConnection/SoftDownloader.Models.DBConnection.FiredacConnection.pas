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
  SoftDownloader.Models.DBConnection.Interfaces;

type

  TModelsDBConnectionFiredacConnection = class(TInterfacedObject, iDBConnection)
  private
    FConnection : TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iDBConnection;
    function Connection : TObject;
  end;

implementation

{ TModelsDBConnectionFiredacConnection }

function TModelsDBConnectionFiredacConnection.Connection: TObject;
begin
  Result := FConnection;
end;

constructor TModelsDBConnectionFiredacConnection.Create;
begin
  FConnection :=  TFDConnection.Create(nil);
  FConnection.Params.DriverID := 'SQLite';  // TO-DO: Criar
  FConnection.Params.Database := 'F:\Case Softplan\Case_Softplan_Delphi\src\Models\DBConnection\a.db';
  FConnection.Params.UserName := '';
  FConnection.Params.Password := 'sotplan';
  FConnection.Connected := true;
end;

destructor TModelsDBConnectionFiredacConnection.Destroy;
begin
  FConnection.Free;
  inherited;
end;

class function TModelsDBConnectionFiredacConnection.New: iDBConnection;
begin
  Result := self.Create;
end;

end.

unit SoftDownloader.Models.DBConnection.ConnectionFactory;

interface

uses
  SoftDownloader.Models.DBConnection.Interfaces;

type

  TConnectionFactory = class(TInterfacedObject, iDBConnectionFactory)
    private
    public
      constructor create;
      destructor Destroy; override;
      class function New : iDBConnectionFactory;
      function Conexao : iDBConnection;
      function Query : iDBQuery;
  end;

implementation

uses
  SoftDownloader.Models.DBConnection.FiredacConnection,
  SoftDownloader.Models.DBConnection.FiredacQuery;

{ TConnectionFactory }

function TConnectionFactory.Conexao: iDBConnection;
begin
  Result := TModelsDBConnectionFiredacConnection.New;
end;

constructor TConnectionFactory.create;
begin

end;

destructor TConnectionFactory.Destroy;
begin

  inherited;
end;

class function TConnectionFactory.New: iDBConnectionFactory;
begin
  Result := Self.Create;
end;

function TConnectionFactory.Query: iDBQuery;
begin
  Result := TFiredacQuery.New(Self.Conexao);
end;

end.

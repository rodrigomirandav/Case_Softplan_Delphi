unit SoftDownloader.Models.BDConnection.ConnectionFactory;

interface

uses
  SoftDownloader.Models.BDConnection.Interfaces;

type

  TConnectionFactory = class(TInterfacedObject, iDBConnectionFactory)
    private
    public
      constructor create;
      destructor destroy; override;
      class function New : iDBConnectionFactory;
      function Conexao : iDBConnection;
      function Query : iDBQuery;
  end;

implementation

uses
  SoftDownloader.Models.BDConnection.FiredacConnection,
  SoftDownloader.Models.BDConnection.FiredacQuery;

{ TConnectionFactory }

function TConnectionFactory.Conexao: iDBConnection;
begin
  Result := TModelsBDConnectionFiredacConnection.New;
end;

constructor TConnectionFactory.create;
begin

end;

destructor TConnectionFactory.destroy;
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

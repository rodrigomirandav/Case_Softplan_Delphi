unit SoftDownloader.Models.BDConnection.FiredacQuery;

interface

uses
  FireDAC.Comp.Client,
  SoftDownloader.Models.BDConnection.Interfaces;

type

  TFiredacQuery = class(TInterfacedObject, iDBQuery)
    private
      FQuery : TFDQuery;
      FConexao : iDBConnection;
    public
      constructor create(aValue : iDBConnection);
      destructor destroy; override;
      class function New(aValue : iDBConnection): TFiredacQuery;
      function Query : TObject;
      function Open(aSQL : String) : iDBQuery;
      function ExecSQL(aSQL : String) : iDBQuery;
  end;

implementation

{ TFiredacQuery }

constructor TFiredacQuery.create(aValue : iDBConnection);
begin
  FConexao := aValue;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(FConexao.Connection);
end;

destructor TFiredacQuery.destroy;
begin
  FQuery.Free;
  inherited;
end;

function TFiredacQuery.ExecSQL(aSQL: String): iDBQuery;
begin
  Result := Self;
  FQuery.ExecSQL(aSQL);
end;

class function TFiredacQuery.New(aValue : iDBConnection): TFiredacQuery;
begin
  Result := TFiredacQuery.create(aValue);
end;

function TFiredacQuery.Open(aSQL: String): iDBQuery;
begin
  Result := Self;
  FQuery.Open(aSQL);
end;

function TFiredacQuery.Query: TObject;
begin
  Result := FQuery;
end;

end.

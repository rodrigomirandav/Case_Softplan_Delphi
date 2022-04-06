unit SoftDownloader.Models.Entity.DAO.LogDownload;

interface

uses
  Data.DB,
  SoftDownloader.Models.Entity.Interfaces,
  SoftDownloader.Models.DBConnection.Interfaces;

type

  TModelsEntityDAOLogDownload = class(TInterfacedObject, iModelsEntityDAODB)
    private
      FQuery : iDBQuery;
    public
      constructor create;
      destructor Destroy; override;
      class function New : iModelsEntityDAODB;
      function DataSet ( aValue : TDataSource ) : iModelsEntityDAODB;
      procedure Open;
      procedure Insert (aValue : iModelsEntity);
  end;

implementation

uses
  SoftDownloader.Models.DBConnection.ConnectionFactory, FireDAC.Comp.Client,
  SoftDownloader.Models.Entity.LogDownload, System.SysUtils;

{ TModelsEntityDAOLogDownload }

constructor TModelsEntityDAOLogDownload.create;
begin
  FQuery := TConnectionFactory.New.Query;
end;

function TModelsEntityDAOLogDownload.DataSet(aValue: TDataSource): iModelsEntityDAODB;
begin
  Result := Self;
  aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelsEntityDAOLogDownload.Destroy;
begin

  inherited;
end;

procedure TModelsEntityDAOLogDownload.Insert(aValue: iModelsEntity);
Var
  aSQL : string;
  aModel : TLogDownload;
begin
  aModel := TLogDownload(aValue);

  aSQL :=   Format('INSERT INTO LOGDOWNLOAD'+
                    '           (URL'+
                    '           ,DataInicio'+
                    '           ,DATAFIM)'+
                    '     VALUES'+
                    '           (%s '+
                    '           ,%s '+
                    '           ,%s)',
                    [QuotedStr(aModel.URL),
                      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', aModel.DataInicio)),
                      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', aModel.DataFim))]);

  FQuery.ExecSQL(aSQL);
end;

class function TModelsEntityDAOLogDownload.New: iModelsEntityDAODB;
begin
  Result := Self.Create;
end;

procedure TModelsEntityDAOLogDownload.Open;
begin
  FQuery.Open('SELECT * FROM logdownload');
end;

end.

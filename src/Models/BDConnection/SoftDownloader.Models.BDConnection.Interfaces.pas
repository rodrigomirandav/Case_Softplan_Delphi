unit SoftDownloader.Models.BDConnection.Interfaces;

interface

type

  iDBConnection = interface
    ['{6C595BEE-FCA4-4770-B944-9C09DF2A7017}']
    function Connection : TObject;
  end;

  iDBQuery = interface
    ['{6C595BEE-FCA4-4770-B944-9C09DF2A7017}']
    function Query : TObject;
    function Open(aSQL : String) : iDBQuery;
    function ExecSQL(aSQL : String) : iDBQuery;
  end;

  iDBConnectionFactory = interface
    ['{500068A7-91D6-40CE-A30B-0C87E8B4109C}']
    function Conexao : iDBConnection;
    function Query : iDBQuery;
  end;

implementation

end.
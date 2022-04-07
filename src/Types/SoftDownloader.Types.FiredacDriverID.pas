unit SoftDownloader.Types.FiredacDriverID;

interface

uses
  SysUtils,
  TypInfo,
  System.Generics.Collections;

type

{$SCOPEDENUMS ON}
  TFiredacDriverID = (SQLite);
{$SCOPEDENUMS OFF}

  TFiredacDriverIDHelper = class
    class function DriverIdInFiredacDriverID(DriverID : string): Boolean;
  end;
implementation

{ TFiredacDriverIDHelper }

class function TFiredacDriverIDHelper.DriverIdInFiredacDriverID(
  DriverID: string): Boolean;
begin
  Result := (GetEnumValue(TypeInfo(TFiredacDriverID),DriverID) > -1)
end;

end.

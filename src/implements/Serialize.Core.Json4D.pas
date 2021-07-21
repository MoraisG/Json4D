unit Serialize.Core.Json4D;

interface

uses
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  Rest.JSON.Types,
  Contracts.Json4D;

type

  TJSON4DCore<T: Class, constructor> = class(TInterfacedObject, IJSONCore<T>)
  private
    FJson: TJSONValue;
    FArrayJson: TJSONArray;
    FDestroyObjectList: Boolean;
    FListObj: TObjectList<T>;
  public
    constructor Create(ADestroyObjectList: Boolean = true);
    destructor Destroy; override;
    class function New(ADestroyObjectList: Boolean = true): IJSONCore<T>;
    function Add(AJsonObject: String): IJSONCore<T>; overload;
    function Add(AJsonObject: T): IJSONCore<T>; overload;
    function DeserializeArray(AJsonArray: TJSONArray): IJSONCore<T>; overload;
    function DeserializeArray(AJsonArray: string): IJSONCore<T>; overload;
    function GSONObject(AValue: String): IJSONCore<T>;
    function GetAttributeJson(AKey: String): String;
    function ListObjects: TObjectList<T>;
    function JsonArray: String;
  end;

implementation

{ TJSON4DCore }

function TJSON4DCore<T>.Add(AJsonObject: T): IJSONCore<T>;
begin
  Result := Self;
  FArrayJson.Add(TJson.ObjectToJsonObject(AJsonObject, [joDateFormatParse]));
end;

function TJSON4DCore<T>.Add(AJsonObject: String): IJSONCore<T>;
begin
  Result := Self;
  FArrayJson.Add(AJsonObject);
end;

constructor TJSON4DCore<T>.Create(ADestroyObjectList: Boolean = true);
begin
  FArrayJson := TJSONArray.Create;
  FDestroyObjectList := ADestroyObjectList;
  FListObj := TObjectList<T>.Create();
  FJson := nil;
end;

function TJSON4DCore<T>.DeserializeArray(AJsonArray: TJSONArray): IJSONCore<T>;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(AJsonArray.Count) do
  begin
    FListObj.Add(TJson.JsonToObject<T>(AJsonArray.Items[I].ToJSON));
  end;
end;

function TJSON4DCore<T>.DeserializeArray(AJsonArray: string): IJSONCore<T>;
Var
  LJsonArray: TJSONArray;
begin
  Result := Self;
  LJsonArray := TJSONObject.ParseJSONValue(AJsonArray) AS TJSONArray;
  try
    Self.DeserializeArray(LJsonArray);
  finally
    LJsonArray.Free;
  end;
end;

destructor TJSON4DCore<T>.Destroy;
begin
  FArrayJson.Free;
  if FDestroyObjectList then
    FListObj.Free;
  if Assigned(FJson) then
    FJson.Free;
  inherited;
end;

function TJSON4DCore<T>.GetAttributeJson(AKey: String): String;
begin
  Result := FJson.GetValue<String>(AKey);
end;

function TJSON4DCore<T>.GSONObject(AValue: String): IJSONCore<T>;
begin
  Result := Self;
  FJson := TJSONObject.ParseJSONValue(AValue);
end;

function TJSON4DCore<T>.JsonArray: String;
begin
  Result := FArrayJson.ToString;
end;

function TJSON4DCore<T>.ListObjects: TObjectList<T>;
begin
  Result := FListObj;
end;

class function TJSON4DCore<T>.New(ADestroyObjectList: Boolean = true)
  : IJSONCore<T>;
begin
  Result := Self.Create(ADestroyObjectList);
end;

end.

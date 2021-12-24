unit Serialize.Json4D;

interface

uses
  System.JSON,
  System.Generics.Collections,
  Contracts.Json4D;

type
  TJson4DSerialize<T: Class, constructor> = class(TInterfacedObject,
    ISerializeJSON4D<T>)
  private
    FJson: IJSONCore<T>;
  public
    constructor Create; overload;
    constructor Create(AOwns : Boolean);overload;
    Destructor Destroy; override;
    function GSONObject(AValue: String): IJSONCore<T>;
    function JsonArrayToObject(AJsonArray: TJsonArray): IJSONCore<T>; overload;
    function JsonArrayToObject(AJsonArray: String): IJSONCore<T>; overload;
    function ObjectToJsonArray(AObject: TObjectList<T>): IJSONCore<T>; overload;
    function ObjectToJsonArray(AObject: TObject): IJSONCore<T>; overload;
    function This: IJSONCore<T>;
    class function New: ISerializeJSON4D<T>;overload;
    class function New(AOwns : Boolean): ISerializeJSON4D<T>;overload;
  end;

implementation

uses
  System.SysUtils,
  System.RTTI,
  Serialize.Core.Json4D,
  RTTI.Attributes.Json4D,
  Types.Enums.Json4D;
{ TJson4DSerialize<T> }

constructor TJson4DSerialize<T>.Create;
begin
  FJson := TJSON4DCore<T>.New;
end;

constructor TJson4DSerialize<T>.Create(AOwns: Boolean);
begin
  FJson := TJSON4DCore<T>.New(AOwns);
end;

destructor TJson4DSerialize<T>.Destroy;
begin

  inherited;
end;

function TJson4DSerialize<T>.GSONObject(AValue: String): IJSONCore<T>;
begin
  Result := FJson.GSONObject(AValue);
end;

function TJson4DSerialize<T>.JsonArrayToObject(AJsonArray: String)
  : IJSONCore<T>;
begin
  FJson.DeserializeArray(AJsonArray);
  Result := FJson;
end;

class function TJson4DSerialize<T>.New(AOwns: Boolean): ISerializeJSON4D<T>;
begin
  Result := Self.Create(AOwns)
end;

function TJson4DSerialize<T>.JsonArrayToObject(AJsonArray: TJsonArray)
  : IJSONCore<T>;
begin
  FJson.DeserializeArray(AJsonArray);
  Result := FJson;
end;

class function TJson4DSerialize<T>.New: ISerializeJSON4D<T>;
begin
  Result := Self.Create;
end;

function TJson4DSerialize<T>.ObjectToJsonArray(AObject: TObject): IJSONCore<T>;
var
  context: TRttiContext;
  typeRtti: TRttiType;
  fldRTTI: TRttiField;
  lAttributes: TCustomAttribute;
begin
  context := TRttiContext.Create;
  try
    typeRtti := context.GetType(AObject.ClassInfo);
    for fldRTTI in typeRtti.GetFields do
      for lAttributes in fldRTTI.GetAttributes do
        if lAttributes is ArrayObjects then
        begin
          case ArrayObjects(lAttributes).TypeArray of
            tpObjectList:
              begin
                Self.ObjectToJsonArray(fldRTTI.GetValue(AObject).AsType <
                  TObjectList < T >> );
              end;
          end;
        end;
  finally
    context.Free;
  end;
  Result := FJson;
end;

function TJson4DSerialize<T>.This: IJSONCore<T>;
begin
  Result := FJson;
end;

function TJson4DSerialize<T>.ObjectToJsonArray(AObject: TObjectList<T>)
  : IJSONCore<T>;
var
  LObj: T;
begin
  for LObj in AObject.ToArray do
    FJson.Add(LObj);
  Result := FJson;
end;

end.

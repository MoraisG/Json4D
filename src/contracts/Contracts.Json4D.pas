unit Contracts.Json4D;

interface

uses
  System.JSON,
  System.Generics.Collections;

type
  IJSONCore<T: Class> = interface;

  ISerializeJSON4D<T: Class> = interface
    ['{E688C149-C82E-4E21-8FB3-110E41248E47}']
    function GSONObject(AValue: String): IJSONCore<T>;
    function JsonArrayToObject(AJsonArray: TJsonArray): IJSONCore<T>; overload;
    function JsonArrayToObject(AJsonArray: String): IJSONCore<T>; overload;
    function ObjectToJsonArray(AObject: TObjectList<T>): IJSONCore<T>; overload;
    function ObjectToJsonArray(AObject: TObject): IJSONCore<T>; overload;
    function This: IJSONCore<T>;
  end;

  IJSONCore<T: Class> = interface
    ['{888E35D0-04B9-42BE-B953-987E98A3A6BB}']
    function GSONObject(AValue: String): IJSONCore<T>;
    function Add(AJsonObject: String): IJSONCore<T>; overload;
    function Add(AJsonObject: T): IJSONCore<T>; overload;
    function DeserializeArray(AJsonArray: TJsonArray): IJSONCore<T>; overload;
    function DeserializeArray(AJsonArray: string): IJSONCore<T>; overload;
    function GetAttributeJson(AKey : String) : String;
    function ListObjects: TObjectList<T>;
    function JsonArray: String;

  end;

implementation

end.

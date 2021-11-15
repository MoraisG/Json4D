# Json4D
 ### Framework JSON for Delphi
 
 ## How to use?
 
 1. JsonArry to ObjectList. You manage memory.
```Pascal 
implementation
 
uses
    Serialize.Json4D;
 
procedure JsonArray4D(LArrayJson : TJsonArray);
var
 ListDto : TObjectList<TArrayDTO>;
begin
    ListDTO := 
      TJson4DSerialize<TArrayDTO>.New(false)
        .JsonArrayToObject(LArrayJson)
          .ListObjects;
    ListDTO.free;
end;
 
procedure StringJsonArray4D(LArrayJson : String);
var
 ListDto : TObjectList<TArrayDTO>;
begin
    ListDTO := 
      TJson4DSerialize<TArrayDTO>.New(false)
        .JsonArrayToObject(LArrayJson)
          .ListObjects;
    ListDTO.free;
end;
```

1. JsonArray to ObjectList. Thread Safe.
```Pascal 
implementation
 
uses
    Contracts.Json4D,
    Serialize.Json4D;
 
procedure JsonArray4D(LArrayJson : TJsonArray);
var
 LSerialize : ISerializeJSON4D<TArrayDTO>;
 LDTO : TArrayDTO;
begin
 LSerialize := TJson4DSerialize<TArrayDTO>.New;
 LSerialize.JsonArrayToObject(LArrayJson);
 for LDTO in This.ListObjects do
 begin
   
 end;
end;
 
procedure StringJsonArray4D(LArrayJson : String);
var
 LSerialize : ISerializeJSON4D<TArrayDTO>;
begin
    ListDTO := 
      TJson4DSerialize<TArrayDTO>.New(false)
        .JsonArrayToObject(LArrayJson)
          .ListObjects;
    ListDTO.free;
end;
```

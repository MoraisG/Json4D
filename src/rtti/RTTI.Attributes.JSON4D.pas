unit RTTI.Attributes.JSON4D;

interface

uses
  Types.Enums.JSON4D;

type
  ArrayObjects = class(TCustomAttribute)
  private
    FTypeArray: TEnumTypeDelphiGenerics;
    procedure SetTypeArray(const Value: TEnumTypeDelphiGenerics);
  public
    constructor Create(AType: TEnumTypeDelphiGenerics);
    destructor destroy; override;
    property TypeArray: TEnumTypeDelphiGenerics read FTypeArray
      write SetTypeArray;
  end;

implementation

{ ArrayObjects }

constructor ArrayObjects.Create(AType: TEnumTypeDelphiGenerics);
begin
  TypeArray := AType;
end;

destructor ArrayObjects.destroy;
begin

  inherited;
end;

procedure ArrayObjects.SetTypeArray(const Value: TEnumTypeDelphiGenerics);
begin
  FTypeArray := Value;
end;

end.

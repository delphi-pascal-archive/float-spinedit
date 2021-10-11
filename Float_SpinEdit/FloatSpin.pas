unit FloatSpin;

interface

uses Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils,
  Forms, Graphics, Menus, Buttons, Math,strutils, Spin;


type
 TUnit=record
   name:string;
   divi:integer;
   mult:integer;
  end;

type
 TUnitCalculator=class
   private
    Fcount:integer;
    FUnit:array of TUnit;
    function GetUnitName(index:integer):string;
    function GetUnits:string;
    procedure SetUnits(v:string);
    constructor Create;
    destructor Destroy;
    function ConvertFromUnit(value:extended;index:integer):extended;
    function ConvertToUnit(value:extended;index:integer):extended;
    procedure AddUnit(name:string;Mult:integer;Divi:integer);
    procedure AddUnits(List:string);
    procedure DelUnit(name:string);
    procedure Clear;
    function FindUnit(name:string):integer;
    property Units:string read GetUnits write SetUnits;
    property UnitName[index:integer]: string read GetUnitName;
   published
    property Count:integer read Fcount;

 end;

type
{ TFloatSpinEdit }
  TFloatSpinEdit = class(TCustomEdit)
  private
    FMinValue: extended;
    FMaxValue: extended;
    FIncrement: extended;
    FButton: TSpinButton;
    FEditorEnabled: Boolean;
    Funites:string;       // liste des unités disponibles
    FCurrentUnit:integer; // unité courant =-1 si aucune
    FPrecision:integer;   // précision de Value à l'affichage
    FValue:extended;      // valeur interne sans unité
    FDefaultUnit:integer; // unité par défaut si aucune n'est écrite

    FUnitList:TUnitCalculator;


    procedure SetUnites(v:string);
    procedure SetPrecision(v:integer);
    procedure UpdateValue(s:string);
    function GetMinHeight: Integer;
    procedure SetValue (NewValue: extended);
    function GetValue:extended;
    function GetUnitValue: extended;
    procedure SetUnitValue (NewValue: extended);
    function CheckValue (NewValue: extended): extended;
    procedure SetCurrentUnit(v:integer);
    procedure SetDefaultUnit(v:integer);
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit);   message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste);   message WM_PASTE;
    procedure WMCut(var Message: TWMCut);   message WM_CUT;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick (Sender: TObject); virtual;
    procedure DownClick (Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpinButton read FButton;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property Increment: extended read FIncrement write FIncrement;
    property Precision: integer read FPrecision write SetPrecision;
    property unites: string read Funites write SetUnites;
    property MaxLength;
    property MaxValue: extended read FMaxValue write FMaxValue; // pour valeur interne
    property MinValue: extended read FMinValue write FMinValue; // pour valeur interne
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: extended read GetValue write SetValue;           // pour valeur interne
    property UnitValue: extended read GetUnitValue write SetUnitValue;           // pour valeur interne
    property CurrentUnit: Integer read FCurrentUnit write SetCurrentUnit;
    property DefaultUnit:integer  read FDefaultUnit write SetDefaultUnit;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;


procedure Register;

implementation

uses Themes;

//{$R FLOATSPIN }


//******************************************************************************
//******************************************************************************

    constructor TUnitCalculator.Create;
     begin
      inherited;
      Fcount:=0;
      setlength(FUnit,0);
     end;

    destructor TUnitCalculator.Destroy;
     begin
      clear;
     end;

    function TUnitCalculator.GetUnitName(index:integer):string;
    begin
      if index=-1 then  result:=''
      else
      result:=FUnit[index].name;
    end;

    function TUnitCalculator.ConvertFromUnit(value:extended;index:integer):extended;
     begin
      if index=-1 then result:=value
      else
      result:=value*FUnit[index].divi/FUnit[index].mult;
     end;

    function TUnitCalculator.ConvertToUnit(value:extended;index:integer):extended;
     begin
      if index=-1 then result:=value
      else
      result:=value*FUnit[index].mult/FUnit[index].divi;
     end;

    function TUnitCalculator.GetUnits:string;
    var
     i:integer;
    begin
     result:='';
     for i:=0 to FCount - 1 do
     begin
      if i<>0 then result:=result+'|';
      result:=result+FUnit[i].name+'|'+inttostr(FUnit[i].mult)+'|'+inttostr(FUnit[i].divi);
     end;
    end;

    procedure TUnitCalculator.SetUnits(v:string);
    begin
     Clear;
     AddUnits(v);
    end;

    procedure TUnitCalculator.AddUnit(name:string;Mult:integer;Divi:integer);
     begin
      inc(Fcount);
      setlength(FUnit,Fcount);
      FUnit[Fcount-1].name:=name;
      FUnit[Fcount-1].mult:=Mult;
      FUnit[Fcount-1].Divi:=Divi;
     end;

    procedure TUnitCalculator.AddUnits(List:string);
     var
      i,c:integer;
      t:string;
      tab:array of string;
      m,d:integer;
     begin
      c:=0;
      for i:=1 to length(List) do
        if List[i]='|' then inc(c);
      setlength(tab,c+1);
      c:=0;
      for i:=1 to length(List) do
      if List[i]='|' then inc(c) else tab[c]:=tab[c]+List[i];
      for i:=0 to (c+1) div 3-1 do
        begin
         if not tryStrToInt(tab[i*3+1],m) then continue;
         if not tryStrToInt(tab[i*3+2],d) then continue;
         AddUnit(tab[i*3],m,d);
        end;
     end;

    procedure TUnitCalculator.DelUnit(name:string);
     var
      i,j:integer;
     begin
      i:=FindUnit(name);
      if i<>-1 then
        begin
         for j:=i to Fcount-2 do FUnit[j]:=FUnit[j+1];
         dec(Fcount);
         setlength(FUnit,Fcount);
        end;
     end;

    procedure TUnitCalculator.Clear;
     begin
      Fcount:=0;
      setlength(FUnit,0);
     end;

    function TUnitCalculator.FindUnit(name:string):integer;
     var
      i:integer;
     begin
      result:=-1;
      for i := 0 to Fcount - 1 do
        if FUnit[i].name=name then begin result:=i;exit; end;
     end;



//******************************************************************************
//******************************************************************************


{ TSpinButton }

procedure Register;
begin
  RegisterComponents('Exemples', [TFloatSpinEdit]);
end;

{ TFloatSpinEdit }

constructor TFloatSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUnitList:=TUnitCalculator.Create;
  FButton := TSpinButton.Create(Self);
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  Text := '0';
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1.0;
  FPrecision:=-2;
  FEditorEnabled := True;
  ParentBackground := False;
  Funites:='';
  FCurrentUnit:=-1;
  FDefaultUnit:=-1;
  FValue:=0;
end;

destructor TFloatSpinEdit.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TFloatSpinEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;


procedure TFloatSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then UpClick (Self)
  else if Key = VK_DOWN then DownClick (Self);
  inherited KeyDown(Key, Shift);
end;

procedure TFloatSpinEdit.KeyPress(var Key: Char);
begin
 if key in [',','.'] then key:=DecimalSeparator;
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TFloatSpinEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := (Key>= #32) or
    ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or
      (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TFloatSpinEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
{  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TFloatSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TFloatSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;



procedure TFloatSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    if NewStyleControls and Ctl3D then
      FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 5)
    else FButton.SetBounds (Width - FButton.Width, 1, FButton.Width, Height - 3);
    SetEditRect;
  end;
end;

function TFloatSpinEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

procedure TFloatSpinEdit.UpClick (Sender: TObject);
begin
  if ReadOnly then MessageBeep(0)
  else UnitValue := UnitValue + FIncrement;
end;

procedure TFloatSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly then MessageBeep(0)
  else UnitValue := UnitValue - FIncrement;
end;

procedure TFloatSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TFloatSpinEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TFloatSpinEdit.CMExit(var Message: TCMExit);
begin
  UpDateValue(Text);
  Setvalue(FValue);
  inherited;
end;

procedure TFloatSpinEdit.SetValue (NewValue: Extended);
var
 s:string;
begin
  FValue:=CheckValue (NewValue);
  s := FloatToStr(Roundto(FUnitList.ConvertToUnit(FValue,FCurrentUnit),FPrecision));
  if FCurrentUnit<>-1 then s:=s+' '+FUnitList.UnitName[FCurrentUnit];
  Text:=s;
end;

function TFloatSpinEdit.GetValue:extended;
begin
 UpdateValue(text);
 result:=FValue;
end;

function TFloatSpinEdit.GetUnitValue: Extended;
begin
 UpdateValue(text);
 result:=FUnitList.ConvertToUnit(fvalue,FCurrentUnit);
end;

procedure TFloatSpinEdit.SetUnitValue (NewValue: Extended);
begin
 SetValue(FUnitList.ConvertFromUnit(NewValue,FCurrentUnit));
end;


function TFloatSpinEdit.CheckValue (NewValue: Extended): Extended;
begin
  Result := roundto(NewValue,FPrecision);
  if (FMaxValue <> FMinValue) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TFloatSpinEdit.SetCurrentUnit(v:integer);
begin
  if v<-1 then exit;
  if v>=FUnitList.Count then exit;
  UpdateValue(text);
  if v=FcurrentUnit then exit;
  FcurrentUnit:=v;
  SetValue(FValue);
end;

procedure TFloatSpinEdit.SetDefaultUnit(v:integer);
begin
 if v<-1 then exit;
 if v>=FUnitList.Count then exit;
 UpdateValue(text);
 FDefaultUnit:=v;
 if FcurrentUnit=-1 then
  begin
   FcurrentUnit:=v;
  end;
 SetValue(FValue);
end;

procedure TFloatSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

procedure TFloatSpinEdit.SetUnites(v:string);
begin
 UpdateValue(text);
 FUnitlist.Units:=v;
 Funites:=FUnitlist.Units;
 if currentunit>=FUnitlist.count then Fcurrentunit:=-1;
 SetValue(FValue);
end;

procedure TFloatSpinEdit.SetPrecision(v:integer);
begin
 if FPrecision=v then exit;
 FPrecision:=v;
 SetValue(FValue);
end;

procedure TFloatSpinEdit.UpdateValue(s:string);
var
 n,u:string;
 i:integer;
 v:extended;
begin
 n:='';
 u:='';
 i:=length(s);
 FValue:=FMinValue;
 while (i>0) and not (s[i] in ['0'..'9','+','-',DecimalSeparator]) do dec(i);
 if i>0 then
  begin
   n:=copy(s,1,i);
   u:=trim(copy(s,i+1,length(s)));
   if trystrtofloat(n,v) then
    begin
     FValue:=v;
     FCurrentUnit:=FUnitlist.FindUnit(u);
     if (FCurrentUnit=-1) then FCurrentUnit:=FDefaultUnit;
     if FCurrentUnit<>-1 then FValue:=FUnitlist.ConvertFromUnit(v,FCurrentUnit);
    end;
  end;
end;

end.


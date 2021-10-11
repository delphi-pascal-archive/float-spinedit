unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, FloatSpin;

type
  TForm2 = class(TForm)
    FloatSpinEdit1: TFloatSpinEdit;
    Button11: TButton;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    FloatSpinEdit2: TFloatSpinEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    FloatSpinEdit3: TFloatSpinEdit;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FloatSpinEdit2Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FloatSpinEdit1Change(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button11Click(Sender: TObject);
begin
 FloatSpinEdit1.DefaultUnit:=-FloatSpinEdit1.DefaultUnit-1;
 if FloatSpinEdit1.DefaultUnit=0 then
  label2.caption:='Avec % par défaut'
  else
  label2.caption:='Sans % par défaut';
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
 FloatSpinEdit2.CurrentUnit:=Tbutton(sender).Tag;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 FloatSpinEdit3.CurrentUnit:=Tbutton(sender).Tag;
end;

procedure TForm2.FloatSpinEdit1Change(Sender: TObject);
begin
 label3.caption:='Value='+floattostr(FloatSpinEdit1.Value);
 label4.caption:='UnitValue='+floattostr(FloatSpinEdit1.UnitValue);
end;

procedure TForm2.FloatSpinEdit2Change(Sender: TObject);
begin
 FloatSpinEdit3.Value:=FloatSpinEdit2.Value;
end;

end.

object Form2: TForm2
  Left = 243
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Float SpinEdit'
  ClientHeight = 219
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 91
    Height = 13
    Caption = 'Sans % par defaut'
  end
  object Label3: TLabel
    Left = 136
    Top = 36
    Width = 40
    Height = 13
    Caption = 'Value=0'
  end
  object Label4: TLabel
    Left = 136
    Top = 53
    Width = 59
    Height = 13
    Caption = 'Unitvalue=0'
  end
  object FloatSpinEdit1: TFloatSpinEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 22
    Increment = 1.000000000000000000
    Precision = -2
    unites = '%|100|1'
    TabOrder = 0
    CurrentUnit = -1
    DefaultUnit = -1
    OnChange = FloatSpinEdit1Change
  end
  object Button11: TButton
    Left = 135
    Top = 8
    Width = 146
    Height = 22
    Caption = 'Avec ou sans % par defaut'
    TabOrder = 1
    OnClick = Button11Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 80
    Width = 465
    Height = 129
    Caption = ' Convertion de longueurs '
    TabOrder = 2
    object Label1: TLabel
      Left = 222
      Top = 40
      Width = 12
      Height = 19
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object FloatSpinEdit2: TFloatSpinEdit
      Left = 127
      Top = 42
      Width = 90
      Height = 22
      Increment = 1.000000000000000000
      Precision = -2
      unites = 'px|1|1|pc|5|254|mm|1|2|cm|1|20'
      TabOrder = 0
      Value = 6.000000000000000000
      UnitValue = 6.000000000000000000
      CurrentUnit = 0
      DefaultUnit = -1
      OnChange = FloatSpinEdit2Change
    end
    object Button1: TButton
      Tag = 3
      Left = 15
      Top = 24
      Width = 50
      Height = 25
      Caption = 'Cm'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Tag = 2
      Left = 15
      Top = 55
      Width = 50
      Height = 25
      Caption = 'Mm'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 72
      Top = 24
      Width = 49
      Height = 25
      Caption = 'Px'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button4: TButton
      Tag = 1
      Left = 72
      Top = 55
      Width = 49
      Height = 25
      Caption = 'Pouce'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button5: TButton
      Tag = -1
      Left = 40
      Top = 86
      Width = 57
      Height = 25
      Caption = 'Sans'
      TabOrder = 5
      OnClick = Button1Click
    end
    object FloatSpinEdit3: TFloatSpinEdit
      Left = 246
      Top = 42
      Width = 91
      Height = 22
      Increment = 1.000000000000000000
      Precision = -2
      unites = 'px|1|1|pc|5|254|mm|1|2|cm|1|20'
      TabOrder = 6
      Value = 6.000000000000000000
      UnitValue = 6.000000000000000000
      CurrentUnit = 0
      DefaultUnit = -1
    end
    object Button6: TButton
      Tag = 3
      Left = 343
      Top = 24
      Width = 50
      Height = 25
      Caption = 'Cm'
      TabOrder = 7
      OnClick = Button6Click
    end
    object Button7: TButton
      Tag = 2
      Left = 343
      Top = 55
      Width = 50
      Height = 25
      Caption = 'Mm'
      TabOrder = 8
      OnClick = Button6Click
    end
    object Button8: TButton
      Left = 400
      Top = 24
      Width = 49
      Height = 25
      Caption = 'Px'
      TabOrder = 9
      OnClick = Button6Click
    end
    object Button9: TButton
      Tag = 1
      Left = 400
      Top = 55
      Width = 49
      Height = 25
      Caption = 'Pouce'
      TabOrder = 10
      OnClick = Button6Click
    end
    object Button10: TButton
      Tag = -1
      Left = 376
      Top = 86
      Width = 49
      Height = 25
      Caption = 'Sans'
      TabOrder = 11
      OnClick = Button6Click
    end
  end
end

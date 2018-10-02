object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FireDAC Threads connection problem'
  ClientHeight = 662
  ClientWidth = 1023
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 165
    Width = 1023
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 145
    ExplicitWidth = 517
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1023
    Height = 165
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1023
      165)
    object Label6: TLabel
      Left = 408
      Top = 20
      Width = 100
      Height = 13
      Caption = 'Database 1 (correct)'
    end
    object Label7: TLabel
      Left = 408
      Top = 43
      Width = 100
      Height = 13
      Caption = 'Database 2 (correct)'
    end
    object Label8: TLabel
      Left = 408
      Top = 66
      Width = 97
      Height = 13
      Caption = 'Database 3 (bad IP)'
    end
    object Label9: TLabel
      Left = 520
      Top = 3
      Width = 71
      Height = 13
      Caption = 'Server Firebird'
    end
    object Label10: TLabel
      Left = 656
      Top = 3
      Width = 75
      Height = 13
      Caption = 'Database name'
    end
    object Label11: TLabel
      Left = 244
      Top = 90
      Width = 717
      Height = 69
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'For Database 1 and 2 set correct data with any Firebird database' +
        '. Database 3 must be incorrect. You can leave this IP - it is no' +
        't a Firebird server. Program creates 5 threads to select from sy' +
        'stem tables. Each one starts connection. Some (or even all - it'#39 +
        's random) threads are suspended because of Thread 3 which try to' +
        ' connect to a bad IP. Only when TFDConnection returns error all ' +
        'other suspended threads go on correctly.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Button1: TButton
      Left = 16
      Top = 16
      Width = 154
      Height = 57
      Caption = 'Start threads'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 200
      Top = 16
      Width = 157
      Height = 57
      Caption = 'Close threads'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 98
      Width = 154
      Height = 25
      Caption = 'Clear'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 520
      Top = 17
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '127.0.0.1'
    end
    object Edit2: TEdit
      Left = 656
      Top = 17
      Width = 249
      Height = 21
      TabOrder = 4
      Text = 'd:\empty.fdb'
    end
    object Edit3: TEdit
      Left = 520
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 5
      Text = '127.0.0.1'
    end
    object Edit4: TEdit
      Left = 656
      Top = 40
      Width = 249
      Height = 21
      TabOrder = 6
      Text = 'd:\empty.fdb'
    end
    object Edit5: TEdit
      Left = 520
      Top = 63
      Width = 121
      Height = 21
      TabOrder = 7
      Text = '18.211.55.24'
    end
    object Edit6: TEdit
      Left = 656
      Top = 63
      Width = 249
      Height = 21
      TabOrder = 8
      Text = 'd:\test.fdb'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 168
    Width = 1023
    Height = 494
    Align = alClient
    TabOrder = 1
    ExplicitTop = 142
    ExplicitHeight = 520
    object Splitter5: TSplitter
      Left = 810
      Top = 1
      Height = 492
      ExplicitLeft = 512
      ExplicitTop = 208
      ExplicitHeight = 100
    end
    object Splitter7: TSplitter
      Left = 607
      Top = 1
      Height = 492
      ExplicitLeft = 512
      ExplicitTop = 208
      ExplicitHeight = 100
    end
    object Splitter9: TSplitter
      Left = 404
      Top = 1
      Height = 492
      ExplicitLeft = 512
      ExplicitTop = 208
      ExplicitHeight = 100
    end
    object Splitter11: TSplitter
      Left = 201
      Top = 1
      Height = 492
      ExplicitLeft = 512
      ExplicitTop = 208
      ExplicitHeight = 100
    end
    object pnlGrid1: TPanel
      Left = 813
      Top = 1
      Width = 209
      Height = 492
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 518
      object Label5: TLabel
        Left = 55
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Thread 5, Database 2'
      end
      object mmGrid5: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 31
        Width = 207
        Height = 460
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 486
      end
    end
    object Panel3: TPanel
      Left = 610
      Top = 1
      Width = 200
      Height = 492
      Align = alLeft
      TabOrder = 1
      ExplicitHeight = 518
      object Label4: TLabel
        Left = 55
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Thread 4, Database 1'
      end
      object mmGrid4: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 31
        Width = 198
        Height = 460
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 486
      end
    end
    object Panel4: TPanel
      Left = 407
      Top = 1
      Width = 200
      Height = 492
      Align = alLeft
      TabOrder = 2
      ExplicitHeight = 518
      object Label3: TLabel
        Left = 63
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Thread 3, Database 3'
      end
      object mmGrid3: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 31
        Width = 198
        Height = 460
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 486
      end
    end
    object Panel5: TPanel
      Left = 204
      Top = 1
      Width = 200
      Height = 492
      Align = alLeft
      TabOrder = 3
      ExplicitHeight = 518
      object Label2: TLabel
        Left = 55
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Thread 2, Database 2'
      end
      object mmGrid2: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 31
        Width = 198
        Height = 460
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 486
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 200
      Height = 492
      Align = alLeft
      TabOrder = 4
      ExplicitHeight = 518
      object Label1: TLabel
        Left = 47
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Thread 1, Database 1'
      end
      object mmGrid1: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 31
        Width = 198
        Height = 460
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 486
      end
    end
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 864
    Top = 56
  end
end

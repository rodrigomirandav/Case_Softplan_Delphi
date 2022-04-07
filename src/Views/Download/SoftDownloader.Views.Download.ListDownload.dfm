object frmListDownloads: TfrmListDownloads
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Downloads efetuados'
  ClientHeight = 359
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlList: TPanel
    Left = 0
    Top = 0
    Width = 543
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      543
      296)
    object dbgDownloads: TDBGrid
      Left = 5
      Top = 5
      Width = 533
      Height = 286
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsDownloads
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgDownloadsDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAINICIO'
          Title.Caption = 'Data inicio'
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAFIM'
          Title.Caption = 'Data fim'
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'URL'
          Width = 178
          Visible = True
        end>
    end
  end
  object pnlActions: TPanel
    Left = 0
    Top = 296
    Width = 543
    Height = 63
    Align = alBottom
    BevelOuter = bvNone
    Color = clMedGray
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      543
      63)
    object btnClose: TButton
      Left = 418
      Top = 8
      Width = 110
      Height = 47
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = btnCloseClick
    end
  end
  object dsDownloads: TDataSource
    Left = 368
    Top = 8
  end
end
